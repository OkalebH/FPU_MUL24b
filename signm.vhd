library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity sign is
    Port ( s1 : in  STD_LOGIC;
           s2 : in  STD_LOGIC;
           s : out  STD_LOGIC);
end sign;

architecture Behavioral of sign is

begin
	s <= s1 xor s2;

end Behavioral;

