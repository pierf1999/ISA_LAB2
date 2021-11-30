library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity xor_plane_n_bit is
    generic(N : positive := 32);
    port(
        XOR_PLANE_N_BIT_IN_PP  : in  std_logic_vector(N - 1 downto 0);
        XOR_PLANE_N_BIT_IN_MULT : IN std_logic;
        XOR_PLANE_N_BIT_OUT : out  std_logic_vector(N - 1 downto 0)
    );
end xor_plane_n_bit;

architecture STRUCTURAL of xor_plane_n_bit is



begin
 

    -- XOR between N bit of A and B
    xor_nbit : process(XOR_PLANE_N_BIT_IN_PP, XOR_PLANE_N_BIT_IN_MULT)
    begin

        for I in 0 to N - 1 loop
            XOR_PLANE_N_BIT_OUT(I) <= XOR_PLANE_N_BIT_IN_PP(I) XOR XOR_PLANE_N_BIT_IN_MULT;
        end loop;

    end process;

end STRUCTURAL;
