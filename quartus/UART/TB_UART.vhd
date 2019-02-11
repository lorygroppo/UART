
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all;
USE STD.textio.all;
USE ieee.std_logic_textio.all;

ENTITY TB_UART IS

END TB_UART;

ARCHITECTURE structural OF TB_UART IS

COMPONENT UART IS 
	PORT( 	WR :  IN  STD_LOGIC;
		    CK :  IN  STD_LOGIC;
		    RX_UART :  IN  STD_LOGIC;
		    RD :  IN  STD_LOGIC;
		    DIN :  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		    TX_UART :  OUT  STD_LOGIC;
		    TXRDY :  OUT  STD_LOGIC;
		    DAV :  OUT  STD_LOGIC;
		    campionamento :  OUT  STD_LOGIC;
		    DOUT :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
	      	RESETn : IN STD_LOGIC);
END COMPONENT;

signal clk_tb, wr_tb, tx_rdy_tb, tx_tb, rd_tb, rx_tb, reset_n_tb, dav_tb: std_logic;
signal sample: std_logic;
signal d_in_tb, d_out_tb : std_logic_vector ( 7 downto 0) := (others =>'0');

file file_din: text;
file file_dout: text;

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
                    campionamento => sample,
                    RESETn => reset_n_tb);

rx_tb<=tx_tb;

process
begin
clk_tb<= '1';
wait for 20ns; 
clk_tb <= '0';
wait for 20ns;
end process;

--UART reset
reset_n_tb <= '0', '1' after 80ns;

--WR signal e lettura DIN da file
process
	variable v_WR_LINE : line;
	variable v_DIN_LINE : line;
	variable v_WR_INT  : integer;
	variable v_DIN_SIG : std_logic_vector(7 downto 0);
begin
	file_open(file_din, "din.txt", read_mode);
	--leggo numeri di trasmissioni da effettuare
	readline(file_din, v_WR_LINE);
	read(v_WR_LINE, v_WR_INT);
	wr_tb<='0';
    wait for 10020 ns;
	for i in 1 to v_WR_INT loop
	    wr_tb<='1';
	    --leggo prossimo byte da trasmettere
	    readline(file_din, v_DIN_LINE);
		read(v_DIN_LINE, v_DIN_SIG);
		d_in_tb<=v_DIN_SIG;
	    wait for 40 ns;
	    wr_tb<='0';
	    d_in_tb<=(others =>'U');
	    wait until tx_rdy_tb'event and tx_rdy_tb='1';
	    wait for 20 ns;
    end loop;
	file_close(file_din);    
	wait;
end process;

--RD signal
--process
--begin
--	rd_tb<='0';
--	if tx_rdy_tb'event and tx_rdy_tb='1' then
--		rd_tb<='1';
--		wait for 40ns;
--	end if;
--end process;

--Scrivo DOUT su di un file quando è asserito DAV
file_open(file_dout,"dout.txt",write_mode);
process (dav_tb)
	variable v_DOUT	: line;
begin
	if dav_tb'event and dav_tb='1' then
		write(v_DOUT, d_out_tb, right, 8);
	    writeline(file_dout, v_DOUT);
	end if;
end process;
file_close(file_dout);

end structural;