library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity mips_pipeline is 
port (	clk: in std_logic);
end entity;
--------------------------------
architecture hungdeptrai of mips_pipeline is 
------------dummy---------------vector------------------------signal----------------theothutubitoke
signal read_data_aW,rslt_aW,read_data_bW,write_data_aM,src1,src2,Rslt_aM, data_src2_mux,data_src1_mux,zero_extend_out,Extend_aE, read_data_1_aE,read_data_2_aE,Compare1,write_data_bM,
Compare2,Rslt,SHIFTLEFT2_out,Extend_bE,writedataW,address_load,address_current,Instr_bD,Instr_aD,pcp4_bD,pcp8_bD,pcp4_aD,pcp8_aD,branch_addr,bnz_addr,jump_addr,R_rs,write_data_mux,read_data_2,read_data_1 : std_logic_vector(31 downto 0);
signal shift_left_s_in : std_logic_vector(25 downto 0);
signal opcodeD, opcodeE, opcodeM, opcodeW, opcodeF, functF, functD, functE, functM, functW : std_logic_vector(5 downto 0);
signal rsD, rtD, rsE, rtE, writeregE, writeregM, writeregW,write_reg_mux, shmt_out,rdE : std_logic_vector(4 downto 0);
signal aluop,ctrl_out_bE,ctrl_out_aE : std_logic_vector(3 downto 0);
signal jump,fwAE, fwBE,memtoregD,memtoregE,memtoregM,memtoregW,fwAD,fwBD,fwCD: std_logic_vector(1 downto 0);
signal regdstE, alusrcE, shmtE, byte_enableE, memwriteE, memreadE, regwriteE, bnz, branch,zero,memreadD, memwriteD, alusrcD, regwriteD,regwriteW, sign_zero, shmtD, byte_enableD, regdstD, jal,byte_enableM, memwriteM, memreadM, regwriteM : std_logic;
signal stallE, stallD, stallF, reg_en, fwCE: std_logic;
--------------------------------component-------------------------------------------
component add
port (	input_1, input_2: in std_logic_vector(31 downto 0);
		output: out std_logic_vector(31 downto 0));
    end component;
component alu
port ( 	src1, src2 : in std_logic_vector(31 downto 0);
		alu_ctrl : in std_logic_vector(3 downto 0);
		rslt : out std_logic_vector(31 downto 0));
    end component;
component alu_control
port ( 	aluop_ctrl : in std_logic_vector(3 downto 0);
		funct_ctrl : in std_logic_vector(5 downto 0);
		ctrl_out   : out std_logic_vector(3 downto 0));
    end component;
component control_unit
port(	opcodeD, funcD, opcodeF, funcF	: in std_logic_vector(5 downto 0) := "000000";
		branch, memread, memwrite, alusrc, regwrite, sign_zero, shmt, byte_enable, regdst, jal: out std_logic := '0';
		jump, memtoreg: out std_logic_vector(1 downto 0) := "00";
		aluop : out std_logic_vector(3 downto 0) := "0000" );		
	end component;
component data_memory
	port (
		address, write_data: in STD_LOGIC_VECTOR (31 downto 0);
		MemWrite, MemRead, byte_enable, clk: in STD_LOGIC;
		read_data: out STD_LOGIC_VECTOR (31 downto 0):=X"0000_0000"
	);
    end component;
component hazard_unit
port(	opcodeF, opcodeD, opcodeE, opcodeM, opcodeW, functF, functD, functE, functM, functW: in std_logic_vector(5 downto 0);
		rsD, rtD, rsE, rtE, writeregE, writeregM, writeregW: in std_logic_vector(4 downto 0);
		branch, zero: in std_logic;
		stallF, stallD, stallE, fwCE: out std_logic;
		fwAD, fwBD, fwCD, fwAE, fwBE: out std_logic_vector(1 downto 0));
    end component;
component instruction_memory
    Port ( address : in  STD_LOGIC_VECTOR (31 downto 0);
           clk: in STD_logic;
           Instr : out  STD_LOGIC_VECTOR (31 downto 0));
    end component;
component mux2_1
	generic (n: natural:= 1); -- number of bits in the choices
	port (
		d1,d0: in std_logic_vector(n-1 downto 0);
		s: in std_logic:='0';
		y: out std_logic_vector(n-1 downto 0)
	);
	end component;
