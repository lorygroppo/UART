
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all;

ENTITY TB_UART IS

END TB_UART;

ARCHITECTURE structural OF TB_UART IS

COMPONENT UART IS 
	PORT( WR :  IN  STD_LOGIC;
		    CK :  IN  STD_LOGIC;
		    RX_UART :  IN  STD_LOGIC;
		    RD :  IN  STD_LOGIC;
		    DIN :  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		    TX_UART :  OUT  STD_LOGIC;
		    TXRDY :  OUT  STD_LOGIC;
		    DAV :  OUT  STD_LOGIC;
		    DOUT :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
	      RESETn : IN STD_LOGIC);
END COMPONENT;

signal clk_t, wr_t, tx_rdy_t , tx_t ,rd,rx,reset_n: std_logic;
signal d_in_t : std_logic_vector ( 7 downto 0) := (others =>'0');

begin

U1: UART port map(  CK => clk_t,
                    WR=> wr_t,
                    TXRDY => tx_rdy_t,
                    TX_UART => tx_t,
                    DIN => d_in_t,
                    RX_UART => rx,
                    RD => rd,
                    RESETn => reset_n);


process
begin
clk_t<= '1';
wait for 10ns; 
clk_t <= '0';
wait for 10ns;
end process;

wr_t <= '0', '1' after 500 ns, '0' after 600 ns;
reset_n <= '0', '1' after 250ns;
d_in_t <= "01100110", "10101010" after 8802 ns;


end structural;
