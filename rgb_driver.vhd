library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity rgb_driver is
    Port ( DIN : in  STD_LOGIC_VECTOR (1 downto 0);
           R : out  STD_LOGIC;
           G : out  STD_LOGIC;
           B : out  STD_LOGIC);
end rgb_driver;

architecture rgb_driver_impl of rgb_driver is
begin
DRIVER: process(DIN)
begin
	case DIN is
		when "00" => R <= '1'; G <= '0'; B <= '0';
		when "01" => R <= '0'; G <= '1'; B <= '0';
		when "11" => R <= '0'; G <= '0'; B <= '1';
		when others => R <= '1'; G <= '1'; B <= '1';
	end case;
end process;
end rgb_driver_impl;

