LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all;

ENTITY FSM_TX IS
PORT
(	CK : IN STD_LOGIC;
	TC, END_TX : IN STD_LOGIC;
	WR: IN STD_LOGIC;
	RESETn: IN STD_LOGIC;
	LOAD, SHIFT, COUNT_EN, TX_SEL, TXRDY, CLEAR, CNT_TX: OUT STD_LOGIC);
END FSM_TX;

ARCHITECTURE Behavioural OF FSM_TX IS

TYPE state_type IS(RESET,WAIT_WR,LOAD_DATA,TX_BIT,NEXT_BIT,CONTROL_END_BIT);
SIGNAL present_state, next_state : state_type;

BEGIN

PROCESS(CK,RESETn)
BEGIN
	IF(RESETn = '0') THEN
		present_state <= RESET;
	ELSIF (CK'event AND CK='1') THEN
		present_state <= next_state;	
	END IF;
END PROCESS;

PROCESS(present_state, WR, TC, END_TX)
BEGIN
CASE (present_state) IS 
   	WHEN RESET => 
		CLEAR <= '1';
	   LOAD <= '0';
		SHIFT <= '0';
		COUNT_EN <= '0';
		TX_SEL <= '0';
		TXRDY <= '1';
		CNT_TX <= '0';
		
		next_state <= WAIT_WR;
		
	WHEN WAIT_WR => 
		CLEAR <= '0';
	   LOAD <= '0';
		SHIFT <= '0';
		COUNT_EN <= '0';
		TX_SEL <= '0';
		TXRDY <= '1';
		CNT_TX <= '0';
		
		IF WR ='1' THEN
		next_state <= LOAD_DATA;
		ELSE
		next_state <= WAIT_WR;
		END IF;

	WHEN LOAD_DATA=> 
		CLEAR <= '0';
	   LOAD <= '1';
		SHIFT <= '1';
		COUNT_EN <= '1';
		TX_SEL <= '0';
		TXRDY <= '0';
		CNT_TX <= '0';
		
		next_state <= TX_BIT;

	WHEN TX_BIT => 
		CLEAR <= '0';
	   LOAD <= '0';
		SHIFT <= '0';
		COUNT_EN <= '1';
		TX_SEL <= '1';
		TXRDY <= '0';
		CNT_TX <= '0';
		
		IF TC = '1' THEN
		next_state <= NEXT_BIT;
		ELSE
		next_state <= TX_BIT;	
		END IF;
		
	WHEN NEXT_BIT => 
		CLEAR <= '0';
	   LOAD <= '0';
		SHIFT <= '1';
		COUNT_EN <= '1';
		TX_SEL <= '1';
		TXRDY <= '0';
		CNT_TX <= '1';
		
		next_state <= CONTROL_END_BIT;
		
	WHEN CONTROL_END_BIT => 
		CLEAR <= '0';
	   LOAD <= '0';
		SHIFT <= '0';
		COUNT_EN <= '1';
		TX_SEL <= '1';
		TXRDY<= '0';
		CNT_TX <= '0';
		
		IF END_TX = '1' THEN
		next_state <= WAIT_WR;
		ELSE
		next_state <= TX_BIT;	
		END IF;
		
END CASE;

END PROCESS;

END Behavioural;