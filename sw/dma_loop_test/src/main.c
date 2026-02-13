/******************************************************************************
 * impulse_sweep_mag_check.c
 *
 * FUNCTION
 *   End-to-end verification of:
 *
 *     DDR -> AXI DMA (MM2S)
 *         -> FFT
 *         -> MAG^2
 *         -> AXI DMA (S2MM)
 *         -> DDR
 *
 * METHOD
 *   For each amplitude A in a predefined set:
 *
 *     1) Build impulse input frame:
 *           x[0] = A (real)
 *           x[1..N-1] = 0
 *
 *     2) FFT property:
 *           FFT{impulse at n=0} => X[k] = A for all bins k
 *
 *     3) Magnitude block behavior (per RTL):
 *           re_s, im_s are signed 16-bit
 *           re_sq  = re_s * re_s
 *           im_sq  = im_s * im_s
 *           mag_sq = re_sq + im_sq
 *           m_axis_tdata = mag_sq(32 downto 1)
 *
 *        Therefore:
 *           mag_out = (A*A) >> 1
 *
 *     4) Compare all N output words to expected value.
 *
 * VALIDATION COVERAGE
 *   - AXI DMA simple mode
 *   - MM2S framing and transfer length
 *   - S2MM framing and transfer length
 *   - AXI-Stream data packing
 *   - Cache flush and invalidate correctness
 *   - FFT pipeline stability
 *   - Magnitude arithmetic correctness
 *
 * LED BEHAVIOR
 *   4-bit rotating pattern independent of pass/fail.
 ******************************************************************************/

#include "xparameters.h"
#include "xaxidma.h"
#include "xaxidma_hw.h"
#include "xil_cache.h"
#include "xil_printf.h"
#include "xil_io.h"
#include "sleep.h"

/* ------------------------------ Configuration ------------------------------ */

/* FFT frame length */
#define N_SAMPLES   2048

/* Transfer sizes in bytes (32-bit words) */
#define IN_BYTES    (N_SAMPLES * 4)
#define OUT_BYTES   (N_SAMPLES * 4)

/* DMA polling timeout */
#define TIMEOUT     20000000

/* Absolute compare tolerance */
#define TOL_ABS     0u


/* ------------------------------ LED Interface ------------------------------ */

/*
 * AXI GPIO expected configuration:
 *   4 output bits mapped to LEDs.
 *   GPIO_DATA offset 0x0
 *   GPIO_TRI  offset 0x4
 */

#ifdef XPAR_AXI_GPIO_0_BASEADDR
#define GPIO_BASE   XPAR_AXI_GPIO_0_BASEADDR
#define GPIO_DATA   (GPIO_BASE + 0x0)
#define GPIO_TRI    (GPIO_BASE + 0x4)

/* Configure GPIO as output */
static inline void leds_init(void) {
    Xil_Out32(GPIO_TRI, 0x0);
}

/* Write 4-bit LED pattern */
static inline void leds_write(u32 v) {
    Xil_Out32(GPIO_DATA, v & 0xF);
}
#else
static inline void leds_init(void) {}
static inline void leds_write(u32 v) {(void)v;}
#endif

/*
 * Rotate 1-hot LED pattern:
 *   0001 -> 0010 -> 0100 -> 1000 -> repeat
 */
static void leds_train_tick(void) {
    static u32 pat = 1;
    leds_write(pat);
    pat <<= 1;
    if (pat == 0x10)
        pat = 1;
}


/* ------------------------------ Buffers ------------------------------------ */

/*
 * Buffers are 64-byte aligned.
 * Required for cache-line aligned flush/invalidate operations.
 */
static u32 in_buf[N_SAMPLES]  __attribute__((aligned(64)));
static u32 out_buf[N_SAMPLES] __attribute__((aligned(64)));

/* AXI DMA driver instance */
static XAxiDma AxiDma;


/* ------------------------------ Utility Functions -------------------------- */

/*
 * Pack complex sample:
 *   Lower 16 bits  = real
 *   Upper 16 bits  = imaginary
 */
static inline u32 pack_im_re_s16(int im, int re) {
    return ((u32)(im & 0xFFFF) << 16) | (u32)(re & 0xFFFF);
}

/*
 * Absolute difference for unsigned 32-bit values.
 */
static inline u32 absdiff_u32(u32 a, u32 b) {
    return (a > b) ? (a - b) : (b - a);
}

/*
 * Print DMA status registers:
 *   MM2S_SR and S2MM_SR
 */
static void dump_dma_status(XAxiDma *Dma) {
    u32 base = Dma->RegBase;
    u32 mm2s_sr = XAxiDma_ReadReg(base, XAXIDMA_TX_OFFSET + XAXIDMA_SR_OFFSET);
    u32 s2mm_sr = XAxiDma_ReadReg(base, XAXIDMA_RX_OFFSET + XAXIDMA_SR_OFFSET);

    xil_printf("MM2S_SR=0x%08x  S2MM_SR=0x%08x\r\n",
               mm2s_sr, s2mm_sr);
}


/* ------------------------------ Input Construction ------------------------- */

/*
 * Build impulse frame:
 *   x[0] = A
 *   x[1..N-1] = 0
 */
static void build_impulse(int A) {
    for (int i = 0; i < N_SAMPLES; i++)
        in_buf[i] = 0;

    in_buf[0] = pack_im_re_s16(0, A);
}


