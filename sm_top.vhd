library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sm_top is
    Port ( SW : in  STD_LOGIC_VECTOR (2 downto 0); 
           LED : out  STD_LOGIC_VECTOR (15 downto 11) );
end sm_top;

architecture sm_top_impl of sm_top is
--- IMPORTS START ---
COMPONENT demux_3to5 is
    Port ( DIN : in  STD_LOGIC_VECTOR (2 downto 0);
           DOUT : out  STD_LOGIC_VECTOR (4 downto 0));
end COMPONENT;
--- IMPORTS END ---

begin
	
LEDDRIVER: demux_3to5 PORT MAP(DIN=>SW, DOUT=>LED);
	
end sm_top_impl;

