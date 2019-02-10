library ieee;
use ieee.std_logic_1164.all;

entity inverter is
port(
input_inverting: in std_logic_vector (7 downto 0);
output_inverted: out std_logic_vector(7 downto 0)
);
end inverter;

architecture behavioural of inverter is
begin

output_inverted(7)<= input_inverting(0);
output_inverted(6)<= input_inverting(1);
output_inverted(5)<= input_inverting(2);
output_inverted(4)<= input_inverting(3);
output_inverted(3)<= input_inverting(4);
output_inverted(2)<= input_inverting(5);
output_inverted(1)<= input_inverting(6);
output_inverted(0)<= input_inverting(7);

end behavioural;
