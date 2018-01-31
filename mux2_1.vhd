library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux2_1 is 
	generic (n: natural:= 1); -- number of bits in the choices
	port (
		d1,d0: in std_logic_vector(n-1 downto 0);
		s: in std_logic:='0';
		y: out std_logic_vector(n-1 downto 0)
	);
end mux2_1;

architecture beh of mux2_1 is
	begin
y <= d0 when s = '0' else
	 d1 ;
end beh;
	