component mux4_1
	generic (n: natural:= 1); -- number of bits in the choices
	port (
		d3,d2,d1,d0: in std_logic_vector(n-1 downto 0);
		s: in std_logic_vector(1 downto 0):="00";
		y: out std_logic_vector(n-1 downto 0)
	);
	end component;
component mux4_1_s
port (	d3, d2, d1, d0: in std_logic_vector(4 downto 0):="00000";
		s : in std_logic_vector(1 downto 0):="00";
		y : out std_logic_vector(4 downto 0));
	end component;
component pc
port(
clk, stallF, branch, zero: in std_logic;
address_load : in std_logic_vector(31 downto 0) := x"0000_0000";
address_current : out std_logic_vector(31 downto 0));
	end component;
component plus4
port(
pc : in std_logic_vector(31 downto 0);
pcplus4 : out std_logic_vector(31 downto 0));
	end component;
component plus8
port(
pc : in std_logic_vector(31 downto 0);
pcplus8 : out std_logic_vector(31 downto 0));
	end component;
component register_file
port ( 	read_reg_1, read_reg_2, write_reg: in std_logic_vector(4 downto 0);
		write_data: in std_logic_vector(31 downto 0);
		write_reg_enable, clk: in std_logic;
		read_data_1, read_data_2: out std_logic_vector(31 downto 0));
		end component;
component shft_left
 port(	shft_left_in : in std_logic_vector(31 downto 0);
		shft_left_out: out std_logic_vector(31 downto 0));
		end component;
component shft_left_s
port(	shft_left_s_in : in std_logic_vector(25 downto 0);
		pc4 : in std_logic_vector(3 downto 0);
		jump_address : out std_logic_vector(31 downto 0));
		end component;
component sign_zero_extend
port(
sign_zero : in std_logic;
imm : in std_logic_vector(15 downto 0);
extended : out std_logic_vector(31 downto 0));
		end component;		
component zero_extend
port(
imm : in std_logic_vector(4 downto 0);
extended : out std_logic_vector(31 downto 0));
		end component;
component compare
port(	comp1, comp2: in std_logic_vector(31 downto 0);
		comp_ctrl: in std_logic_vector(3 downto 0);
		zero: out std_logic);
		end component;
component regD
port(	inst_in, pc4_in, pc8_in: in std_logic_vector(31 downto 0);
		clk, stallD: in std_logic;
		inst_out, pc4_out, pc8_out: out std_logic_vector(31 downto 0));
		end component;
component regE
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
		end component;	
component regM
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
		end component;
component regW
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
		end component;
component mux2_1_logic
	port (
		d1,d0: in std_logic;
		s: in std_logic:='0';
		y: out std_logic
	);
