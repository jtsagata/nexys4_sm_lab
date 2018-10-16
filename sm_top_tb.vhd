LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

  
ENTITY sm_top_tb IS
END sm_top_tb;
 
ARCHITECTURE behavior OF sm_top_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sm_top
    PORT(
         CLK : IN  std_logic;
         RESET : IN  std_logic;
         ENABLE : IN  std_logic;
         SW_A : IN  std_logic;
         SW_B : IN  std_logic;
         LED : OUT  std_logic_vector(15 downto 11);
         SEG : OUT  std_logic_vector(6 downto 0);
         AN : OUT  std_logic_vector(7 downto 0);
         RGB1_Red : OUT  std_logic;
         RGB1_Green : OUT  std_logic;
         RGB1_Blue : OUT  std_logic;
         S1_LED : OUT  std_logic;
         S2_LED : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RESET : std_logic := '0';
   signal ENABLE : std_logic := '0';
   signal SW_A : std_logic := '0';
   signal SW_B : std_logic := '0';

 	--Outputs
   signal LED : std_logic_vector(15 downto 11);
   signal SEG : std_logic_vector(6 downto 0);
   signal AN : std_logic_vector(7 downto 0);
   signal RGB1_Red : std_logic;
   signal RGB1_Green : std_logic;
   signal RGB1_Blue : std_logic;
   signal S1_LED : std_logic;
   signal S2_LED : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;

	-- Clock  Enable trick
	signal CLK_ENABLE: std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: sm_top PORT MAP (
          CLK => CLK,
          RESET => RESET,
          ENABLE => ENABLE,
          SW_A => SW_A,
          SW_B => SW_B,
          LED => LED,
          SEG => SEG,
          AN => AN,
          RGB1_Red => RGB1_Red,
          RGB1_Green => RGB1_Green,
          RGB1_Blue => RGB1_Blue,
          S1_LED => S1_LED,
          S2_LED => S2_LED
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
	RESET <= '0';
	SW_A <= '0';
	SW_B <= '0';
	-- hold reset state for 100 ns.
	wait for 100 ns;	
	RESET <= '1';
	CLK_ENABLE <= '1';
    ENABLE <= '1';

	-- On Initial State
	wait for CLK_period*1;
	ASSERT S1_LED ='0'   REPORT "Initial state" SEVERITY error;
    ASSERT S2_LED ='0'   REPORT "Initial state" SEVERITY error;
	ASSERT LED = "10000" REPORT "Initial state" SEVERITY error;

	-- check STATE1
	SW_A <= '0'; SW_B <= '0'; wait for CLK_period*1;
    ASSERT LED = "10000" REPORT "Initial state -> 00" SEVERITY error;
	SW_A <= '0'; SW_B <= '1'; wait for CLK_period*1;
    ASSERT LED = "10000" REPORT "Initial state -> 01" SEVERITY error;
	SW_A <= '1'; SW_B <= '1'; wait for CLK_period*1;
    ASSERT LED = "10000" REPORT "Initial state -> 11" SEVERITY error;
	-- check STATE1-> STATE2
    SW_A <= '1'; SW_B <= '0'; wait for CLK_period*1;
	ASSERT LED = "01000" REPORT "STATE2" SEVERITY error;

	-- check STATE2
	ASSERT S1_LED ='0'   REPORT "STATE2" SEVERITY error;
    ASSERT S2_LED ='0'   REPORT "STATE2" SEVERITY error;


    -- wait at end
    wait;
   end process;

END;
