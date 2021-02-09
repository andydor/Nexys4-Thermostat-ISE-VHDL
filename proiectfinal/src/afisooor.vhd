library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity eAfisare is
Port(digit0 : in std_logic_vector(3 downto 0);
     digit1 : in std_logic_vector(3 downto 0);
     digit2 : in std_logic_vector(3 downto 0);
     digit3 : in std_logic_vector(3 downto 0);
	 digit4 : in std_logic_vector(3 downto 0);
	 digit5 : in std_logic_vector(3 downto 0);
	 digit6 : in std_logic_vector(3 downto 0);
	 digit7 : in std_logic_vector(3 downto 0);
     clk : in std_logic;
     cat : out std_logic_vector(6 downto 0);
     an : out std_logic_vector(7 downto 0));
end eAfisare;

architecture aAfisare of eAfisare is

signal i0: std_logic_vector(7 downto 0):="11111110";
signal i1: std_logic_vector(7 downto 0):="11111101";
signal i2: std_logic_vector(7 downto 0):="11111011";
signal i3: std_logic_vector(7 downto 0):="11110111";
signal i4: std_logic_vector(7 downto 0):="11101111";
signal i5: std_logic_vector(7 downto 0):="11011111";
signal i6: std_logic_vector(7 downto 0):="10111111";
signal i7: std_logic_vector(7 downto 0):="01111111";

signal count: std_logic_vector(15 downto 0) := x"0000";
signal m1: std_logic_vector(3 downto 0);

begin

process(clk)
begin
	
      if rising_edge(clk) then
        count <= count +1;
      end if;
	  
end process;

process(digit0, digit1, digit2, digit3, digit4, digit5, digit6, digit7, count(15 downto 13))
begin
	
    case count(15 downto 13) is
        when "000" => m1 <= digit0;
        when "001" => m1 <= digit1;
        when "010" => m1 <= digit2;
        when "011" => m1 <= digit3;
	    when "100" => m1 <= digit4;
		when "101" => m1 <= digit5;
		when "110" => m1 <= digit6;
		when "111" => m1 <= digit7;
		when others => m1<="1111";
    end case;
	
end process;

process(i0, i1, i2, i3, i4, i5, i6, i7, count(15 downto 13))
begin
	
    case count(15 downto 13) is 
        when "000" => an <= i0; 
        when "001" => an <= i1;
        when "010" => an <= i2;
        when "011" => an <= i3;
		when "100" => an <= i4;
		when "101" => an <= i5;
		when "110" => an <= i6;
		when others => an <= i7;
	end case;
	
 end process;
 
 process(m1)
 begin 
	 
  case m1 is
          when "0000" => cat <= "1000000";   --0
          when "0001" => cat <= "1111001";   --1
          when "0010" => cat <= "0100100";   --2
          when "0011" => cat <= "0110000";   --3
          when "0100" => cat <= "0011001";   --4
          when "0101" => cat <= "0010010";   --5
          when "0110" => cat <= "0000010";   --6
          when "0111" => cat <= "1111000";   --7
          when "1000" => cat <= "0000000";   --8
          when "1001" => cat <= "0010000";   --9
          when "1010" => cat <= "0001000";   --A
          when "1011" => cat <= "0001110";   --F
          when "1100" => cat <= "1000110";   --C
          when "1101" => cat <= "0100001";   --d
          when "1110" => cat <= "1001000";   --M
          when others => cat <= "1000001";   --U
  end case;
  
  end process;
         
end aAfisare;