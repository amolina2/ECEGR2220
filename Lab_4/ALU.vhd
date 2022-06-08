Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity shift_register is
	port(	datain: in std_logic_vector(31 downto 0);
	   	dir: in std_logic;
		shamt:	in std_logic_vector(4 downto 0);
		dataout: out std_logic_vector(31 downto 0));
end entity shift_register;

architecture shifter of shift_register is
	signal s: std_logic_vector(2 downto 0);
begin
	s <= dir & shamt (1 downto 0);
	process (s) is 
	begin 
	if s= "001" then dataout <= datain(30 downto 0) & "0";
	elsif s = "010" then dataout <= datain(29 downto 0) & "00";
	elsif s="011" then dataout <= datain(28 downto 0) & "000";
	elsif s = "101" then dataout <= "0" & datain(31 downto 1);
	elsif s = "110" then dataout <= "00" & datain(31 downto 2);
	elsif s = "111" then dataout <= "000" & datain(31 downto 3);
	else dataout <= datain;
	end if;
	end process;
	
end architecture shifter;

------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity fulladder is
    port (a : in std_logic;
          b : in std_logic;
          cin : in std_logic;
          sum : out std_logic;
          carry : out std_logic );
end fulladder;

architecture addlike of fulladder is
begin
  sum   <= a xor b xor cin; 
  carry <= (a and b) or (a and cin) or (b and cin); 
end architecture addlike;
---------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity adder_subtracter is
	port(	datain_a: in std_logic_vector(31 downto 0);
		datain_b: in std_logic_vector(31 downto 0);
		add_sub: in std_logic;
		dataout: out std_logic_vector(31 downto 0);
		co: out std_logic);
end entity adder_subtracter;

architecture calc of adder_subtracter is

component fulladder 
    port (a : in std_logic;
          b : in std_logic;
          cin : in std_logic;
          sum : out std_logic;
          carry : out std_logic);
	end component;

	signal temp: std_logic_vector(31 downto 0); 
	signal addorsub: std_logic_vector(32 downto 0);

begin
	addorsub(0) <= add_sub;
	co <= addorsub(32); 
	
	process (add_sub, datain_a, datain_b) is 
	begin 
		if add_sub = '0' then temp <= datain_b; 
		else temp <= not datain_b; 
		end if; 
	end process; 
	
	adderloop: for i in 31 downto 0 generate
	addi: fulladder port map(datain_a(i), temp(i),addorsub(i),dataout(i),addorsub(i+1));	
	end generate;

end architecture calc;

--------------------------------------------------------------------------------
--
-- LAB #4
--
--------------------------------------------------------------------------------

Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity ALU is
	Port(	DataIn1: in std_logic_vector(31 downto 0);
		DataIn2: in std_logic_vector(31 downto 0);
		ALUCtrl: in std_logic_vector(4 downto 0);
		Zero: out std_logic;
		ALUResult: out std_logic_vector(31 downto 0) );
end entity ALU;

architecture ALU_Arch of ALU is
	-- ALU components	
	component adder_subtracter
		port(	datain_a: in std_logic_vector(31 downto 0); 
			datain_b: in std_logic_vector(31 downto 0);
			add_sub: in std_logic;
			dataout: out std_logic_vector(31 downto 0);
			co: out std_logic);
	end component adder_subtracter;

	component shift_register
		port(	datain: in std_logic_vector(31 downto 0);
		   	dir: in std_logic; --direction 
			shamt:	in std_logic_vector(4 downto 0); --shift amount
			dataout: out std_logic_vector(31 downto 0));
	end component shift_register;

-------------NON-IMMEDIATES
	signal add_sub_output: std_logic_vector (31 downto 0); 
	signal shift: std_logic_vector (31 downto 0);
	signal andj: std_logic_vector (31 downto 0); 
	signal orj: std_logic_vector (31 downto 0);
	signal coj: std_logic;   
	
	signal aosj: std_logic;
	signal tempoutj: std_logic_vector (31 downto 0);

------------IMMEDIATES 
	signal add_sub_output_i: std_logic_vector (31 downto 0); 
	signal shift_i: std_logic_vector (31 downto 0);
	signal andj_i: std_logic_vector (31 downto 0); 
	signal orj_i: std_logic_vector (31 downto 0);
	signal coj_i: std_logic; 
	

begin

process (ALUCtrl) is 
begin 
	if ALUCtrl = "00001" then aosj <= '0';
	elsif ALUCtrl = "00010" then aosj <= '1';
	end if; 
end process;

-------NON-IMMEDIATE
	andj <= DataIn1 and DataIn2;
	orj <= DataIn1 or DataIn2;
	j1: component adder_subtracter 
		port map(DataIn1, DataIn2, aosj,add_sub_output,coj);
	j2: component shift_register 
		port map(DataIn1,ALUCtrl(3),ALUCtrl,shift);
	
-------IMMEDIATE 
	andj_i <= DataIn1 and DataIn2;
	orj_i <= DataIn1 or DataIn2;
	j1_1: component adder_subtracter 
		port map(DataIn1, DataIn2, aosj,add_sub_output_i,coj);
	j2_1: component shift_register 
		port map(DataIn1,ALUCtrl(3),ALUCtrl,shift_i);
-----------------------------------------------------------

	
	with ALUCtrl select 
	tempoutj <= add_sub_output when "00001",
		     add_sub_output when "00010",
		     shift when "01001",
		     shift when "01010",
		     shift when "01011",
		     shift when "10001",
		     shift when "10010", 
		     shift when "10011",
		     andj when "00011",
		     orj when "00101",
-----------IMMEDIATE--------
		     add_sub_output_i when "11110",
		     add_sub_output_i when "11101",
		     shift_i when "10110",
		     shift_i when "10101",
		     shift_i when "10100",
		     shift_i when "01110",
		     shift_i when "01101", 
		     shift_i when "01100",
		     andj_i when "11100",
		     orj_i when "11010",


		     DataIn2 when others;
process (tempoutj) is 
begin 
	if tempoutj = 0 then Zero <= '1';
else Zero <= '0';
end if;
end process;

ALUResult <= tempoutj;

end architecture ALU_Arch;

