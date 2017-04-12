library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity counter is
	 Generic (DELAY: Time := 5ns);
	 
    Port ( clk : in  STD_LOGIC;
        --   plusH : in  STD_LOGIC;
           plusM : in  STD_LOGIC;
         --  hour : out  STD_LOGIC_VECTOR (4 downto 0);
           minute : out  STD_LOGIC_VECTOR (5 downto 0);
           second : out  STD_LOGIC_VECTOR (5 downto 0);
			  dump : out  STD_LOGIC_VECTOR (1 downto 0)
			  );
end counter;

architecture Behavioral of counter is
	signal secondInt, minuteInt, hourInt: integer range 0 to 60 := 0;
	signal addHourFlag, addMinuteFlag: STD_LOGIC_VECTOR (1 downto 0) := "00";
begin
	
	process (clk, plusM) 
	begin
		if (plusM = '1' and addMinuteFlag(0) = '0') then
			addMinuteFlag(1) <= '1'; -- Można inkrementować
			addMinuteFlag(0) <= '1'; -- Blokuj kolejną inkrementację		
		elsif (plusM = '1' and 	addMinuteFlag(1) = '1') then
			addMinuteFlag(1) <= '0'; -- zablokuj zbyt szybką inkrementację
		elsif (plusM = '0' and addMinuteFlag(0) = '1') then
			addMinuteFlag(0) <= '0';
			addMinuteFlag(1) <= '0';
		end if;
	end process;

	process (clk)		
	begin			
		if (clk'event and clk = '1') then
					
					
			if (secondInt = 59 or addMinuteFlag(1) = '1') then
				if (minuteInt = 59) then 
					minuteInt <= 0;
				else
					minuteInt <= minuteInt + 1;
				end if;
			end if;
					
					
			if (secondInt = 59) then
				secondInt <= 0;
			else 
				secondInt <= secondInt + 1;
			end if;
			
			
			
			
		end if;
		dump <= addMinuteFlag;
			
	
	end process;
	
	
	
	second <= conv_std_logic_vector(secondInt, 6);
	minute <= conv_std_logic_vector(minuteInt, 6);
 	--hour   <= conv_std_logic_vector(hourInt, 5);

end Behavioral;