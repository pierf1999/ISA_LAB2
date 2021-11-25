LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY FPmul IS
    PORT(
        FP_A : IN  std_logic_vector(31 DOWNTO 0);
        FP_B : IN  std_logic_vector(31 DOWNTO 0);
        clk  : IN  std_logic;
        FP_Z : OUT std_logic_vector(31 DOWNTO 0)
    );

END FPmul;

ARCHITECTURE pipeline OF FPmul IS

    -- Architecture declarations

    -- Internal signal declarations
    SIGNAL A_EXP                            : std_logic_vector(7 DOWNTO 0);
    SIGNAL A_SIG                            : std_logic_vector(31 DOWNTO 0);
    SIGNAL B_EXP                            : std_logic_vector(7 DOWNTO 0);
    SIGNAL B_SIG                            : std_logic_vector(31 DOWNTO 0);
    SIGNAL EXP_in                           : std_logic_vector(7 DOWNTO 0);
    SIGNAL EXP_in_pipe                      : std_logic_vector(7 DOWNTO 0);
    SIGNAL EXP_neg                          : std_logic;
    SIGNAL EXP_neg_stage2                   : std_logic;
    SIGNAL EXP_neg_stage2_pipe              : std_logic;
    SIGNAL EXP_out_round                    : std_logic_vector(7 DOWNTO 0);
    SIGNAL EXP_pos                          : std_logic;
    SIGNAL EXP_pos_stage2                   : std_logic;
    SIGNAL EXP_pos_stage2_pipe              : std_logic;
    SIGNAL SIGN_out                         : std_logic;
    SIGNAL SIGN_out_stage1                  : std_logic;
    SIGNAL SIGN_out_stage2                  : std_logic;
    SIGNAL SIGN_out_stage2_pipe             : std_logic;
    SIGNAL SIG_in                           : std_logic_vector(27 DOWNTO 0);
    SIGNAL SIG_in_pipe                      : std_logic_vector(27 DOWNTO 0);
    SIGNAL SIG_out_round                    : std_logic_vector(27 DOWNTO 0);
    SIGNAL isINF_stage1                     : std_logic;
    SIGNAL isINF_stage2                     : std_logic;
    SIGNAL isINF_stage2_pipe                : std_logic;
    SIGNAL isINF_tab                        : std_logic;
    SIGNAL isNaN                            : std_logic;
    SIGNAL isNaN_stage1                     : std_logic;
    SIGNAL isNaN_stage2                     : std_logic;
    SIGNAL isNaN_stage2_pipe                : std_logic;
    SIGNAL isZ_tab                          : std_logic;
    SIGNAL isZ_tab_stage1                   : std_logic;
    SIGNAL isZ_tab_stage2                   : std_logic;
    SIGNAL isZ_tab_stage2_pipe              : std_logic;
    SIGNAL FP_A_reg_stage1, FP_B_reg_stage1 : std_logic_vector(31 DOWNTO 0);

    -- Component Declarations

    component reg_en_rst_n
        generic(N : positive := 32);
        port(
            D     : in  std_logic_vector(N - 1 downto 0);
            en    : in  std_logic;
            rst_n : in  std_logic;
            clk   : in  std_logic;
            Q     : out std_logic_vector(N - 1 downto 0)
        );
    end component reg_en_rst_n;

    COMPONENT FPmul_stage1
        PORT(
            FP_A            : IN  std_logic_vector(31 DOWNTO 0);
            FP_B            : IN  std_logic_vector(31 DOWNTO 0);
            clk             : IN  std_logic;
            A_EXP           : OUT std_logic_vector(7 DOWNTO 0);
            A_SIG           : OUT std_logic_vector(31 DOWNTO 0);
            B_EXP           : OUT std_logic_vector(7 DOWNTO 0);
            B_SIG           : OUT std_logic_vector(31 DOWNTO 0);
            SIGN_out_stage1 : OUT std_logic;
            isINF_stage1    : OUT std_logic;
            isNaN_stage1    : OUT std_logic;
            isZ_tab_stage1  : OUT std_logic
        );
    END COMPONENT;
    COMPONENT FPmul_stage2
        PORT(
            A_EXP           : IN  std_logic_vector(7 DOWNTO 0);
            A_SIG           : IN  std_logic_vector(31 DOWNTO 0);
            B_EXP           : IN  std_logic_vector(7 DOWNTO 0);
            B_SIG           : IN  std_logic_vector(31 DOWNTO 0);
            SIGN_out_stage1 : IN  std_logic;
            clk             : IN  std_logic;
            isINF_stage1    : IN  std_logic;
            isNaN_stage1    : IN  std_logic;
            isZ_tab_stage1  : IN  std_logic;
            EXP_in          : OUT std_logic_vector(7 DOWNTO 0);
            EXP_neg_stage2  : OUT std_logic;
            EXP_pos_stage2  : OUT std_logic;
            SIGN_out_stage2 : OUT std_logic;
            SIG_in          : OUT std_logic_vector(27 DOWNTO 0);
            isINF_stage2    : OUT std_logic;
            isNaN_stage2    : OUT std_logic;
            isZ_tab_stage2  : OUT std_logic
        );
    END COMPONENT;
    COMPONENT FPmul_stage3
        PORT(
            EXP_in          : IN  std_logic_vector(7 DOWNTO 0);
            EXP_neg_stage2  : IN  std_logic;
            EXP_pos_stage2  : IN  std_logic;
            SIGN_out_stage2 : IN  std_logic;
            SIG_in          : IN  std_logic_vector(27 DOWNTO 0);
            clk             : IN  std_logic;
            isINF_stage2    : IN  std_logic;
            isNaN_stage2    : IN  std_logic;
            isZ_tab_stage2  : IN  std_logic;
            EXP_neg         : OUT std_logic;
            EXP_out_round   : OUT std_logic_vector(7 DOWNTO 0);
            EXP_pos         : OUT std_logic;
            SIGN_out        : OUT std_logic;
            SIG_out_round   : OUT std_logic_vector(27 DOWNTO 0);
            isINF_tab       : OUT std_logic;
            isNaN           : OUT std_logic;
            isZ_tab         : OUT std_logic
        );
    END COMPONENT;
    COMPONENT FPmul_stage4
        PORT(
            EXP_neg       : IN  std_logic;
            EXP_out_round : IN  std_logic_vector(7 DOWNTO 0);
            EXP_pos       : IN  std_logic;
            SIGN_out      : IN  std_logic;
            SIG_out_round : IN  std_logic_vector(27 DOWNTO 0);
            clk           : IN  std_logic;
            isINF_tab     : IN  std_logic;
            isNaN         : IN  std_logic;
            isZ_tab       : IN  std_logic;
            FP_Z          : OUT std_logic_vector(31 DOWNTO 0)
        );
    END COMPONENT;
    
    component flipflop_rst_n
        port(
            D     : in  std_logic;
            clk   : in  std_logic;
            rst_n : in  std_logic;
            Q     : out std_logic
        );
    end component flipflop_rst_n;

    component REG_RST_N
        generic(N : positive := 32);
        port(
            D     : in  std_logic_vector(N - 1 downto 0);
            RST_N : in  std_logic;
            CLK   : in  std_logic;
            Q     : out std_logic_vector(N - 1 downto 0)
        );
    end component REG_RST_N;

    -- Optional embedded configurations
    -- pragma synthesis_off
    FOR ALL : FPmul_stage1 USE ENTITY work.FPmul_stage1;
    FOR ALL : FPmul_stage2 USE ENTITY work.FPmul_stage2;
    FOR ALL : FPmul_stage3 USE ENTITY work.FPmul_stage3;
    FOR ALL : FPmul_stage4 USE ENTITY work.FPmul_stage4;
    -- pragma synthesis_on

