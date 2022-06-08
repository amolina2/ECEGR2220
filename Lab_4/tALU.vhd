--------------------------------------------------------------------------------
--
-- Test Bench for LAB #4
--
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY testALU_vhd IS
END testALU_vhd;

ARCHITECTURE behavior OF testALU_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT ALU
		Port(	DataIn1: in std_logic_vector(31 downto 0);
			DataIn2: in std_logic_vector(31 downto 0);
			ALUCtrl: in std_logic_vector(4 downto 0);
			Zero: out std_logic;
			ALUResult: out std_logic_vector(31 downto 0) );
	end COMPONENT ALU;

	--Inputs
	SIGNAL datain_a : std_logic_vector(31 downto 0) := (others=>'0');
	SIGNAL datain_b : std_logic_vector(31 downto 0) := (others=>'0');
	SIGNAL control	: std_logic_vector(4 downto 0)	:= (others=>'0');

	--Outputs
	SIGNAL result   :  std_logic_vector(31 downto 0);
	SIGNAL zeroOut  :  std_logic;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: ALU PORT MAP(
		DataIn1 => datain_a,
		DataIn2 => datain_b,
		ALUCtrl => control,
		Zero => zeroOut,
		ALUResult => result
	);
	

	tb : PROCESS
	BEGIN

		-- Wait 100 ns for global reset to finish
		wait for 100 ns;

		-- Start testing the ALU
		datain_a <= X"01234567";	-- DataIn in hex
		datain_b <= X"11223344";
		control  <= "00000";		-- DATAIN2 OUTPUT
		wait for 20 ns; 			

		control <= "00001"; -- ADD
		wait for 20 ns;
		control <= "00010"; --SUBSTRACTING
		wait for 20 ns;
		control <= "00011"; --AND
		wait for 20 ns;
		control <= "00101"; --OR
		wait for 20 ns;
		control <= "01001"; --SHIFT RIGHT BY ONE
		wait for 20 ns;
		control <= "01010"; --SHIFT RIGHT BY TWO
		wait for 20 ns;
		control <= "01011"; --SHIFT RIGHT BY THREE
		wait for 20 ns;
		control <= "10001"; --SHIFT LEFT BY ONE
		wait for 20 ns;
		control <= "10010"; --SHIFT LEFT BY TWO
		wait for 20 ns;
		control <= "10011"; --SHIFT LEFT BY THREE
		wait for 20 ns;
		
             ----------------IMMEDIATES---------------------------
	
		control <= "11110"; --addi
		wait for 20 ns; 
		control <= "11101"; --subs
		wait for 20 ns; 
		control <= "11100"; --andi
		wait for 20 ns; 
		control <= "11010"; --ori
		wait for 20 ns; 
		control <= "10110" ;--shift right by one 
		wait for 20 ns; 
		control <= "10101"; --shift right by two 
		wait for 20 ns; 
		control <= "10100"; --shift right by three
		wait for 20 ns; 
		control <= "01110"; --shift left by one
		wait for 20 ns; 
		control <= "01101"; --shift left by two
		wait for 20 ns; 
		control <= "01100"; --shift left by three
		wait for 20 ns; 
		


		wait; -- will wait forever
	END PROCESS;

END;