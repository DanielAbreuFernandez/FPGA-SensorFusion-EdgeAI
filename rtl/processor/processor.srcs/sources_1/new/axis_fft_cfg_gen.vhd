library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity axis_fft_cfg_gen is
  generic (
    CFG_WIDTH : integer := 16;
    CFG_WORD  : std_logic_vector(31 downto 0) := x"00000001"  -- default: forward FFT (bit0=1)
  );
  port (
    aclk    : in  std_logic;
    aresetn : in  std_logic;

    -- AXI4-Stream output to FFT S_AXIS_CONFIG
    m_tdata  : out std_logic_vector(CFG_WIDTH-1 downto 0);
    m_tvalid : out std_logic;
    m_tready : in  std_logic
  );
end entity;

architecture rtl of axis_fft_cfg_gen is
  signal sent : std_logic := '0';
  signal m_tvalid_o : std_logic := '0';
begin

  -- Drive constant config word (truncate/extend safely if CFG_WIDTH != 32)
  m_tdata <= std_logic_vector(resize(unsigned(CFG_WORD), CFG_WIDTH));

  process(aclk)
  begin
    if rising_edge(aclk) then
      if aresetn = '0' then
        sent    <= '0';
        m_tvalid_o <= '0';
      else
        if sent = '0' then
          -- Present config until accepted
          m_tvalid_o <= '1';
          if (m_tvalid_o = '1') and (m_tready = '1') then
            sent     <= '1';
            m_tvalid_o <= '0';
          end if;
        else
          m_tvalid_o <= '0';
        end if;
      end if;
    end if;
  end process;

m_tvalid <= m_tvalid_o;

end architecture;