end component;			
--------------------------------hetcomponentroinedoqua-----------------------------												
begin
bnz <= branch and zero;
opcodeF <= 	Instr_bD(31 downto 26) ;
opcodeD <= 	Instr_aD(31 downto 26);
functF <=	Instr_bD(5 downto 0) ;
functD <= 	Instr_aD(5 downto 0) ;
rsD <= Instr_aD(25 downto 21);
rtD <= Instr_aD(20 downto 16);
-----------portmapcuaHung----------------------------------------------------------
PC1: pc port map(
clk => clk,
stallF => stallF,
branch => branch,
zero => zero,
address_load => address_load,
address_current => address_current
);
IM: instruction_memory port map(
address => address_current,
clk => clk,
Instr => instr_bD
);
MUX1: mux2_1 generic map(32) port map(
d1 => branch_addr,
d0 => pcp4_bD,
s => bnz,
y => bnz_addr
);
PCP41: plus4 port map(
pc => address_current,
pcplus4 => pcp4_bD
);
PCP81: plus8 port map(
pc => address_current,
pcplus8 => pcp8_bD
);
SHIFTLEFT2S:  shft_left_s port map(
shft_left_s_in => instr_bD(25 downto 0),
		pc4 => pcp4_bD(31 downto 28),
		jump_address => jump_addr
);
MUX2: mux4_1 generic map(32) port map(
d3 => jump_addr,
d2 => R_rs,
d1 => R_rs,
d0 => bnz_addr,
s => jump,
y => address_load
);
HAZARDINTENSIVE: hazard_unit port map(
opcodeF => opcodeF,
opcodeD =>  opcodeD,
opcodeE => opcodeE,
opcodeM => opcodeM,
opcodeW => opcodeW,
functF => functF,
functD => functD,
functE => functE,
functM => functM,
functW => functW,
rsD => rsD,
rtD => rtD,
rsE => rsE,
rtE => rtE,
writeregE => writeregE,
writeregM => writeregM,
writeregW => writeregW,
stallF => stallF,
stallD => stallD,
stallE => stallE,
fwAD => fwAD,
fwBD => fwBD,
fwCD => fwCD,
fwAE => fwAE,
fwBE => fwBE, 
fwCE => fwCE,
branch => branch,
zero => zero
);
REGD1: regD port map(
inst_in => instr_bD,
pc4_in => pcp4_bD,
pc8_in => pcp8_bD,
clk => clk,
stallD => stallD,
inst_out => Instr_aD,
pc4_out => pcp4_aD ,
pc8_out => pcp8_aD
);
CUMEANSCONTROLUNIT: control_unit port map(
opcodeD => opcodeD,
funcD => functD,
opcodeF => opcodeF,
funcF => functF,
branch => branch,
memread => memreadD,
memwrite => memwriteD,
alusrc => alusrcD,
regwrite => regwriteD,
sign_zero => sign_zero,
shmt => shmtD,
byte_enable => byte_enableD,
regdst => regdstD,
jal => jal,
jump => jump,
memtoreg => memtoregD,
aluop => aluop
);
REGISTERFILE: register_file port map(
read_reg_1 => instr_aD(25 downto 21),
read_reg_2 => instr_aD(20 downto 16),
write_reg => write_reg_mux,
write_data => write_data_mux,
write_reg_enable => reg_en,
clk => clk,
read_data_1 => read_data_1,
read_data_2 => read_data_2
);
-----------------------------------
MUXEXTRAFORJAL: mux2_1_logic port map(
d1 => regwriteD,
d0 => regwriteW,
s => jal,
y => reg_en
);
-----------------------------------
MUX3: mux2_1 generic map(5) port map(
d1 => "11111",
d0 => writeregW,
s => jal,
y => write_reg_mux
);
MUX4: mux2_1 generic map(32) port map(
d1 => pcp8_aD,
d0 => writedataW,
s => jal,
y => write_data_mux
);
ALUCTRL: alu_control port map (
aluop_ctrl => aluop,
funct_ctrl =>Instr_aD(5 downto 0),
ctrl_out => ctrl_out_bE
);
SZEXTENSION: sign_zero_extend port map (
sign_zero => sign_zero,
imm => Instr_aD(15 downto 0),
extended => Extend_bE
);
SHIFTLEFT2: shft_left port map (
shft_left_in => Extend_bE,
		shft_left_out => SHIFTLEFT2_out
);
ADD1: add port map (
input_1 => SHIFTLEFT2_out,
input_2 => pcp4_aD,
output => branch_addr
);
MUX5: mux4_1 generic map(32) port map(
d3 => rslt,
d2 => rslt,
d1 => rslt_aM,
d0 => read_data_1,
s => fwCD,
y => R_rs
);
MUX6: mux4_1 generic map(32) port map(
d3 => read_data_bW,
d2 => Rslt,
d1 => Rslt_aM,
d0 => read_data_1,
s => fwAD,
y => Compare1
);
MUX7: mux4_1 generic map(32) port map(
d3 => read_data_bW,
d2 => Rslt,
d1 => Rslt_aM,
d0 => read_data_2,
s => fwBD,
y => Compare2
);
COMPARator: compare port map (
comp1 => Compare1,
comp2 => Compare2,
comp_ctrl => ctrl_out_bE,
zero => zero
);
REGE1: regE port map(
		regdstD => regdstD,
		alusrcD => alusrcD,
		shmtD => shmtD,
		byte_enableD => byte_enableD,
		memwriteD => memwriteD,
		memreadD => memreadD,
		regwriteD => regwriteD,
		clk => clk,
		stallE => stallE,
		memtoregD => memtoregD,
		reg1_in => read_data_1,
		reg2_in => read_data_2,
		alu_ctrl_in => ctrl_out_bE,
		extend_in => Extend_bE,
		shmt_in => Instr_aD(10 downto 6),
		rsD => Instr_aD(25 downto 21),
		rtD => Instr_aD(20 downto 16),
		rdD => Instr_aD(15 downto 11),
		opcodeD => Instr_aD(31 downto 26),
		functD => Instr_aD(5 downto 0),
		------------------------------------------------------------------------------------------------
		regdstE => regdstE,
		alusrcE => alusrcE,
		shmtE=>shmtE,
		byte_enableE => byte_enableE,
		memwriteE => memwriteE,
		memreadE => memreadE,
		regwriteE => regwriteE,
		memtoregE => memtoregE,
		reg1_out => read_data_1_aE,
		reg2_out => read_data_2_aE,
		alu_ctrl_out => ctrl_out_aE,
		extend_out => Extend_aE,
		shmt_out => shmt_out,
		rsE => rsE,
		rtE => rtE,
		rdE => rdE,
		opcodeE => opcodeE,
		functE => functE
		);
