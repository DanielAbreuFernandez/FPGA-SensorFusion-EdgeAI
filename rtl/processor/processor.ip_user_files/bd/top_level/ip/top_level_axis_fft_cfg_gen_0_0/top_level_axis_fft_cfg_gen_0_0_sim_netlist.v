// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.1 (lin64) Build 6140274 Wed May 21 22:58:25 MDT 2025
// Date        : Thu Feb 12 20:16:14 2026
// Host        : fedora running 64-bit Fedora Linux 43 (KDE Plasma Desktop Edition)
// Command     : write_verilog -force -mode funcsim
//               /home/daniel/Documents/FPGA-SensorFusion-EdgeAI/rtl/processor/processor.gen/sources_1/bd/top_level/ip/top_level_axis_fft_cfg_gen_0_0/top_level_axis_fft_cfg_gen_0_0_sim_netlist.v
// Design      : top_level_axis_fft_cfg_gen_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "top_level_axis_fft_cfg_gen_0_0,axis_fft_cfg_gen,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "axis_fft_cfg_gen,Vivado 2025.1" *) 
(* NotValidForBitStream *)
module top_level_axis_fft_cfg_gen_0_0
   (aclk,
    aresetn,
    m_tdata,
    m_tvalid,
    m_tready);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 aclk CLK" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME aclk, ASSOCIATED_BUSIF m, ASSOCIATED_RESET aresetn, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN top_level_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *) input aclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 aresetn RST" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input aresetn;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m TDATA" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN top_level_processing_system7_0_0_FCLK_CLK0, LAYERED_METADATA undef, INSERT_VIP 0" *) output [15:0]m_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m TVALID" *) output m_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m TREADY" *) input m_tready;

  wire \<const0> ;
  wire \<const1> ;
  wire aclk;
  wire aresetn;
  wire m_tready;
  wire m_tvalid;

  assign m_tdata[15] = \<const0> ;
  assign m_tdata[14] = \<const0> ;
  assign m_tdata[13] = \<const0> ;
  assign m_tdata[12] = \<const0> ;
  assign m_tdata[11] = \<const0> ;
  assign m_tdata[10] = \<const0> ;
  assign m_tdata[9] = \<const0> ;
  assign m_tdata[8] = \<const0> ;
  assign m_tdata[7] = \<const0> ;
  assign m_tdata[6] = \<const0> ;
  assign m_tdata[5] = \<const0> ;
  assign m_tdata[4] = \<const0> ;
  assign m_tdata[3] = \<const0> ;
  assign m_tdata[2] = \<const0> ;
  assign m_tdata[1] = \<const0> ;
  assign m_tdata[0] = \<const1> ;
  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  top_level_axis_fft_cfg_gen_0_0_axis_fft_cfg_gen inst
       (.aclk(aclk),
        .aresetn(aresetn),
        .m_tready(m_tready),
        .m_tvalid(m_tvalid));
endmodule

(* ORIG_REF_NAME = "axis_fft_cfg_gen" *) 
module top_level_axis_fft_cfg_gen_0_0_axis_fft_cfg_gen
   (m_tvalid,
    aresetn,
    m_tready,
    aclk);
  output m_tvalid;
  input aresetn;
  input m_tready;
  input aclk;

  wire aclk;
  wire aresetn;
  wire m_tready;
  wire m_tvalid;
  wire m_tvalid_o_i_1_n_0;
  wire sent;
  wire sent_i_1_n_0;

  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h002A)) 
    m_tvalid_o_i_1
       (.I0(aresetn),
        .I1(m_tready),
        .I2(m_tvalid),
        .I3(sent),
        .O(m_tvalid_o_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    m_tvalid_o_reg
       (.C(aclk),
        .CE(1'b1),
        .D(m_tvalid_o_i_1_n_0),
        .Q(m_tvalid),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'hA888)) 
    sent_i_1
       (.I0(aresetn),
        .I1(sent),
        .I2(m_tvalid),
        .I3(m_tready),
        .O(sent_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    sent_reg
       (.C(aclk),
        .CE(1'b1),
        .D(sent_i_1_n_0),
        .Q(sent),
        .R(1'b0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
