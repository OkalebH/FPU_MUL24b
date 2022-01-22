library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity exponent is
    Port ( exp1 : in  STD_LOGIC_VECTOR(7 downto 0);
           exp2 : in  STD_LOGIC_VECTOR(7 downto 0);
           exp : out  STD_LOGIC_VECTOR (7 downto 0));
end exponent;

architecture Behavioral of exponent is
signal exp_sum : unsigned(8 downto 0);
signal exp_debiased : unsigned(8 downto 0);
--signal exp_o : unsigned(8 downto 0);
signal exp_1,exp_2 : unsigned(7 downto 0);
--integer 
begin
	exp_1 <= unsigned(exp1);-- -1 when unsigned(exp1) < 127 else unsigned(exp1);
	exp_2 <= unsigned(exp2);-- -1 when unsigned(exp2) < 127 else unsigned(exp2);
	
	--exp_sum <= ('0' & exp_1) + ('0' & exp_2);
	exp_debiased <= exp_sum - 127 when exp_sum >= 128 and exp_sum <= 381 else -- Cuando el exponente resultante sin desplazar es menor a 128, significa que ocurre un underflow
						(others => '0') when exp_sum < 128 else
						(others => '1') when exp_sum > 381;
		
	exp_sum <= (('0' & exp_1) + ('0' & exp_2)) when (exp_1 < 127) and (exp_2 < 127) and ( exp_1 = exp_2) else
				  (('0' & exp_1) + ('0' & exp_2) - 1) when (exp_1 < 127) or (exp_2 < 127) else				  
				  ('0' & exp_1) + ('0' & exp_2); --when (exp_1 >= 127) and (exp_2 >= 127) else
	--			  
				  
	--			  ('0' & exp_1) + ('0' & exp_2) - 2;
				 
	--exp_debiased <= exp_sum - 127 when exp_sum >= 128 and exp_sum <= 381 else -- Cuando el exponente resultante sin desplazar es menor a 128, significa que ocurre un underflow
	--					 (others => '0') when exp_sum < 128 else
	--					 (others => '1') when exp_sum > 381;
	
	--exp_o <= exp_sum(8 downto 0) - 128; --
	exp <= std_logic_vector(exp_debiased(7 downto 0));
	
end Behavioral;

