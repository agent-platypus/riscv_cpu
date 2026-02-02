library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_registerfile is
end tb_registerfile;

architecture behavior of tb_registerfile is

	component registerfile 
		port( clk:        		in std_logic;
				Reg1, Reg2: 		in std_logic_vector(4 downto 0);
				DestReg:    		in std_logic_vector(4 downto 0);
				WrEn:       		in std_logic;
				WrData:     		in std_logic_vector(31 downto 0);
				Reset:      		in std_logic;
				Reg1Out, Reg2Out: out std_logic_vector(31 downto 0)
			  );
	end component;
	 
	constant clockfreq : integer := 50e6;
	constant clockperiod : time := 1000ms/clockfreq;

	signal clk_sig: std_logic:= '0';
	signal Reg1_sig, Reg2_sig, DestReg_sig: std_logic_vector(4 downto 0);
	signal WrEn_sig: std_logic:= '0';
	signal WrData_sig, Reg1Out_sig, Reg2Out_sig: std_logic_vector(31 downto 0);
	signal Reset_sig: std_logic:= '0';

begin 

DUT: registerfile
port map(clk => clk_sig,
			Reg1 => Reg1_sig,
			Reg2 => Reg2_sig,
			DestReg => DestReg_sig,
			WrEn => WrEn_sig,
			WrData => WrData_sig,
			Reset => Reset_sig,
			Reg1Out => Reg1Out_sig,
			Reg2Out => Reg2Out_sig
		  );
