library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PRECONDITIONING_24BIT is
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
    R12 : out  std_logic_vector(27 downto 0));
end PRECONDITIONING_24BIT;


architecture STRUCTURAL of PRECONDITIONING_24BIT is
    
begin
    
    R0 <= not(S11) & '1' & not(S10) & '1' & not(S9) & '1' & not(S8) & '1' & not(S7) & '1' & not(S6) & '1' & not(S5) & '1' & not(S4) & '1' & not(S3) & '1' & not(S2) & '1' & not(S0) & S0 & S0 & P0;
    R1 <= P12(23) & P11(24 downto 23) & P10(24 downto 23) & P9(24 downto 23) & P8(24 downto 23) & P7(24 downto 23) & P6(24 downto 23) & P5(24 downto 23) & P4(24 downto 23) & P3(24 downto 23) & P2(24) & not(S1) & P1(24 downto 0) & '0' & S0;
    R2 <= P12(22 downto 21) & P11(22 downto 21) & P10(22 downto 21) & P9(22 downto 21) & P8(22 downto 21) & P7(22 downto 21) & P6(22 downto 21) & P5(22 downto 21) & P4(22 downto 21) & P3(22) & P2(23 downto 0) & '0' & S1 & "00";
    R3 <= P12(20 downto 19) & P11(20 downto 19) & P10(20 downto 19) & P9(20 downto 19) & P8(20 downto 19) & P7(20 downto 19) & P6(20 downto 19) & P5(20 downto 19) & P4(20) & P3(21 downto 0) & '0' & S2 & "0000";
    R4 <= P12(18 downto 17) & P11(18 downto 17) & P10(18 downto 17) & P9(18 downto 17) & P8(18 downto 17) & P7(18 downto 17) & P6(18 downto 17) & P5(18) & P4(19 downto 0) & '0' & S3 & "000000";
    R5 <= P12(16 downto 15) & P11(16 downto 15) & P10(16 downto 15) & P9(16 downto 15) & P8(16 downto 15) & P7(16 downto 15) & P6(16) & P5(17 downto 0) & '0' & S4 & "00000000";
    R6 <= P12(14 downto 13) & P11(14 downto 13) & P10(14 downto 13) & P9(14 downto 13) & P8(14 downto 13) & P7(14) & P6(15 downto 0) & '0' & S5 & "0000000000";
    R7 <= P12(12 downto 11) & P11(12 downto 11) & P10(12 downto 11) & P9(12 downto 11) & P8(12) & P7(13 downto 0) & '0' & S6 & "000000000000";
    R8 <= P12(10 downto 9) & P11(10 downto 9) & P10(10 downto 9) & P9(10) & P8(11 downto 0) & '0' & S7 & "00000000000000";
    R9 <= P12(8 downto 7) & P11(8 downto 7) & P10(8) & P9(9 downto 0) & '0' & S8 & "0000000000000000";
    R10 <= P12(6 downto 5) & P11(6) & P10(7 downto 0) & '0' & S9 & "000000000000000000";
    R11 <= P12(4) & P11(5 downto 0) & '0' & S10 & "00000000000000000000";
    R12 <= P12(3 downto 0) & '0' & S11 & "0000000000000000000000";

end STRUCTURAL;