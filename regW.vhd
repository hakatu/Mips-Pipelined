library ieee;
use ieee.std_logic_1164.all;
entity regW is 
port(	regwriteM, clk: in std_logic;
		memtoregM : in std_logic_vector(1 downto 0);
		rslt_in, read_data_in: in std_logic_vector(31 downto 0);
		writeregM: in std_logic_vector(4 downto 0);
		opcodeM, functM: in std_logic_vector(5 downto 0);
		------------------------------------------------------------------------------------------------
		regwriteW: out std_logic;
		memtoregW : out std_logic_vector(1 downto 0);
		rslt_out, read_data_out: out std_logic_vector(31 downto 0);
		writeregW: out std_logic_vector(4 downto 0);
		opcodeW, functW: out std_logic_vector(5 downto 0));
end entity;
--------------------------------
architecture behavior of regW is 
begin
process(clk)
begin
if rising_edge(clk) then
	memtoregW <= memtoregM;
	regwriteW <= regwriteM;
	rslt_out <= rslt_in;
	read_data_out <= read_data_in;
	writeregW <= writeregM;
	opcodeW <= opcodeM;
	functW <= functM;	
end if;
end process;
end behavior;



		