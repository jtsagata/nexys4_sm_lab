library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity demux_3to5 is
    Port ( DIN : in  STD_LOGIC_VECTOR (2 downto 0);
           DOUT : out  STD_LOGIC_VECTOR (4 downto 0));
end demux_3to5;

architecture demux_3to5_impl of demux_3to5 is
begin
	DEMUX: process(DIN)
	begin
		case DIN is
			 when "001" => DOUT <= "10000";
			 when "010" => DOUT <= "01000";
			 when "011" => DOUT <= "00100";
			 when "100" => DOUT <= "00010";
			 when "101" => DOUT <= "00001";
			 when others =>DOUT <= "11111";
		end case;
	end process;
end demux_3to5_impl;

