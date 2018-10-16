
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity top_segswitch is
    Port ( sw : in  STD_LOGIC_VECTOR (15 downto 0);
           seg : out  STD_LOGIC_VECTOR (6 downto 0);
			  an : out  STD_LOGIC_VECTOR (7 downto 0));
end top_segswitch;

architecture top_segswitch_arch of top_segswitch is

	COMPONENT encoder15
	PORT(
		inENC : IN std_logic_vector(15 downto 0);          
		outENC : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
		
		COMPONENT segswitch
	PORT(
		BCD : IN std_logic_vector(3 downto 0);          
		led_out : OUT std_logic_vector(6 downto 0);
		AN : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

	signal connect : std_logic_vector(3 downto 0);
	-- signal an_control : std_logic_vector(7 downto 0);
begin

	EnCode: encoder15 PORT MAP(
		inENC => sw,
		outENC => connect
	);
	
		switch_light: segswitch PORT MAP(
		BCD => connect ,
		led_out =>seg ,
		AN => an
		);

-- an_control <= "00000001";

end top_segswitch_arch;

