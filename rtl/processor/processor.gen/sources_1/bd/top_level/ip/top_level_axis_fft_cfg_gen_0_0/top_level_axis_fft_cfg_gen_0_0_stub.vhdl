-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2025.1 (lin64) Build 6140274 Wed May 21 22:58:25 MDT 2025
-- Date        : Thu Feb 12 20:16:14 2026
-- Host        : fedora running 64-bit Fedora Linux 43 (KDE Plasma Desktop Edition)
-- Command     : write_vhdl -force -mode synth_stub
--               /home/daniel/Documents/FPGA-SensorFusion-EdgeAI/rtl/processor/processor.gen/sources_1/bd/top_level/ip/top_level_axis_fft_cfg_gen_0_0/top_level_axis_fft_cfg_gen_0_0_stub.vhdl
-- Design      : top_level_axis_fft_cfg_gen_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_level_axis_fft_cfg_gen_0_0 is
  Port ( 
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    m_tdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_tvalid : out STD_LOGIC;
    m_tready : in STD_LOGIC
  );

  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of top_level_axis_fft_cfg_gen_0_0 : entity is "top_level_axis_fft_cfg_gen_0_0,axis_fft_cfg_gen,{}";
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of top_level_axis_fft_cfg_gen_0_0 : entity is "top_level_axis_fft_cfg_gen_0_0,axis_fft_cfg_gen,{x_ipProduct=Vivado 2025.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=axis_fft_cfg_gen,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,CFG_WIDTH=16,CFG_WORD=0x00000001}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of top_level_axis_fft_cfg_gen_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of top_level_axis_fft_cfg_gen_0_0 : entity is "module_ref";
end top_level_axis_fft_cfg_gen_0_0;

architecture stub of top_level_axis_fft_cfg_gen_0_0 is
  attribute syn_black_box : boolean;
  attribute black_box_pad_pin : string;
  attribute syn_black_box of stub : architecture is true;
  attribute black_box_pad_pin of stub : architecture is "aclk,aresetn,m_tdata[15:0],m_tvalid,m_tready";
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of aclk : signal is "xilinx.com:signal:clock:1.0 aclk CLK";
  attribute X_INTERFACE_MODE : string;
  attribute X_INTERFACE_MODE of aclk : signal is "slave";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of aclk : signal is "XIL_INTERFACENAME aclk, ASSOCIATED_BUSIF m, ASSOCIATED_RESET aresetn, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN top_level_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of aresetn : signal is "xilinx.com:signal:reset:1.0 aresetn RST";
  attribute X_INTERFACE_MODE of aresetn : signal is "slave";
  attribute X_INTERFACE_PARAMETER of aresetn : signal is "XIL_INTERFACENAME aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of m_tdata : signal is "xilinx.com:interface:axis:1.0 m TDATA";
  attribute X_INTERFACE_MODE of m_tdata : signal is "master";
  attribute X_INTERFACE_PARAMETER of m_tdata : signal is "XIL_INTERFACENAME m, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN top_level_processing_system7_0_0_FCLK_CLK0, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of m_tvalid : signal is "xilinx.com:interface:axis:1.0 m TVALID";
  attribute X_INTERFACE_INFO of m_tready : signal is "xilinx.com:interface:axis:1.0 m TREADY";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of stub : architecture is "axis_fft_cfg_gen,Vivado 2025.1";
begin
end;
