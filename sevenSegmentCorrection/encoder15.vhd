
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity encoder15 is
    Port ( inENC : in  STD_LOGIC_VECTOR (15 downto 0);
           outENC : out  STD_LOGIC_VECTOR (3 downto 0));
			  
end encoder15;

architecture encoder15_arch of encoder15 is



begin
	Encoder: process(inENC)

 begin
 case inENC is
    --                         	                       
	 when "1000000000000000" => outENC <= "0000";   --"0"   
    when "0000000000000001" => outENC <= "0001";  
    when "0000000000000010" => outENC <= "0010"; 
    when "0000000000000100" => outENC <= "0011";                        	                       
	 when "0000000000001000" => outENC <= "0100"; 
    when "0000000000010000" => outENC <= "0101";  
    when "0000000000100000" => outENC <= "0110";  
    when "0000000001000000" => outENC <= "0111"; -- "7" 
    when "0000000010000000" => outENC <= "1000"; -- "8"     
    when "0000000100000000" => outENC <= "1001"; -- "9" 
    when "0000001000000000" => outENC <= "1010"; -- a
    when "0000010000000000" => outENC <= "1011"; -- b
    when "0000100000000000" => outENC <= "1100"; -- C
    when "0001000000000000" => outENC <= "1101"; -- d
    when "0010000000000000" => outENC <= "1110"; -- E
    when "0100000000000000" => outENC <= "1111"; -- F

	 when others => outENC <= "0000"; -- 0
	end case;
end process;

end encoder15_arch;

