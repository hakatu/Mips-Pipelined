library ieee;
use ieee.std_logic_1164.all;
entity regM is 
port(	byte_enableE, memwriteE, memreadE, regwriteE, clk: in std_logic;
		memtoregE : in std_logic_vector(1 downto 0);
		rslt_in, write_data_in: in std_logic_vector(31 downto 0);
		writeregE: in std_logic_vector(4 downto 0);
		opcodeE, functE: in std_logic_vector(5 downto 0);
		------------------------------------------------------------------------------------------------
		byte_enableM, memwriteM, memreadM, regwriteM: out std_logic;
		memtoregM : out std_logic_vector(1 downto 0);
		rslt_out, write_data_out: out std_logic_vector(31 downto 0);
		writeregM: out std_logic_vector(4 downto 0);
		opcodeM, functM: out std_logic_vector(5 downto 0));
end entity;
--------------------------------
architecture behavior of regM is 
begin
process(clk)
begin
if rising_edge(clk) then
	byte_enableM <= byte_enableE;
	memwriteM <= memwriteE;
	memreadM <= memreadE;
	memtoregM <= memtoregE;
	regwriteM <= regwriteE;
	rslt_out <= rslt_in;
	write_data_out <= write_data_in;
	writeregM <= writeregE;
	opcodeM <= opcodeE;
	functM <= functE;	
end if;
end process;
end behavior;



		