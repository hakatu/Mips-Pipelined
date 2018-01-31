library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shft_left_s is
port(	shft_left_s_in : in std_logic_vector(25 downto 0);
		pc4 : in std_logic_vector(3 downto 0);
		jump_address : out std_logic_vector(31 downto 0));
end entity;
architecture structure of shft_left_s is 
signal temp0: std_logic_vector(31 downto 0);
signal temp1: unsigned(31 downto 0);
signal temp2: unsigned(31 downto 0);
signal temp3: std_logic_vector(31 downto 0);
begin
temp0 <= "000000" & shft_left_s_in;
temp1 <= shift_left(unsigned(temp0),2);
temp3<= x"0000000" & pc4;
temp2 <= shift_left(unsigned(temp3),28);
jump_address <= std_logic_vector(unsigned(temp1) or unsigned(temp2));
end architecture;