clk_sig <= not clk_sig after clockperiod/2;

	process is
		begin
		-- start of testing each register
		DestReg_sig <= "00001"; 
		WrEn_sig <= '1';
		WrData_sig <= x"11111111";
		wait for 20 ns;
		
		DestReg_sig <= "00010"; 
		WrEn_sig <= '1';
		WrData_sig <= x"22222222";
		wait for 20 ns;

		Reg1_sig <= "00001";
		Reg2_sig <= "00010";
		WrEn_sig <= '0';
		wait for 20 ns;
		
		
		DestReg_sig <= "00011"; 
		WrEn_sig <= '1';
		WrData_sig <= x"33333333";
		wait for 20 ns;
		
		DestReg_sig <= "00100"; 
		WrEn_sig <= '1';
		WrData_sig <= x"44444444";
		wait for 20 ns;

		Reg1_sig <= "00011";
		Reg2_sig <= "00100";
		WrEn_sig <= '0';
		wait for 20 ns;
		
		DestReg_sig <= "00101";
		WrEn_sig <= '1';
		WrData_sig <= x"55555555";
		wait for 20 ns; 

		DestReg_sig <= "00110"; 
		WrEn_sig <= '1'; 
		WrData_sig <= x"66666666"; 
		wait for 20 ns; 

		Reg1_sig <= "00101"; 
		Reg2_sig <= "00110"; 
		WrEn_sig <= '0'; 
		wait for 20 ns; 

		DestReg_sig <= "00110";
		WrEn_sig <= '1';
		WrData_sig <= x"66666666";
		wait for 20 ns; 

		DestReg_sig <= "00111"; 
		WrEn_sig <= '1'; 
		WrData_sig <= x"77777777"; 
		wait for 20 ns; 

		Reg1_sig <= "00110"; 
		Reg2_sig <= "00111"; 
		WrEn_sig <= '0'; 
		wait for 20 ns; 

		DestReg_sig <= "00111";
		WrEn_sig <= '1';
		WrData_sig <= x"77777777";
		wait for 20 ns; 

		DestReg_sig <= "01000"; 
		WrEn_sig <= '1'; 
		WrData_sig <= x"88888888"; 
		wait for 20 ns; 

		Reg1_sig <= "00111"; 
		Reg2_sig <= "01000"; 
		WrEn_sig <= '0'; 
		wait for 20 ns; 

		DestReg_sig <= "01000";
		WrEn_sig <= '1';
		WrData_sig <= x"88888888";
		wait for 20 ns; 

		DestReg_sig <= "01001"; 
		WrEn_sig <= '1'; 
		WrData_sig <= x"99999999"; 
		wait for 20 ns; 

		Reg1_sig <= "01000"; 
		Reg2_sig <= "01001"; 
		WrEn_sig <= '0'; 
		wait for 20 ns; 

		DestReg_sig <= "01001";
		WrEn_sig <= '1';
		WrData_sig <= x"99999999";
		wait for 20 ns; 

		DestReg_sig <= "01010"; 
		WrEn_sig <= '1'; 
		WrData_sig <= x"aaaaaaaa"; 
		wait for 20 ns; 

		Reg1_sig <= "01001"; 
		Reg2_sig <= "01010"; 
		WrEn_sig <= '0'; 
		wait for 20 ns; 

		DestReg_sig <= "01010";
		WrEn_sig <= '1';
		WrData_sig <= x"aaaaaaaa";
		wait for 20 ns; 

		DestReg_sig <= "01011"; 
		WrEn_sig <= '1'; 
		WrData_sig <= x"bbbbbbbb"; 
		wait for 20 ns; 

		Reg1_sig <= "01011"; 
		Reg2_sig <= "01010"; 
		WrEn_sig <= '0'; 
		wait for 20 ns; 

		DestReg_sig <= "01011";
		WrEn_sig <= '1';
		WrData_sig <= x"bbbbbbbb";
		wait for 20 ns; 

		DestReg_sig <= "01100"; 
		WrEn_sig <= '1'; 
		WrData_sig <= x"cccccccc"; 
		wait for 20 ns; 

		Reg1_sig <= "01011"; 
		Reg2_sig <= "01100"; 
		WrEn_sig <= '0'; 
		wait for 20 ns; 

		DestReg_sig <= "01100";
		WrEn_sig <= '1';
		WrData_sig <= x"cccccccc";
		wait for 20 ns; 

		DestReg_sig <= "01101"; 
		WrEn_sig <= '1'; 
		WrData_sig <= x"dddddddd"; 
		wait for 20 ns; 

		Reg1_sig <= "01100"; 
		Reg2_sig <= "01101"; 
		WrEn_sig <= '0'; 
		wait for 20 ns; 

		DestReg_sig <= "01101";
		WrEn_sig <= '1';
		WrData_sig <= x"0000000d";
		wait for 20 ns; 

		DestReg_sig <= "01110"; 
		WrEn_sig <= '1'; 
		WrData_sig <= x"0000000e"; 
		wait for 20 ns; 

		Reg1_sig <= "01101"; 
		Reg2_sig <= "01110"; 
		WrEn_sig <= '0'; 
		wait for 20 ns; 

		DestReg_sig <= "01110";
		WrEn_sig <= '1';
		WrData_sig <= x"0000000e";
		wait for 20 ns; 

		DestReg_sig <= "01111"; 
		WrEn_sig <= '1'; 
		WrData_sig <= x"0000000f"; 
		wait for 20 ns; 

		Reg1_sig <= "01110"; 
		Reg2_sig <= "01111"; 
		WrEn_sig <= '0'; 
		wait for 20 ns; 

		DestReg_sig <= "01111";
		WrEn_sig <= '1';
		WrData_sig <= x"0000000f";
		wait for 20 ns; 

		DestReg_sig <= "10000"; 
		WrEn_sig <= '1'; 
		WrData_sig <= x"00000010"; 
		wait for 20 ns; 

		Reg1_sig <= "01111"; 
		Reg2_sig <= "10000"; 
		WrEn_sig <= '0'; 
		wait for 20 ns; 

		DestReg_sig <= "10000";
		WrEn_sig <= '1';
		WrData_sig <= x"00000010";
		wait for 20 ns; 

		DestReg_sig <= "10001"; 
		WrEn_sig <= '1'; 
		WrData_sig <= x"00000011"; 
		wait for 20 ns; 

		Reg1_sig <= "10000"; 
		Reg2_sig <= "10001"; 
		WrEn_sig <= '0'; 
		wait for 20 ns; 

		DestReg_sig <= "10001";
		WrEn_sig <= '1';
		WrData_sig <= x"00000011";
		wait for 20 ns; 

		DestReg_sig <= "10010"; 
		WrEn_sig <= '1'; 
		WrData_sig <= x"00000012"; 
		wait for 20 ns; 

		Reg1_sig <= "10001"; 
		Reg2_sig <= "10010"; 
		WrEn_sig <= '0'; 
		wait for 20 ns; 

		DestReg_sig <= "10010";
		WrEn_sig <= '1';
		WrData_sig <= x"00000012";
		wait for 20 ns; 

		DestReg_sig <= "10011"; 
		WrEn_sig <= '1'; 
		WrData_sig <= x"00000013"; 
		wait for 20 ns; 

		Reg1_sig <= "10010"; 
		Reg2_sig <= "10011"; 
		WrEn_sig <= '0'; 
		wait for 20 ns; 

		DestReg_sig <= "10011";
		WrEn_sig <= '1';
		WrData_sig <= x"00000013";
		wait for 20 ns; 

		DestReg_sig <= "10100"; 
		WrEn_sig <= '1'; 
		WrData_sig <= x"00000014"; 
		wait for 20 ns; 

		Reg1_sig <= "10011"; 
		Reg2_sig <= "10100"; 
		WrEn_sig <= '0'; 
		wait for 20 ns; 

		DestReg_sig <= "10100";
		WrEn_sig <= '1';
		WrData_sig <= x"00000014";
		wait for 20 ns; 

		DestReg_sig <= "10101"; 
		WrEn_sig <= '1'; 
		WrData_sig <= x"00000015"; 
		wait for 20 ns; 

		Reg1_sig <= "10100"; 
		Reg2_sig <= "10101"; 
		WrEn_sig <= '0'; 
		wait for 20 ns; 

		DestReg_sig <= "10101";
		WrEn_sig <= '1';
		WrData_sig <= x"00000015";
		wait for 20 ns; 

		DestReg_sig <= "10110"; 
		WrEn_sig <= '1'; 
		WrData_sig <= x"00000016"; 
		wait for 20 ns; 

		Reg1_sig <= "10101"; 
		Reg2_sig <= "10110"; 
		WrEn_sig <= '0'; 
		wait for 20 ns; 

		DestReg_sig <= "10110";
		WrEn_sig <= '1';
		WrData_sig <= x"00000016";
		wait for 20 ns; 

		DestReg_sig <= "10111"; 
		WrEn_sig <= '1'; 
		WrData_sig <= x"00000017"; 
		wait for 20 ns; 

		Reg1_sig <= "10110"; 
		Reg2_sig <= "10111"; 
		WrEn_sig <= '0'; 
		wait for 20 ns; 

		DestReg_sig <= "10111";
		WrEn_sig <= '1';
		WrData_sig <= x"00000017";
		wait for 20 ns; 

		DestReg_sig <= "11000"; 
		WrEn_sig <= '1'; 
		WrData_sig <= x"00000018"; 
		wait for 20 ns; 

		Reg1_sig <= "10111"; 
		Reg2_sig <= "11000"; 
		WrEn_sig <= '0'; 
		wait for 20 ns; 

		DestReg_sig <= "11000";
		WrEn_sig <= '1';
		WrData_sig <= x"00000018";
		wait for 20 ns; 

		DestReg_sig <= "11001"; 
		WrEn_sig <= '1'; 
		WrData_sig <= x"00000019"; 
		wait for 20 ns; 

		Reg1_sig <= "11000"; 
		Reg2_sig <= "11001"; 
		WrEn_sig <= '0'; 
		wait for 20 ns; 

		DestReg_sig <= "11001";
		WrEn_sig <= '1';
		WrData_sig <= x"00000019";
		wait for 20 ns; 

		DestReg_sig <= "11010"; 
		WrEn_sig <= '1'; 
		WrData_sig <= x"0000001a"; 
		wait for 20 ns; 

		Reg1_sig <= "11001"; 
		Reg2_sig <= "11010"; 
		WrEn_sig <= '0'; 
		wait for 20 ns; 

		DestReg_sig <= "11010";
		WrEn_sig <= '1';
		WrData_sig <= x"0000001a";
		wait for 20 ns; 

		DestReg_sig <= "11011"; 
		WrEn_sig <= '1'; 
		WrData_sig <= x"0000001b"; 
		wait for 20 ns; 

		Reg1_sig <= "11010"; 
		Reg2_sig <= "11011"; 
		WrEn_sig <= '0'; 
		wait for 20 ns; 

		DestReg_sig <= "11011";
		WrEn_sig <= '1';
		WrData_sig <= x"0000001b";
		wait for 20 ns; 

		DestReg_sig <= "11100"; 
		WrEn_sig <= '1'; 
		WrData_sig <= x"0000001c"; 
		wait for 20 ns; 

		Reg1_sig <= "11011"; 
		Reg2_sig <= "11100"; 
		WrEn_sig <= '0'; 
		wait for 20 ns; 

		DestReg_sig <= "11100";
		WrEn_sig <= '1';
		WrData_sig <= x"0000001c";
		wait for 20 ns; 

		DestReg_sig <= "11101"; 
		WrEn_sig <= '1'; 
		WrData_sig <= x"0000001d"; 
		wait for 20 ns; 

		Reg1_sig <= "11100"; 
		Reg2_sig <= "11101"; 
		WrEn_sig <= '0'; 
		wait for 20 ns; 

		DestReg_sig <= "11101";
		WrEn_sig <= '1';
		WrData_sig <= x"0000001d";
		wait for 20 ns; 

		DestReg_sig <= "11110"; 
		WrEn_sig <= '1'; 
		WrData_sig <= x"0000001e"; 
		wait for 20 ns; 

		Reg1_sig <= "11101"; 
		Reg2_sig <= "11110"; 
		WrEn_sig <= '0'; 
		wait for 20 ns; 

		DestReg_sig <= "11110";
		WrEn_sig <= '1';
		WrData_sig <= x"0000001e";
		wait for 20 ns; 

		DestReg_sig <= "11111"; 
		WrEn_sig <= '1'; 
		WrData_sig <= x"0000001f"; 
		wait for 20 ns; 

		Reg1_sig <= "11110"; 
		Reg2_sig <= "11111"; 
		WrEn_sig <= '0'; 
		wait for 20 ns; 
		-- end of testing each register
		
		
		Reg1_sig <= "00010";
		Reg2_sig <= "00100";
		wait for 20 ns;
		
		
		
		-- testing reset signal
		Reset_sig <= '1';
		wait for 20 ns;
		Reset_sig <= '0';
		
		-- testing write enable
		DestReg_sig <= "11110";
		WrEn_sig <= '0';
		WrData_sig <= x"0000001e";
		wait for 20 ns; 

		DestReg_sig <= "11111"; 
		WrEn_sig <= '0'; 
		WrData_sig <= x"0000001f"; 
		wait for 20 ns; 

		Reg1_sig <= "11110"; 
		Reg2_sig <= "11111"; 
		WrEn_sig <= '0'; 
		wait for 20 ns; 
		
		-- end of write enable test
		
		
		
	end process;
end;
