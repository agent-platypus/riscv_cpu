library ieee;
use ieee.std_logic_1164.all;

entity hex_interface is
	port( data_in: in std_logic_vector(3 downto 0);
			seg_out: out std_logic_vector(6 downto 0)
		  );
end hex_interface;

architecture behavior of hex_interface is

begin

--	hex_segment_mapping: for ii in 0 to 6 generate
--		seg_out(ii) <= seg_out(ii);
--	end generate;
--	
--	button_mapping: for ii in 0 to 3 generate
--		SW(ii) <= SW(ii);
--	end generate;
	
	display_hex: process(data_in)
		begin
			case data_in is
				when x"0" => 
					seg_out <= "1000000";
				when x"1" => 
					seg_out <= "1111001";
				when x"2" => 
					seg_out <= "0100100";
				when x"3" => 
					seg_out <= "0110000";
				when x"4" => 
					seg_out <= "0011001";
				when x"5" => 
					seg_out <= "0010010";
				when x"6" => 
					seg_out <= "0000010";
				when x"7" => 
					seg_out <= "1111000";
				when x"8" => 
					seg_out <= "0000000";
				when x"9" => 
					seg_out <= "0010000";
				when x"a" => 
					seg_out <= "0001000";
				when x"b" => 
					seg_out <= "0000011";
				when x"c" => 
					seg_out <= "0100111";
				when x"d" => 
					seg_out <= "0100001";
				when x"e" => 
					seg_out <= "0000110";
				when x"f" => 
					seg_out <= "0001110";
				when others =>
					seg_out <= "1111111";
			end case;
			
		end process display_hex;
		
end behavior;