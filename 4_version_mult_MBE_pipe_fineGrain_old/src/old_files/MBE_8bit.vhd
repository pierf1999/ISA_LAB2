library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MBE_8BIT is
    port(
        A : in  std_logic_vector(7 downto 0);
        B : in  std_logic_vector(7 downto 0);
        P : out std_logic_vector(15 downto 0));
end MBE_8BIT;

----------------------------------------------------------------------------------
--Architecture
-----------------------------------------------------------------------------------

architecture STRUCTURAL of MBE_8BIT is

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
            XOR_PLANE_N_BIT_IN_MULT : in  std_logic;
            XOR_PLANE_N_BIT_OUT     : out std_logic_vector(N - 1 downto 0)
        );
    end component xor_plane_n_bit;
    
    component PRECONDITIONING_8BIT
        port(
            P0 : in  std_logic_vector(8 downto 0);
            S0 : in  std_logic;
            P1 : in  std_logic_vector(8 downto 0);
            S1 : in  std_logic;
            P2 : in  std_logic_vector(8 downto 0);
            S2 : in  std_logic;
            P3 : in  std_logic_vector(8 downto 0);
            S3 : in  std_logic;
            P4 : in  std_logic_vector(7 downto 0);
            R0 : out  std_logic_vector(15 downto 0);
            R1 : out  std_logic_vector(15 downto 0);
            R2 : out  std_logic_vector(14 downto 0);
            R3 : out  std_logic_vector(12 downto 0);
            R4 : out  std_logic_vector(11 downto 0)
        );
    end component PRECONDITIONING_8BIT;


    --------signals--------------------------------------
    signal B_dummy: std_logic_vector(10 downto 0);
    signal SEL_BRU_MUX: std_logic_vector(9 downto 0);
    signal PP_MUX_1C: std_logic_vector(43 downto 0);
    signal PP_1C_PRECOND : std_logic_vector(43 downto 0);
    signal R0 : std_logic_vector(15 downto 0);
    signal R1 : std_logic_vector(15 downto 0);
    signal R2 : std_logic_vector(14 downto 0);
    signal R3 : std_logic_vector(12 downto 0);
    signal R4 : std_logic_vector(11 downto 0);


begin

    B_dummy <= "00" & B & '0';

    --N/2+1 BRU are needed, considering the zero padding of the multiplicand that is needed
    --when implementing a radix-4 algorithm  
    i_BRU_units_generate : for I in 0 to 4 generate
        i_BRU_I : BRU
            port map(
                BRU_input  => B_dummy(2 * I + 2 downto 2 * I),
                BRU_output => SEL_BRU_MUX(2 * I + 1 downto 2 * I));
    end generate i_BRU_units_generate;

    --we need N/2 MUX, for the first N/2 partial products, whose selector are taken from the output of the different
    --BRU units
    i_MUX_units_generate : for I in 0 to 3 generate
        i_MUX_I : bN_3to1mux
            generic map(
                N => 9
            )
            port map(
                X                 => (OTHERS => '0'),
                Y(8 downto 1)     => A,
                Y(0)              => '0',
                Z(8)              => '0',
                Z(7 downto 0) => A,
                S                 => SEL_BRU_MUX(2 * I + 1 downto 2 * I),
                OUTPUT            => PP_MUX_1C(9 * I + 8 downto 9 * I));
    end generate i_MUX_units_generate;

    --the last MUX can be simplified, considering a MUX with just two input, 0 and A
    i_last_MUX : bN_2to1mux
        generic map(
            N => 8
        )
        port map(
            x      => (OTHERS => '0'),
            y      => A,
            s      => SEL_BRU_MUX(8), --the MSB-1 of the last BRU unit, the MSB is not needed, since
                                          --the inputs are limited to A and 0
            output => PP_MUX_1C(43 downto 36));

    i_XOR_units_generate : for I in 0 to 3 generate
        i_XOR_plane_I : xor_plane_n_bit
            generic map(
                N => 9
            )
            port map(
                XOR_PLANE_N_BIT_IN_PP   => PP_MUX_1C(9 * I + 8 downto 9 * I),
                XOR_PLANE_N_BIT_IN_MULT => B_dummy(2 * I + 2),
                XOR_PLANE_N_BIT_OUT     => PP_1C_PRECOND(9 * I + 8 downto 9 * I)
            );
    end generate i_XOR_units_generate;
    
    PP_1C_PRECOND(43 downto 36) <= PP_MUX_1C(43 downto 36);

    i_PRECONDITIONING: PRECONDITIONING_8BIT
        port map(
            P0 => PP_1C_PRECOND(8 downto 0),
            S0 => B_dummy(2),
            P1 => PP_1C_PRECOND(17 downto 9),
            S1 => B_dummy(4),
            P2 => PP_1C_PRECOND(26 downto 18),
            S2 => B_dummy(6),
            P3 => PP_1C_PRECOND(35 downto 27),
            S3 => B_dummy(8),
            P4 => PP_1C_PRECOND(43 downto 36),
            R0 => R0,
            R1 => R1,
            R2 => R2,
            R3 => R3,
            R4 => R4
        );

end STRUCTURAL;