library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
entity alu is 
port ( 	src1, src2 : in std_logic_vector(31 downto 0);
		alu_ctrl : in std_logic_vector(3 downto 0);
		rslt : out std_logic_vector(31 downto 0));
end entity;
architecture structure of alu is 
-----------------------------------------------------------
signal add 		: std_logic_vector(3 downto 0) := "0000";
signal sll_op	: std_logic_vector(3 downto 0) := "0001";
signal srl_op	: std_logic_vector(3 downto 0) := "0010";
signal eq	 	: std_logic_vector(3 downto 0) := "0011";
signal neq 		: std_logic_vector(3 downto 0) := "0100";
signal and_op 	: std_logic_vector(3 downto 0) := "0101";
signal or_op 	: std_logic_vector(3 downto 0) := "0110";
signal nor_op	: std_logic_vector(3 downto 0) := "0111";
signal slt 		: std_logic_vector(3 downto 0) := "1000";
signal sll_16	: std_logic_vector(3 downto 0) := "1001";
-----------------------------------------------------------
signal temp 	: std_logic_vector(32 downto 0); -- bit 33 is bit carry 
begin
temp <= (('0' & src1) + src2) when (alu_ctrl = add) else
		"000000000000000000000000000000000";
rslt <=		temp(31 downto 0) when (alu_ctrl = add) else
			std_logic_vector(unsigned(src2) sll to_integer(unsigned(src1))) when (alu_ctrl = sll_op) else
			std_logic_vector(unsigned(src2) srl to_integer(unsigned(src1))) when (alu_ctrl = srl_op) else
			(src1 and src2) when (alu_ctrl = and_op) else
			(src1 or src2) when (alu_ctrl = or_op) else
			(src1 nor src2) when (alu_ctrl = nor_op) else
			x"0000_0001" when (alu_ctrl = slt) and (src1 < src2) else
			std_logic_vector(unsigned(src2) sll 16) when alu_ctrl = sll_16 else
			x"0000_0000";
end structure;
