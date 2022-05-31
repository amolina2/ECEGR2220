--------------------------------------------------------------------------------
--
-- LAB #3
--
--------------------------------------------------------------------------------

Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity bitstorage is
	port(bitin: in std_logic;
		 enout: in std_logic;
		 writein: in std_logic;
		 bitout: out std_logic);
end entity bitstorage;

architecture memlike of bitstorage is
	signal q: std_logic := '0';
begin
	process(writein) is
	begin
		if (rising_edge(writein)) then
			q <= bitin;
		end if;
	end process;
	
	-- Note that data is output only when enout = 0	
	bitout <= q when enout = '0' else 'Z';
end architecture memlike;

--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity fulladder is
    port (a : in std_logic;
          b : in std_logic;
          cin : in std_logic;
          sum : out std_logic;
          carry : out std_logic
         );
end fulladder;

architecture addlike of fulladder is
begin
  sum   <= a xor b xor cin; 
  carry <= (a and b) or (a and cin) or (b and cin); 
end architecture addlike;


--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity register8 is
	port(datain: in std_logic_vector(7 downto 0);
	     enout:  in std_logic;
	     writein: in std_logic;
	     dataout: out std_logic_vector(7 downto 0));
end entity register8;

architecture memmy of register8 is
	component bitstorage
		port(bitin: in std_logic;
		 	 enout: in std_logic;
		 	 writein: in std_logic;
		 	 bitout: out std_logic);
	end component;
begin
	j1: component bitstorage
		port map(datain (0), enout , writein, dataout(0));
	j2: component bitstorage
		port map(datain(1), enout, writein, dataout(1));
	j3: component bitstorage
		port map(datain(2), enout, writein, dataout(2));
	j4: component bitstorage
		port map(datain(3), enout, writein, dataout(3));
	j5: component bitstorage
		port map(datain(4), enout, writein, dataout(4));
	j6: component bitstorage 
		port map(datain(5), enout, writein, dataout(5));
	j7: component bitstorage
		port map(datain(6), enout, writein, dataout(6));
	j8: component bitstorage
		port map(datain(7), enout, writein, dataout(7));
end architecture memmy;

--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity register32 is
	port(datain: in std_logic_vector(31 downto 0);
		 enout32,enout16,enout8: in std_logic;
		 writein32, writein16, writein8: in std_logic;
		 dataout: out std_logic_vector(31 downto 0));
end entity register32;

architecture biggermem of register32 is
	component register8
		port(datain: in std_logic_vector(7 downto 0);
		 	 enout: in std_logic;
		 	 writein: in std_logic;
		 	 dataout: out std_logic_vector(7 downto 0));
	end component;

signal enableo,siu: std_logic_vector(3 downto 0);
signal k,g: std_logic_vector(2 downto 0);
begin
	
	k <= enout32 & enout16 & enout8;
	g <= writein32 & writein16 & writein8;
	
	process(k)is 
	begin 
	if k = "110" then enableo <= "1110";
	elsif k = "101" then enableo <= "1100";
	elsif k = "011" then enableo <= "0000"; 
	else enableo <= "1111"; 
	end if;
	end process;
	

	process(g)is 
	begin 
	if g = "010" then siu <= "0011" ;
	elsif g = "001" then siu <= "0001";
	elsif g = "100" then siu <= "1111"; 
	else siu <= "0000"; 
	end if;
	end process;

	d1:  register8 
		port map(datain(7 downto 0), enableo(0), siu(0), dataout(7 downto 0));
	d2:  register8 
		port map(datain(15 downto 8), enableo(1), siu(1), dataout(15 downto 8));
	d3:  register8 
		port map(datain(23 downto 16), enableo(2), siu(2), dataout(23 downto 16));
	d4:  register8 
		port map(datain(31 downto 24), enableo(3), siu(3), dataout(31 downto 24));

end architecture biggermem;

--------------------------------------------------------------------------------
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



