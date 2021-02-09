library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity numsec is
     port(
         clk : in STD_LOGIC;
         reset : in STD_LOGIC;
 		 tc : out STD_LOGIC);
end numsec;

architecture numsec_arc of numsec is
begin
    counter : process (clk,reset) is
    variable m : integer range 0 to 60 := 0;
    begin 
		tc<='0';
        if (reset='1') then
            m := 0;
        elsif (clk = '1' and clk'event) then
            m := m + 1;
        end if;
		if (m=60) then
			tc <= '1';
		end if;
        if (m=60) then
            m := 0;
        end if;
    end process counter;
end numsec_arc;