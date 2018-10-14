library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sm_decoder is
    Port ( CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           S1 : out  STD_LOGIC;
           S2 : out  STD_LOGIC;
			  ISTATE: out  std_logic_vector(2 downto 0) 
			  );
end sm_decoder;

architecture sm_decoder_impl of sm_decoder is
	
	-- STATE ENCODINGS                                         
	constant STATE1 : std_logic_vector(4 downto 0) := "001" & "00";
	constant STATE2 : std_logic_vector(4 downto 0) := "010" & "00";
	constant STATE3 : std_logic_vector(4 downto 0) := "011" & "01";
	constant STATE4 : std_logic_vector(4 downto 0) := "100" & "11";
	constant STATE5 : std_logic_vector(4 downto 0) := "101" & "00";
	
	signal CUR_STATE : std_logic_vector(4 downto 0);
begin

-- Hard wires
S1 <= CUR_STATE(0);
S2 <= CUR_STATE(1);
ISTATE <= CUR_STATE(4 downto 2);

FSM: PROCESS(CLK,RESET)
begin
	if (RESET ='1') then CUR_STATE <= STATE1;
	elsif rising_edge(CLK) then
		case CUR_STATE is
			when STATE1 => 
				if ( (A='1') and (B='0') ) then
					CUR_STATE <= STATE2;
				else 
					CUR_STATE <= STATE1;
				end if;
			when STATE2 => 
				if ( (A='0') and (B='1') ) then
					CUR_STATE <= STATE4;
				elsif ( (A='0') and (B='0') ) then
					CUR_STATE <= STATE3;
				else
					CUR_STATE <= STATE2;
				end if;
			when STATE3 => 
				if ( (A='1') and (B='0') ) then
					CUR_STATE <= STATE2;
				elsif ( (A='1') and (B='1') ) then
					CUR_STATE <= STATE1;
				elsif ( (A='0') and (B='1') ) then
					CUR_STATE <= STATE5;
				else
					CUR_STATE <= STATE3;
				end if;
			when STATE4 =>
				if ( (A='0') and (B='0') ) then
					CUR_STATE <= STATE5;
				else
					CUR_STATE <= STATE4;
				end if;
			when STATE5 => 
				CUR_STATE <= STATE1;
			when OTHERS => 
				CUR_STATE <= STATE1;
		end case;
	end if;
end process FSM;

end sm_decoder_impl;

