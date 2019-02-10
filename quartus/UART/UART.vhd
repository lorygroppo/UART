-- Copyright (C) 1991-2011 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II 32-bit"
-- VERSION		"Version 11.1 Build 173 11/01/2011 SJ Web Edition"
-- CREATED		"Fri Jan 11 09:23:52 2019"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY UART IS 
	PORT
	(
		WR :  IN  STD_LOGIC;
		RD :  IN  STD_LOGIC;
		CK :  IN  STD_LOGIC;
		RESETn :  IN  STD_LOGIC;
		RX_UART :  IN  STD_LOGIC;
		DIN :  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		TXRDY :  OUT  STD_LOGIC;
		DAV :  OUT  STD_LOGIC;
		TX_UART :  OUT  STD_LOGIC;
		Rx_sonda :  OUT  STD_LOGIC;
		campionamento :  OUT  STD_LOGIC;
		stop_bit_output :  OUT  STD_LOGIC;
		DOUT :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END UART;

ARCHITECTURE bdf_type OF UART IS 

COMPONENT rx
	PORT(CK : IN STD_LOGIC;
		 RX_UART : IN STD_LOGIC;
		 RD : IN STD_LOGIC;
		 RESETn : IN STD_LOGIC;
		 Campionamento_out : OUT STD_LOGIC;
		 DAV : OUT STD_LOGIC;
		 stop_bit_out : OUT STD_LOGIC;
		 DOUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT tx
	PORT(CK : IN STD_LOGIC;
		 WR : IN STD_LOGIC;
		 RESETn : IN STD_LOGIC;
		 DIN : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 TX_UART : OUT STD_LOGIC;
		 TXRDY : OUT STD_LOGIC
	);
END COMPONENT;



BEGIN 
Rx_sonda <= RX_UART;



b2v_RX_BLOCK : rx
PORT MAP(CK => CK,
		 RX_UART => RX_UART,
		 RD => RD,
		 RESETn => RESETn,
		 Campionamento_out => campionamento,
		 DAV => DAV,
		 stop_bit_out => stop_bit_output,
		 DOUT => DOUT);


b2v_TX_BLOCK : tx
PORT MAP(CK => CK,
		 WR => WR,
		 RESETn => RESETn,
		 DIN => DIN,
		 TX_UART => TX_UART,
		 TXRDY => TXRDY);


END bdf_type;