// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.1 (lin64) Build 6140274 Wed May 21 22:58:25 MDT 2025
// Date        : Thu Feb 12 20:16:14 2026
// Host        : fedora running 64-bit Fedora Linux 43 (KDE Plasma Desktop Edition)
// Command     : write_verilog -force -mode synth_stub
//               /home/daniel/Documents/FPGA-SensorFusion-EdgeAI/rtl/processor/processor.gen/sources_1/bd/top_level/ip/top_level_axis_fft_cfg_gen_0_0/top_level_axis_fft_cfg_gen_0_0_stub.v
// Design      : top_level_axis_fft_cfg_gen_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* CHECK_LICENSE_TYPE = "top_level_axis_fft_cfg_gen_0_0,axis_fft_cfg_gen,{}" *) (* CORE_GENERATION_INFO = "top_level_axis_fft_cfg_gen_0_0,axis_fft_cfg_gen,{x_ipProduct=Vivado 2025.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=axis_fft_cfg_gen,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,CFG_WIDTH=16,CFG_WORD=0x00000001}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) 
(* IP_DEFINITION_SOURCE = "module_ref" *) (* X_CORE_INFO = "axis_fft_cfg_gen,Vivado 2025.1" *) 
module top_level_axis_fft_cfg_gen_0_0(aclk, aresetn, m_tdata, m_tvalid, m_tready)
/* synthesis syn_black_box black_box_pad_pin="aresetn,m_tdata[15:0],m_tvalid,m_tready" */
/* synthesis syn_force_seq_prim="aclk" */;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 aclk CLK" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME aclk, ASSOCIATED_BUSIF m, ASSOCIATED_RESET aresetn, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN top_level_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *) input aclk /* synthesis syn_isclock = 1 */;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 aresetn RST" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input aresetn;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m TDATA" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN top_level_processing_system7_0_0_FCLK_CLK0, LAYERED_METADATA undef, INSERT_VIP 0" *) output [15:0]m_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m TVALID" *) output m_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m TREADY" *) input m_tready;
endmodule
