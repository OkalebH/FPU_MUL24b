library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity multiplication is
    Port ( frac1 : in  STD_LOGIC_VECTOR (15 downto 0);
           frac2 : in  STD_LOGIC_VECTOR (15 downto 0);
           frac : out  STD_LOGIC_VECTOR (18 downto 0));
end multiplication;

architecture Behavioral of multiplication is
signal num_1, num_2 : unsigned(15 downto 0);
signal bit_sum : unsigned(31 downto 0);
signal frac_t : unsigned(17 downto 0);
signal frac_r : unsigned(18 downto 0);
signal lead0 : unsigned(3 downto 0);
signal least0 : unsigned(17 downto 0);
begin
	num_1 <= unsigned(frac1);
	num_2 <= unsigned(frac2);
	
	bit_sum <= unsigned(num_1) * unsigned(num_2);
--	--Trunca a 18 bits, revisa que los bits más significativos no sean cero
	lead0 <= "0000" when bit_sum(31) = '1' else
				"0001" when bit_sum(30) = '1' else
				"0010" when bit_sum(29) = '1' else
				"0011" when bit_sum(28) = '1' else
				"0100" when bit_sum(27) = '1' else
				"0101" when bit_sum(26) = '1' else
				"0110" when bit_sum(25) = '1' else
				"0111" when bit_sum(24) = '1' else
				"1000" when bit_sum(23) = '1' else
				"1001" when bit_sum(22) = '1' else
				"1010" when bit_sum(21) = '1' else
				"1011" when bit_sum(20) = '1' else
				"1100" when bit_sum(19) = '1' else
				"1101" when bit_sum(18) = '1' else
				"1110";

	with lead0 select 
		frac_t <= 
			bit_sum(31 downto 14) when "0000",
			bit_sum(30 downto 13) when "0001",
			bit_sum(29 downto 12) when "0010",
			bit_sum(28 downto 11) when "0011",
			bit_sum(27 downto 10) when "0100",
			bit_sum(26 downto 9) when "0101",
			bit_sum(25 downto 8) when "0110",
			bit_sum(24 downto 7) when "0111",
			bit_sum(23 downto 6) when "1000",
			bit_sum(22 downto 5) when "1001",
			bit_sum(21 downto 4) when "1010",
			bit_sum(20 downto 3) when "1011",
			bit_sum(19 downto 2) when "1100",
			bit_sum(18 downto 1) when "1101",
			bit_sum(17 downto 0) when others;
			
	--REDONDEOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
	least0 <= "000000000000000001" when frac_t(0) = '1' else
				 "000000000000000010" when frac_t(1) = '1' else
				 "000000000000000100" when frac_t(2) = '1' else
				 "000000000000000000"; 
	frac_r <= ('0' & frac_t) + ('0' & least0);
	frac <= std_logic_vector(frac_r);
end Behavioral;

