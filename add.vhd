library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity add is 
port (	input_1, input_2: in std_logic_vector(31 downto 0);
		output: out std_logic_vector(31 downto 0));
end entity;
architecture dataflow of add is 
begin 
output <= input_1 + input_2;
end dataflow;
