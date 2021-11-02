library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity tb_fpmult_pipeline is
end entity tb_fpmult_pipeline;

architecture structural of tb_fpmult_pipeline is

    -- components declaration ----------------------------------------------------------------------
    component FPmul IS
        PORT(
            FP_A : IN  std_logic_vector(31 DOWNTO 0);
            FP_B : IN  std_logic_vector(31 DOWNTO 0);
            clk  : IN  std_logic;
            FP_Z : OUT std_logic_vector(31 DOWNTO 0)
        );
    end component FPmul;

    ------------------------------- signal declaration -----------------------------------
    signal in_clk : std_logic;
    signal in_A   : std_logic_vector(31 downto 0);
    signal ID_OUT : std_logic_vector(31 downto 0);

    file file_input, file_output : text;

begin

    stimuli_process : process
        variable v_ILINE : line;
        variable v_OLINE : line;
        variable v_A     : std_logic_vector(31 downto 0);

    begin
        file_open(file_input, "fp_samples.hex", read_mode);
        file_open(file_output, "output_results.hex", write_mode);

        for i in 0 to 4 loop

            readline(file_input, v_ILINE);
            hread(v_ILINE, v_A);

            in_A <= v_A;

            in_clk <= '0';
            wait for 5 ns;
            in_clk <= '1';
            wait for 5 ns;
        end loop;

        while not endfile(file_input) loop
            readline(file_input, v_ILINE);
            hread(v_ILINE, v_A);

            in_A <= v_A;

            hwrite(v_OLINE, ID_OUT);
            writeline(file_output, v_OLINE);

            in_clk <= '0';
            wait for 5 ns;
            in_clk <= '1';
            wait for 5 ns;

        end loop;

        for i in 0 to 4 loop
            hwrite(v_OLINE, ID_OUT);
            writeline(file_output, v_OLINE);

            in_clk <= '0';
            wait for 5 ns;
            in_clk <= '1';
            wait for 5 ns;
        end loop;

        file_close(file_input);
        file_close(file_output);

        wait;

        file_close(file_input);
        file_close(file_output);

        wait;

    end process;

    DUT : FPmul
        port map(FP_A => in_A, FP_B => in_A, clk => in_clk, FP_Z => ID_OUT);

end structural;
