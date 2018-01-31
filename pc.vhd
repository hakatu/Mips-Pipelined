Library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity PC is
port(
clk, stallF, branch, zero : in std_logic;
address_load : in std_logic_vector(31 downto 0) := x"0000_0000";
address_current : out std_logic_vector(31 downto 0) := x"0000_0000");
end entity;
architecture behavior of PC is
signal address : std_logic_vector(31 downto 0):=x"0000_0000";

begin
process(clk)
variable stall_temp1: std_logic; 
begin
if rising_edge(clk) then
	stall_temp1 := not stall_temp1 and stallF;
	if stall_temp1 = '0' then
	address_current <= address;
	end if;
end if;
end process;
process(clk)
begin
	if falling_edge(clk) then
		if address = address_load then
		address <= address_load +4;
		else address <= address_load;
		end if;
	end if;
end process;
end behavior;
