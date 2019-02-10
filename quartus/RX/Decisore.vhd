library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity Decisore is
port(
data: in std_logic_vector (7 downto 0);
decisione : out std_logic
);
end Decisore;

architecture behavioural of Decisore is
signal A, B, C : std_logic :='0';

begin

A <= data(7);
B<= data(6);
C<= data (5);

decisione <= ( A and B ) or (A and C) or (B and C);


end behavioural;