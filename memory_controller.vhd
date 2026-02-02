library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity memory_controller is

	port(  SW      : in std_logic_vector(11 downto 0);
			 KEY     : in std_logic;
			 CLOCK_50: in std_logic;
			 LCD_DATA: out std_logic_vector(7 downto 0);
			 LCD_EN  : out std_logic;
			 LCD_RW  : out std_logic;
			 LCD_RS  : out std_logic;
			 LCD_ON  : out std_logic);	

end memory_controller;

architecture Behavior of memory_controller is
	
	type state_type is (
		IDLE,
		SETUP_ADDR,
		ENABLE_HIGH,
		DATA_SETUP,
		ENABLE_LOW,
		DONE
	);
	
	signal state: state_type := IDLE;
	
	signal counter: integer := 0;
	
	--	signal LCD_enable_sig: std_logic := '0';
	
	--external
	signal LCD_select_reg: std_logic; 
	signal LCD_readwrite: std_logic;
	signal LCD_data_line: std_logic_vector(7 downto 0);
	signal clk_sig: std_logic; 
	signal enable_operation: std_logic;

	begin
	mapping_sw_to_lcd_data: for ii in 0 to 7 generate
		LCD_data_line(ii) <= SW(ii);
	end generate mapping_sw_to_lcd_data;

	
	clk_sig <= CLOCK_50;
	
	LCD_select_reg <= SW(8);
	
	LCD_readwrite <= SW(9);
	
	LCD_ON <= SW(10);
	
	enable_operation <= SW(11);
	 
	writeOp: process(clk_sig) --50 MHz clock -> 20 ns/cycle 
	begin 
		if rising_edge(clk_sig) then
			case state is
				
				when IDLE =>
					if enable_operation = '1' then
						LCD_RS <= LCD_select_reg;
						LCD_RW <= LCD_readwrite;
						counter <= 0;
						state <= SETUP_ADDR;
					end if;
				
				when SETUP_ADDR =>
					if counter = 2 then  -- for 35 ns
						LCD_EN <= '1';
						counter <= 0;
						state <= ENABLE_HIGH;
					else
						counter <= counter + 1;
					end if;
				when ENABLE_HIGH =>
					if counter = 15 then  -- for 285 ns
						LCD_DATA <= LCD_data_line;
						counter <= 0;
						state <= DATA_SETUP;
					else
						counter <= counter + 1;
					end if;
				when DATA_SETUP =>
					if counter = 10 then  -- for 195 ns 
						LCD_EN <= '0';
						counter <= 0;
						state <= ENABLE_LOW;
					else
						counter <= counter + 1;
					end if;
				when ENABLE_LOW =>
					if counter = 3 then  -- for 50 ns 
						state <= DONE;
					else
						counter <= counter + 1;
					end if;
				when DONE =>
					state <= idle;
			
			end case;
		end if;
		
	end process writeOp;
	
end Behavior;
		
	
--	 --internal
--	signal LCD_enable_sig: std_logic := '0';
--	
--	--external
--	signal LCD_select_reg: std_logic; 
--	signal LCD_readwrite: std_logic;
--	signal LCD_data_line: std_logic_vector(7 downto 0);
--	signal clk_sig: std_logic;
--	
--	
--begin 
--
--	mapping_sw_to_lcd_data: for ii in 0 to 7 generate
--		LCD_data_line(ii) <= SW(ii);
--	end generate mapping_sw_to_lcd_data;
--
--	
--	clk_sig <= KEY;
--	
--	LCD_select_reg <= SW(8);
--	
--	LCD_readwrite <= SW(9);
--	
--	LCD_ON <= SW(10);
--	
--	trigger_writeOp: process(clk_sig) is
--		begin
--		
--			if rising_edge(clk_sig) then
--			
--				LCD_RS <= LCD_select_reg;
--				LCD_RW <= LCD_readwrite;
--				wait for 35 ns; --address set-up time minus enable rising time ( 60ns - 25ns = 35ns)
--				
--				LCD_enable_sig <= '1';
--				LCD_EN <= LCD_enable_sig;
--				wait for 285 ns; --Enable rising time = 25 ns + 5 ns to ensure stable enable signal
--									  --Enable pulse width minus data setup time (450ns - 195ns = 255 ns)
--									  
--				LCD_DATA <= LCD_data_line; 
--				wait for 195 ns;  -- Data setup time
--				
--				LCD_enable_sig <= '0';
--				LCD_EN <= LCD_enable_sig;
--				wait for 50 ns;  -- enable fall time (30 ns) + address hold time (20 ns) 
--									  -- once enable is low, RS, RW and data are maintained 
--									  -- for max(address hold, data hold (10ns) = 20 ns 
--				
--			end if;
--			
--	end process trigger_writeOp;
--	
--
--end Behavior;