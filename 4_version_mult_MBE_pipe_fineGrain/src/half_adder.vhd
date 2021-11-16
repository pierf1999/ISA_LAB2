library ieee; 
use ieee.std_logic_1164.all;

-- basic half adder block 

entity half_adder is
    port(
            a:      in std_logic;
            b:      in std_logic;
            s:      out std_logic;
            c_out:  out std_logic
        );
end entity half_adder;

architecture structure of half_adder is
begin

    s <= a xor b;
    c_out <= a and b;

end architecture structure;