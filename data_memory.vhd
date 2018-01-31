library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;
entity data_memory is
	port (
		address, write_data: in STD_LOGIC_VECTOR (31 downto 0);
		MemWrite, MemRead, byte_enable, clk: in STD_LOGIC;
		read_data: out STD_LOGIC_VECTOR (31 downto 0):=X"0000_0000"
	);
end data_memory;


architecture behavioral of data_memory is	  

type mem_array is array(0 to 255) of STD_LOGIC_VECTOR (7 downto 0);

signal data_mem: mem_array := ((others=> (others=>'0')));
begin
process (clk)
  begin
      if clk = '0' and clk'event then
         if (MemWrite='1') then
          if (byte_enable = '1') then
               data_mem(to_integer (unsigned(address(31 downto 0)))) <= write_data(7 downto 0);
          elsif (byte_enable = '0') then
          data_mem(to_integer (unsigned(address(31 downto 0)))) <= write_data(7 downto 0);
          data_mem(to_integer (unsigned(address(31 downto 0)))+1) <= write_data(15 downto 8);
          data_mem(to_integer (unsigned(address(31 downto 0)))+2) <= write_data(23 downto 16);
          data_mem(to_integer (unsigned(address(31 downto 0)))+3) <= write_data(31 downto 24);
          end if;
          end if ;
       end if ;
end process ;

    read_data(7 downto 0) <= data_mem(to_integer(unsigned(address(31 downto 0)))) when (MemRead = '1' and byte_enable='1') else
				data_mem(to_integer(unsigned(address(31 downto 0)))) when (MemRead = '1' and byte_enable='0') else "00000000";
	read_data(15 downto 8) <= data_mem(to_integer(unsigned(address(31 downto 0)))+1) when (MemRead = '1' and byte_enable='0') else
				"00000000" when (MemRead = '1' and byte_enable='1') else "00000000";
	read_data(23 downto 16) <= data_mem(to_integer(unsigned(address(31 downto 0)))+2) when (MemRead = '1' and byte_enable='0') else
				"00000000" when (MemRead = '1' and byte_enable='1') else "00000000";
	read_data(31 downto 24) <= data_mem(to_integer(unsigned(address(31 downto 0)))+3) when (MemRead = '1' and byte_enable='0') else
				"00000000" when (MemRead = '1' and byte_enable='1') else "00000000";
end architecture;