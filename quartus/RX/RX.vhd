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
-- CREATED		"Fri Jan 11 09:22:04 2019"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY RX IS 
	PORT
	(
		RD :  IN  STD_LOGIC;
		CK :  IN  STD_LOGIC;
		RX_UART :  IN  STD_LOGIC;
		RESETn :  IN  STD_LOGIC;
		DAV :  OUT  STD_LOGIC;
		Campionamento_out :  OUT  STD_LOGIC;
		stop_bit_out :  OUT  STD_LOGIC;
		DOUT :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END RX;

ARCHITECTURE bdf_type OF RX IS 

COMPONENT and_edge_detector
	PORT(data : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		 edge_detection : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT lpm_counter_rx_mod_16
	PORT(sclr : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 cnt_en : IN STD_LOGIC;
		 q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

COMPONENT lpm_counter_rx_mod_32
	PORT(sclr : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 cnt_en : IN STD_LOGIC;
		 q : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
	);
END COMPONENT;

COMPONENT decisore
	PORT(data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 decisione : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT fsm_rx
	PORT(RD : IN STD_LOGIC;
		 TC_CNT_MOD_27 : IN STD_LOGIC;
		 TC_CNT_MOD_8_EDGE : IN STD_LOGIC;
		 TC_CNT_MOD_8_BIT : IN STD_LOGIC;
		 START : IN STD_LOGIC;
		 CK : IN STD_LOGIC;
		 RESETn : IN STD_LOGIC;
		 STOP_BIT : IN STD_LOGIC;
		 DAV : OUT STD_LOGIC;
		 SHIFT_LEFT_EDGE : OUT STD_LOGIC;
		 SHIFT_RX_DECISOR : OUT STD_LOGIC;
		 SHIFT_DOUT : OUT STD_LOGIC;
		 CNT_EN_MOD_27 : OUT STD_LOGIC;
		 CNT_EN_MOD_8_EDGE : OUT STD_LOGIC;
		 CNT_ED_MOD_8_BIT : OUT STD_LOGIC;
		 CLEAR : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT lpm_shiftreg_rx_right_9
	PORT(sclr : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 enable : IN STD_LOGIC;
		 shiftin : IN STD_LOGIC;
		 q : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
	);
END COMPONENT;

COMPONENT lpm_shiftreg_rx_left_edge
	PORT(sclr : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 enable : IN STD_LOGIC;
		 shiftin : IN STD_LOGIC;
		 q : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END COMPONENT;

COMPONENT lpm_shiftreg_rx_right_8_bit
	PORT(sclr : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 enable : IN STD_LOGIC;
		 shiftin : IN STD_LOGIC;
		 q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT and_num_bit
	PORT(data : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 output : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT and_clk_div
	PORT(data : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 output : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT and_decisore
	PORT(data : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 output : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	data_out :  STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_28 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_29 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_30 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_31 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_32 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_17 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_18 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_22 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_24 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_25 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_26 :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_27 :  STD_LOGIC_VECTOR(3 DOWNTO 0);


BEGIN 
Campionamento_out <= SYNTHESIZED_WIRE_17;



b2v_AND_Edge_Detector : and_edge_detector
PORT MAP(data => SYNTHESIZED_WIRE_0,
		 edge_detection => SYNTHESIZED_WIRE_31);


b2v_CNT_RX_MOD_16_BIT : lpm_counter_rx_mod_16
PORT MAP(sclr => SYNTHESIZED_WIRE_1,
		 clock => CK,
		 cnt_en => SYNTHESIZED_WIRE_2,
		 q => SYNTHESIZED_WIRE_25);


b2v_CNT_RX_MOD_16_EDGE : lpm_counter_rx_mod_16
PORT MAP(sclr => SYNTHESIZED_WIRE_3,
		 clock => CK,
		 cnt_en => SYNTHESIZED_WIRE_4,
		 q => SYNTHESIZED_WIRE_27);


b2v_CNT_RX_MOD_32 : lpm_counter_rx_mod_32
PORT MAP(sclr => SYNTHESIZED_WIRE_5,
		 clock => CK,
		 cnt_en => SYNTHESIZED_WIRE_6,
		 q => SYNTHESIZED_WIRE_26);


b2v_Decisore : decisore
PORT MAP(data => SYNTHESIZED_WIRE_7,
		 decisione => SYNTHESIZED_WIRE_18);


b2v_FSM_RX : fsm_rx
PORT MAP(RD => RD,
		 TC_CNT_MOD_27 => SYNTHESIZED_WIRE_28,
		 TC_CNT_MOD_8_EDGE => SYNTHESIZED_WIRE_29,
		 TC_CNT_MOD_8_BIT => SYNTHESIZED_WIRE_30,
		 START => SYNTHESIZED_WIRE_31,
		 CK => CK,
		 RESETn => RESETn,
		 STOP_BIT => data_out(8),
		 DAV => DAV,
		 SHIFT_LEFT_EDGE => SYNTHESIZED_WIRE_22,
		 SHIFT_RX_DECISOR => SYNTHESIZED_WIRE_24,
		 SHIFT_DOUT => SYNTHESIZED_WIRE_17,
		 CNT_EN_MOD_27 => SYNTHESIZED_WIRE_6,
		 CNT_EN_MOD_8_EDGE => SYNTHESIZED_WIRE_4,
		 CNT_ED_MOD_8_BIT => SYNTHESIZED_WIRE_2,
		 CLEAR => SYNTHESIZED_WIRE_32);


SYNTHESIZED_WIRE_1 <= SYNTHESIZED_WIRE_32 OR SYNTHESIZED_WIRE_30;


SYNTHESIZED_WIRE_3 <= SYNTHESIZED_WIRE_32 OR SYNTHESIZED_WIRE_29;


b2v_inst2 : lpm_shiftreg_rx_right_9
PORT MAP(sclr => SYNTHESIZED_WIRE_32,
		 clock => CK,
		 enable => SYNTHESIZED_WIRE_17,
		 shiftin => SYNTHESIZED_WIRE_18,
		 q => data_out);


SYNTHESIZED_WIRE_5 <= SYNTHESIZED_WIRE_32 OR SYNTHESIZED_WIRE_28;


b2v_LEFT_SHIFT_RX_EDGE : lpm_shiftreg_rx_left_edge
PORT MAP(sclr => SYNTHESIZED_WIRE_31,
		 clock => CK,
		 enable => SYNTHESIZED_WIRE_22,
		 shiftin => RX_UART,
		 q => SYNTHESIZED_WIRE_0);


b2v_RIGHT_SHIFT_RX_BIT : lpm_shiftreg_rx_right_8_bit
PORT MAP(sclr => SYNTHESIZED_WIRE_32,
		 clock => CK,
		 enable => SYNTHESIZED_WIRE_24,
		 shiftin => RX_UART,
		 q => SYNTHESIZED_WIRE_7);


b2v_TC_CNT_9_BIT : and_num_bit
PORT MAP(data => SYNTHESIZED_WIRE_25,
		 output => SYNTHESIZED_WIRE_30);


b2v_TC_CNT_MOD_27 : and_clk_div
PORT MAP(data => SYNTHESIZED_WIRE_26,
		 output => SYNTHESIZED_WIRE_28);


b2v_TC_CNT_MOD_8_EDGE : and_decisore
PORT MAP(data => SYNTHESIZED_WIRE_27,
		 output => SYNTHESIZED_WIRE_29);

stop_bit_out <= data_out(8);
DOUT(7 DOWNTO 0) <= data_out(7 DOWNTO 0);

END bdf_type;