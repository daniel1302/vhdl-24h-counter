library IEEE;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity counter is
	 Generic (DELAY: Time := 5ns);
	 
    Port ( clk : in  STD_LOGIC;
           plusH : in  STD_LOGIC;
           plusM : in  STD_LOGIC;
           hour : out  STD_LOGIC_VECTOR (4 downto 0);
           minute : out  STD_LOGIC_VECTOR (5 downto 0);
           second : out  STD_LOGIC_VECTOR (5 downto 0);
			  
			  -----
			  -- 7 seg displays
			  -----
			  second_units : out  STD_LOGIC_VECTOR (7 downto 0);
			  second_tens : out  STD_LOGIC_VECTOR (7 downto 0);
			  minute_units : out  STD_LOGIC_VECTOR (7 downto 0);
			  minute_tens : out  STD_LOGIC_VECTOR (7 downto 0);
			  hour_units : out  STD_LOGIC_VECTOR (7 downto 0);
			  hour_tens : out  STD_LOGIC_VECTOR (7 downto 0)
			  );
end counter;

architecture Behavioral of counter is
	
	-----
	-- Converter 8bit vector to two 7-seg displays
	-----
	COMPONENT vec8_to_7seg
    PORT(
			  vector_in : in  STD_LOGIC_VECTOR (6 downto 0);
           hex1_out : out  STD_LOGIC_VECTOR (7 downto 0);
			  hex2_out : out  STD_LOGIC_VECTOR (7 downto 0)
        );
    END COMPONENT;


	signal secondInt, minuteInt, hourInt: integer range 0 to 60 := 0;
	signal addHourFlag, addMinuteFlag: STD_LOGIC_VECTOR (1 downto 0) := "00";
	signal second7bit, minute7bit, hour7bit : STD_LOGIC_VECTOR(6 downto 0) := "0000000";
begin
	second_7seg: vec8_to_7seg PORT MAP (second7bit, second_tens, second_units);
	minute_7seg: vec8_to_7seg PORT MAP (minute7bit, minute_tens, minute_units);
	hour_7seg:   vec8_to_7seg PORT MAP (hour7bit, hour_tens, hour_units);
	
	
	
	-----
	-- Minute increments
	-----
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

	-----
	-- Hours increments
	-----
	process (clk, plusH) 
	begin
		if (plusH = '1' and addHourFlag(0) = '0') then
			addHourFlag(1) <= '1'; -- Można inkrementować
			addHourFlag(0) <= '1'; -- Blokuj kolejną inkrementację		
		elsif (plusH = '1' and 	addHourFlag(1) = '1') then
			addHourFlag(1) <= '0'; -- zablokuj zbyt szybką inkrementację
		elsif (plusH = '0' and addHourFlag(0) = '1') then
			addHourFlag(0) <= '0';
			addHourFlag(1) <= '0';
		end if;
	end process;
	
	-----
	-- Main process
	-----
	process (clk)		
	begin			
		if (clk'event and clk = '1') then

			if ((minuteInt = 59 and secondInt = 59) or addHourFlag(1) = '1') then
				if (hourInt = 23) then 
					hourInt <= 0;
				else
					hourInt <= hourInt + 1;
				end if;
			end if;
				
				
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
			
	
	end process;	
	
	
	
	second <= conv_std_logic_vector(secondInt, 6);
	minute <= conv_std_logic_vector(minuteInt, 6);
 	hour   <= conv_std_logic_vector(hourInt, 5);
	
	second7bit <= conv_std_logic_vector(secondInt, 7);
	minute7bit <= conv_std_logic_vector(minuteInt, 7);
	hour7bit   <= conv_std_logic_vector(hourInt, 7);

end Behavioral;