library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity vec8_to_7seg is
    Port ( vector_in : in  STD_LOGIC_VECTOR (6 downto 0);
           hex1_out : out  STD_LOGIC_VECTOR (7 downto 0);
			  hex2_out : out  STD_LOGIC_VECTOR (7 downto 0)
			  );
end vec8_to_7seg;

architecture Behavioral of vec8_to_7seg is
	function to7seg(value: in integer)
		return STD_LOGIC_VECTOR is
	begin
		case value is 
			when 0	=> return "00111111";
			when 1	=> return "00000110";
			when 2   => return "01011011";
			when 3 => return "01001111";
			when 4 => return "01100110";
			when 5 => return "01101101";
			when 6 => return "01111101";
			when 7 => return "00000111";
			when 8 => return "01111111";
			when 9 => return "01101111";
			when others => return "01000000";
		end case;		
	end to7seg;
	
	function div_f(value: in integer; divier: in integer)
		return integer is
		
		variable a : integer;
	begin
		a := 0;
		
		for i in 0 to 10 loop
			a := i * divier;
			
			if (a > value) then
				return (i - 1);
			end if;
		end loop;
		
	
		return 4;
	end div_f;
	
	function mod_f(value: in integer; divier: in integer)
		return integer is
		
		variable a : integer;
	begin
		
		a := div_f(value, divier);
				
		return value - (divier * a);
		
	end mod_f;
	
	
	signal help: integer range 0 to 99 := 0;
begin
	help <= conv_integer( unsigned(vector_in));
	
	hex1_out <= conv_std_logic_vector(div_f(help, 10), 8);
	hex2_out <= conv_std_logic_vector(mod_f(help, 10), 8);
end Behavioral;

