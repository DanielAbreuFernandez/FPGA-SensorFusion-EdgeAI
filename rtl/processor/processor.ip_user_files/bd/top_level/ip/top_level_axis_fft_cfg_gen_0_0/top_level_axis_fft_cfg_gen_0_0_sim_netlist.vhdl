-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2025.1 (lin64) Build 6140274 Wed May 21 22:58:25 MDT 2025
-- Date        : Thu Feb 12 20:16:14 2026
-- Host        : fedora running 64-bit Fedora Linux 43 (KDE Plasma Desktop Edition)
-- Command     : write_vhdl -force -mode funcsim
--               /home/daniel/Documents/FPGA-SensorFusion-EdgeAI/rtl/processor/processor.gen/sources_1/bd/top_level/ip/top_level_axis_fft_cfg_gen_0_0/top_level_axis_fft_cfg_gen_0_0_sim_netlist.vhdl
-- Design      : top_level_axis_fft_cfg_gen_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity top_level_axis_fft_cfg_gen_0_0_axis_fft_cfg_gen is
  port (
    m_tvalid : out STD_LOGIC;
    aresetn : in STD_LOGIC;
    m_tready : in STD_LOGIC;
    aclk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of top_level_axis_fft_cfg_gen_0_0_axis_fft_cfg_gen : entity is "axis_fft_cfg_gen";
end top_level_axis_fft_cfg_gen_0_0_axis_fft_cfg_gen;

architecture STRUCTURE of top_level_axis_fft_cfg_gen_0_0_axis_fft_cfg_gen is
  signal \^m_tvalid\ : STD_LOGIC;
  signal m_tvalid_o_i_1_n_0 : STD_LOGIC;
  signal sent : STD_LOGIC;
  signal sent_i_1_n_0 : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of m_tvalid_o_i_1 : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of sent_i_1 : label is "soft_lutpair0";
begin
  m_tvalid <= \^m_tvalid\;
m_tvalid_o_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"002A"
    )
        port map (
      I0 => aresetn,
      I1 => m_tready,
      I2 => \^m_tvalid\,
      I3 => sent,
      O => m_tvalid_o_i_1_n_0
    );
m_tvalid_o_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => m_tvalid_o_i_1_n_0,
      Q => \^m_tvalid\,
      R => '0'
    );
sent_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A888"
    )
        port map (
      I0 => aresetn,
      I1 => sent,
      I2 => \^m_tvalid\,
      I3 => m_tready,
      O => sent_i_1_n_0
    );
sent_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => sent_i_1_n_0,
      Q => sent,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity top_level_axis_fft_cfg_gen_0_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    m_tdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_tvalid : out STD_LOGIC;
    m_tready : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of top_level_axis_fft_cfg_gen_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of top_level_axis_fft_cfg_gen_0_0 : entity is "top_level_axis_fft_cfg_gen_0_0,axis_fft_cfg_gen,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of top_level_axis_fft_cfg_gen_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of top_level_axis_fft_cfg_gen_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of top_level_axis_fft_cfg_gen_0_0 : entity is "axis_fft_cfg_gen,Vivado 2025.1";
end top_level_axis_fft_cfg_gen_0_0;

architecture STRUCTURE of top_level_axis_fft_cfg_gen_0_0 is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of aclk : signal is "xilinx.com:signal:clock:1.0 aclk CLK";
  attribute X_INTERFACE_MODE : string;
  attribute X_INTERFACE_MODE of aclk : signal is "slave";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of aclk : signal is "XIL_INTERFACENAME aclk, ASSOCIATED_BUSIF m, ASSOCIATED_RESET aresetn, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN top_level_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of aresetn : signal is "xilinx.com:signal:reset:1.0 aresetn RST";
  attribute X_INTERFACE_MODE of aresetn : signal is "slave";
  attribute X_INTERFACE_PARAMETER of aresetn : signal is "XIL_INTERFACENAME aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of m_tready : signal is "xilinx.com:interface:axis:1.0 m TREADY";
  attribute X_INTERFACE_INFO of m_tvalid : signal is "xilinx.com:interface:axis:1.0 m TVALID";
  attribute X_INTERFACE_INFO of m_tdata : signal is "xilinx.com:interface:axis:1.0 m TDATA";
  attribute X_INTERFACE_MODE of m_tdata : signal is "master";
  attribute X_INTERFACE_PARAMETER of m_tdata : signal is "XIL_INTERFACENAME m, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN top_level_processing_system7_0_0_FCLK_CLK0, LAYERED_METADATA undef, INSERT_VIP 0";
begin
  m_tdata(15) <= \<const0>\;
  m_tdata(14) <= \<const0>\;
  m_tdata(13) <= \<const0>\;
  m_tdata(12) <= \<const0>\;
  m_tdata(11) <= \<const0>\;
  m_tdata(10) <= \<const0>\;
  m_tdata(9) <= \<const0>\;
  m_tdata(8) <= \<const0>\;
  m_tdata(7) <= \<const0>\;
  m_tdata(6) <= \<const0>\;
  m_tdata(5) <= \<const0>\;
  m_tdata(4) <= \<const0>\;
  m_tdata(3) <= \<const0>\;
  m_tdata(2) <= \<const0>\;
  m_tdata(1) <= \<const0>\;
  m_tdata(0) <= \<const1>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
     port map (
      P => \<const1>\
    );
inst: entity work.top_level_axis_fft_cfg_gen_0_0_axis_fft_cfg_gen
     port map (
      aclk => aclk,
      aresetn => aresetn,
      m_tready => m_tready,
      m_tvalid => m_tvalid
    );
end STRUCTURE;
