library ieee;   
use ieee.std_logic_1164.all;   
use ieee.std_logic_unsigned.all; 
 
entity raminfr is 
  port (clk : in std_logic;
  		we  : in std_logic;   
        a   : in std_logic_vector(4 downto 0);   
        di  : in std_logic_vector(9 downto 0);   
        dout  : out std_logic_vector(9 downto 0);
		ao  : out std_logic_vector(4 downto 0));   
end raminfr;  
 
architecture syn of raminfr is   
  type ram_type is array (31 downto 0)   
    of std_logic_vector (9 downto 0);   
  signal RAM : ram_type;   
begin   
  process(clk)   
  begin
	  if(clk'event and clk='1') then
      if (we = '1') then   
        RAM(conv_integer(a)) <= di;   
      end if;  
      dout <= RAM(conv_integer(a));
	  ao <= a;
	  end if;
  end process;   
end syn; 