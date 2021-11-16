-------------------------------------------------------------------------------------
-- Top level entity of the Modiefied Booth Encoding Multiplier
-------------------------------------------------------------------------------------


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



----------------------------------------------------------------------------------
--Architecture
-----------------------------------------------------------------------------------
architecture STRUCTURAL of MBE_Nbit is

    -------------------------------------------------------------------------------
    ---COMPONENTS------------------------------------------------------------------
    -------------------------------------------------------------------------------
    component bN_3to1mux
        generic(N : integer := 9);
        port(
            X, Y, Z : in  std_logic_vector(N - 1 downto 0);
            S       : in  std_logic_vector(1 downto 0);
            OUTPUT  : out std_logic_vector(N - 1 downto 0)
        );
    end component bN_3to1mux;

    component bN_2to1mux
        generic(N : positive := 8);
        port(
            x, y   : in  std_logic_vector(N - 1 downto 0);
            s      : in  std_logic;
            output : out std_logic_vector(N - 1 downto 0)
        );
    end component bN_2to1mux;

    component BRU
        port(
            BRU_input  : in  std_logic_vector(2 downto 0);
            BRU_output : out std_logic_vector(1 downto 0)
        );
    end component BRU;

    component xor_plane_n_bit
        generic(N : positive := 8);
        port(
            XOR_PLANE_N_BIT_IN_PP   : in  std_logic_vector(N - 1 downto 0);
            XOR_PLANE_N_BIT_IN_MULT : IN  std_logic;
            XOR_PLANE_N_BIT_OUT     : out std_logic_vector(N - 1 downto 0)
        );
    end component xor_plane_n_bit;

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
    
    ------END COMPONENTS DECLARATION------------------------------------------------------------


    ---------------------------------------------------------------------------------------------
    --------SIGNALS------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------------
    signal B_dummy        : std_logic_vector(N + 2 downto 0);
    signal SEL_BRU_MUX    : std_logic_vector(N - 2 downto 0);
    signal PP_MUX_1C      : std_logic_vector(1 / 2 * (N ** 2) + (3 / 2 * N) downto 0);
    --PP_MUX_1C should be 1/2*(N**2)+(3/2*N)+1 long, but since the last partial product
    --can be represented on N bit instead of N+1, this vector (which is containing all the PPs)
    --can be 1 bit shorter
    signal PP_1C_PRE_COND : std_logic_vector(1 / 2 * (N ** 2) + (3 / 2 * N) downto 0);

begin

    B_dummy <= "00" & B & '0';

    --N/2+1 BRU are needed, considering the zero padding of the multiplicand that is needed
    --when implementing a radix-4 algorithm  
    i_BRU_units_generate : for I in 0 to N / 2 generate
        i_BRU_I : BRU
            port map(
                BRU_input  => B_dummy(2 * I + 2 downto 2 * I),
                BRU_output => SEL_BRU_MUX(2 * I + 1 downto 2 * I));
    end generate i_BRU_units_generate;

    --we need N/2 MUX, for the first N/2 partial products, whose selector are taken from the output of the different
    --BRU units
    i_MUX_units_generate : for I in 0 to N / 2 generate
        i_MUX_I : bN_3to1mux
            generic map(
                N => N + 1
            )
            port map(
                X                 => (OTHERS => '0'),
                Y(N downto 1)     => A,
                Y(0)              => '0',
                Z(N)              => '0',
                Z(N - 1 downto 0) => A,
                S                 => SEL_BRU_MUX(2 * I + 1 downto 2 * I),
                OUTPUT            => PP_MUX_1C(9 * I + 8 downto 9 * I));
    end generate i_MUX_units_generate;

    --the last MUX can be simplified, considering a MUZ with just two input, 0 and A
    i_last_MUX : bN_2to1mux
        generic map(
            N => N
        )
        port map(
            x      => (OTHERS => '0'),
            y      => A,
            s      => SEL_BRU_MUX(2 * (N / 2 + 1)), --the MSB-1 of the last BRU unit, the MSB is not needed, since
                                                    --the inputs are limited to A and 0
            output => PP_MUX_1C(9 * (N / 2 + 1) - 1 downto 9 * (N / 2 + 1)));

    i_XOR_units_generate : for I in 0 to N / 2 + 1 generate
        i_XOR_plane : xor_plane_n_bit
            generic map(
                N => N
            )
            port map(
                XOR_PLANE_N_BIT_IN_PP   => PP_MUX_1C,
                XOR_PLANE_N_BIT_IN_MULT => B(2 * I + 1),
                XOR_PLANE_N_BIT_OUT     => PP_1C_PRE_COND
            );
    end generate i_XOR_units_generate;
    
    
    

end STRUCTURAL;
