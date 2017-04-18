LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY counter_testbench IS
END counter_testbench;
 
ARCHITECTURE behavior OF counter_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT counter
    PORT(
         clk : IN  std_logic;
         plusH : IN  std_logic;
         plusM : IN  std_logic;
         hour : OUT  std_logic_vector(4 downto 0);
         minute : OUT  std_logic_vector(5 downto 0);
         second : OUT  std_logic_vector(5 downto 0);
      
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
    END COMPONENT;
    

   --Inputs
   signal clk     : std_logic := '0';
   signal plusH   : std_logic := '0';
   signal plusM   : std_logic := '0';

  --Outputs
   signal hour  : std_logic_vector(4 downto 0);
   signal minute  : std_logic_vector(5 downto 0);
   signal second  : std_logic_vector(5 downto 0);
   
  --Displays
  signal second_units : STD_LOGIC_VECTOR (7 downto 0);
  signal second_tens  : STD_LOGIC_VECTOR (7 downto 0);
  signal minute_units : STD_LOGIC_VECTOR (7 downto 0);
  signal minute_tens  : STD_LOGIC_VECTOR (7 downto 0);
  signal hour_units : STD_LOGIC_VECTOR (7 downto 0);
  signal hour_tens  : STD_LOGIC_VECTOR (7 downto 0);
  
  
  -- Clock period definitions
   constant clk_period : time := 10 ps;
  
  
  signal is_set_hour, is_set_minute  : bit := '0';
BEGIN
 
  -- Instantiate the Unit Under Test (UUT)
   uut: counter PORT MAP (
          clk     => clk,
          plusH   => plusH,
          plusM   => plusM,
          hour  => hour,
          minute  => minute,
          second  => second,
       second_tens => second_tens,
       second_units => second_units,
       minute_tens => minute_tens,
       minute_units => minute_units,
       hour_tens => hour_tens,
       hour_units => hour_units
        );

   -- Clock process definitions
   clk_process :process
   begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
   end process;
 
  -----
  -- Set clock to 11:40 a.m
  -----
   -- Set minute to 40
   set_minute_proc: process
   begin        
    if (is_set_minute = '0') then
      for j in 0 to 39 loop
      
        wait for 11 ps;
        plusM   <= '1';
        wait for 6 ps;
        plusM<= '0';
        wait for 13 ps;
      end loop;
      is_set_minute <= '1';
    end if;
    
    
      wait;
   end process;
  
  -- Set hour to 11 a.m
  set_hour_proc: process
  begin
  
    if (is_set_hour = '0') then
      for i in 0 to 10 loop
      
        wait for 100 ps;
        plusH   <= '1';
        wait for 55 ps;
        plusH<= '0';
        wait for 255 ps;
      end loop;
      is_set_hour <= '1';
    end if;
    
    
      wait;
   end process;
  

END;