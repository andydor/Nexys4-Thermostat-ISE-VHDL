library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity compare is
port(num1 : in std_logic_vector(4 downto 0);
     num2 : in std_logic_vector(4 downto 0);
     less : out std_logic;
     equal : out std_logic;
     greater : out std_logic);
end compare;

architecture Behavioral of compare is
begin
process(num1,num2)
begin
if (num1 > num2 ) then
less <= '0';
equal <= '0';
greater <= '1';
elsif (num1 < num2) then
less <= '1';
equal <= '0';
greater <= '0';
else
less <= '0';
equal <= '1';
greater <= '0';
end if;
end process;
end Behavioral;