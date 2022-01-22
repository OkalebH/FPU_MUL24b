library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity normalization is
    Port ( exp : in  STD_LOGIC_VECTOR (7 downto 0);
           frac : in  STD_LOGIC_VECTOR (18 downto 0);
           exp_o : out  STD_LOGIC_VECTOR (7 downto 0);
           frac_o : out  STD_LOGIC_VECTOR (14 downto 0));
end normalization;

architecture Behavioral of normalization is
	signal lead0 : unsigned(4 downto 0);
	signal t_frac,frac_norm : unsigned(17 downto 0);
begin
	t_frac <= unsigned(frac(18 downto 1)) when frac(18) = '1' else
				 unsigned(frac(17 downto 0));
	lead0 <= "00000" when t_frac(17) = '1' else
				"00001" when t_frac(16) = '1' else
				"00010" when t_frac(15) = '1' else
				"00011" when t_frac(14) = '1' else
				"00100" when t_frac(13) = '1' else
				"00101" when t_frac(12) = '1' else
				"00110" when t_frac(11) = '1' else
				"00111" when t_frac(10) = '1' else
				"01000" when t_frac(9) = '1' else
				"01001" when t_frac(8) = '1' else
				"01010" when t_frac(7) = '1' else
				"01011" when t_frac(6) = '1' else
				"01100" when t_frac(5) = '1' else
				"01101" when t_frac(4) = '1' else
				"01110" when t_frac(3) = '1' else
				"01111" when t_frac(2) = '1' else
				"10000" when t_frac(1) = '1' else
				"10001";
	
	with lead0 select 
		frac_norm <= 
			t_frac(17 downto 0) 						when "00000",
			t_frac(16 downto 0) & '0'				when "00001",
			t_frac(15 downto 0) & "00"				when "00010",
			t_frac(14 downto 0) & "000"			when "00011",
			t_frac(13 downto 0) & "0000"			when "00100",
			t_frac(12 downto 0) & "00000"			when "00101",
			t_frac(11 downto 0) & "000000"		when "00110",
			t_frac(10 downto 0) & "0000000"		when "00111",
			t_frac(9 downto 0)  & "00000000"		when "01000",
			t_frac(8 downto 0)  & "000000000"		when "01001",
			t_frac(7 downto 0)  & "0000000000"		when "01010",
			t_frac(6 downto 0)  & "00000000000"		when "01011",
			t_frac(5 downto 0)  & "000000000000"		when "01100",
			t_frac(4 downto 0)  & "0000000000000"		when "01101",
			t_frac(3 downto 0)  & "00000000000000"		when "01110",
			t_frac(2 downto 0)  & "000000000000000"	when "01111",
			t_frac(1 downto 0)  & "0000000000000000"	when "10000",
			t_frac(0)			  & "00000000000000000"	when others;

	process(frac_norm,lead0,exp)
	begin
		if (lead0 > unsigned(exp)) then
			exp_o <= (others=>'0');
			frac_o <= (others=>'0');
		else
			exp_o <= std_logic_vector(unsigned(exp) - lead0 - 1);
			frac_o <= std_logic_vector(frac_norm(16 downto 2));
		end if;
	end process;

end Behavioral;

