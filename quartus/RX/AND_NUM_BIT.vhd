library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity AND_NUM_BIT is
port(
		data: in std_logic_vector (3 downto 0);
		output : out std_logic);
end AND_NUM_BIT;

architecture behavioural of AND_NUM_BIT is
begin
output <= data(3) and not(data(2)) and not(data(1)) and data(0);
end behavioural;