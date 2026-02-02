library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity Reg is
port( data_in:  in std_logic_vector(31 downto 0);
		data_out: out std_logic_vector(31 downto 0);
		en:       in std_logic;
		clk:      in std_logic;
		reset:    in std_logic);
end Reg;

architecture Behavior of Reg is
	
	signal data_internal: std_logic_vector(31 downto 0);
	
begin
	storeBit: process(clk, reset)
	
	begin
		if reset = '1' then
		
			data_internal <= (OTHERS => '0');
--			data_out <= (OTHERS => '0');
		elsif rising_edge(clk) then 
		
			if en = '1' then
				data_internal <= data_in;
--			data_out <= data_in;
			end if;
			
		end if;
	end process;
	
	data_out <= data_internal;
			
end Behavior;