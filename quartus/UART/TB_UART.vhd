
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

signal clk_tb, wr_tb, tx_rdy_tb, tx_tb, rd_tb, rx_tb, reset_n_tb, dav_tb: std_logic;
signal d_in_tb, d_out_tb : std_logic_vector ( 7 downto 0) := (others =>'0');

begin

U1: UART port map(  CK => clk_tb,
                    WR=> wr_tb,
                    TXRDY => tx_rdy_tb,
                    TX_UART => tx_tb,
                    DIN => d_in_tb,
                    RX_UART => rx_tb,
                    RD => rd_tb,
                    DAV => dav_tb,
                    DOUT => d_out_tb,
                    RESETn => reset_n_tb);



process
begin
clk_tb<= '1';
wait for 10ns; 
clk_tb <= '0';
wait for 10ns;
end process;

reset_n_tb <= '0', '1' after 250ns;

--TX signal
wr_tb <= '0', '1' after 530 ns, '0' after 570 ns, '1' after 87840 ns, '0' after 87940 ns, '1' after 200000 ns, '0' after 200060 ns;
d_in_tb <= "01100110", "10101010" after 8802 ns, "01010101" after 100000ns;

--RX signal

rx_tb <= '1', '0' after 10000 ns, '1' after 88125 ns, 
          '0' after 140000 ns, 
          '1' after 280000 ns, '0' after 301000 ns, '1' after 309681 ns;
rd_tb <= '0', '1' after 110000 ns, '0' after 110100 ns;

end structural;
