library ieee;
use ieee.std_logic_1164.all;
entity alu_control is
port ( 	aluop_ctrl : in std_logic_vector(3 downto 0);
		funct_ctrl : in std_logic_vector(5 downto 0);
		ctrl_out   : out std_logic_vector(3 downto 0));
end entity;
architecture behavior of alu_control is 
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
----------------------------------------------------------
begin 
ctrl_out <= add		when ((aluop_ctrl = "0000") and (funct_ctrl = "100000")) or (aluop_ctrl = "0100") or (aluop_ctrl = "1000") else
			sll_op 	when (aluop_ctrl = "0000") and (funct_ctrl = "000000") else
			srl_op 	when (aluop_ctrl = "0000") and (funct_ctrl = "000010") else
			eq		when (aluop_ctrl = "0001") else
			neq		when (aluop_ctrl = "0010") else
			and_op	when ((aluop_ctrl = "0000") and (funct_ctrl = "100100")) or (aluop_ctrl = "0101") else
			or_op	when ((aluop_ctrl = "0000") and (funct_ctrl = "100101")) or (aluop_ctrl = "0110") else
			nor_op	when ((aluop_ctrl = "0000") and (funct_ctrl = "100111")) else
			slt 	when ((aluop_ctrl = "0000") and (funct_ctrl = "101010")) or (aluop_ctrl = "0011") else
			sll_16 	when (aluop_ctrl = "0111") else
			"1111";
end architecture;

			
