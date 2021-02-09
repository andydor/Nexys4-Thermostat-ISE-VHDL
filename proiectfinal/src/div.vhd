library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ClockPrescaler is
    port(clock : in std_logic;
         Led : out std_logic);
end ClockPrescaler;

architecture Behavioral of ClockPrescaler is

    signal prescaler : std_logic_vector(25 downto 0) := "10111110101111000010000000";
    
    --signal prescaler : std_logic_vector(19 downto 0) := "11110100001001000000";
    --signal prescaler_counter : std_logic_vector(19 downto 0) := (others => '0');
    
    signal prescaler_counter : std_logic_vector(25 downto 0) := (others => '0');
    signal newClock : std_logic := '0';
	
begin
	
    Led <= newClock;
    countClock: process(clock, newClock)
    begin
        if rising_edge(clock) then
            prescaler_counter <= prescaler_counter + 1;
            if(prescaler_counter > prescaler) then
                newClock <= not newClock;
                prescaler_counter <= (others => '0');
            end if;
        end if;
    end process;

end Behavioral;