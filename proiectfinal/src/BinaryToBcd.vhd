library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity BinaryToBCD is
	port(CLK : in std_logic;
	Input : in std_logic_vector(6 downto 0);
	Output : out std_logic_vector(11 downto 0));
end BinaryToBCD;					  

architecture A of BinaryToBCD is 

function BinToBCD(InputB : std_logic_vector(6 downto 0)) return std_logic_vector is

	variable BCD : std_logic_vector(11 downto 0) := (others => '0');
	variable NR : std_logic_vector(7 downto 0) := ('0' & InputB);
	variable i : integer := 0; 
	
	begin	
		for i in 0 to 7 loop 
			BCD(11 downto 1) := BCD (10 downto 0);
			BCD(0) := NR(7);
			NR(7 downto 1) := NR(6 downto 0);
			NR(0) := '0';	
			if(i <7 and BCD(3 downto 0)> "0100") then
				BCD(3 downto 0) := BCD(3 downto 0) + "0011";
			end if;
			if(i<7 and BCD(7 downto 4) > "0100") then
				BCD(7 downto 4) := BCD(7 downto 4) + "0011";
			end if;		
			if(i<7 and BCD(11 downto 8) > "0100") then
				BCD(11 downto 8) := BCD(11 downto 8) + "0011";
			end if;
		end loop;
		return BCD;
	end BinToBCD;
begin
	Output <= BinToBCD(Input);		  	
end A;
