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
      dump   : OUT  std_logic_vector(1 downto 0)
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
  signal dump   : std_logic_vector(1 downto 0);
   -- Clock period definitions
   constant clk_period : time := 1 ns;
 
BEGIN
 
  -- Instantiate the Unit Under Test (UUT)
   uut: counter PORT MAP (
          clk     => clk,
          plusH   => plusH,
          plusM   => plusM,
          hour  => hour,
          minute  => minute,
          second  => second,
       dump   => dump
        );

   -- Clock process definitions
   clk_process :process
   begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin    
  
    wait for 10 ns;
    plusM   <= '1';
    wait for 5 ns;
    plusM   <= '0';
    
    
      wait for clk_period*10;
    
      wait;
   end process;

END;