BEGIN

    -- Instance port mappings.
    REGA : reg_en_rst_n
        generic map(N => 32)
        port map(D => FP_A, en => '1', rst_n => '1', clk => clk, Q => FP_A_reg_stage1);

    REGB : reg_en_rst_n
        generic map(N => 32)
        port map(D => FP_B, en => '1', rst_n => '1', clk => clk, Q => FP_B_reg_stage1);

    I1 : FPmul_stage1
        PORT MAP(
            FP_A            => FP_A_reg_stage1,
            FP_B            => FP_B_reg_stage1,
            clk             => clk,
            A_EXP           => A_EXP,
            A_SIG           => A_SIG,
            B_EXP           => B_EXP,
            B_SIG           => B_SIG,
            SIGN_out_stage1 => SIGN_out_stage1,
            isINF_stage1    => isINF_stage1,
            isNaN_stage1    => isNaN_stage1,
            isZ_tab_stage1  => isZ_tab_stage1
        );
    I2 : FPmul_stage2
        PORT MAP(
            A_EXP           => A_EXP,
            A_SIG           => A_SIG,
            B_EXP           => B_EXP,
            B_SIG           => B_SIG,
            SIGN_out_stage1 => SIGN_out_stage1,
            clk             => clk,
            isINF_stage1    => isINF_stage1,
            isNaN_stage1    => isNaN_stage1,
            isZ_tab_stage1  => isZ_tab_stage1,
            EXP_in          => EXP_in,
            EXP_neg_stage2  => EXP_neg_stage2,
            EXP_pos_stage2  => EXP_pos_stage2,
            SIGN_out_stage2 => SIGN_out_stage2,
            SIG_in          => SIG_in,
            isINF_stage2    => isINF_stage2,
            isNaN_stage2    => isNaN_stage2,
            isZ_tab_stage2  => isZ_tab_stage2
        );
        
    
    i_reg_EXP_in: REG_RST_N
        generic map(
            N => 8
        )
        port map(
            D     => EXP_in,
            RST_N => '1',
            CLK   => clk,
            Q     => EXP_in_pipe
        );

    i_ff_EXP_neg: flipflop_rst_n
        port map(
            D     => EXP_neg_stage2,
            clk   => clk,
            rst_n => '1',
            Q     => EXP_neg_stage2_pipe
        );

    i_ff_EXP_pos: flipflop_rst_n
        port map(
            D     => EXP_pos_stage2,
            clk   => clk,
            rst_n => '1',
            Q     => EXP_pos_stage2_pipe
        );

    i_ff_SIGN_out: flipflop_rst_n
        port map(
            D     => SIGN_out_stage2,
            clk   => clk,
            rst_n => '1',
            Q     => SIGN_out_stage2_pipe
        );

    i_reg_SIG_in: REG_RST_N
        generic map(
            N => 28
        )
        port map(
            D     => SIG_in,
            RST_N => '1',
            CLK   => clk,
            Q     => SIG_in_pipe
        );

    i_ff_isINF: flipflop_rst_n
        port map(
            D     => isINF_stage2,
            clk   => clk,
            rst_n => '1',
            Q     => isINF_stage2_pipe
        );

    i_ff_inNan: flipflop_rst_n
        port map(
            D     => isNaN_stage2,
            clk   => clk,
            rst_n => '1',
            Q     => isNaN_stage2_pipe
        );

    i_ff_isZ: flipflop_rst_n
        port map(
            D     => isZ_tab_stage2,
            clk   => clk,
            rst_n => '1',
            Q     => isZ_tab_stage2_pipe
        );
    
    I3 : FPmul_stage3
        PORT MAP(
            EXP_in          => EXP_in_pipe,
            EXP_neg_stage2  => EXP_neg_stage2_pipe,
            EXP_pos_stage2  => EXP_pos_stage2_pipe,
            SIGN_out_stage2 => SIGN_out_stage2_pipe,
            SIG_in          => SIG_in_pipe,
            clk             => clk,
            isINF_stage2    => isINF_stage2_pipe,
            isNaN_stage2    => isNaN_stage2_pipe,
            isZ_tab_stage2  => isZ_tab_stage2_pipe,
            EXP_neg         => EXP_neg,
            EXP_out_round   => EXP_out_round,
            EXP_pos         => EXP_pos,
            SIGN_out        => SIGN_out,
            SIG_out_round   => SIG_out_round,
            isINF_tab       => isINF_tab,
            isNaN           => isNaN,
            isZ_tab         => isZ_tab
        );
        
    I4 : FPmul_stage4
        PORT MAP(
            EXP_neg       => EXP_neg,
            EXP_out_round => EXP_out_round,
            EXP_pos       => EXP_pos,
            SIGN_out      => SIGN_out,
            SIG_out_round => SIG_out_round,
            clk           => clk,
            isINF_tab     => isINF_tab,
            isNaN         => isNaN,
            isZ_tab       => isZ_tab,
            FP_Z          => FP_Z
        );

END pipeline;
