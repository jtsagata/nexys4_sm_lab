LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY sm_decoder_tb IS
END sm_decoder_tb;
 
ARCHITECTURE behavior OF sm_decoder IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT smarch2_onehot
    PORT(
         CLK : IN  std_logic;
         RESET : IN  std_logic;
         A : IN  std_logic;
         B : IN  std_logic;
         S1 : OUT  std_logic;
         S2 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RESET : std_logic := '0';
   signal A : std_logic := '0';
   signal B : std_logic := '0';

 	--Outputs
   signal S1 : std_logic;
   signal S2 : std_logic;

	-- Clock  Enable trick
	signal CLK_ENABLE: std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: smarch2_onehot PORT MAP (
          CLK => CLK,
          RESET => RESET,
          A => A,
          B => B,
          S1 => S1,
          S2 => S2
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= CLK_ENABLE;
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- Initial state
		CLK_ENABLE <= '0';
		RESET <= '1';
		A <= '0';
		B <= '0';
		-- hold reset state for 100 ns.
		wait for 100 ns;	
		RESET <= '0';

      --wait for CLK_period*10;
		CLK_ENABLE <= '1';

      wait for CLK_period*10;
		ASSERT S1 ='0' REPORT "Initial state" SEVERITY error;
		ASSERT S2 ='0' REPORT "Initial state" SEVERITY error;

      wait for CLK_period*2;
		B <= '1';
		-- State is the same
		wait for CLK_period*2;
		ASSERT S1 ='0' REPORT "Initial state" SEVERITY error;
		ASSERT S2 ='0' REPORT "Initial state" SEVERITY error;

		A <= '1';
		B <= '0';
		-- STATE1 -> STATE2
		wait for CLK_period*2;
		ASSERT S1 ='0' REPORT "STATE1 -> STATE2" SEVERITY error;
		ASSERT S2 ='0' REPORT "STATE1 -> STATE2" SEVERITY error;
		

		A <= '0';
		B <= '1';
		-- STATE2 -> STATE4
		wait for CLK_period*2;
		ASSERT S1 ='1' REPORT "STATE2 -> STATE4" SEVERITY error;
		ASSERT S2 ='1' REPORT "STATE2 -> STATE4" SEVERITY error;

		A <= '0';
		B <= '1';
		-- STATE4 STAY
		wait for CLK_period*2;
		ASSERT S1 ='1' REPORT "STATE4" SEVERITY error;
		ASSERT S2 ='1' REPORT "STATE4" SEVERITY error;


		A <= '0';
		B <= '0';
		-- STATE4 -> STATE5
		wait for CLK_period*2;
		ASSERT S1 ='0' REPORT "STATE4 -> STATE5" SEVERITY error;
		ASSERT S2 ='0' REPORT "STATE4 -> STATE5" SEVERITY error;
		

		-- STATE5 -> STATE1 (always)
		wait for CLK_period*2;
		ASSERT S1 ='0' REPORT "STATE5 -> STATE1" SEVERITY error;
		ASSERT S2 ='0' REPORT "STATE5 -> STATE1" SEVERITY error;
		

      wait;
   end process;

END;
