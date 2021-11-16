library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MBE_24BIT is
    port(
        A : in  std_logic_vector(23 downto 0);
        B : in  std_logic_vector(23 downto 0);
        P : out std_logic_vector(47 downto 0));
end MBE_24BIT;

----------------------------------------------------------------------------------
--Architecture
-----------------------------------------------------------------------------------

architecture STRUCTURAL of MBE_24BIT is

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
    
    component PRECONDITIONING_24BIT
        port(
            P0 : in  std_logic_vector(24 downto 0);
            S0 : in  std_logic;
            P1 : in  std_logic_vector(24 downto 0);
            S1 : in  std_logic;
            P2 : in  std_logic_vector(24 downto 0);
            S2 : in  std_logic;
            P3 : in  std_logic_vector(24 downto 0);
            S3 : in  std_logic;
            P4 : in  std_logic_vector(24 downto 0);
            S4 : in  std_logic;
            P5 : in  std_logic_vector(24 downto 0);
            S5 : in  std_logic;
            P6 : in  std_logic_vector(24 downto 0);
            S6 : in  std_logic;
            P7 : in  std_logic_vector(24 downto 0);
            S7 : in  std_logic;
            P8 : in  std_logic_vector(24 downto 0);
            S8 : in  std_logic;
            P9 : in  std_logic_vector(24 downto 0);
            S9 : in  std_logic;
            P10 : in  std_logic_vector(24 downto 0);
            S10 : in  std_logic;
            P11 : in  std_logic_vector(24 downto 0);
            S11 : in  std_logic;
            P12 : in  std_logic_vector(23 downto 0);
            R0 : out  std_logic_vector(47 downto 0);
            R1 : out  std_logic_vector(47 downto 0);
            R2 : out  std_logic_vector(46 downto 0);
            R3 : out  std_logic_vector(44 downto 0);
            R4 : out  std_logic_vector(42 downto 0);
            R5 : out  std_logic_vector(40 downto 0);
            R6 : out  std_logic_vector(38 downto 0);
            R7 : out  std_logic_vector(36 downto 0);
            R8 : out  std_logic_vector(34 downto 0);
            R9 : out  std_logic_vector(32 downto 0);
            R10 : out  std_logic_vector(30 downto 0);
            R11 : out  std_logic_vector(28 downto 0);
            R12 : out  std_logic_vector(27 downto 0)
        );
    end component PRECONDITIONING_24BIT;

    component dadda_tree
        port(
            d0_0         : in  std_logic_vector(47 downto 0);
            d0_1         : in  std_logic_vector(47 downto 0);
            d0_2         : in  std_logic_vector(46 downto 0);
            d0_3         : in  std_logic_vector(44 downto 0);
            d0_4         : in  std_logic_vector(42 downto 0);
            d0_5         : in  std_logic_vector(40 downto 0);
            d0_6         : in  std_logic_vector(38 downto 0);
            d0_7         : in  std_logic_vector(36 downto 0);
            d0_8         : in  std_logic_vector(34 downto 0);
            d0_9         : in  std_logic_vector(32 downto 0);
            d0_10        : in  std_logic_vector(30 downto 0);
            d0_11        : in  std_logic_vector(28 downto 0);
            d0_12        : in  std_logic_vector(27 downto 0);
            sum_output   : out std_logic_vector(47 downto 0);
            carry_output : out std_logic_vector(47 downto 0)
        );
    end component dadda_tree;

    --------signals--------------------------------------
    signal B_dummy: std_logic_vector(26 downto 0);
    signal SEL_BRU_MUX: std_logic_vector(25 downto 0);
    signal PP_MUX_1C: std_logic_vector(323 downto 0);
    signal PP_1C_PRECOND : std_logic_vector(323 downto 0);
    signal R0 : std_logic_vector(47 downto 0);
    signal R1 : std_logic_vector(47 downto 0);
    signal R2 : std_logic_vector(46 downto 0);
    signal R3 : std_logic_vector(44 downto 0);
    signal R4 : std_logic_vector(42 downto 0);
    signal R5 : std_logic_vector(40 downto 0);
    signal R6 : std_logic_vector(38 downto 0);
    signal R7 : std_logic_vector(36 downto 0);
    signal R8 : std_logic_vector(34 downto 0);
    signal R9 : std_logic_vector(32 downto 0);
    signal R10 : std_logic_vector(30 downto 0);
    signal R11 : std_logic_vector(28 downto 0);
    signal R12 : std_logic_vector(27 downto 0);
    signal SUM_DADDA_ADDER, CARRY_DADDA_ADDER : std_logic_vector(47 downto 0);


