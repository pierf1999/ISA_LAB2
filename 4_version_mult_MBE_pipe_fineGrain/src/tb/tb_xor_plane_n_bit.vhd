library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity tb_XOR_plane_n_bit is
end entity tb_XOR_plane_n_bit;

architecture test of tb_XOR_plane_n_bit is

    component xor_plane_n_bit is
        generic(N : positive := 32);
        port(
            XOR_PLANE_N_BIT_IN_PP   : in  std_logic_vector(N - 1 downto 0);
            XOR_PLANE_N_BIT_IN_MULT : IN  std_logic;
            XOR_PLANE_N_BIT_OUT     : out std_logic_vector(N - 1 downto 0)
        );
    end component xor_plane_n_bit;

    signal A      : std_logic_vector(7 downto 0);
    signal B      : std_logic;
    signal OUTPUT : std_logic_vector(7 downto 0);

begin

    stimuli_process : process
    begin
        A <= "00000000";
        B <= '1';
        wait for 10 ns;
        A <= "00000001";
        B <= '1';
        wait for 10 ns;
        A <= "11111111";
        B <= '1';
        wait for 10 ns;
        A <= "11100011";
        B <= '1';
        wait for 10 ns;
        A <= "00000000";
        B <= '0';
        wait for 10 ns;
        A <= "00000001";
        B <= '0';
        wait for 10 ns;
        A <= "11111111";
        B <= '0';
        wait for 10 ns;
        A <= "11100011";
        B <= '0';
        wait for 10 ns;
    end process;

    DUT : xor_plane_n_bit
        generic map(N => 8)
        port map(
            XOR_PLANE_N_BIT_IN_PP   => A,
            XOR_PLANE_N_BIT_IN_MULT => B,
            XOR_PLANE_N_BIT_OUT     => OUTPUT
        );

end architecture test;

