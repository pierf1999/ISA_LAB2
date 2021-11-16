library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PRECONDITIONING_8BIT is
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
end PRECONDITIONING_8BIT;


architecture STRUCTURAL of PRECONDITIONING_8BIT is
    
begin
    
    R0 <= not(S3) & '1' & not(S2) & '1' & not(S0) & S0 & S0 & P0;
    R1 <= P4(7) & P3(8 downto 7) & P2(8) & not(S1) & P1(8 downto 0) & '0' & S0;
    R2 <= P4(6 downto 5) & P3(6) & P2(7 downto 0) & '0' & S1 & "00";
    R3 <= P4(4) & P3(5 downto 0) & '0' & S2 & "0000";
    R4 <= P4(3 downto 0) & '0' & S3 & "000000";

end STRUCTURAL;