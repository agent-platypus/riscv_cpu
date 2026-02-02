library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sram_controller_test is
port(
    SW      : in std_logic_vector(17 downto 0);
    -- sw17 used for read/write toggling
    -- sw15 -> sw8 used for addressing (8 bit width)
    -- sw7  -> sw0 used for data (8 bit width)

    KEY     : in std_logic_vector(3 downto 0);  
    -- KEY0 to increment the upper byte of the address
    -- KEY1 to decrement the upper byte of the address
    -- KEY2 to increment the upper byte of the data (WRITE mode)
    -- KEY3 to start a read or write operation

    CLOCK_50 : in std_logic;

    -- Hex displays for current address
    HEX0 : out std_logic_vector(6 downto 0);
    HEX1 : out std_logic_vector(6 downto 0);
    HEX2 : out std_logic_vector(6 downto 0);
    HEX3 : out std_logic_vector(6 downto 0);
    HEX4 : out std_logic_vector(6 downto 0);

    -- Display data written/read depending on wr toggle
    LEDR : out std_logic_vector(15 downto 0);

    -- Directly to SRAM chip
    SRAM_DQ   : inout std_logic_vector(15 downto 0);
    SRAM_ADDR : out   std_logic_vector(19 downto 0);
    SRAM_OE_N : out   std_logic;
    SRAM_WE_N : out   std_logic;
    SRAM_CE_N : out   std_logic;
    SRAM_LB_N : out   std_logic;
    SRAM_UB_N : out   std_logic
);
end entity;

architecture behavior of sram_controller_test is

component hex_interface
    port(
        data_in : in  std_logic_vector(3 downto 0);
        seg_out : out std_logic_vector(6 downto 0)
    );
end component;

    signal wr_toggle, incr_ub_addr, decr_ub_addr, incr_ub_data, decr_ub_data, start_op : std_logic; 

    signal sw_address : std_logic_vector(7 downto 0);
    signal sw_data    : std_logic_vector(7 downto 0);

    signal address    : std_logic_vector(19 downto 0);
    signal ub_address : std_logic_vector(11 downto 0) := (others => '0');

    signal ub_data    : std_logic_vector(7 downto 0)  := (others => '0');
    signal data_in    : std_logic_vector(15 downto 0);
    signal data_out   : std_logic_vector(15 downto 0);

    signal counter    : integer := 0;

    -- Button edge detection signals
    signal key_prev   : std_logic_vector(3 downto 0) := (others => '1');
    signal key_rising : std_logic_vector(3 downto 0);

    type state_type is (
        IDLE,
        SRAM_READ,
        SRAM_WRITE
    );

    signal state : state_type := IDLE;

begin
    wr_toggle     <= SW(17);
    incr_ub_addr  <= key_rising(0);  
    decr_ub_addr  <= key_rising(1);
    incr_ub_data  <= key_rising(2);
    start_op      <= key_rising(3);

    edge_detect: process(CLOCK_50)
    begin
        if rising_edge(CLOCK_50) then
            key_prev   <= KEY;
            key_rising <= key_prev AND (NOT KEY); -- detect falling edge (active-low press)
        end if;
    end process edge_detect;

    mapping_sw_to_address: for ii in 0 to 7 generate
        sw_address(ii) <= SW(ii + 8);
    end generate mapping_sw_to_address;

    mapping_sw_to_data: for ii in 0 to 7 generate
        sw_data(ii) <= SW(ii);
    end generate mapping_sw_to_data;

    -- FIX 6: Correct hex port maps - input is address slice, output is HEX segment
    zeroth_hex:  hex_interface port map(data_in => address(3  downto 0),  seg_out => HEX0);
    first_hex:   hex_interface port map(data_in => address(7  downto 4),  seg_out => HEX1);
    second_hex:  hex_interface port map(data_in => address(11 downto 8),  seg_out => HEX2);
    third_hex:   hex_interface port map(data_in => address(15 downto 12), seg_out => HEX3);
    fourth_hex:  hex_interface port map(data_in => address(19 downto 16), seg_out => HEX4);

    addressing_logic: process(CLOCK_50)
    begin
        if rising_edge(CLOCK_50) then
            if incr_ub_addr = '1' then
                if ub_address /= x"FFF" then
                    ub_address <= std_logic_vector(unsigned(ub_address) + 1);
                end if;
            elsif decr_ub_addr = '1' then 
                if ub_address /= x"000" then
                    ub_address <= std_logic_vector(unsigned(ub_address) - 1);
                end if;
            end if;
        end if;
    end process addressing_logic;

    -- Combinational: assemble full address from upper and lower parts
    address <= ub_address & sw_address;

    data_logic: process(CLOCK_50)
    begin
        if rising_edge(CLOCK_50) then
            if incr_ub_data = '1' then
                if ub_data /= x"FF" then
                    ub_data <= std_logic_vector(unsigned(ub_data) + 1);
                end if;
            elsif decr_ub_data = '1' then
                if ub_data /= x"00" then
                    ub_data <= std_logic_vector(unsigned(ub_data) - 1);
                end if;
            end if;
        end if;
    end process data_logic;

    -- Assemble full 16-bit data from upper and lower bytes
    data_in <= ub_data & sw_data;

    data_io: process(CLOCK_50)
    begin
        if rising_edge(CLOCK_50) then
            case state is
                when IDLE =>
                    if start_op = '1' then
                        if wr_toggle = '0' then          -- Read mode
                            SRAM_ADDR <= address;
                            SRAM_OE_N <= '0';
                            SRAM_WE_N <= '1';
                            SRAM_CE_N <= '0';
                            SRAM_LB_N <= '0';
                            SRAM_UB_N <= '0';
                            counter   <= 0;
                            state     <= SRAM_READ;
                        else                             -- Write mode
                            SRAM_ADDR <= address;
                            SRAM_DQ   <= data_in;
                            SRAM_OE_N <= '1';
                            SRAM_WE_N <= '0';
                            SRAM_CE_N <= '0';
                            SRAM_LB_N <= '0';
                            SRAM_UB_N <= '0';
                            counter   <= 0;
                            state     <= SRAM_WRITE;
                        end if;
                    end if;

                when SRAM_READ =>
                    if counter >= 1 then               -- Hold for timing 
                        data_out  <= SRAM_DQ;
                        LEDR      <= data_out;
                        SRAM_OE_N <= '1';              -- Release bus
                        state     <= IDLE;
                    else
                        counter <= counter + 1;
                    end if;

                when SRAM_WRITE =>
                    if counter >= 1 then               -- Hold WE low for timing
                        SRAM_WE_N <= '1';              -- Release write
                        SRAM_DQ   <= (others => 'Z');  -- Release bus
                        state     <= IDLE;
                    else
                        counter <= counter + 1;
                    end if;
            end case;
        end if;
    end process data_io;

end behavior;