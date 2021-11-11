---------------------------------------------------------------------------------------------
-- File: BN_MUX8TO1.vhd
---------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MBE_Nbit is
    generic(N : positive := 8);
    port(
        A : in  std_logic_vector(N - 1 downto 0);
        B : in  std_logic_vector(N - 1 downto 0);
        P : out std_logic_vector(2 * N - 1 downto 0));
end MBE_Nbit;

architecture STRUCTURAL of MBE_Nbit is

    component bN_3to1mux
        generic(N : integer := 9);
        port(
            X, Y, Z : in  std_logic_vector(N - 1 downto 0);
            S       : in  std_logic_vector(1 downto 0);
            OUTPUT  : out std_logic_vector(N - 1 downto 0)
        );
    end component bN_3to1mux;

    component BRU
        port(
            BRU_input  : in  std_logic_vector(2 downto 0);
            BRU_output : out std_logic_vector(1 downto 0)
        );
    end component BRU;
    
    component half_adder
        port(
            a    : in  std_logic;
            b    : in  std_logic;
            s    : out std_logic;
            cout : out std_logic
        );
    end component half_adder;
    
    component full_adder
        port(
            a    : in  std_logic;
            b    : in  std_logic;
            cin  : in  std_logic;
            s    : out std_logic;
            cout : out std_logic
        );
    end component full_adder;

    --------signals--------------------------------------
    signal ZERO : std_logic_vector(N downto 0) ;
    signal B_dummy: std_logic_vector(N+2 downto 0);
    signal SEL_BRU_MUX: std_logic_vector(N-2 downto 0);
    signal PP_MUX_1C: std_logic_vector(1/2*(N**2)+(3/2*N)+1 downto 0);

begin

    B_dummy<= "00" & B & '0';
    ZERO <= (OTHERS=>'0');
    
    i_BRU_units_generate : for I in 0 to N/2 generate
        i_BRU_I: BRU
        port map(
            BRU_input  => B_dummy(2*I+2 downto 2*I),
            BRU_output => SEL_BRU_MUX(2*I+1 downto 2*I));
   end generate i_BRU_units_generate;
   
   i_MUX_units_generate: for I in 0 to N/2 generate
    i_MUX_I: bN_3to1mux
        generic map(
            N => N+1
        )
        port map(
            X      => ZERO,
            Y      => Y,
            Z (N-1) => '0',
            Z (N-2 downto 0)      => A ,
            S      => SEL_BRU_MUX(2*I+1 downto 2*I),
            OUTPUT => PP_MUX_1C(9*I downto I));
   end generate i_MUX_units_generate;
   


        
end STRUCTURAL;
