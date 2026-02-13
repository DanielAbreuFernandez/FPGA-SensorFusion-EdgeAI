library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity magnitude is
  generic ( W : integer := 16 );
  port (
    aclk           : in  std_logic;
    aresetn        : in  std_logic;

    s_axis_tdata   : in  std_logic_vector(2*W-1 downto 0);
    s_axis_tvalid  : in  std_logic;
    s_axis_tready  : out std_logic;
    s_axis_tlast   : in  std_logic;

    m_axis_tdata   : out std_logic_vector(2*W-1 downto 0);
    m_axis_tvalid  : out std_logic;
    m_axis_tready  : in  std_logic;
    m_axis_tlast   : out std_logic
  );
end entity;

architecture rtl of magnitude is
  signal out_valid : std_logic := '0';
  signal out_data  : std_logic_vector(2*W-1 downto 0) := (others => '0');
  signal out_last  : std_logic := '0';

  signal s_ready   : std_logic;

  signal re_s, im_s : signed(W-1 downto 0);
  signal re_sq, im_sq : signed(2*W-1 downto 0);
  signal mag_sq : unsigned(2*W downto 0);
  signal mag32  : std_logic_vector(31 downto 0);

  signal in_fire  : std_logic;
  signal out_fire : std_logic;
begin
  -- Output regs to ports
  m_axis_tvalid <= out_valid;
  m_axis_tdata  <= out_data;
  m_axis_tlast  <= out_last;

  -- Ready logic 
  -- ready when buffer empty OR downstream ready
  s_ready      <= (not out_valid) or m_axis_tready;
  s_axis_tready <= s_ready;

  -- Handshake events
  in_fire  <= s_axis_tvalid and s_ready;
  out_fire <= out_valid and m_axis_tready;

  -- Math
  re_s <= signed(s_axis_tdata(W-1 downto 0));
  im_s <= signed(s_axis_tdata(2*W-1 downto W));

  re_sq  <= re_s * re_s;
  im_sq  <= im_s * im_s;
  mag_sq <= unsigned(resize(re_sq, 2*W+1)) + unsigned(resize(im_sq, 2*W+1));

  mag32 <= std_logic_vector(mag_sq(2*W downto 2*W-31));

  process(aclk)
  begin
    if rising_edge(aclk) then
      if aresetn = '0' then
        out_valid <= '0';
        out_data  <= (others => '0');
        out_last  <= '0';
      else
        -- If output consumed and no new input, clear valid
        if (out_fire = '1') and (in_fire = '0') then
          out_valid <= '0';
        end if;

        -- If new input accepted, load/overwrite output regs
        if in_fire = '1' then
          out_valid <= '1';
          out_data  <= mag32(2*W-1 downto 0);
          out_last  <= s_axis_tlast;
        end if;
      end if;
    end if;
  end process;

end architecture;
