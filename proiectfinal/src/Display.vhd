library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity Display is
	port(CLK : in std_logic;
	BinInput : in std_logic_vector (6 downto 0);	
	unitmin : out std_logic_vector(3 downto 0);
	tenmin : out std_logic_vector(3 downto 0));
end Display;

architecture Arch_Display of Display is 

component BinaryToBCD is
	port(CLK : in std_logic;
	Input : in std_logic_vector(6 downto 0);
	Output : out std_logic_vector(11 downto 0));
end component; 

signal BCDInput : std_logic_vector(11 downto 0);

begin
 
	OP2: BinaryToBCD port map(clk, BinInput, BCDInput);
	
	unitmin <= BCDInput(3 downto 0);
	tenmin <= BCDInput(7 downto 4);
	
end Arch_Display;	