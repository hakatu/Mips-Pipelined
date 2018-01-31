library IEEE;
use ieee.STD_LOGIC_1164.all;
use ieee.Numeric_std.all;
entity sign_zero_extend is
port(
sign_zero : in std_logic;
imm : in std_logic_vector(15 downto 0);
extended : out std_logic_vector(31 downto 0));
end entity;
architecture behavior of sign_zero_extend is
begin
with sign_zero select
extended <= std_logic_vector(resize(signed(imm), extended'length)) when '1',
			std_logic_vector(resize(unsigned(imm), extended'length)) when others;
end behavior;