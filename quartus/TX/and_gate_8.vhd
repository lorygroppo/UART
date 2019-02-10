LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all;

ENTITY AND_GATE_8 IS
PORT
(
data : in std_logic_vector (7 downto 0);
result : out std_logic
);
END AND_GATE_8;



ARCHITECTURE behavioural OF AND_GATE_8 IS
BEGIN

result <= data(0) and not(data(1)) and not(data(2)) and data(3) and data(4) and not(data(5)) and data(6) and data(7);

end behavioural;
