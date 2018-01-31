library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity compare is
port(	comp1, comp2: in std_logic_vector(31 downto 0);
		comp_ctrl: in std_logic_vector(3 downto 0);
		zero: out std_logic);
end entity;

architecture dataflow of compare is
signal eq : std_logic_vector(3 downto 0) := "0011";
signal neq:	std_logic_vector(3 downto 0) := "0100";
begin
zero <= '1' when (comp_ctrl = eq and comp1 = comp2) or (comp_ctrl = neq and comp1 /= comp2) else
		'0';
end architecture;

