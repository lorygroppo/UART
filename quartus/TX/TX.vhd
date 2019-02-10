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
-- VERSION		"Version 11.1 Build 259 01/25/2012 Service Pack 2 SJ Web Edition"
-- CREATED		"Sat Dec 08 13:47:24 2018"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY TX IS 
	PORT
	(
		WR :  IN  STD_LOGIC;
		CK :  IN  STD_LOGIC;
		RESETn :  IN  STD_LOGIC;
		DIN :  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		TXRDY :  OUT  STD_LOGIC;
		TX_UART :  OUT  STD_LOGIC
	);
END TX;

ARCHITECTURE bdf_type OF TX IS 

ATTRIBUTE black_box : BOOLEAN;
ATTRIBUTE noopt : BOOLEAN;

COMPONENT lpm_ff_0
	PORT(clock : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END COMPONENT;
ATTRIBUTE black_box OF lpm_ff_0: COMPONENT IS true;
ATTRIBUTE noopt OF lpm_ff_0: COMPONENT IS true;

COMPONENT and_gate_4
	PORT(data : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 result : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT and_gate_8
	PORT(data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 result : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT lpm_counter_tx_mod_10
	PORT(sclr : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 cnt_en : IN STD_LOGIC;
		 q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

COMPONENT lpm_counter_tx
	PORT(sclr : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 cnt_en : IN STD_LOGIC;
		 q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT fsm_tx
	PORT(CK : IN STD_LOGIC;
		 TC : IN STD_LOGIC;
		 END_TX : IN STD_LOGIC;
		 WR : IN STD_LOGIC;
		 RESETn : IN STD_LOGIC;
		 LOAD : OUT STD_LOGIC;
		 SHIFT : OUT STD_LOGIC;
		 COUNT_EN : OUT STD_LOGIC;
		 TX_SEL : OUT STD_LOGIC;
		 TXRDY : OUT STD_LOGIC;
		 CLEAR : OUT STD_LOGIC;
		 CNT_TX : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT lpm_mux0
	PORT(data1 : IN STD_LOGIC;
		 data0 : IN STD_LOGIC;
		 sel : IN STD_LOGIC;
		 result : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT lpm_shiftreg0
	PORT(load : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 enable : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 shiftout : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	data :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_17 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_18 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_9 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_10 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_19 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_15 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_16 :  STD_LOGIC;


BEGIN 
SYNTHESIZED_WIRE_9 <= '1';



b2v_AND_GATE_4 : and_gate_4
PORT MAP(data => SYNTHESIZED_WIRE_0,
		 result => SYNTHESIZED_WIRE_18);


b2v_AND_GATE_8 : and_gate_8
PORT MAP(data => SYNTHESIZED_WIRE_1,
		 result => SYNTHESIZED_WIRE_17);


b2v_CNT_TX_MOD_10 : lpm_counter_tx_mod_10
PORT MAP(sclr => SYNTHESIZED_WIRE_2,
		 clock => CK,
		 cnt_en => SYNTHESIZED_WIRE_3,
		 q => SYNTHESIZED_WIRE_0);


b2v_CNT_TX_MOD_217 : lpm_counter_tx
PORT MAP(sclr => SYNTHESIZED_WIRE_4,
		 clock => CK,
		 cnt_en => SYNTHESIZED_WIRE_5,
		 q => SYNTHESIZED_WIRE_1);


b2v_DATA_FF : lpm_ff_0
PORT MAP(clock => CK,
		 data => DIN,
		 q => data(8 DOWNTO 1));


b2v_FSM_TX : fsm_tx
PORT MAP(CK => CK,
		 TC => SYNTHESIZED_WIRE_17,
		 END_TX => SYNTHESIZED_WIRE_18,
		 WR => WR,
		 RESETn => RESETn,
		 LOAD => SYNTHESIZED_WIRE_15,
		 SHIFT => SYNTHESIZED_WIRE_16,
		 COUNT_EN => SYNTHESIZED_WIRE_5,
		 TX_SEL => SYNTHESIZED_WIRE_10,
		 TXRDY => TXRDY,
		 CLEAR => SYNTHESIZED_WIRE_19,
		 CNT_TX => SYNTHESIZED_WIRE_3);





b2v_MUX_2_TO_1 : lpm_mux0
PORT MAP(data1 => SYNTHESIZED_WIRE_8,
		 data0 => SYNTHESIZED_WIRE_9,
		 sel => SYNTHESIZED_WIRE_10,
		 result => TX_UART);


SYNTHESIZED_WIRE_2 <= SYNTHESIZED_WIRE_18 OR SYNTHESIZED_WIRE_19;


SYNTHESIZED_WIRE_4 <= SYNTHESIZED_WIRE_19 OR SYNTHESIZED_WIRE_17;


b2v_TX_SHIFT_REG : lpm_shiftreg0
PORT MAP(load => SYNTHESIZED_WIRE_15,
		 clock => CK,
		 enable => SYNTHESIZED_WIRE_16,
		 data => data,
		 shiftout => SYNTHESIZED_WIRE_8);


data(0) <= '0';
data(9) <= '1';
END bdf_type;