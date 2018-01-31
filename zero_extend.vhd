library IEEE;
use ieee.STD_LOGIC_1164.all;
use ieee.Numeric_std.all;
entity zero_extend is
port(
imm : in std_logic_vector(4 downto 0);
extended : out std_logic_vector(31 downto 0));
end entity;
architecture behavior of zero_extend is
begin
extended <= std_logic_vector(resize(unsigned(imm), extended'length));
end behavior;