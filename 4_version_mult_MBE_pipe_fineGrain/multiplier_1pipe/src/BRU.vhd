---------------------------------------------------------------------------------------------
-- File: BRU.vhd
---------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BRU is
    port(
        BRU_input  : in  std_logic_vector(2 downto 0);
        BRU_output : out std_logic_vector(1 downto 0)
    );
end entity BRU;

architecture BEHAVIORAL of BRU is

begin

    i_BRU_unit : process(BRU_input)
    begin
        case BRU_input is
            when "000"  => BRU_output <= "00";
            when "001"  => BRU_output <= "01";
            when "010"  => BRU_output <= "01";
            when "011"  => BRU_output <= "10";
            when "100"  => BRU_output <= "10";
            when "101"  => BRU_output <= "01";
            when "110"  => BRU_output <= "01";
            when "111"  => BRU_output <= "00";
            when others => BRU_output <= "00";
        end case;
    end process;

end BEHAVIORAL;
