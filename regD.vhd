library ieee;
use ieee.std_logic_1164.all;
entity regD is 
port(	inst_in, pc4_in, pc8_in: in std_logic_vector(31 downto 0);
		clk, stallD: in std_logic;
		inst_out, pc4_out, pc8_out: out std_logic_vector(31 downto 0));
end entity;
--------------------------------
architecture behavior of regD is 
begin
process(clk)
variable stall_temp: std_logic;
begin
if rising_edge(clk) then
	stall_temp := stallD and not stall_temp;
	if stall_temp = '0' then
		inst_out <= inst_in;
		pc4_out <= pc4_in;
		pc8_out <= pc8_in;
	end if;
end if;
end process;
end behavior;



		