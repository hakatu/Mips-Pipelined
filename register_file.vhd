library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity register_file is
port ( 	read_reg_1, read_reg_2, write_reg: in std_logic_vector(4 downto 0);
		write_data: in std_logic_vector(31 downto 0);
		write_reg_enable, clk: in std_logic;
		read_data_1, read_data_2: out std_logic_vector(31 downto 0));
end entity;
architecture behavior of register_file is
type mem_array is array (0 to 31) of std_logic_vector(31 downto 0);
signal reg_mem: mem_array := ( 	x"0000_0000",--0
								x"0000_0000",
								x"0000_0000",
								x"0000_0000",
								x"0000_0000",
								x"0000_0000",
								x"0000_0000",
								x"0000_0000",
								x"0000_0000",
								x"0000_0000",
								x"0000_0000",--10
								x"0000_0000",
								x"0000_0000",
								x"0000_0000",
								x"0000_0000",
								x"0000_0000",
								x"0000_0000",
								x"0000_0000",
								x"0000_0000",
								x"0000_0000",
								x"0000_0000",--20
								x"0000_0000",
								x"0000_0000",
								x"0000_0000",
								x"0000_0000",
								x"0000_0000",
								x"0000_0000",
								x"0000_0000",
								x"0000_0000",
								x"0000_0000",
								x"0000_0000",--30
								x"0000_0000");
begin
read_data_1 <= 	write_data when read_reg_1 = write_reg and write_reg_enable ='1' else
				reg_mem(to_integer(unsigned(read_reg_1)));
read_data_2 <= 	write_data when read_reg_2 = write_reg and write_reg_enable ='1' else
				reg_mem(to_integer(unsigned(read_reg_2)));
process(clk)
begin
	if rising_edge(clk) and write_reg_enable = '1'  then
		reg_mem(to_integer(unsigned(write_reg))) <= write_data;
	end if;
end process;
end architecture;


								
								