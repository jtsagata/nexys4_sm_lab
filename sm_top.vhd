library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sm_top is
    Port ( CLK :in  STD_LOGIC;
	        RESET : in  STD_LOGIC;
			  SW_A : in  STD_LOGIC;
			  SW_B : in  STD_LOGIC;	
			  
           LED : out  STD_LOGIC_VECTOR (15 downto 11); 
			  SEG : out  STD_LOGIC_VECTOR (6 downto 0);
			  AN  : out STD_LOGIC_VECTOR (7 downto 0);
			  
			  RGB1_Red : out STD_LOGIC;
			  RGB1_Green : out STD_LOGIC;
			  RGB1_Blue : out STD_LOGIC;
			  
			  S1_LED : out  STD_LOGIC;
			  S2_LED : out  STD_LOGIC
			 );
end sm_top;

architecture sm_top_impl of sm_top is
--- IMPORTS START ---
COMPONENT demux_3to5 is
    Port ( DIN : in  STD_LOGIC_VECTOR (2 downto 0);
           DOUT : out  STD_LOGIC_VECTOR (4 downto 0));
end COMPONENT;

COMPONENT seg_driver is
    Port ( BCD : in  STD_LOGIC_VECTOR (3 downto 0);
           LED_out : out  STD_LOGIC_VECTOR (6 downto 0);
			  AN  : out STD_LOGIC_VECTOR (7 downto 0) );
end COMPONENT;

COMPONENT rgb_driver is
    Port ( DIN : in  STD_LOGIC_VECTOR (1 downto 0);
           R : out  STD_LOGIC;
           G : out  STD_LOGIC;
           B : out  STD_LOGIC);
end COMPONENT;

COMPONENT sm_decoder
PORT(
	CLK : IN std_logic;
	RESET : IN std_logic;
	A : IN std_logic;
	B : IN std_logic;          
	S1 : OUT std_logic;
	S2 : OUT std_logic;
	ISTATE : OUT std_logic_vector(2 downto 0)
	);
END COMPONENT;

--- IMPORTS END ---

-- SIGNALS --
	signal SM_OUT_S1: STD_LOGIC;
	signal SM_OUT_S2: STD_LOGIC;
	signal SM_OUT_ISTATE: STD_LOGIC_VECTOR (2 downto 0);
	signal RESET_NEG: STD_LOGIC;
	signal S1S2: STD_LOGIC_VECTOR (1 downto 0);

begin

	ST_MACH: sm_decoder PORT MAP(
		CLK => CLK,
		RESET => RESET_NEG,
		A => SW_A,
		B => SW_B,
		S1 => SM_OUT_S1,
		S2 => SM_OUT_S2,
		ISTATE => SM_OUT_ISTATE
	);

   LEDDRIVER: demux_3to5 PORT MAP(DIN=>SM_OUT_ISTATE, DOUT=>LED);

	SEGDRIVER: seg_driver PORT MAP(
		BCD => '0' & SM_OUT_ISTATE,
		LED_out => SEG,
		AN => AN
	);

	RGBDRIVER: rgb_driver PORT MAP(
		DIN => S1S2,
		R => RGB1_Red,
		G => RGB1_Green,
		B => RGB1_Blue
	);

	S1S2      <= SM_OUT_S1 & SM_OUT_S2;
   RESET_NEG <= not RESET;
   S1_LED <= SM_OUT_S1;
   S2_LED <= SM_OUT_S2;
		
end sm_top_impl;

