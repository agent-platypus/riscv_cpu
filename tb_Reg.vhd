library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all; 

ENTITY tb_Reg is
END tb_Reg;

ARCHITECTURE Behavior of tb_Reg is 

COMPONENT Reg

PORT(data_in: in std_logic_vector(31 downto 0);
		data_out: out std_logic_vector(31 downto 0);
		en: in std_logic;
		clk: in std_logic;
		reset: in std_logic);

END COMPONENT;

constant clockfreq : integer := 50e6;
constant clockperiod : time := 1000ms/clockfreq;



signal data_in_sig: std_logic_vector(31 downto 0);

signal data_out_sig: std_logic_vector(31 downto 0);

signal en_sig: std_logic;

signal clk_sig: std_logic:= '0'; 

signal reset_sig: std_logic:= '1';

BEGIN
DUT: Reg
PORT MAP(data_in => data_in_sig, data_out => data_out_sig, en => en_sig, clk => clk_sig, reset => reset_sig);

clk_sig <= not clk_sig after clockperiod/2;

	PROCESS IS

		BEGIN
		
		reset_sig <= '0';
		data_in_sig <= "10101010101010101010101010101010";
		en_sig <= '0';
		wait for 40 ns;
		
		reset_sig <= '0';
		data_in_sig <= "10101010101010101010101010101010";
		en_sig <= '1';
		wait for 40 ns;
		
		reset_sig <= '0';
		data_in_sig <= "11111111111111110000000000000000";
		en_sig <= '1';
		wait for 40 ns;
		
		reset_sig <= '0';
		data_in_sig <= "11110000111100001111000011110000";
		en_sig <= '1';
		wait for 40 ns;
		
		reset_sig <= '1';
		data_in_sig <= "10101010101010101010101010101010";
		en_sig <= '1';
		wait for 80 ns;
		
	END PROCESS;
END;

