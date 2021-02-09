library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity MS is
end MS;

architecture MS_arh of MS is

component termostat is
	port(SET,TEMPMIN,TEMPMAX,ORA,clk100,reset,reset11 : in std_logic;
	tempsensor : in std_logic_vector(4 downto 0);
	heater : out std_logic;
	anod : out std_logic_vector (7 downto 0);
    catod : out std_logic_vector (6 downto 0));
end component;	

signal A,B,C,D,E,F,G : std_logic;
signal H : std_logic_vector(4 downto 0);
signal I :  std_logic;
signal clk : std_logic := '0';
constant clk_period : time := 1 ns;

begin
	
	UST : termostat port map (A,B,C,D,E,F,G,H,I);
	
	A <= '0', '1' after 40 ns; --set 1
	B <= '0', '1' after 40 ns; --prog 1
	C <= '0', '1' after 50 ns, '0' after 100 ns, '1' after 150 ns, '0' after 200 ns; --setare temperatura minima 2
	D <= '0', '1' after 50 ns, '0' after 100 ns, '1' after 150 ns, '0' after 200 ns, '1' after 250 ns, '0' after 300 ns; --setare temperatura maxima 3
	E <= '0' after 10 ns; --ora program 0
	G <= '0' after 10 ns; --reset 0
	H <= "00001" after 20 ns; --temperatura ambientala 1
	
	clk_process :process --generator de tact
    begin
        F <= '0';
        wait for clk_period/2;
        F <= '1';
        wait for clk_period/2;
    end process;

	process(I) --incalzire 
	begin 
		if(I = '1') then
			for i in 0 to 2 loop
				H <= H + '1' after 3000 ns ; --incalzire cu un grad la 3 secunde
			end loop;
		else
			for i in 0 to 2 loop
				H <= H - '1' after 3000 ns; --racire cu un grad la 3 secunde
			end loop;
		end if;
	end process;
	
end	MS_arh;
			