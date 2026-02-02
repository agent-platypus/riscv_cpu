library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registerfile is

port( clk:        		in std_logic;
		Reg1, Reg2: 		in std_logic_vector(4 downto 0);
		DestReg:    		in std_logic_vector(4 downto 0);
		WrEn:       		in std_logic;
		WrData:     		in std_logic_vector(31 downto 0);
		Reset:      		in std_logic;
		Reg1Out, Reg2Out: out std_logic_vector(31 downto 0)
	 );
		
end registerfile;

architecture Behavior of registerfile is

component Reg 
port( data_in:  in std_logic_vector(31 downto 0);
		data_out: out std_logic_vector(31 downto 0);
		en:       in std_logic;
		clk:      in std_logic;
		reset:    in std_logic);
end component;
	

type Reg_Array is array (0 to 31) of std_logic_vector(31 downto 0);

signal Reg_Data_In: Reg_Array;
signal Reg_Data_Out: Reg_Array;
signal Reg_WrEn: std_logic_vector(31 downto 0);


begin	
	decode_enable:process(DestReg, WrEn)
		begin
			Reg_WrEn <= (others => '0');
			if WrEn = '1' then
				Reg_WrEn(to_integer(unsigned(DestReg))) <= '1';
			end if;
		end process;
		
--	Reg_Data_In <= (others => (others => '0'));
--	--DEMUX to select which register to write
--	Reg_Data_In(to_integer(unsigned(DestReg))) <= WrData;
	
	demux_write_to_registers: process(WrData, DestReg)
		begin
			Reg_Data_In <= (others => (others => '0'));
			Reg_Data_In(to_integer(unsigned(DestReg))) <= WrData;
		end process;
	generate_registers: for i in 0 to 31 generate
		register_array: Reg
		port map( data_in  => Reg_Data_In(i),
				    data_out => Reg_Data_Out(i),
				    en       => Reg_WrEn(i),
				    clk      => clk,
				    reset    => Reset);
		end generate generate_registers;
	
	--Reg_Data_In(to_integer(unsigned(DestReg))) <= WrData;
	
	--MUX to select which register to read from
	Reg1Out <= Reg_Data_Out(to_integer(unsigned(Reg1)));
	Reg2Out <= Reg_Data_Out(to_integer(unsigned(Reg2)));
		
end Behavior;
