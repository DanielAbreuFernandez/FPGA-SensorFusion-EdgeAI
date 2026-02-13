/******************************************************************************
* Copyright (C) 2023 Advanced Micro Devices, Inc. All Rights Reserved.
* SPDX-License-Identifier: MIT
******************************************************************************/
/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "xgpio.h"
#include "xparameters.h"
#include "sleep.h"


int main()
{
    init_platform();

    print("Hello World\n\r");
    print("Successfully ran Hello World application");

    XGpio Gpio;
    int status;

    // Device ID comes from xparameters.h
    status = XGpio_Initialize(&Gpio, XPAR_AXI_GPIO_0_BASEADDR);
    if (status != XST_SUCCESS) {
        xil_printf("GPIO init failed\r\n");
        return -1;
    }

    // Channel 1 = LEDs, set as outputs (0 = output, 1 = input)
    XGpio_SetDataDirection(&Gpio, 1, 0x0);

    xil_printf("LED test start\r\n");

    while (1) {
        for (int i = 0; i < 4; i++) {
            XGpio_DiscreteWrite(&Gpio, 1, (1 << i));
            usleep(200000); // 200 ms
        }
        for (int i = 2; i >= 1; i--) {
            XGpio_DiscreteWrite(&Gpio, 1, (1 << i));
            usleep(200000);
        }
    }

    cleanup_platform();
    return 0;
}
