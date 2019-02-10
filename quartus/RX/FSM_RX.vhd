LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all;

ENTITY FSM_RX IS
PORT(		RD, TC_CNT_MOD_27, TC_CNT_MOD_8_EDGE, TC_CNT_MOD_8_BIT, START, CK, RESETn, STOP_BIT: IN STD_LOGIC;
			DAV, SHIFT_LEFT_EDGE, SHIFT_RX_DECISOR, SHIFT_DOUT, CNT_EN_MOD_27, CNT_EN_MOD_8_EDGE, CNT_ED_MOD_8_BIT, CLEAR: OUT STD_LOGIC);
END FSM_RX;

ARCHITECTURE Behavioural OF FSM_RX IS

TYPE state IS (Reset, Clk_divider_ED,  Edge_detection, Clk_divider_decisore , Decisore,Decisore2, Accumulo_output, Accumulo_Output2, Ricezione_terminata, Uscita_letta, Wait_read);
SIGNAL present_state, next_state : state;

BEGIN
PROCESS(CK,RESETn)
BEGIN
	IF(RESETn = '0') THEN
		present_state <= RESET;
	ELSIF (CK'event AND CK='1') THEN
		present_state <= next_state;	
	END IF;
END PROCESS;

PROCESS(present_state, RD, TC_CNT_MOD_27, TC_CNT_MOD_8_EDGE, TC_CNT_MOD_8_BIT, START, STOP_BIT)
BEGIN
CASE present_state IS

	WHEN Reset => 
		CLEAR <= '1';
		DAV <= '0';
		SHIFT_LEFT_EDGE <= '0';
		SHIFT_RX_DECISOR <= '0';
		SHIFT_DOUT <= '0';
		CNT_EN_MOD_27 <= '0';
		CNT_EN_MOD_8_EDGE <='0';
		CNT_ED_MOD_8_BIT <='0';
	
		next_state <= CLk_divider_ED;
		
	WHEN Clk_divider_ED => 
		CLEAR <= '0';
		DAV <= '0';
		SHIFT_LEFT_EDGE <= '0';
		SHIFT_RX_DECISOR <= '0';
		SHIFT_DOUT <= '0';
		CNT_EN_MOD_27 <= '1';
		CNT_EN_MOD_8_EDGE <='0';
		CNT_ED_MOD_8_BIT <='0';
		
		IF (TC_CNT_MOD_27 = '1') THEN
		next_state <= Edge_detection;
		ELSE
		next_state <= Clk_divider_ED;
		END IF;		
		
	WHEN Edge_detection => 
		CLEAR <= '0';
		DAV <= '0';
		SHIFT_LEFT_EDGE <= '1';
		SHIFT_RX_DECISOR <= '0';
		SHIFT_DOUT <= '0';
		CNT_EN_MOD_27 <= '0';
		CNT_EN_MOD_8_EDGE <='0';
		CNT_ED_MOD_8_BIT <='0';
		
		IF (START = '1') THEN
		next_state <= clk_divider_decisore;
		ELSE
		next_state <= clk_divider_ED;
		END IF;
			
		
	WHEN Clk_divider_decisore => 
		CLEAR <= '0';
		DAV <= '0';
		SHIFT_LEFT_EDGE <= '0';
		SHIFT_RX_DECISOR <= '0';
		SHIFT_DOUT <= '0';
		CNT_EN_MOD_27 <= '1';
		CNT_EN_MOD_8_EDGE <='0';
		CNT_ED_MOD_8_BIT <='0';
		
		IF (TC_CNT_MOD_27 = '1') THEN
		next_state <= Decisore ;
		ELSE
		next_state <= Clk_divider_decisore;
		END IF;	
		
	WHEN Decisore => 
		CLEAR <= '0';
		DAV <= '0';
		SHIFT_LEFT_EDGE <= '0';
		SHIFT_RX_DECISOR <= '1';
		SHIFT_DOUT <= '0';
		CNT_EN_MOD_27 <= '0';
		CNT_EN_MOD_8_EDGE <='1';
		CNT_ED_MOD_8_BIT <='0';
		
		next_state <= Decisore2 ;

	
	WHEN Decisore2 => 
		CLEAR <= '0';
		DAV <= '0';
		SHIFT_LEFT_EDGE <= '0';
		SHIFT_RX_DECISOR <= '0';
		SHIFT_DOUT <= '0';
		CNT_EN_MOD_27 <= '0';
		CNT_EN_MOD_8_EDGE <='0';
		CNT_ED_MOD_8_BIT <='0';
		
		IF (TC_CNT_MOD_8_EDGE = '1') THEN
		next_state <= Accumulo_output ;
		ELSE 
		next_state <= CLK_divider_decisore;
		END IF;	
		
	WHEN Accumulo_output => 
		CLEAR <= '0';
		DAV <= '0';
		SHIFT_LEFT_EDGE <= '0';
		SHIFT_RX_DECISOR <= '0';
		SHIFT_DOUT <= '1';
		CNT_EN_MOD_27 <= '0';
		CNT_EN_MOD_8_EDGE <='0';
		CNT_ED_MOD_8_BIT <='1';
		
		next_state <= Accumulo_output2;
		
	WHEN Accumulo_output2 => 	
		CLEAR <= '0';
		DAV <= '0';
		SHIFT_LEFT_EDGE <= '0';
		SHIFT_RX_DECISOR <= '0';
		SHIFT_DOUT <= '0';
		CNT_EN_MOD_27 <= '0';
		CNT_EN_MOD_8_EDGE <='0';
		CNT_ED_MOD_8_BIT <='0';
		
		IF (TC_CNT_MOD_8_BIT = '1') THEN
		next_state <= Ricezione_terminata ;
		ELSE 
		next_state <= Clk_divider_decisore;
		END IF;	
		
	WHEN Ricezione_terminata => 
		CLEAR <= '0';
		DAV <= '0';
		SHIFT_LEFT_EDGE <= '0';
		SHIFT_RX_DECISOR <= '0';
		SHIFT_DOUT <= '0';
		CNT_EN_MOD_27 <= '0';
		CNT_EN_MOD_8_EDGE <='0';
		CNT_ED_MOD_8_BIT <='0';
		
		IF (STOP_BIT = '0') THEN
		next_state <= Reset;
		ELSE
		next_state <= Wait_read;
		END IF;
	
	WHEN Wait_read => 
		CLEAR <= '0';
		DAV <= '1';
		SHIFT_LEFT_EDGE <= '0';
		SHIFT_RX_DECISOR <= '0';
		SHIFT_DOUT <= '0';
		CNT_EN_MOD_27 <= '0';
		CNT_EN_MOD_8_EDGE <='0';
		CNT_ED_MOD_8_BIT <='0';
		
		IF (RD = '1') THEN
		next_state <= Uscita_letta ;
		ELSE
		next_state <= Wait_read;
		END IF;	
		
	WHEN Uscita_letta => 
		CLEAR <= '0';
		DAV <= '0';
		SHIFT_LEFT_EDGE <= '0';
		SHIFT_RX_DECISOR <= '0';
		SHIFT_DOUT <= '0';
		CNT_EN_MOD_27 <= '0';
		CNT_EN_MOD_8_EDGE <='0';
		CNT_ED_MOD_8_BIT <='0';
		
		next_state <= Reset;
					
	END CASE;
		
END PROCESS;
END Behavioural;