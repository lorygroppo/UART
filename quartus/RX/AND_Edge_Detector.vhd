library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity AND_Edge_Detector is
port(
data: in std_logic_vector (6 downto 0);
edge_detection: out std_logic
);
end AND_Edge_Detector;

architecture behavioural of AND_Edge_Detector is
begin
edge_detection <= data(0) and  data(1) and data(2) and not(data(3)) and not(data(4)) and not(data(5)) and not(data(6))    ;

end behavioural;
