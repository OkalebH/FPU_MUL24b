----------------------------------------------------------------------------------
-- Company: BUAP
-- Engineer: Oscar Kaleb Hernandez Badillo
-- 
-- Create Date:    01:14:16 09/17/2020 
-- Design Name: 	 FPU_Multiplier
-- Module Name:    cero_check - Behavioral 
-- Description: 
-- This module has the objective of verify if some of its inputs is zero.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cero_check is
    Port ( num_1 : in  STD_LOGIC_VECTOR (23 downto 0);
           num_2 : in  STD_LOGIC_VECTOR (23 downto 0);
			  num_i : out STD_LOGIC_VECTOR(23 downto 0);
           flag : out  STD_LOGIC_VECTOR(1 downto 0));
end cero_check;

architecture Behavioral of cero_check is
begin
	process(num_1,num_2)
	begin
		if(num_1(22 downto 0) = "00000000000000000000000" or num_2(22 downto 0) = "00000000000000000000000") then
			flag <= "01";
		elsif(num_1 = x"3F8000") then
			num_i <= num_2;
			flag <= "10";
		elsif(num_2 = x"3F8000") then
			num_i <= num_1;
			flag <= "10";
		elsif(num_1 = x"BF8000") then 
			num_i <= num_2;
			num_i(23) <= '1';
			flag <= "10";
		elsif(num_2 = x"BF8000") then 
			num_i <= num_1;
			num_i(23) <= '1';
			flag<="10";
		else
			flag <= "00";
		end if;
	end process;

end Behavioral;

