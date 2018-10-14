library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sm_top is
    Port ( SW : in  STD_LOGIC_VECTOR (4 downto 0); 
           LED : out  STD_LOGIC_VECTOR (15 downto 11); 
			  SEG : out  STD_LOGIC_VECTOR (6 downto 0);
			  AN  : out STD_LOGIC_VECTOR (7 downto 0);
			  RGB1_Red : out STD_LOGIC;
			  RGB1_Green : out STD_LOGIC;
			  RGB1_Blue : out STD_LOGIC
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

--- IMPORTS END ---

-- SIGNALS --
	signal BCD_in :  STD_LOGIC_VECTOR (3 downto 0);
	signal LED_SIGNAL: STD_LOGIC_VECTOR (2 downto 0);
	signal RGB_SIGNAL: STD_LOGIC_VECTOR (1 downto 0);
begin
	
-- Connect inputs to signals for easy rerouting
LED_SIGNAL <= SW(2 downto 0);
RGB_SIGNAL <= SW(4 downto 3);	

-- 7 Segment display
BCD_in(3) <= '0';	
BCD_in(2 downto 0) <= LED_SIGNAL;	

LEDDRIVER: demux_3to5 PORT MAP(DIN=>LED_SIGNAL, DOUT=>LED);
SEGDRIVER: seg_driver PORT MAP(BCD=>BCD_in, LED_out=>SEG, AN=>AN);
RGBDRIVER: rgb_driver PORT MAP(DIN=>RGB_SIGNAL, R=>RGB1_Red, G=>RGB1_Green, B=> RGB1_Blue);
	
end sm_top_impl;

