----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.12.2018 16:47:49
-- Design Name: 
-- Module Name: TB_Butterfly - Structural
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_signed.all;
USE STD.textio.all;
USE ieee.std_logic_textio.all;

entity TB_Butterfly is

end TB_Butterfly;

architecture Structural of TB_Butterfly is

component Butterfly_structural is
  Port ( 
  clock      :  in std_logic;
  input_w    : in std_logic_vector (15 downto 0);
  input_data : in std_logic_vector (15 downto 0);
  input_start: in std_logic;
  output_data: out std_logic_vector (15 downto 0);
  output_done: out std_logic
  );
end component;

file file_input: text;
file file_output: text;
file file_start: text;

 signal clock_t:  std_logic;
 signal input_w_t :  std_logic_vector (15 downto 0);
 signal input_data_t :  std_logic_vector (15 downto 0);
 signal input_start_t:  std_logic;
 signal output_data_t: std_logic_vector (15 downto 0);
 signal output_done_t:  std_logic;


begin

Butterfly: Butterfly_Structural port map(
 clock       =>  clock_t         ,
 input_w     =>  input_w_t       ,
 input_data  =>  input_data_t    ,
 input_start =>  input_start_t   ,
 output_data =>  output_data_t   ,
 output_done =>  output_done_t
);

process --clock generation
begin
clock_t<='1';
wait for 20ns;
clock_t<='0';
wait for 20ns;
end process;

process --input reading
	variable v_ILINE	: line;
	--variable v_OLINE	: line;
	variable v_DATA		: std_logic_vector(15 downto 0);
	variable v_W		: std_logic_vector(15 downto 0);
	variable v_SPACE	: character;
	variable i : integer :=0;
begin
	file_open(file_input, "input_vectors.txt", read_mode);
	while not endfile(file_input) loop
     if i=0 then --aspetto lo start e un colpo di clock
	   wait until input_start_t'event and input_start_t='1';
	   wait until clock_t'event and clock_t='1';
	   wait until clock_t'event and clock_t='0';
	  else
	   wait until clock_t'event and clock_t='0';
	  end if;
		--leggo input da file
		readline(file_input, v_ILINE);
		read(v_ILINE, v_DATA);
		read(v_ILINE, v_SPACE);
		read(v_ILINE, v_W);
		--modifico segnali di input
		input_data_t	<= v_DATA;
		input_w_t		<= v_W;
		if i<3 then
		  i:=i+1;
		else
		  i:=0;  
		end if;
	end loop;
	file_close(file_input);
	wait;
end process;

file_open(file_output, "output_vectors.txt", write_mode);
process (output_data_t) --output wrtiting
  variable v_OLINE	: line;
--  variable i : integer :=0;
  begin
    
    if output_data_t'event then
      write(v_OLINE, output_data_t, right, 16);
      writeline(file_output, v_OLINE);
    end if;

end process;    
file_close(file_output);

process --start reading
	variable v_START : line;
	variable v_TIME	: time;
	variable time_tot : time;
begin
	file_open(file_start, "start_signal.txt", read_mode);
    input_start_t<='0';
	while not endfile(file_start) loop
      --leggo prossimo start da file da file
      readline(file_start, v_START);
	  read(v_START, v_TIME);
      wait for v_TIME;
      input_start_t<='1';
      wait for 40 ns;
      input_start_t<='0';  
	end loop;
	file_close(file_start);
	wait;
end process;

end Structural;
