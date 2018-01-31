library ieee;
use ieee.std_logic_1164.all;
entity mux2_1_logic is
port (	d1, d0: in std_logic;
		s : in std_logic:='0';
		y : out std_logic);
end entity;
architecture dataflow of mux2_1_logic is
begin 
y <= d1 when s = '1' else
	 d0;
end dataflow;
