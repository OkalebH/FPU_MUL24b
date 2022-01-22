----------------------------------------------------------------------------------
-- Company: BUAP
-- Engineer: Oscar Kaleb Hernandez Badillo
-- 
-- Create Date:    01:14:16 09/17/2020 
-- Design Name: 	 Multiplicador de punto flotante
-- Module Name:    cero_check - Behavioral 
-- Project Name: 	 FP_Multiplier
-- Target Devices: Spartan 6
-- Tool versions: 
-- Description: 
--	This project focuse on the implementation of a floating point multiplier, following
-- instructions from the IEEE 754-2008 Standard.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Multiplier is
    Port ( num_1 : in  STD_LOGIC_VECTOR (23 downto 0);
           num_2 : in  STD_LOGIC_VECTOR (23 downto 0);
           num_o : out  STD_LOGIC_VECTOR (23 downto 0));
end Multiplier;

architecture Behavioral of Multiplier is
-----------------------------------------------------------------------
---------------- C   O   M   P   O   N   E   N   T --------------------
-----------------------------------------------------------------------
	COMPONENT cero_check
	PORT(
		num_1 : IN std_logic_vector(23 downto 0);
		num_2 : IN std_logic_vector(23 downto 0);          
		num_i : OUT std_logic_vector(23 downto 0);
		flag : OUT std_logic_vector(1 downto 0)
		);
	END COMPONENT;


	COMPONENT separate_bits
	PORT(
		en : IN std_logic_vector(1 downto 0);
		num_1 : IN std_logic_vector(23 downto 0);
		num_2 : IN std_logic_vector(23 downto 0);          
		s1 : OUT std_logic;
		s2 : OUT std_logic;
		exp1 : OUT std_logic_vector(7 downto 0);
		exp2 : OUT std_logic_vector(7 downto 0);
		frac1 : OUT std_logic_vector(15 downto 0);
		frac2 : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	COMPONENT sign
	PORT(
		s1 : IN std_logic;
		s2 : IN std_logic;          
		s : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT exponent
	PORT(
		exp1 : IN std_logic_vector(7 downto 0);
		exp2 : IN std_logic_vector(7 downto 0);          
		exp : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	
	COMPONENT multiplication
	PORT(
		frac1 : IN std_logic_vector(15 downto 0);
		frac2 : IN std_logic_vector(15 downto 0);          
		frac : OUT std_logic_vector(18 downto 0)
		);
	END COMPONENT;
	
	COMPONENT normalization
	PORT(
		exp : IN std_logic_vector(7 downto 0);
		frac : IN std_logic_vector(18 downto 0);          
		exp_o : OUT std_logic_vector(7 downto 0);
		frac_o : OUT std_logic_vector(14 downto 0)
		);
	END COMPONENT;
	
	COMPONENT union_bits
	PORT(
		s : IN std_logic;
		exp : IN std_logic_vector(7 downto 0);
		frac : IN std_logic_vector(14 downto 0);          
		num : OUT std_logic_vector(23 downto 0)
		);
	END COMPONENT;

	COMPONENT final_selector
	PORT(
		flag : IN std_logic_vector(1 downto 0);
		num : IN std_logic_vector(23 downto 0);
		num_1 : IN std_logic_vector(23 downto 0);          
		num_o : OUT std_logic_vector(23 downto 0)
		);
	END COMPONENT;

-----------------------------------------------------------------------
-------------------- S    I    G    N    A    L -----------------------
-----------------------------------------------------------------------
	signal s1x,s2x,sx : std_logic;
	signal flag_x : std_logic_vector(1 downto 0);
	signal exp1x,exp2x,expx,fexp : std_logic_vector(7 downto 0);
	signal frac1x,frac2x : std_logic_vector(15 downto 0);
	signal ffrac : std_logic_vector(14 downto 0);
	signal fracx : std_logic_vector(18 downto 0);
	signal numx, num_ix : std_logic_vector(23 downto 0);
begin
-----------------------------------------------------------------------
---------- I   N   S   T   A   N   T   I   A   T   I   O   N ----------
-----------------------------------------------------------------------
	one_cero_check: cero_check PORT MAP(
		num_1 => num_1,
		num_2 => num_2,
		num_i => num_ix,
		flag => flag_x
	);
	Separacion: separate_bits PORT MAP(
		en => flag_x,
		num_1 => num_1,
		num_2 => num_2,
		s1 => s1x,
		s2 => s2x,
		exp1 => exp1x,
		exp2 => exp2x,
		frac1 => frac1x,
		frac2 => frac2x
	);
	
	Signo: sign PORT MAP(
		s1 => s1x,
		s2 => s2x,
		s => sx
	);
	Exponente: exponent PORT MAP(
		exp1 => exp1x,
		exp2 => exp2x,
		exp => expx 
	);
	
	Mantisa: multiplication PORT MAP(
		frac1 => frac1x,
		frac2 => frac2x,
		frac => fracx
	);
	
	Normalizacion: normalization PORT MAP(
		exp => expx,
		frac => fracx,
		exp_o => fexp,
		frac_o => ffrac
	);	
	
	Union: union_bits PORT MAP(
		s => sx,
		exp => fexp,
		frac => ffrac,
		num => numx
	);

	Selector: final_selector PORT MAP(
		flag => flag_x,
		num => numx,
		num_1 => num_ix,
		num_o => num_o
	);
end Behavioral;

