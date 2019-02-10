library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity invert is
port(
data: in std_logic_vector (7 downto 0);
output : out std_logic_vector (7 downto 0)
);
end invert;

architecture behavioural of invert is
begin
output (7) <= data(0);
output (6) <= data(1);
output (5) <= data(2);
output (4) <= data(3);
output (3) <= data(4);
output (2) <= data(5);
output (1) <= data(6);
output (0) <= data(7);

end behavioural;