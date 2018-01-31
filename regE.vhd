library ieee;
use ieee.std_logic_1164.all;
entity regE is 
port(	regdstD, alusrcD, shmtD, byte_enableD, memwriteD, memreadD, regwriteD, clk, stallE: in std_logic;
		memtoregD : in std_logic_vector(1 downto 0);
		alu_ctrl_in : in std_logic_vector(3 downto 0);
		reg1_in, reg2_in, extend_in: in std_logic_vector(31 downto 0);
		shmt_in, rsD, rtD, rdD: in std_logic_vector(4 downto 0);
		opcodeD, functD: in std_logic_vector(5 downto 0);
		------------------------------------------------------------------------------------------------
		regdstE, alusrcE, shmtE, byte_enableE, memwriteE, memreadE, regwriteE: out std_logic;
		memtoregE : out std_logic_vector(1 downto 0);
		alu_ctrl_out : out std_logic_vector(3 downto 0);
		reg1_out, reg2_out, extend_out: out std_logic_vector(31 downto 0);
		shmt_out, rsE, rtE, rdE: out std_logic_vector(4 downto 0);
		opcodeE, functE: out std_logic_vector(5 downto 0));
end entity;
--------------------------------
architecture behavior of regE is 
begin
process(clk)
variable stall_temp: std_logic;
begin
if rising_edge(clk) then
	stall_temp := stallE and not stall_temp;
	if stall_temp = '0' then
		regdstE <= regdstD;
		alusrcE <= alusrcD;
		shmtE <= shmtD;
		byte_enableE <= byte_enableD;
		memwriteE <= memwriteD;
		memreadE <= memreadD;
		memtoregE <= memtoregD;
		regwriteE <= regwriteD;
		shmt_out <= shmt_in;
		reg1_out <= reg1_in;
		reg2_out <= reg2_in;
		alu_ctrl_out <= alu_ctrl_in;
		extend_out <= extend_in;
		rsE <= rsD;
		rtE <=rtD;
		rdE <=rdD;
		opcodeE <= opcodeD;
		functE <= functD;
	else 
		regdstE <= '0';
		alusrcE <= '0';
		shmtE <= '0';
		byte_enableE <= '0';
		memwriteE <= '0';
		memreadE <= '0';
		memtoregE <= "00";
		regwriteE <= '0';
		shmt_out <= "00000";
		reg1_out <= x"00000000";
		reg2_out <= x"00000000";
		alu_ctrl_out <= "0000";
		extend_out <= x"00000000";
		rsE <= "00000";
		rtE <= "00000";
		rdE <= "00000";
		opcodeE <= "000000";
		functE <= "000000";
	end if;
end if;
end process;
end behavior;



		