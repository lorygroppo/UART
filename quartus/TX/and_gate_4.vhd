LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all;

ENTITY AND_GATE_4 IS
PORT
(
data : in std_logic_vector (3 downto 0);
result : out std_logic
);
END AND_GATE_4;



ARCHITECTURE behavioural OF AND_GATE_4 IS
BEGIN

result <= not(data(0)) and data(1) and not(data(2)) and data(3);

end behavioural;
