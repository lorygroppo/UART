library ieee;
use ieee.std_logic_1164.all;

entity TB_RX is

end TB_RX;

architecture structural of TB_RX is

component RX IS 
	PORT
	( RD : IN std_logic;
		CK :  IN  STD_LOGIC;
		RX_UART :  IN  STD_LOGIC;
		RESETn :  IN  STD_LOGIC;
		DAV :  OUT  STD_LOGIC;
		DOUT :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END component; 

signal rd_t,clk_t, Rx_t, dav_t,reset_n: std_logic;
signal dout_t : std_logic_vector (7 downto 0);

begin

U1: rx port map(  CK => clk_t,
                  RX_UART => rx_t,
                  RD => rd_t,
                  DAV => dav_t,
                  DOUT => dout_t,
                  RESETn => reset_n);

process
begin
clk_t <= '0';
wait for 20 ns;
clk_t <= '1';
wait for 20 ns;
end process;

reset_n <= '0', '1' after 1000ns;
Rx_t <= '1', '0' after 10000 ns, '1' after 18780 ns, '0' after 27461 ns, '1' after 79540 ns, '1' after 101480 ns;--, '1' after 189280 ns;
RD_t <='0', '1' after 150000 ns;

end structural;