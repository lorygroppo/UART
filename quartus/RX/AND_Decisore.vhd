library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity AND_Decisore is
port(
data: in std_logic_vector (3 downto 0);
output : out std_logic
);
end AND_Decisore;

architecture behavioural of AND_Decisore is
begin
output <= data(3) and not(data(2)) and not(data(1)) and not(data(0))  ;

end behavioural;