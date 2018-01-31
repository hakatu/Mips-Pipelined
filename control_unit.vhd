library ieee;
use ieee.std_logic_1164.all;
entity control_unit is 
port(	opcodeD, funcD, opcodeF, funcF	: in std_logic_vector(5 downto 0) := "000000";
		branch, memread, memwrite, alusrc, regwrite, sign_zero, shmt, byte_enable, regdst, jal: out std_logic := '0';
		jump, memtoreg: out std_logic_vector(1 downto 0) := "00";
		aluop : out std_logic_vector(3 downto 0) := "0000" );		
end entity;
architecture behavior of control_unit is 
begin
regdst <=	'1' when opcodeD = "000000" else
			'0' when opcodeD = "001000" else
			'0' when opcodeD = "001100" else
			'0' when opcodeD = "001101" else
			'0' when opcodeD = "000100" else
			'0' when opcodeD = "000101" else
			'0' when opcodeD = "001010" else
			'0' when opcodeD = "100011" else
			'0' when opcodeD = "001111" else
			'0' when opcodeD = "100000" else
			'0' when opcodeD = "101011" else
			'0' when opcodeD = "101000" else
			'0' when opcodeD = "000010" else
			'0' when opcodeD = "000011" else
			'0';
jal <= 		'1' when opcodeD = "000011" else
			'0';
jump <=		"01" when opcodeD = "000000" and funcD = "001000" else -- jr
			"00" when opcodeF = "000000" else
			"00" when opcodeF = "001000" else
			"00" when opcodeF = "001100" else
			"00" when opcodeF = "001101" else
			"00" when opcodeF = "000100" else
			"00" when opcodeF = "000101" else
			"00" when opcodeF = "001010" else
			"00" when opcodeF = "100011" else
			"00" when opcodeF = "001111" else
			"00" when opcodeF = "100000" else
			"00" when opcodeF = "101011" else
			"00" when opcodeF = "101000" else
			"11" when opcodeF = "000010" else
			"11" when opcodeF = "000011" else
			"00";
memtoreg <= "11" when opcodeD = "000000" else
			"11" when opcodeD = "001000" else
			"11" when opcodeD = "001100" else
			"11" when opcodeD = "001101" else
			"01" when opcodeD = "000100" else
			"01" when opcodeD = "000101" else
			"11" when opcodeD = "001010" else
			"00" when opcodeD = "100011" else
			"11" when opcodeD = "001111" else
			"10" when opcodeD = "100000" else--
			"01" when opcodeD = "101011" else
			"01" when opcodeD = "101000" else
			"01" when opcodeD = "000010" else
			"01" when opcodeD = "000011" else--
			"11";
branch <=	'0' when opcodeD = "000000" else
			'0' when opcodeD = "001000" else
			'0' when opcodeD = "001100" else
			'0' when opcodeD = "001101" else
			'1' when opcodeD = "000100" else
			'1' when opcodeD = "000101" else
			'0' when opcodeD = "001010" else
			'0' when opcodeD = "100011" else
			'0' when opcodeD = "001111" else
			'0' when opcodeD = "100000" else
			'0' when opcodeD = "101011" else
			'0' when opcodeD = "101000" else
			'0' when opcodeD = "000010" else
			'0' when opcodeD = "000011" else
			'0';
memread <=	'0' when opcodeD = "000000" else
			'0' when opcodeD = "001000" else
			'0' when opcodeD = "001100" else
			'0' when opcodeD = "001101" else
			'0' when opcodeD = "000100" else
			'0' when opcodeD = "000101" else
			'0' when opcodeD = "001010" else
			'1' when opcodeD = "100011" else
			'0' when opcodeD = "001111" else
			'1' when opcodeD = "100000" else
			'0' when opcodeD = "101011" else
			'0' when opcodeD = "101000" else
			'0' when opcodeD = "000010" else
			'0' when opcodeD = "000011" else
			'0';
memwrite <=	'0' when opcodeD = "000000" else
			'0' when opcodeD = "001000" else
			'0' when opcodeD = "001100" else
			'0' when opcodeD = "001101" else
			'0' when opcodeD = "000100" else
			'0' when opcodeD = "000101" else
			'0' when opcodeD = "001010" else
			'0' when opcodeD = "100011" else
			'0' when opcodeD = "001111" else
			'0' when opcodeD = "100000" else
			'1' when opcodeD = "101011" else
			'1' when opcodeD = "101000" else
			'0' when opcodeD = "000010" else
			'0' when opcodeD = "000011" else
			'0';
alusrc <=	'0' when opcodeD = "000000" else
			'1' when opcodeD = "001000" else
			'1' when opcodeD = "001100" else
			'1' when opcodeD = "001101" else
			'0' when opcodeD = "000100" else
			'0' when opcodeD = "000101" else
			'1' when opcodeD = "001010" else
			'1' when opcodeD = "100011" else
			'1' when opcodeD = "001111" else
			'1' when opcodeD = "100000" else
			'1' when opcodeD = "101011" else
			'1' when opcodeD = "101000" else
			'0' when opcodeD = "000010" else
			'0' when opcodeD = "000011" else
			'0';
regwrite <=	'0' when opcodeD = "000000" and funcD = "001000" else -- jr
			'1' when opcodeD = "000000" else
			'1' when opcodeD = "001000" else
			'1' when opcodeD = "001100" else
			'1' when opcodeD = "001101" else
			'0' when opcodeD = "000100" else
			'0' when opcodeD = "000101" else
			'1' when opcodeD = "001010" else
			'1' when opcodeD = "100011" else
			'1' when opcodeD = "001111" else
			'1' when opcodeD = "100000" else
			'0' when opcodeD = "101011" else
			'0' when opcodeD = "101000" else
			'0' when opcodeD = "000010" else
			'1' when opcodeD = "000011" else
			'0';
sign_zero <='0' when opcodeD = "000000" else
			'1' when opcodeD = "001000" else
			'0' when opcodeD = "001100" else
			'0' when opcodeD = "001101" else
			'1' when opcodeD = "000100" else
			'1' when opcodeD = "000101" else
			'1' when opcodeD = "001010" else
			'1' when opcodeD = "100011" else
			'0' when opcodeD = "001111" else
			'1' when opcodeD = "100000" else
			'1' when opcodeD = "101011" else
			'1' when opcodeD = "101000" else
			'0' when opcodeD = "000010" else
			'0' when opcodeD = "000011" else
			'0';
shmt <= 	'1' when opcodeD = "000000" and funcD = "000000" else
			'1' when opcodeD= "000000" and funcD = "000010" else
			'0';
aluop <=	"0000" when opcodeD = "000000" else
			"1000" when opcodeD = "001000" else
			"0101" when opcodeD = "001100" else
			"0110" when opcodeD = "001101" else
			"0001" when opcodeD = "000100" else
			"0010" when opcodeD = "000101" else
			"0011" when opcodeD = "001010" else
			"0100" when opcodeD = "100011" else
			"0111" when opcodeD = "001111" else
			"0100" when opcodeD = "100000" else
			"0100" when opcodeD = "101011" else
			"0100" when opcodeD = "101000" else
			"1111" when opcodeD = "000010" else
			"1111" when opcodeD = "000011" else
			"0000";	
byte_enable <=  '1' when opcodeD = "101000" or opcodeD = "100000" else
				'0';
end architecture;