ZEROEXTENSIONNN: zero_extend port map(
imm => shmt_out,
extended => zero_extend_out
);
MUX8: Mux2_1 generic map(5) port map(
d1 => rdE,
d0 => rtE,
s => regdstE,
y => writeregE
);
MUX9: mux4_1 generic map(32) port map(
d3 => read_data_1_aE,
d2 => writedataW,
d1 => Rslt_aM,
d0 => read_data_1_aE,
s => fwAE,
y => data_src1_mux
);
MUX10: Mux2_1 generic map(32) port map(
d1 => zero_extend_out,
d0 => data_src1_mux,
s => shmtE,
y => src1
);
MUX11: mux4_1 generic map(32) port map(
d3 => read_data_2_aE,
d2 => writedataW,
d1 => Rslt_aM,
d0 => read_data_2_aE,
s => fwBE,
y => data_src2_mux
);
MUX12: Mux2_1 generic map(32) port map(
d1 => Extend_aE,
d0 => data_src2_mux,
s => alusrcE,
y => src2
);
ALUYO: alu port map(
src1 => src1,
src2 => src2,
alu_ctrl => ctrl_out_aE,
rslt => rslt
);
MUX_DATA: mux2_1 generic map(32) port map(
d1 => rslt_aM,
d0 => data_src2_mux,
s => fwCE,
y => write_data_bM
);
REGM1: regM port map(
		byte_enableE => byte_enableE,
		memwriteE => memwriteE,
		memreadE => memreadE,
		regwriteE => regwriteE,
		clk => clk,
		memtoregE => memtoregE,
		rslt_in => rslt,
		write_data_in => write_data_bM,
		writeregE => writeregE,
		opcodeE => opcodeE,
		functE => functE,
		------------------------------------------------------------------------------------------------
		byte_enableM => byte_enableM,
		memwriteM => memwriteM,
		memreadM => memreadM,
		regwriteM => regwriteM,
		memtoregM => memtoregM,
		rslt_out => rslt_aM,
		write_data_out=>write_data_aM,
		writeregM => writeregM, 
		opcodeM => opcodeM,
		functM => functM
		);
DATAMEMISHERE: data_memory port map(
		address => rslt_aM,
		write_data => write_data_aM,
		MemWrite => memwriteM,
		MemRead => memreadM,
		byte_enable => byte_enableM,
		clk => clk,
		read_data => read_data_bW
);
REGW1: regW port map(
		regwriteM => regwriteM ,
		clk => clk,
		memtoregM => memtoregM,
		rslt_in => rslt_aM,
		read_data_in => read_data_bW,
		writeregM => writeregM,
		opcodeM => opcodeM,
		functM => functM,
		------------------------------------------------------------------------------------------------
		regwriteW => regwriteW,
		memtoregW =>memtoregW,
		rslt_out => rslt_aW,
		read_data_out => read_data_aW,
		writeregW => writeregW,
		opcodeW =>opcodeW,
		functW => functW
);
MUX13: mux4_1 generic map(32) port map(
d3 => rslt_aW,
d2 => read_data_aW,
d1 => Rslt_aW,
d0 => read_data_aW,
s => memtoregW,
y => writedataW
);
end hungdeptrai;



		