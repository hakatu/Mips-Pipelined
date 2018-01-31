library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux4_1 is 
	generic (n: natural:= 1); -- number of bits in the choices
	port (
		d3,d2,d1,d0: in std_logic_vector(n-1 downto 0);
		s: in std_logic_vector(1 downto 0):="00";
		y: out std_logic_vector(n-1 downto 0)
	);
end mux4_1;

architecture beh of mux4_1 is
	begin
	y <= d0 when s = "00" else
	 d1 when s = "01" else
	 d2 when s = "10" else
	 d3;
end beh;
	