/* ------------------------------ DMA Execution ------------------------------ */

/*
 * Run one full DMA transaction:
 *   1) Poison output buffer
 *   2) Flush caches
 *   3) Start S2MM (device -> memory)
 *   4) Start MM2S (memory -> device)
 *   5) Poll until both channels idle
 *   6) Invalidate output cache
 *
 * Returns:
 *   0  = success
 *  -1  = timeout
 *  -2  = DMA configuration error
 */
static int run_dma_once(void)
{
    /* Initialize output buffer with known pattern */
    for (int i = 0; i < N_SAMPLES; i++)
        out_buf[i] = 0xDEADBEEF;

    /* Ensure memory contents visible to DMA */
    Xil_DCacheFlushRange((UINTPTR)in_buf, IN_BYTES);
    Xil_DCacheFlushRange((UINTPTR)out_buf, OUT_BYTES);

    /* Start S2MM first */
    int st = XAxiDma_SimpleTransfer(&AxiDma,(UINTPTR)out_buf,OUT_BYTES,XAXIDMA_DEVICE_TO_DMA);
    if (st != XST_SUCCESS)
        return -2;

    /* Start MM2S */
    st = XAxiDma_SimpleTransfer(&AxiDma,(UINTPTR)in_buf,IN_BYTES,XAXIDMA_DMA_TO_DEVICE);
    if (st != XST_SUCCESS)
        return -2;

    /* Poll DMA busy flags */
    int t = TIMEOUT;

    while (t-- > 0)
    {
        int busy_tx = XAxiDma_Busy(&AxiDma, XAXIDMA_DMA_TO_DEVICE);
        int busy_rx = XAxiDma_Busy(&AxiDma, XAXIDMA_DEVICE_TO_DMA);

        /* LED tick for visual activity */
        if ((t & 0x1FFFF) == 0)
            leds_train_tick();

        if (!busy_tx && !busy_rx)
            break;
    }

    if (t <= 0)
        return -1;

    /* Make DMA writes visible to CPU */
    Xil_DCacheInvalidateRange((UINTPTR)out_buf, OUT_BYTES);

    return 0;
}


/* ------------------------------ Frame Comparison --------------------------- */

/*
 * Compare entire output frame against expected value.
 */
static int compare_frame(u32 expected, int *mismatch_count)
{
    int mism = 0;

    for (int i = 0; i < N_SAMPLES; i++)
    {
        if (absdiff_u32(out_buf[i], expected) > TOL_ABS)
            mism++;
    }

    if (mismatch_count)
        *mismatch_count = mism;

    return (mism == 0) ? 0 : -1;
}


/* ------------------------------ Main --------------------------------------- */

int main(void)
{
    leds_init();
    leds_write(0);

    xil_printf("\r\n=== IMPULSE SWEEP MAG^2 CHECK ===\r\n");
    xil_printf("N=%d IN_BYTES=%d OUT_BYTES=%d\r\n", N_SAMPLES, (int)IN_BYTES, (int)OUT_BYTES);

    /* Initialize DMA driver */
    XAxiDma_Config *Cfg =
        XAxiDma_LookupConfig(XPAR_AXI_DMA_0_BASEADDR);

    if (!Cfg) {
        xil_printf("ERROR: LookupConfig failed\r\n");
        while (1) { leds_train_tick(); sleep(1); }
    }

    if (XAxiDma_CfgInitialize(&AxiDma, Cfg) != XST_SUCCESS) {
        xil_printf("ERROR: CfgInitialize failed\r\n");
        while (1) { leds_train_tick(); sleep(1); }
    }

    if (XAxiDma_HasSg(&AxiDma)) {
        xil_printf("ERROR: DMA is SG mode\r\n");
        while (1) { leds_train_tick(); sleep(1); }
    }

    /* Test amplitude sweep */
    int amps[10] = {
        100, 250, 500, 750, 1000,
        1234, 1500, 2000, 2500, 3000
    };

    for (int i = 0; i < 10; i++)
    {
        int A = amps[i];

        xil_printf("\r\n--- Test %d/10 AMP=%d ---\r\n", i+1, A);

        build_impulse(A);

        /* Expected MAG^2 result */
        u32 expected = (u32)(((u64)A * (u64)A) >> 1);

        int rc = run_dma_once();

        xil_printf("DMA rc=%d\r\n", rc);
        dump_dma_status(&AxiDma);

        if (rc != 0)
        {
            xil_printf("DMA FAILURE\r\n");
            while (1) { leds_train_tick(); sleep(1); }
        }

        int mism = 0;
        int ok = compare_frame(expected, &mism);

        xil_printf("Expected=0x%08x (%u)\r\n", expected, (unsigned)expected);

        xil_printf("First 4 outputs:\r\n");
        for (int k = 0; k < 4; k++)
            xil_printf("  out[%d]=0x%08x\r\n", k, out_buf[k]);
        if (ok == 0) {
            xil_printf("PASS: all bins matched\r\n");
        }
        else {
            xil_printf("FAIL: mismatches=%d\r\n", mism);
            while (1) { leds_train_tick(); sleep(1); }
        }
    }

    xil_printf("\r\nALL 10 IMPULSE TESTS PASSED\r\n");

    while (1) {
        leds_train_tick();
        sleep(1);
    }

    return 0;
}
