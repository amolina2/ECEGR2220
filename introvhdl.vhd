
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;
ENTITY introvhdl is
PORT (
	A : IN STD_LOGIC;
	B : IN STD_LOGIC;
	C : IN STD_LOGIC;
	D : IN STD_LOGIC;
	E : OUT STD_LOGIC);
END introvhdl;
ARCHITECTURE behavior OF introvhdl IS
BEGIN 
	E <= (A OR B) AND (C OR D);
END architecture behavior;