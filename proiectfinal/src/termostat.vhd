library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity termostat is
	port(SET,TEMPMIN,TEMPMAX,ORA,clk100,reset,reset11 : in std_logic;
	tempsensor : in std_logic_vector(4 downto 0);
	heater : out std_logic;
	anod : out std_logic_vector (7 downto 0);
   catod : out std_logic_vector (6 downto 0));
end termostat;	

architecture ex of termostat is

component raminfr is 
  port (clk : in std_logic;
  		  we  : in std_logic;   
        a   : in std_logic_vector(4 downto 0);   
        di  : in std_logic_vector(9 downto 0);   
        dout  : out std_logic_vector(9 downto 0);
		  ao  : out std_logic_vector(4 downto 0));   
end component; 

component ClockPrescaler is
    port(clock : in std_logic;
        Led : out std_logic);
end component;

component compare is
port(num1 : in std_logic_vector(4 downto 0);
     num2 : in std_logic_vector(4 downto 0);
     less : out std_logic;
     equal : out std_logic;
     greater : out std_logic);
end component;

component nummin is
     port(clk : in STD_LOGIC;
         reset : in STD_LOGIC;
         dout : out STD_LOGIC_VECTOR(5 downto 0);
 		   tc : out STD_LOGIC);
end component;

component numsec is
     port(clk : in STD_LOGIC;
         reset : in STD_LOGIC;
 		   tc : out STD_LOGIC);
end component;

component numora is
     port(clk : in std_logic;
         reset : in std_logic;
         dout : out std_logic_vector(4 downto 0));
end component; 

component mux_2to1_top is
    Port ( SEL : in  STD_LOGIC;
           A   : in  STD_LOGIC_VECTOR (4 downto 0);
           B   : in  STD_LOGIC_VECTOR (4 downto 0);
           X   : out STD_LOGIC_VECTOR (4 downto 0));
end component;

component numtemp is
     port(clk : in std_logic;
         reset : in std_logic;
         dout : out std_logic_vector(4 downto 0));
end component;

component Display is
	port(CLK : in std_logic;
	BinInput : in std_logic_vector (6 downto 0);	
	unitmin : out std_logic_vector(3 downto 0);
	tenmin : out std_logic_vector(3 downto 0)
	);
end component;

component eAfisare is
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
end component;

signal out0,out1,tc1,tc2,reset1,reset2 : std_logic;
signal memout,datain : std_logic_vector (9 downto 0);
signal cmp1out,cmp1out0,cmp1out00,cmp2out,cmp2out0,cmp2out00,cmp3out,cmp3out0,cmp3out00 : std_logic;
signal intcomp1,intcomp2,tempbutonmin,tempbutonmax,orabuton,oraaf,adresa,adresa_out,mux_out : std_logic_vector(4 downto 0);
signal minaf : std_logic_vector(5 downto 0);
signal oraaf1,minaf1,tempsensor1 : std_logic_vector(6 downto 0);
signal afminunit,afminten,aforaunit,aforaten,tempsensorunit,tempsensorten : std_logic_vector(3 downto 0);

begin
	
	reset1 <= reset;
	reset2 <= reset11;
	
	DIV1 : ClockPrescaler port map (clk100,out1);
	TEMPMIN1 : numtemp port map (TEMPMIN,reset2,tempbutonmin);
	TEMPMAX1 : numtemp port map (TEMPMAX,reset2,tempbutonmax);
	ORA1 : numora port map (ORA,reset2,orabuton);
	MUX : mux_2to1_top port map (SET,oraaf,orabuton,mux_out);
	
	process (clk100)
	begin
		if (SET = '1') then
			datain (9 downto 5) <= tempbutonmin;
		end if;
	end process;		
	
	process (clk100)
	begin 
		if (SET = '1' and datain (9 downto 5) > "00000") then
			datain (4 downto 0) <= tempbutonmax;
		end if;
	end process;
	
	process (clk100)
	begin
		
	intcomp1 <= oraaf;
	intcomp2 <= adresa_out;
	
	end process;
	
	MEMRAM1 : raminfr port map (clk100,SET,mux_out,datain,memout,adresa_out);
	CMP1 : compare port map (memout(9 downto 5),tempsensor,cmp1out,cmp1out0,cmp1out00);
	CMP2 : compare port map (intcomp1,intcomp2,cmp2out,cmp2out0,cmp2out00);
	CMP3 : compare port map (memout(4 downto 0),tempsensor,cmp3out,cmp3out0,cmp3out00);
	ORA2 : numora port map (tc2,reset1,oraaf);
	MIN : nummin port map (tc1,reset1,minaf,tc2);
	SEC : numsec port map (out1,reset1,tc1);
	
	process (clk100)
	begin
	oraaf1 <= "00"&oraaf;
	minaf1 <= "0"&minaf;
	tempsensor1 <= "00"&tempsensor;
	end process;
	
	process (clk100)
	begin
		heater <= '0';
		if (cmp1out00='1' and cmp2out0='1') then
			heater <= '1';
		else  if cmp3out0 = '1' then
			heater <= '0';
			end if;
		end if;
	end process;
	
	preluaremin : Display port map (clk100,minaf1,afminunit,afminten);
	preluareora : Display port map (clk100,oraaf1,aforaunit,aforaten);
	preluaretemp : Display port map (clk100,tempsensor1,tempsensorunit,tempsensorten);
	Display1 : eAfisare port map ("0000","0000",tempsensorunit,tempsensorten,afminunit,afminten,aforaunit,aforaten,clk100,catod,anod);
	
end ex;