begin

    B_dummy <= "00" & B & '0';

    --N/2+1 BRU are needed, considering the zero padding of the multiplicand that is needed
    --when implementing a radix-4 algorithm  
    i_BRU_units_generate : for I in 0 to 12 generate
        i_BRU_I : BRU
            port map(
                BRU_input  => B_dummy(2 * I + 2 downto 2 * I),
                BRU_output => SEL_BRU_MUX(2 * I + 1 downto 2 * I));
    end generate i_BRU_units_generate;

    --we need N/2 MUX, for the first N/2 partial products, whose selector are taken from the output of the different
    --BRU units
    i_MUX_units_generate : for I in 0 to 11 generate
        i_MUX_I : bN_3to1mux
            generic map(
                N => 25
            )
            port map(
                X                 => (OTHERS => '0'),
                Y(24 downto 1)     => A,
                Y(0)              => '0',
                Z(24)              => '0',
                Z(23 downto 0) => A,
                S                 => SEL_BRU_MUX(2 * I + 1 downto 2 * I),
                OUTPUT            => PP_MUX_1C(25 * I + 24 downto 25 * I));
    end generate i_MUX_units_generate;

    --the last MUX can be simplified, considering a MUX with just two input, 0 and A
    i_last_MUX : bN_2to1mux
        generic map(
            N => 24
        )
        port map(
            x      => (OTHERS => '0'),
            y      => A,
            s      => SEL_BRU_MUX(24), --the MSB-1 of the last BRU unit, the MSB is not needed, since
                                          --the inputs are limited to A and 0
            output => PP_MUX_1C(323 downto 300));

    i_XOR_units_generate : for I in 0 to 11 generate
        i_XOR_plane_I : xor_plane_n_bit
            generic map(
                N => 25
            )
            port map(
                XOR_PLANE_N_BIT_IN_PP   => PP_MUX_1C(25 * I + 24 downto 25 * I),
                XOR_PLANE_N_BIT_IN_MULT => B_dummy(2 * I + 2),
                XOR_PLANE_N_BIT_OUT     => PP_1C_PRECOND(25 * I + 24 downto 25 * I)
            );
    end generate i_XOR_units_generate;
    
    PP_1C_PRECOND(323 downto 300) <= PP_MUX_1C(323 downto 300);

    i_PRECONDITIONING: PRECONDITIONING_24BIT
        port map(
            P0 => PP_1C_PRECOND(24 downto 0),
            S0 => B_dummy(2),
            P1 => PP_1C_PRECOND(49 downto 25),
            S1 => B_dummy(4),
            P2 => PP_1C_PRECOND(74 downto 50),
            S2 => B_dummy(6),
            P3 => PP_1C_PRECOND(99 downto 75),
            S3 => B_dummy(8),
            P4 => PP_1C_PRECOND(124 downto 100),
            S4 => B_dummy(10),
            P5 => PP_1C_PRECOND(149 downto 125),
            S5 => B_dummy(12),
            P6 => PP_1C_PRECOND(174 downto 150),
            S6 => B_dummy(14),
            P7 => PP_1C_PRECOND(199 downto 175),
            S7 => B_dummy(16),
            P8 => PP_1C_PRECOND(224 downto 200),
            S8 => B_dummy(18),
            P9 => PP_1C_PRECOND(249 downto 225),
            S9 => B_dummy(20),
            P10 => PP_1C_PRECOND(274 downto 250),
            S10 => B_dummy(22),
            P11 => PP_1C_PRECOND(299 downto 275),
            S11 => B_dummy(24),
            P12 => PP_1C_PRECOND(323 downto 300),
            R0 => R0,
            R1 => R1,
            R2 => R2,
            R3 => R3,
            R4 => R4,
            R5 => R5,
            R6 => R6,
            R7 => R7,
            R8 => R8,
            R9 => R9,
            R10 => R10,
            R11 => R11,
            R12 => R12
        );

    i_DADDATREE: dadda_tree
        port map(
            d0_0         => R0,
            d0_1         => R1,
            d0_2         => R2,
            d0_3         => R3,
            d0_4         => R4,
            d0_5         => R5,
            d0_6         => R6,
            d0_7         => R7,
            d0_8         => R8,
            d0_9         => R9,
            d0_10        => R10,
            d0_11        => R11,
            d0_12        => R12,
            sum_output   => SUM_DADDA_ADDER,
            carry_output => CARRY_DADDA_ADDER
        );
        
     P <= std_logic_vector(unsigned(SUM_DADDA_ADDER) + unsigned(CARRY_DADDA_ADDER));
     
     
end STRUCTURAL;