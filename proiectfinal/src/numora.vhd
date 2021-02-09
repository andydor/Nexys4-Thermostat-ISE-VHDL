library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity numora is
     port(
         clk : in std_logic;
         reset : in std_logic;
         dout : out std_logic_vector(4 downto 0));
end numora;

architecture numora_arh of numora is
begin
    counter : process (clk,reset) is
    variable m : integer range 0 to 24 := 0;
    begin 
        if (reset='1') then
            m := 0;
        elsif (clk = '1' and clk'event) then
            m := m + 1;
        end if;
        if (m=24) then
            m := 0;
        end if;
        dout <= conv_std_logic_vector (m,5);
    end process counter;
end numora_arh;