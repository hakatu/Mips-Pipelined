library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity plus4 is
port(
pc : in std_logic_vector(31 downto 0);
pcplus4 : out std_logic_vector(31 downto 0));
end entity;
architecture behavior of plus4 is
begin
pcplus4 <= pc + 4;
end architecture;
