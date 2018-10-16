library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity seg_driver is
    Port ( BCD : in  STD_LOGIC_VECTOR (3 downto 0);
           LED_out : out  STD_LOGIC_VECTOR (6 downto 0);
			  AN  : out STD_LOGIC_VECTOR (7 downto 0)
			);
end seg_driver;

architecture seg_driver_impl of seg_driver is
begin
 
 AN <= "01111111";

 DRIVER: process(BCD)
 begin
	case BCD is
    --                        "GFEDCBA" 	                       
	 when "0000" => LED_out <= "1000000"; -- "0"     
    when "0001" => LED_out <= "1111001"; -- "1" 
    when "0010" => LED_out <= "0100100"; -- "2" 
    when "0011" => LED_out <= "0110000"; -- "3" 
    	                       
	 when "0100" => LED_out <= "0011001"; -- "4" 
    when "0101" => LED_out <= "0010010"; -- "5" 
    when "0110" => LED_out <= "0000010"; -- "6" 
    when "0111" => LED_out <= "1111000"; -- "7" 
    when "1000" => LED_out <= "0000000"; -- "8"     
    when "1001" => LED_out <= "0010000"; -- "9" 
    when "1010" => LED_out <= "0001000"; ---"a"
--	 if(AN <= "11111110")then
--	   AN <= "11111100";
--		LED_out <= "1000000";
--		--LED_out2 <= "1111001";
--		end if; --LED_out <= "0001000"; -- a

    when "1011" => LED_out <= "0000011"; -- b
    when "1100" => LED_out <= "1000110"; -- C
    when "1101" => LED_out <= "0100001"; -- d
    when "1110" => LED_out <= "0000110"; -- E
    when "1111" => LED_out <= "0001110"; -- F

	 when others => LED_out <= "1111111"; -- (no number<= leds off)
	end case;
end process;
end seg_driver_impl;

