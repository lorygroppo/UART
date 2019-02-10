
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all;

ENTITY TB_TX IS

END TB_TX;



ARCHITECTURE structural OF TB_TX IS

component TX IS 
	PORT
	(	CK :  IN  STD_LOGIC;
		WR :  IN  STD_LOGIC;
		DIN :  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		TXRDY :  OUT  STD_LOGIC;
		TX_UART :  OUT  STD_LOGIC;
		RESETn : IN STD_LOGIC);
END component;

signal clk_t, wr_t, tx_rdy_t , tx_t, reset_n : std_logic :='0';
signal d_in_t : std_logic_vector ( 7 downto 0) := (others =>'0');

begin

U1: tx port map(	CK => clk_t,
						WR=> wr_t,
						TXRDY => tx_rdy_t,
						TX_UART => tx_t,
						DIN => d_in_t,
						RESETn => reset_n);
						
process
begin
clk_t<= '1';
wait for 20ns; 
clk_t <= '0';
wait for 20ns;
end process;
reset_n <= '0', '1' after 10 ns;
wr_t <= '0', '1' after 25 ns, '0' after 100 ns, '1' after 8804ns, '0' AFTER 10000ns;

d_in_t <= "01100110", "10101010" after 8802 ns;


end structural;
