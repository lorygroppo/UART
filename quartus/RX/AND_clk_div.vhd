library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity AND_clk_div is
port(
data: in std_logic_vector (4 downto 0);
output : out std_logic
);
end AND_clk_div;

architecture behavioural of AND_clk_div is
begin
output <= data(4) and data(3) and not(data(2)) and not(data(1)) and not(data(0) )   ;

end behavioural;