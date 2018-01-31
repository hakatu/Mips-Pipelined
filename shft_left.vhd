library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity shft_left is
 port(	shft_left_in : in std_logic_vector(31 downto 0);
		shft_left_out: out std_logic_vector(31 downto 0));
end entity;
architecture structure of shft_left is 
begin
shft_left_out <= std_logic_vector(unsigned(shft_left_in) sll 2);
end architecture;

