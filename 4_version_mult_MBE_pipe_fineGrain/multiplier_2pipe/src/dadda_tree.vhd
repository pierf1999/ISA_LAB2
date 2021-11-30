library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dadda_tree is
	port(
		d5_0 : in std_logic_vector(47 downto 0);
		d5_1 : in std_logic_vector(47 downto 0);
		d5_2 : in std_logic_vector(46 downto 0);
		d5_3 : in std_logic_vector(44 downto 0);
		d5_4 : in std_logic_vector(42 downto 0);
		d5_5 : in std_logic_vector(40 downto 0);
		d5_6 : in std_logic_vector(38 downto 0);
		d5_7 : in std_logic_vector(36 downto 0);
		d5_8 : in std_logic_vector(34 downto 0);
		d5_9 : in std_logic_vector(32 downto 0);
		d5_10 : in std_logic_vector(30 downto 0);
		d5_11 : in std_logic_vector(28 downto 0);
		d5_12 : in std_logic_vector(27 downto 0);
		sum_output : out std_logic_vector(47 downto 0);
		carry_output : out std_logic_vector(47 downto 0)
);
end dadda_tree;


architecture structural of dadda_tree is

	component half_adder
		port(
			a : in std_logic;
			b : in std_logic;
			s : out std_logic;
			cout : out std_logic);
	end component;

	component full_adder
	port(
			a : in std_logic;
			b : in std_logic;
			cin : in std_logic;
			s : out std_logic;
			cout : out std_logic);
	end component;

	signal d4_0 : std_logic_vector(47 downto 0);
	signal d4_1 : std_logic_vector(47 downto 0);
	signal d4_2 : std_logic_vector(46 downto 0);
	signal d4_3 : std_logic_vector(44 downto 0);
	signal d4_4 : std_logic_vector(42 downto 0);
	signal d4_5 : std_logic_vector(40 downto 0);
	signal d4_6 : std_logic_vector(38 downto 0);
	signal d4_7 : std_logic_vector(36 downto 0);
	signal d4_8 : std_logic_vector(35 downto 0);
	signal d3_0 : std_logic_vector(47 downto 0);
	signal d3_1 : std_logic_vector(47 downto 0);
	signal d3_2 : std_logic_vector(46 downto 0);
	signal d3_3 : std_logic_vector(44 downto 0);
	signal d3_4 : std_logic_vector(42 downto 0);
	signal d3_5 : std_logic_vector(41 downto 0);
	signal d2_0 : std_logic_vector(47 downto 0);
	signal d2_1 : std_logic_vector(47 downto 0);
	signal d2_2 : std_logic_vector(46 downto 0);
	signal d2_3 : std_logic_vector(45 downto 0);
	signal d1_0 : std_logic_vector(47 downto 0);
	signal d1_1 : std_logic_vector(47 downto 0);
	signal d1_2 : std_logic_vector(47 downto 0);
	signal d0_0 : std_logic_vector(48 downto 0);
	signal d0_1 : std_logic_vector(47 downto 0);

begin

d4_0(0) <= d5_0(0);

d4_1(0) <= d5_1(0);

d4_0(1) <= d5_0(1);

d4_0(2) <= d5_0(2);

d4_1(2) <= d5_1(2);

d4_2(2) <= d5_2(2);

d4_0(3) <= d5_0(3);

d4_1(3) <= d5_1(3);

d4_0(4) <= d5_0(4);

d4_1(4) <= d5_1(4);

d4_2(4) <= d5_2(4);

d4_3(4) <= d5_3(4);

d4_0(5) <= d5_0(5);

d4_1(5) <= d5_1(5);

d4_2(5) <= d5_2(5);

d4_0(6) <= d5_0(6);

d4_1(6) <= d5_1(6);

d4_2(6) <= d5_2(6);

d4_3(6) <= d5_3(6);

d4_4(6) <= d5_4(6);

d4_0(7) <= d5_0(7);

d4_1(7) <= d5_1(7);

d4_2(7) <= d5_2(7);

d4_3(7) <= d5_3(7);

d4_0(8) <= d5_0(8);

d4_1(8) <= d5_1(8);

d4_2(8) <= d5_2(8);

d4_3(8) <= d5_3(8);

d4_4(8) <= d5_4(8);

d4_5(8) <= d5_5(8);

d4_0(9) <= d5_0(9);

d4_1(9) <= d5_1(9);

d4_2(9) <= d5_2(9);

d4_3(9) <= d5_3(9);

d4_4(9) <= d5_4(9);

d4_0(10) <= d5_0(10);

d4_1(10) <= d5_1(10);

d4_2(10) <= d5_2(10);

d4_3(10) <= d5_3(10);

d4_4(10) <= d5_4(10);

d4_5(10) <= d5_5(10);

d4_6(10) <= d5_6(10);

d4_0(11) <= d5_0(11);

d4_1(11) <= d5_1(11);

d4_2(11) <= d5_2(11);

d4_3(11) <= d5_3(11);

d4_4(11) <= d5_4(11);

d4_5(11) <= d5_5(11);

d4_0(12) <= d5_0(12);

d4_1(12) <= d5_1(12);

d4_2(12) <= d5_2(12);

d4_3(12) <= d5_3(12);

d4_4(12) <= d5_4(12);

d4_5(12) <= d5_5(12);

d4_6(12) <= d5_6(12);

d4_7(12) <= d5_7(12);

d4_0(13) <= d5_0(13);

d4_1(13) <= d5_1(13);

d4_2(13) <= d5_2(13);

d4_3(13) <= d5_3(13);

d4_4(13) <= d5_4(13);

d4_5(13) <= d5_5(13);

d4_6(13) <= d5_6(13);

d4_0(14) <= d5_0(14);

d4_1(14) <= d5_1(14);

d4_2(14) <= d5_2(14);

d4_3(14) <= d5_3(14);

d4_4(14) <= d5_4(14);

d4_5(14) <= d5_5(14);

d4_6(14) <= d5_6(14);

d4_7(14) <= d5_7(14);

d4_8(14) <= d5_8(14);

d4_0(15) <= d5_0(15);

d4_1(15) <= d5_1(15);

d4_2(15) <= d5_2(15);

d4_3(15) <= d5_3(15);

d4_4(15) <= d5_4(15);

d4_5(15) <= d5_5(15);

d4_6(15) <= d5_6(15);

d4_7(15) <= d5_7(15);

i_HA1_6_16: half_adder
port map(
	a => d5_0(16),
	b => d5_1(16),
	s => d4_0(16),
	cout => d4_0(17)
);

d4_1(16) <= d5_2(16);

d4_2(16) <= d5_3(16);

d4_3(16) <= d5_4(16);

d4_4(16) <= d5_5(16);

d4_5(16) <= d5_6(16);

d4_6(16) <= d5_7(16);

d4_7(16) <= d5_8(16);

d4_8(16) <= d5_9(16);

i_HA1_6_17: half_adder
port map(
	a => d5_0(17),
	b => d5_1(17),
	s => d4_1(17),
	cout => d4_0(18)
);

d4_2(17) <= d5_2(17);

d4_3(17) <= d5_3(17);

d4_4(17) <= d5_4(17);

d4_5(17) <= d5_5(17);

d4_6(17) <= d5_6(17);

d4_7(17) <= d5_7(17);

d4_8(17) <= d5_8(17);

i_FA1_5_18: full_adder
port map(
	a => d5_0(18),
	b => d5_1(18),
	cin => d5_2(18),
	s => d4_1(18),
	cout => d4_0(19)
);

i_HA1_6_18: half_adder
port map(
	a => d5_3(18),
	b => d5_4(18),
	s => d4_2(18),
	cout => d4_1(19)
);

d4_3(18) <= d5_5(18);

d4_4(18) <= d5_6(18);

d4_5(18) <= d5_7(18);

d4_6(18) <= d5_8(18);

d4_7(18) <= d5_9(18);

d4_8(18) <= d5_10(18);

i_FA1_5_19: full_adder
port map(
	a => d5_0(19),
	b => d5_1(19),
	cin => d5_2(19),
	s => d4_2(19),
	cout => d4_0(20)
);

i_HA1_6_19: half_adder
port map(
	a => d5_3(19),
	b => d5_4(19),
	s => d4_3(19),
	cout => d4_1(20)
);

d4_4(19) <= d5_5(19);

d4_5(19) <= d5_6(19);

d4_6(19) <= d5_7(19);

d4_7(19) <= d5_8(19);

d4_8(19) <= d5_9(19);

i_FA1_5_20: full_adder
port map(
	a => d5_0(20),
	b => d5_1(20),
	cin => d5_2(20),
	s => d4_2(20),
	cout => d4_0(21)
);

i_FA2_5_20: full_adder
port map(
	a => d5_3(20),
	b => d5_4(20),
	cin => d5_5(20),
	s => d4_3(20),
	cout => d4_1(21)
);

i_HA1_6_20: half_adder
port map(
	a => d5_6(20),
	b => d5_7(20),
	s => d4_4(20),
	cout => d4_2(21)
);

d4_5(20) <= d5_8(20);

d4_6(20) <= d5_9(20);

d4_7(20) <= d5_10(20);

d4_8(20) <= d5_11(20);

i_FA1_5_21: full_adder
port map(
	a => d5_0(21),
	b => d5_1(21),
	cin => d5_2(21),
	s => d4_3(21),
	cout => d4_0(22)
);

i_FA2_5_21: full_adder
port map(
	a => d5_3(21),
	b => d5_4(21),
	cin => d5_5(21),
	s => d4_4(21),
	cout => d4_1(22)
);

i_HA1_6_21: half_adder
port map(
	a => d5_6(21),
	b => d5_7(21),
	s => d4_5(21),
	cout => d4_2(22)
);

d4_6(21) <= d5_8(21);

d4_7(21) <= d5_9(21);

d4_8(21) <= d5_10(21);

i_FA1_5_22: full_adder
port map(
	a => d5_0(22),
	b => d5_1(22),
	cin => d5_2(22),
	s => d4_3(22),
	cout => d4_0(23)
);

i_FA2_5_22: full_adder
port map(
	a => d5_3(22),
	b => d5_4(22),
	cin => d5_5(22),
	s => d4_4(22),
	cout => d4_1(23)
);

i_FA3_5_22: full_adder
port map(
	a => d5_6(22),
	b => d5_7(22),
	cin => d5_8(22),
	s => d4_5(22),
	cout => d4_2(23)
);

i_HA1_6_22: half_adder
port map(
	a => d5_9(22),
	b => d5_10(22),
	s => d4_6(22),
	cout => d4_3(23)
);

d4_7(22) <= d5_11(22);

d4_8(22) <= d5_12(22);

i_FA1_5_23: full_adder
port map(
	a => d5_0(23),
	b => d5_1(23),
	cin => d5_2(23),
	s => d4_4(23),
	cout => d4_0(24)
);

i_FA2_5_23: full_adder
port map(
	a => d5_3(23),
	b => d5_4(23),
	cin => d5_5(23),
	s => d4_5(23),
	cout => d4_1(24)
);

i_FA3_5_23: full_adder
port map(
	a => d5_6(23),
	b => d5_7(23),
	cin => d5_8(23),
	s => d4_6(23),
	cout => d4_2(24)
);

i_HA1_6_23: half_adder
port map(
	a => d5_9(23),
	b => d5_10(23),
	s => d4_7(23),
	cout => d4_3(24)
);

d4_8(23) <= d5_11(23);

i_FA1_5_24: full_adder
port map(
	a => d5_0(24),
	b => d5_1(24),
	cin => d5_2(24),
	s => d4_4(24),
	cout => d4_0(25)
);

i_FA2_5_24: full_adder
port map(
	a => d5_3(24),
	b => d5_4(24),
	cin => d5_5(24),
	s => d4_5(24),
	cout => d4_1(25)
);

i_FA3_5_24: full_adder
port map(
	a => d5_6(24),
	b => d5_7(24),
	cin => d5_8(24),
	s => d4_6(24),
	cout => d4_2(25)
);

i_FA4_5_24: full_adder
port map(
	a => d5_9(24),
	b => d5_10(24),
	cin => d5_11(24),
	s => d4_7(24),
	cout => d4_3(25)
);

d4_8(24) <= d5_12(24);

i_FA1_5_25: full_adder
port map(
	a => d5_0(25),
	b => d5_1(25),
	cin => d5_2(25),
	s => d4_4(25),
	cout => d4_0(26)
);

i_FA2_5_25: full_adder
port map(
	a => d5_3(25),
	b => d5_4(25),
	cin => d5_5(25),
	s => d4_5(25),
	cout => d4_1(26)
);

i_FA3_5_25: full_adder
port map(
	a => d5_6(25),
	b => d5_7(25),
	cin => d5_8(25),
	s => d4_6(25),
	cout => d4_2(26)
);

i_FA4_5_25: full_adder
port map(
	a => d5_9(25),
	b => d5_10(25),
	cin => d5_11(25),
	s => d4_7(25),
	cout => d4_3(26)
);

d4_8(25) <= d5_12(25);

i_FA1_5_26: full_adder
port map(
	a => d5_0(26),
	b => d5_1(26),
	cin => d5_2(26),
	s => d4_4(26),
	cout => d4_0(27)
);

i_FA2_5_26: full_adder
port map(
	a => d5_3(26),
	b => d5_4(26),
	cin => d5_5(26),
	s => d4_5(26),
	cout => d4_1(27)
);

i_FA3_5_26: full_adder
port map(
	a => d5_6(26),
	b => d5_7(26),
	cin => d5_8(26),
	s => d4_6(26),
	cout => d4_2(27)
);

i_FA4_5_26: full_adder
port map(
	a => d5_9(26),
	b => d5_10(26),
	cin => d5_11(26),
	s => d4_7(26),
	cout => d4_3(27)
);

d4_8(26) <= d5_12(26);

i_FA1_5_27: full_adder
port map(
	a => d5_0(27),
	b => d5_1(27),
	cin => d5_2(27),
	s => d4_4(27),
	cout => d4_0(28)
);

i_FA2_5_27: full_adder
port map(
	a => d5_3(27),
	b => d5_4(27),
	cin => d5_5(27),
	s => d4_5(27),
	cout => d4_1(28)
);

i_FA3_5_27: full_adder
port map(
	a => d5_6(27),
	b => d5_7(27),
	cin => d5_8(27),
	s => d4_6(27),
	cout => d4_2(28)
);

i_FA4_5_27: full_adder
port map(
	a => d5_9(27),
	b => d5_10(27),
	cin => d5_11(27),
	s => d4_7(27),
	cout => d4_3(28)
);

d4_8(27) <= d5_12(27);

i_FA1_5_28: full_adder
port map(
	a => d5_0(28),
	b => d5_1(28),
	cin => d5_2(28),
	s => d4_4(28),
	cout => d4_0(29)
);

i_FA2_5_28: full_adder
port map(
	a => d5_3(28),
	b => d5_4(28),
	cin => d5_5(28),
	s => d4_5(28),
	cout => d4_1(29)
);

i_FA3_5_28: full_adder
port map(
	a => d5_6(28),
	b => d5_7(28),
	cin => d5_8(28),
	s => d4_6(28),
	cout => d4_2(29)
);

i_HA1_6_28: half_adder
port map(
	a => d5_9(28),
	b => d5_10(28),
	s => d4_7(28),
	cout => d4_3(29)
);

d4_8(28) <= d5_11(28);

i_FA1_5_29: full_adder
port map(
	a => d5_0(29),
	b => d5_1(29),
	cin => d5_2(29),
	s => d4_4(29),
	cout => d4_0(30)
);

i_FA2_5_29: full_adder
port map(
	a => d5_3(29),
	b => d5_4(29),
	cin => d5_5(29),
	s => d4_5(29),
	cout => d4_1(30)
);

i_FA3_5_29: full_adder
port map(
	a => d5_6(29),
	b => d5_7(29),
	cin => d5_8(29),
	s => d4_6(29),
	cout => d4_2(30)
);

d4_7(29) <= d5_9(29);

d4_8(29) <= d5_10(29);

i_FA1_5_30: full_adder
port map(
	a => d5_0(30),
	b => d5_1(30),
	cin => d5_2(30),
	s => d4_3(30),
	cout => d4_0(31)
);

i_FA2_5_30: full_adder
port map(
	a => d5_3(30),
	b => d5_4(30),
	cin => d5_5(30),
	s => d4_4(30),
	cout => d4_1(31)
);

i_HA1_6_30: half_adder
port map(
	a => d5_6(30),
	b => d5_7(30),
	s => d4_5(30),
	cout => d4_2(31)
);

d4_6(30) <= d5_8(30);

d4_7(30) <= d5_9(30);

d4_8(30) <= d5_10(30);

i_FA1_5_31: full_adder
port map(
	a => d5_0(31),
	b => d5_1(31),
	cin => d5_2(31),
	s => d4_3(31),
	cout => d4_0(32)
);

i_FA2_5_31: full_adder
port map(
	a => d5_3(31),
	b => d5_4(31),
	cin => d5_5(31),
	s => d4_4(31),
	cout => d4_1(32)
);

d4_5(31) <= d5_6(31);

d4_6(31) <= d5_7(31);

d4_7(31) <= d5_8(31);

d4_8(31) <= d5_9(31);

i_FA1_5_32: full_adder
port map(
	a => d5_0(32),
	b => d5_1(32),
	cin => d5_2(32),
	s => d4_2(32),
	cout => d4_0(33)
);

i_HA1_6_32: half_adder
port map(
	a => d5_3(32),
	b => d5_4(32),
	s => d4_3(32),
	cout => d4_1(33)
);

d4_4(32) <= d5_5(32);

d4_5(32) <= d5_6(32);

d4_6(32) <= d5_7(32);

d4_7(32) <= d5_8(32);

d4_8(32) <= d5_9(32);

i_FA1_5_33: full_adder
port map(
	a => d5_0(33),
	b => d5_1(33),
	cin => d5_2(33),
	s => d4_2(33),
	cout => d4_0(34)
);

d4_3(33) <= d5_3(33);

d4_4(33) <= d5_4(33);

d4_5(33) <= d5_5(33);

d4_6(33) <= d5_6(33);

d4_7(33) <= d5_7(33);

d4_8(33) <= d5_8(33);

i_HA1_6_34: half_adder
port map(
	a => d5_0(34),
	b => d5_1(34),
	s => d4_1(34),
	cout => d4_0(35)
);

d4_2(34) <= d5_2(34);

d4_3(34) <= d5_3(34);

d4_4(34) <= d5_4(34);

d4_5(34) <= d5_5(34);

d4_6(34) <= d5_6(34);

d4_7(34) <= d5_7(34);

d4_8(34) <= d5_8(34);

d4_1(35) <= d5_0(35);

d4_2(35) <= d5_1(35);

d4_3(35) <= d5_2(35);

d4_4(35) <= d5_3(35);

d4_5(35) <= d5_4(35);

d4_6(35) <= d5_5(35);

d4_7(35) <= d5_6(35);

d4_8(35) <= d5_7(35);

d4_0(36) <= d5_0(36);

d4_1(36) <= d5_1(36);

d4_2(36) <= d5_2(36);

d4_3(36) <= d5_3(36);

d4_4(36) <= d5_4(36);

d4_5(36) <= d5_5(36);

d4_6(36) <= d5_6(36);

d4_7(36) <= d5_7(36);

d4_0(37) <= d5_0(37);

d4_1(37) <= d5_1(37);

d4_2(37) <= d5_2(37);

d4_3(37) <= d5_3(37);

d4_4(37) <= d5_4(37);

d4_5(37) <= d5_5(37);

d4_6(37) <= d5_6(37);

d4_0(38) <= d5_0(38);

d4_1(38) <= d5_1(38);

d4_2(38) <= d5_2(38);

d4_3(38) <= d5_3(38);

d4_4(38) <= d5_4(38);

d4_5(38) <= d5_5(38);

d4_6(38) <= d5_6(38);

d4_0(39) <= d5_0(39);

d4_1(39) <= d5_1(39);

d4_2(39) <= d5_2(39);

d4_3(39) <= d5_3(39);

d4_4(39) <= d5_4(39);

d4_5(39) <= d5_5(39);

d4_0(40) <= d5_0(40);

d4_1(40) <= d5_1(40);

d4_2(40) <= d5_2(40);

d4_3(40) <= d5_3(40);

d4_4(40) <= d5_4(40);

d4_5(40) <= d5_5(40);

d4_0(41) <= d5_0(41);

d4_1(41) <= d5_1(41);

d4_2(41) <= d5_2(41);

d4_3(41) <= d5_3(41);

d4_4(41) <= d5_4(41);

d4_0(42) <= d5_0(42);

d4_1(42) <= d5_1(42);

d4_2(42) <= d5_2(42);

d4_3(42) <= d5_3(42);

d4_4(42) <= d5_4(42);

d4_0(43) <= d5_0(43);

d4_1(43) <= d5_1(43);

d4_2(43) <= d5_2(43);

d4_3(43) <= d5_3(43);

d4_0(44) <= d5_0(44);

d4_1(44) <= d5_1(44);

d4_2(44) <= d5_2(44);

d4_3(44) <= d5_3(44);

d4_0(45) <= d5_0(45);

d4_1(45) <= d5_1(45);

d4_2(45) <= d5_2(45);

d4_0(46) <= d5_0(46);

d4_1(46) <= d5_1(46);

d4_2(46) <= d5_2(46);

d4_0(47) <= d5_0(47);

d4_1(47) <= d5_1(47);

d3_0(0) <= d4_0(0);

d3_1(0) <= d4_1(0);

d3_0(1) <= d4_0(1);

d3_0(2) <= d4_0(2);

d3_1(2) <= d4_1(2);

d3_2(2) <= d4_2(2);

d3_0(3) <= d4_0(3);

d3_1(3) <= d4_1(3);

d3_0(4) <= d4_0(4);

d3_1(4) <= d4_1(4);

d3_2(4) <= d4_2(4);

d3_3(4) <= d4_3(4);

d3_0(5) <= d4_0(5);

d3_1(5) <= d4_1(5);

d3_2(5) <= d4_2(5);

d3_0(6) <= d4_0(6);

d3_1(6) <= d4_1(6);

d3_2(6) <= d4_2(6);

d3_3(6) <= d4_3(6);

d3_4(6) <= d4_4(6);

d3_0(7) <= d4_0(7);

d3_1(7) <= d4_1(7);

d3_2(7) <= d4_2(7);

d3_3(7) <= d4_3(7);

d3_0(8) <= d4_0(8);

d3_1(8) <= d4_1(8);

d3_2(8) <= d4_2(8);

d3_3(8) <= d4_3(8);

d3_4(8) <= d4_4(8);

d3_5(8) <= d4_5(8);

d3_0(9) <= d4_0(9);

d3_1(9) <= d4_1(9);

d3_2(9) <= d4_2(9);

d3_3(9) <= d4_3(9);

d3_4(9) <= d4_4(9);

i_HA1_5_10: half_adder
port map(
	a => d4_0(10),
	b => d4_1(10),
	s => d3_0(10),
	cout => d3_0(11)
);

d3_1(10) <= d4_2(10);

d3_2(10) <= d4_3(10);

d3_3(10) <= d4_4(10);

d3_4(10) <= d4_5(10);

d3_5(10) <= d4_6(10);

i_HA1_5_11: half_adder
port map(
	a => d4_0(11),
	b => d4_1(11),
	s => d3_1(11),
	cout => d3_0(12)
);

d3_2(11) <= d4_2(11);

d3_3(11) <= d4_3(11);

d3_4(11) <= d4_4(11);

d3_5(11) <= d4_5(11);

i_FA1_4_12: full_adder
port map(
	a => d4_0(12),
	b => d4_1(12),
	cin => d4_2(12),
	s => d3_1(12),
	cout => d3_0(13)
);

i_HA1_5_12: half_adder
port map(
	a => d4_3(12),
	b => d4_4(12),
	s => d3_2(12),
	cout => d3_1(13)
);

d3_3(12) <= d4_5(12);

d3_4(12) <= d4_6(12);

d3_5(12) <= d4_7(12);

i_FA1_4_13: full_adder
port map(
	a => d4_0(13),
	b => d4_1(13),
	cin => d4_2(13),
	s => d3_2(13),
	cout => d3_0(14)
);

i_HA1_5_13: half_adder
port map(
	a => d4_3(13),
	b => d4_4(13),
	s => d3_3(13),
	cout => d3_1(14)
);

d3_4(13) <= d4_5(13);

d3_5(13) <= d4_6(13);

i_FA1_4_14: full_adder
port map(
	a => d4_0(14),
	b => d4_1(14),
	cin => d4_2(14),
	s => d3_2(14),
	cout => d3_0(15)
);

i_FA2_4_14: full_adder
port map(
	a => d4_3(14),
	b => d4_4(14),
	cin => d4_5(14),
	s => d3_3(14),
	cout => d3_1(15)
);

i_HA1_5_14: half_adder
port map(
	a => d4_6(14),
	b => d4_7(14),
	s => d3_4(14),
	cout => d3_2(15)
);

d3_5(14) <= d4_8(14);

i_FA1_4_15: full_adder
port map(
	a => d4_0(15),
	b => d4_1(15),
	cin => d4_2(15),
	s => d3_3(15),
	cout => d3_0(16)
);

i_FA2_4_15: full_adder
port map(
	a => d4_3(15),
	b => d4_4(15),
	cin => d4_5(15),
	s => d3_4(15),
	cout => d3_1(16)
);

i_HA1_5_15: half_adder
port map(
	a => d4_6(15),
	b => d4_7(15),
	s => d3_5(15),
	cout => d3_2(16)
);

i_FA1_4_16: full_adder
port map(
	a => d4_0(16),
	b => d4_1(16),
	cin => d4_2(16),
	s => d3_3(16),
	cout => d3_0(17)
);

i_FA2_4_16: full_adder
port map(
	a => d4_3(16),
	b => d4_4(16),
	cin => d4_5(16),
	s => d3_4(16),
	cout => d3_1(17)
);

i_FA3_4_16: full_adder
port map(
	a => d4_6(16),
	b => d4_7(16),
	cin => d4_8(16),
	s => d3_5(16),
	cout => d3_2(17)
);

i_FA1_4_17: full_adder
port map(
	a => d4_0(17),
	b => d4_1(17),
	cin => d4_2(17),
	s => d3_3(17),
	cout => d3_0(18)
);

i_FA2_4_17: full_adder
port map(
	a => d4_3(17),
	b => d4_4(17),
	cin => d4_5(17),
	s => d3_4(17),
	cout => d3_1(18)
);

i_FA3_4_17: full_adder
port map(
	a => d4_6(17),
	b => d4_7(17),
	cin => d4_8(17),
	s => d3_5(17),
	cout => d3_2(18)
);

i_FA1_4_18: full_adder
port map(
	a => d4_0(18),
	b => d4_1(18),
	cin => d4_2(18),
	s => d3_3(18),
	cout => d3_0(19)
);

i_FA2_4_18: full_adder
port map(
	a => d4_3(18),
	b => d4_4(18),
	cin => d4_5(18),
	s => d3_4(18),
	cout => d3_1(19)
);

i_FA3_4_18: full_adder
port map(
	a => d4_6(18),
	b => d4_7(18),
	cin => d4_8(18),
	s => d3_5(18),
	cout => d3_2(19)
);

i_FA1_4_19: full_adder
port map(
	a => d4_0(19),
	b => d4_1(19),
	cin => d4_2(19),
	s => d3_3(19),
	cout => d3_0(20)
);

i_FA2_4_19: full_adder
port map(
	a => d4_3(19),
	b => d4_4(19),
	cin => d4_5(19),
	s => d3_4(19),
	cout => d3_1(20)
);

i_FA3_4_19: full_adder
port map(
	a => d4_6(19),
	b => d4_7(19),
	cin => d4_8(19),
	s => d3_5(19),
	cout => d3_2(20)
);

i_FA1_4_20: full_adder
port map(
	a => d4_0(20),
	b => d4_1(20),
	cin => d4_2(20),
	s => d3_3(20),
	cout => d3_0(21)
);

i_FA2_4_20: full_adder
port map(
	a => d4_3(20),
	b => d4_4(20),
	cin => d4_5(20),
	s => d3_4(20),
	cout => d3_1(21)
);

i_FA3_4_20: full_adder
port map(
	a => d4_6(20),
	b => d4_7(20),
	cin => d4_8(20),
	s => d3_5(20),
	cout => d3_2(21)
);

i_FA1_4_21: full_adder
port map(
	a => d4_0(21),
	b => d4_1(21),
	cin => d4_2(21),
	s => d3_3(21),
	cout => d3_0(22)
);

i_FA2_4_21: full_adder
port map(
	a => d4_3(21),
	b => d4_4(21),
	cin => d4_5(21),
	s => d3_4(21),
	cout => d3_1(22)
);

i_FA3_4_21: full_adder
port map(
	a => d4_6(21),
	b => d4_7(21),
	cin => d4_8(21),
	s => d3_5(21),
	cout => d3_2(22)
);

i_FA1_4_22: full_adder
port map(
	a => d4_0(22),
	b => d4_1(22),
	cin => d4_2(22),
	s => d3_3(22),
	cout => d3_0(23)
);

i_FA2_4_22: full_adder
port map(
	a => d4_3(22),
	b => d4_4(22),
	cin => d4_5(22),
	s => d3_4(22),
	cout => d3_1(23)
);

i_FA3_4_22: full_adder
port map(
	a => d4_6(22),
	b => d4_7(22),
	cin => d4_8(22),
	s => d3_5(22),
	cout => d3_2(23)
);

i_FA1_4_23: full_adder
port map(
	a => d4_0(23),
	b => d4_1(23),
	cin => d4_2(23),
	s => d3_3(23),
	cout => d3_0(24)
);

i_FA2_4_23: full_adder
port map(
	a => d4_3(23),
	b => d4_4(23),
	cin => d4_5(23),
	s => d3_4(23),
	cout => d3_1(24)
);

i_FA3_4_23: full_adder
port map(
	a => d4_6(23),
	b => d4_7(23),
	cin => d4_8(23),
	s => d3_5(23),
	cout => d3_2(24)
);

i_FA1_4_24: full_adder
port map(
	a => d4_0(24),
	b => d4_1(24),
	cin => d4_2(24),
	s => d3_3(24),
	cout => d3_0(25)
);

i_FA2_4_24: full_adder
port map(
	a => d4_3(24),
	b => d4_4(24),
	cin => d4_5(24),
	s => d3_4(24),
	cout => d3_1(25)
);

i_FA3_4_24: full_adder
port map(
	a => d4_6(24),
	b => d4_7(24),
	cin => d4_8(24),
	s => d3_5(24),
	cout => d3_2(25)
);

i_FA1_4_25: full_adder
port map(
	a => d4_0(25),
	b => d4_1(25),
	cin => d4_2(25),
	s => d3_3(25),
	cout => d3_0(26)
);

i_FA2_4_25: full_adder
port map(
	a => d4_3(25),
	b => d4_4(25),
	cin => d4_5(25),
	s => d3_4(25),
	cout => d3_1(26)
);

i_FA3_4_25: full_adder
port map(
	a => d4_6(25),
	b => d4_7(25),
	cin => d4_8(25),
	s => d3_5(25),
	cout => d3_2(26)
);

i_FA1_4_26: full_adder
port map(
	a => d4_0(26),
	b => d4_1(26),
	cin => d4_2(26),
	s => d3_3(26),
	cout => d3_0(27)
);

i_FA2_4_26: full_adder
port map(
	a => d4_3(26),
	b => d4_4(26),
	cin => d4_5(26),
	s => d3_4(26),
	cout => d3_1(27)
);

i_FA3_4_26: full_adder
port map(
	a => d4_6(26),
	b => d4_7(26),
	cin => d4_8(26),
	s => d3_5(26),
	cout => d3_2(27)
);

i_FA1_4_27: full_adder
port map(
	a => d4_0(27),
	b => d4_1(27),
	cin => d4_2(27),
	s => d3_3(27),
	cout => d3_0(28)
);

i_FA2_4_27: full_adder
port map(
	a => d4_3(27),
	b => d4_4(27),
	cin => d4_5(27),
	s => d3_4(27),
	cout => d3_1(28)
);

i_FA3_4_27: full_adder
port map(
	a => d4_6(27),
	b => d4_7(27),
	cin => d4_8(27),
	s => d3_5(27),
	cout => d3_2(28)
);

i_FA1_4_28: full_adder
port map(
	a => d4_0(28),
	b => d4_1(28),
	cin => d4_2(28),
	s => d3_3(28),
	cout => d3_0(29)
);

i_FA2_4_28: full_adder
port map(
	a => d4_3(28),
	b => d4_4(28),
	cin => d4_5(28),
	s => d3_4(28),
	cout => d3_1(29)
);

i_FA3_4_28: full_adder
port map(
	a => d4_6(28),
	b => d4_7(28),
	cin => d4_8(28),
	s => d3_5(28),
	cout => d3_2(29)
);

i_FA1_4_29: full_adder
port map(
	a => d4_0(29),
	b => d4_1(29),
	cin => d4_2(29),
	s => d3_3(29),
	cout => d3_0(30)
);

i_FA2_4_29: full_adder
port map(
	a => d4_3(29),
	b => d4_4(29),
	cin => d4_5(29),
	s => d3_4(29),
	cout => d3_1(30)
);

i_FA3_4_29: full_adder
port map(
	a => d4_6(29),
	b => d4_7(29),
	cin => d4_8(29),
	s => d3_5(29),
	cout => d3_2(30)
);

i_FA1_4_30: full_adder
port map(
	a => d4_0(30),
	b => d4_1(30),
	cin => d4_2(30),
	s => d3_3(30),
	cout => d3_0(31)
);

i_FA2_4_30: full_adder
port map(
	a => d4_3(30),
	b => d4_4(30),
	cin => d4_5(30),
	s => d3_4(30),
	cout => d3_1(31)
);

i_FA3_4_30: full_adder
port map(
	a => d4_6(30),
	b => d4_7(30),
	cin => d4_8(30),
	s => d3_5(30),
	cout => d3_2(31)
);

i_FA1_4_31: full_adder
port map(
	a => d4_0(31),
	b => d4_1(31),
	cin => d4_2(31),
	s => d3_3(31),
	cout => d3_0(32)
);

i_FA2_4_31: full_adder
port map(
	a => d4_3(31),
	b => d4_4(31),
	cin => d4_5(31),
	s => d3_4(31),
	cout => d3_1(32)
);

i_FA3_4_31: full_adder
port map(
	a => d4_6(31),
	b => d4_7(31),
	cin => d4_8(31),
	s => d3_5(31),
	cout => d3_2(32)
);

i_FA1_4_32: full_adder
port map(
	a => d4_0(32),
	b => d4_1(32),
	cin => d4_2(32),
	s => d3_3(32),
	cout => d3_0(33)
);

i_FA2_4_32: full_adder
port map(
	a => d4_3(32),
	b => d4_4(32),
	cin => d4_5(32),
	s => d3_4(32),
	cout => d3_1(33)
);

i_FA3_4_32: full_adder
port map(
	a => d4_6(32),
	b => d4_7(32),
	cin => d4_8(32),
	s => d3_5(32),
	cout => d3_2(33)
);

i_FA1_4_33: full_adder
port map(
	a => d4_0(33),
	b => d4_1(33),
	cin => d4_2(33),
	s => d3_3(33),
	cout => d3_0(34)
);

i_FA2_4_33: full_adder
port map(
	a => d4_3(33),
	b => d4_4(33),
	cin => d4_5(33),
	s => d3_4(33),
	cout => d3_1(34)
);

i_FA3_4_33: full_adder
port map(
	a => d4_6(33),
	b => d4_7(33),
	cin => d4_8(33),
	s => d3_5(33),
	cout => d3_2(34)
);

i_FA1_4_34: full_adder
port map(
	a => d4_0(34),
	b => d4_1(34),
	cin => d4_2(34),
	s => d3_3(34),
	cout => d3_0(35)
);

i_FA2_4_34: full_adder
port map(
	a => d4_3(34),
	b => d4_4(34),
	cin => d4_5(34),
	s => d3_4(34),
	cout => d3_1(35)
);

i_FA3_4_34: full_adder
port map(
	a => d4_6(34),
	b => d4_7(34),
	cin => d4_8(34),
	s => d3_5(34),
	cout => d3_2(35)
);

i_FA1_4_35: full_adder
port map(
	a => d4_0(35),
	b => d4_1(35),
	cin => d4_2(35),
	s => d3_3(35),
	cout => d3_0(36)
);

i_FA2_4_35: full_adder
port map(
	a => d4_3(35),
	b => d4_4(35),
	cin => d4_5(35),
	s => d3_4(35),
	cout => d3_1(36)
);

i_FA3_4_35: full_adder
port map(
	a => d4_6(35),
	b => d4_7(35),
	cin => d4_8(35),
	s => d3_5(35),
	cout => d3_2(36)
);

i_FA1_4_36: full_adder
port map(
	a => d4_0(36),
	b => d4_1(36),
	cin => d4_2(36),
	s => d3_3(36),
	cout => d3_0(37)
);

i_FA2_4_36: full_adder
port map(
	a => d4_3(36),
	b => d4_4(36),
	cin => d4_5(36),
	s => d3_4(36),
	cout => d3_1(37)
);

i_HA1_5_36: half_adder
port map(
	a => d4_6(36),
	b => d4_7(36),
	s => d3_5(36),
	cout => d3_2(37)
);

i_FA1_4_37: full_adder
port map(
	a => d4_0(37),
	b => d4_1(37),
	cin => d4_2(37),
	s => d3_3(37),
	cout => d3_0(38)
);

i_FA2_4_37: full_adder
port map(
	a => d4_3(37),
	b => d4_4(37),
	cin => d4_5(37),
	s => d3_4(37),
	cout => d3_1(38)
);

d3_5(37) <= d4_6(37);

i_FA1_4_38: full_adder
port map(
	a => d4_0(38),
	b => d4_1(38),
	cin => d4_2(38),
	s => d3_2(38),
	cout => d3_0(39)
);

i_HA1_5_38: half_adder
port map(
	a => d4_3(38),
	b => d4_4(38),
	s => d3_3(38),
	cout => d3_1(39)
);

d3_4(38) <= d4_5(38);

d3_5(38) <= d4_6(38);

i_FA1_4_39: full_adder
port map(
	a => d4_0(39),
	b => d4_1(39),
	cin => d4_2(39),
	s => d3_2(39),
	cout => d3_0(40)
);

d3_3(39) <= d4_3(39);

d3_4(39) <= d4_4(39);

d3_5(39) <= d4_5(39);

i_HA1_5_40: half_adder
port map(
	a => d4_0(40),
	b => d4_1(40),
	s => d3_1(40),
	cout => d3_0(41)
);

d3_2(40) <= d4_2(40);

d3_3(40) <= d4_3(40);

d3_4(40) <= d4_4(40);

d3_5(40) <= d4_5(40);

d3_1(41) <= d4_0(41);

d3_2(41) <= d4_1(41);

d3_3(41) <= d4_2(41);

d3_4(41) <= d4_3(41);

d3_5(41) <= d4_4(41);

d3_0(42) <= d4_0(42);

d3_1(42) <= d4_1(42);

d3_2(42) <= d4_2(42);

d3_3(42) <= d4_3(42);

d3_4(42) <= d4_4(42);

d3_0(43) <= d4_0(43);

d3_1(43) <= d4_1(43);

d3_2(43) <= d4_2(43);

d3_3(43) <= d4_3(43);

d3_0(44) <= d4_0(44);

d3_1(44) <= d4_1(44);

d3_2(44) <= d4_2(44);

d3_3(44) <= d4_3(44);

d3_0(45) <= d4_0(45);

d3_1(45) <= d4_1(45);

d3_2(45) <= d4_2(45);

d3_0(46) <= d4_0(46);

d3_1(46) <= d4_1(46);

d3_2(46) <= d4_2(46);

d3_0(47) <= d4_0(47);

d3_1(47) <= d4_1(47);

d2_0(0) <= d3_0(0);

d2_1(0) <= d3_1(0);

d2_0(1) <= d3_0(1);

d2_0(2) <= d3_0(2);

d2_1(2) <= d3_1(2);

d2_2(2) <= d3_2(2);

d2_0(3) <= d3_0(3);

d2_1(3) <= d3_1(3);

d2_0(4) <= d3_0(4);

d2_1(4) <= d3_1(4);

d2_2(4) <= d3_2(4);

d2_3(4) <= d3_3(4);

d2_0(5) <= d3_0(5);

d2_1(5) <= d3_1(5);

d2_2(5) <= d3_2(5);

i_HA1_4_6: half_adder
port map(
	a => d3_0(6),
	b => d3_1(6),
	s => d2_0(6),
	cout => d2_0(7)
);

d2_1(6) <= d3_2(6);

d2_2(6) <= d3_3(6);

d2_3(6) <= d3_4(6);

i_HA1_4_7: half_adder
port map(
	a => d3_0(7),
	b => d3_1(7),
	s => d2_1(7),
	cout => d2_0(8)
);

d2_2(7) <= d3_2(7);

d2_3(7) <= d3_3(7);

i_FA1_3_8: full_adder
port map(
	a => d3_0(8),
	b => d3_1(8),
	cin => d3_2(8),
	s => d2_1(8),
	cout => d2_0(9)
);

i_HA1_4_8: half_adder
port map(
	a => d3_3(8),
	b => d3_4(8),
	s => d2_2(8),
	cout => d2_1(9)
);

d2_3(8) <= d3_5(8);

i_FA1_3_9: full_adder
port map(
	a => d3_0(9),
	b => d3_1(9),
	cin => d3_2(9),
	s => d2_2(9),
	cout => d2_0(10)
);

i_HA1_4_9: half_adder
port map(
	a => d3_3(9),
	b => d3_4(9),
	s => d2_3(9),
	cout => d2_1(10)
);

i_FA1_3_10: full_adder
port map(
	a => d3_0(10),
	b => d3_1(10),
	cin => d3_2(10),
	s => d2_2(10),
	cout => d2_0(11)
);

i_FA2_3_10: full_adder
port map(
	a => d3_3(10),
	b => d3_4(10),
	cin => d3_5(10),
	s => d2_3(10),
	cout => d2_1(11)
);

i_FA1_3_11: full_adder
port map(
	a => d3_0(11),
	b => d3_1(11),
	cin => d3_2(11),
	s => d2_2(11),
	cout => d2_0(12)
);

i_FA2_3_11: full_adder
port map(
	a => d3_3(11),
	b => d3_4(11),
	cin => d3_5(11),
	s => d2_3(11),
	cout => d2_1(12)
);

i_FA1_3_12: full_adder
port map(
	a => d3_0(12),
	b => d3_1(12),
	cin => d3_2(12),
	s => d2_2(12),
	cout => d2_0(13)
);

i_FA2_3_12: full_adder
port map(
	a => d3_3(12),
	b => d3_4(12),
	cin => d3_5(12),
	s => d2_3(12),
	cout => d2_1(13)
);

i_FA1_3_13: full_adder
port map(
	a => d3_0(13),
	b => d3_1(13),
	cin => d3_2(13),
	s => d2_2(13),
	cout => d2_0(14)
);

i_FA2_3_13: full_adder
port map(
	a => d3_3(13),
	b => d3_4(13),
	cin => d3_5(13),
	s => d2_3(13),
	cout => d2_1(14)
);

i_FA1_3_14: full_adder
port map(
	a => d3_0(14),
	b => d3_1(14),
	cin => d3_2(14),
	s => d2_2(14),
	cout => d2_0(15)
);

i_FA2_3_14: full_adder
port map(
	a => d3_3(14),
	b => d3_4(14),
	cin => d3_5(14),
	s => d2_3(14),
	cout => d2_1(15)
);

i_FA1_3_15: full_adder
port map(
	a => d3_0(15),
	b => d3_1(15),
	cin => d3_2(15),
	s => d2_2(15),
	cout => d2_0(16)
);

i_FA2_3_15: full_adder
port map(
	a => d3_3(15),
	b => d3_4(15),
	cin => d3_5(15),
	s => d2_3(15),
	cout => d2_1(16)
);

i_FA1_3_16: full_adder
port map(
	a => d3_0(16),
	b => d3_1(16),
	cin => d3_2(16),
	s => d2_2(16),
	cout => d2_0(17)
);

i_FA2_3_16: full_adder
port map(
	a => d3_3(16),
	b => d3_4(16),
	cin => d3_5(16),
	s => d2_3(16),
	cout => d2_1(17)
);

i_FA1_3_17: full_adder
port map(
	a => d3_0(17),
	b => d3_1(17),
	cin => d3_2(17),
	s => d2_2(17),
	cout => d2_0(18)
);

i_FA2_3_17: full_adder
port map(
	a => d3_3(17),
	b => d3_4(17),
	cin => d3_5(17),
	s => d2_3(17),
	cout => d2_1(18)
);

i_FA1_3_18: full_adder
port map(
	a => d3_0(18),
	b => d3_1(18),
	cin => d3_2(18),
	s => d2_2(18),
	cout => d2_0(19)
);

i_FA2_3_18: full_adder
port map(
	a => d3_3(18),
	b => d3_4(18),
	cin => d3_5(18),
	s => d2_3(18),
	cout => d2_1(19)
);

i_FA1_3_19: full_adder
port map(
	a => d3_0(19),
	b => d3_1(19),
	cin => d3_2(19),
	s => d2_2(19),
	cout => d2_0(20)
);

i_FA2_3_19: full_adder
port map(
	a => d3_3(19),
	b => d3_4(19),
	cin => d3_5(19),
	s => d2_3(19),
	cout => d2_1(20)
);

i_FA1_3_20: full_adder
port map(
	a => d3_0(20),
	b => d3_1(20),
	cin => d3_2(20),
	s => d2_2(20),
	cout => d2_0(21)
);

i_FA2_3_20: full_adder
port map(
	a => d3_3(20),
	b => d3_4(20),
	cin => d3_5(20),
	s => d2_3(20),
	cout => d2_1(21)
);

i_FA1_3_21: full_adder
port map(
	a => d3_0(21),
	b => d3_1(21),
	cin => d3_2(21),
	s => d2_2(21),
	cout => d2_0(22)
);

i_FA2_3_21: full_adder
port map(
	a => d3_3(21),
	b => d3_4(21),
	cin => d3_5(21),
	s => d2_3(21),
	cout => d2_1(22)
);

i_FA1_3_22: full_adder
port map(
	a => d3_0(22),
	b => d3_1(22),
	cin => d3_2(22),
	s => d2_2(22),
	cout => d2_0(23)
);

i_FA2_3_22: full_adder
port map(
	a => d3_3(22),
	b => d3_4(22),
	cin => d3_5(22),
	s => d2_3(22),
	cout => d2_1(23)
);

i_FA1_3_23: full_adder
port map(
	a => d3_0(23),
	b => d3_1(23),
	cin => d3_2(23),
	s => d2_2(23),
	cout => d2_0(24)
);

i_FA2_3_23: full_adder
port map(
	a => d3_3(23),
	b => d3_4(23),
	cin => d3_5(23),
	s => d2_3(23),
	cout => d2_1(24)
);

i_FA1_3_24: full_adder
port map(
	a => d3_0(24),
	b => d3_1(24),
	cin => d3_2(24),
	s => d2_2(24),
	cout => d2_0(25)
);

i_FA2_3_24: full_adder
port map(
	a => d3_3(24),
	b => d3_4(24),
	cin => d3_5(24),
	s => d2_3(24),
	cout => d2_1(25)
);

i_FA1_3_25: full_adder
port map(
	a => d3_0(25),
	b => d3_1(25),
	cin => d3_2(25),
	s => d2_2(25),
	cout => d2_0(26)
);

i_FA2_3_25: full_adder
port map(
	a => d3_3(25),
	b => d3_4(25),
	cin => d3_5(25),
	s => d2_3(25),
	cout => d2_1(26)
);

i_FA1_3_26: full_adder
port map(
	a => d3_0(26),
	b => d3_1(26),
	cin => d3_2(26),
	s => d2_2(26),
	cout => d2_0(27)
);

i_FA2_3_26: full_adder
port map(
	a => d3_3(26),
	b => d3_4(26),
	cin => d3_5(26),
	s => d2_3(26),
	cout => d2_1(27)
);

i_FA1_3_27: full_adder
port map(
	a => d3_0(27),
	b => d3_1(27),
	cin => d3_2(27),
	s => d2_2(27),
	cout => d2_0(28)
);

i_FA2_3_27: full_adder
port map(
	a => d3_3(27),
	b => d3_4(27),
	cin => d3_5(27),
	s => d2_3(27),
	cout => d2_1(28)
);

i_FA1_3_28: full_adder
port map(
	a => d3_0(28),
	b => d3_1(28),
	cin => d3_2(28),
	s => d2_2(28),
	cout => d2_0(29)
);

i_FA2_3_28: full_adder
port map(
	a => d3_3(28),
	b => d3_4(28),
	cin => d3_5(28),
	s => d2_3(28),
	cout => d2_1(29)
);

i_FA1_3_29: full_adder
port map(
	a => d3_0(29),
	b => d3_1(29),
	cin => d3_2(29),
	s => d2_2(29),
	cout => d2_0(30)
);

i_FA2_3_29: full_adder
port map(
	a => d3_3(29),
	b => d3_4(29),
	cin => d3_5(29),
	s => d2_3(29),
	cout => d2_1(30)
);

i_FA1_3_30: full_adder
port map(
	a => d3_0(30),
	b => d3_1(30),
	cin => d3_2(30),
	s => d2_2(30),
	cout => d2_0(31)
);

i_FA2_3_30: full_adder
port map(
	a => d3_3(30),
	b => d3_4(30),
	cin => d3_5(30),
	s => d2_3(30),
	cout => d2_1(31)
);

i_FA1_3_31: full_adder
port map(
	a => d3_0(31),
	b => d3_1(31),
	cin => d3_2(31),
	s => d2_2(31),
	cout => d2_0(32)
);

i_FA2_3_31: full_adder
port map(
	a => d3_3(31),
	b => d3_4(31),
	cin => d3_5(31),
	s => d2_3(31),
	cout => d2_1(32)
);

i_FA1_3_32: full_adder
port map(
	a => d3_0(32),
	b => d3_1(32),
	cin => d3_2(32),
	s => d2_2(32),
	cout => d2_0(33)
);

i_FA2_3_32: full_adder
port map(
	a => d3_3(32),
	b => d3_4(32),
	cin => d3_5(32),
	s => d2_3(32),
	cout => d2_1(33)
);

i_FA1_3_33: full_adder
port map(
	a => d3_0(33),
	b => d3_1(33),
	cin => d3_2(33),
	s => d2_2(33),
	cout => d2_0(34)
);

i_FA2_3_33: full_adder
port map(
	a => d3_3(33),
	b => d3_4(33),
	cin => d3_5(33),
	s => d2_3(33),
	cout => d2_1(34)
);

i_FA1_3_34: full_adder
port map(
	a => d3_0(34),
	b => d3_1(34),
	cin => d3_2(34),
	s => d2_2(34),
	cout => d2_0(35)
);

i_FA2_3_34: full_adder
port map(
	a => d3_3(34),
	b => d3_4(34),
	cin => d3_5(34),
	s => d2_3(34),
	cout => d2_1(35)
);

i_FA1_3_35: full_adder
port map(
	a => d3_0(35),
	b => d3_1(35),
	cin => d3_2(35),
	s => d2_2(35),
	cout => d2_0(36)
);

i_FA2_3_35: full_adder
port map(
	a => d3_3(35),
	b => d3_4(35),
	cin => d3_5(35),
	s => d2_3(35),
	cout => d2_1(36)
);

i_FA1_3_36: full_adder
port map(
	a => d3_0(36),
	b => d3_1(36),
	cin => d3_2(36),
	s => d2_2(36),
	cout => d2_0(37)
);

i_FA2_3_36: full_adder
port map(
	a => d3_3(36),
	b => d3_4(36),
	cin => d3_5(36),
	s => d2_3(36),
	cout => d2_1(37)
);

i_FA1_3_37: full_adder
port map(
	a => d3_0(37),
	b => d3_1(37),
	cin => d3_2(37),
	s => d2_2(37),
	cout => d2_0(38)
);

i_FA2_3_37: full_adder
port map(
	a => d3_3(37),
	b => d3_4(37),
	cin => d3_5(37),
	s => d2_3(37),
	cout => d2_1(38)
);

i_FA1_3_38: full_adder
port map(
	a => d3_0(38),
	b => d3_1(38),
	cin => d3_2(38),
	s => d2_2(38),
	cout => d2_0(39)
);

i_FA2_3_38: full_adder
port map(
	a => d3_3(38),
	b => d3_4(38),
	cin => d3_5(38),
	s => d2_3(38),
	cout => d2_1(39)
);

i_FA1_3_39: full_adder
port map(
	a => d3_0(39),
	b => d3_1(39),
	cin => d3_2(39),
	s => d2_2(39),
	cout => d2_0(40)
);

i_FA2_3_39: full_adder
port map(
	a => d3_3(39),
	b => d3_4(39),
	cin => d3_5(39),
	s => d2_3(39),
	cout => d2_1(40)
);

i_FA1_3_40: full_adder
port map(
	a => d3_0(40),
	b => d3_1(40),
	cin => d3_2(40),
	s => d2_2(40),
	cout => d2_0(41)
);

i_FA2_3_40: full_adder
port map(
	a => d3_3(40),
	b => d3_4(40),
	cin => d3_5(40),
	s => d2_3(40),
	cout => d2_1(41)
);

i_FA1_3_41: full_adder
port map(
	a => d3_0(41),
	b => d3_1(41),
	cin => d3_2(41),
	s => d2_2(41),
	cout => d2_0(42)
);

i_FA2_3_41: full_adder
port map(
	a => d3_3(41),
	b => d3_4(41),
	cin => d3_5(41),
	s => d2_3(41),
	cout => d2_1(42)
);

i_FA1_3_42: full_adder
port map(
	a => d3_0(42),
	b => d3_1(42),
	cin => d3_2(42),
	s => d2_2(42),
	cout => d2_0(43)
);

i_HA1_4_42: half_adder
port map(
	a => d3_3(42),
	b => d3_4(42),
	s => d2_3(42),
	cout => d2_1(43)
);

i_FA1_3_43: full_adder
port map(
	a => d3_0(43),
	b => d3_1(43),
	cin => d3_2(43),
	s => d2_2(43),
	cout => d2_0(44)
);

d2_3(43) <= d3_3(43);

i_HA1_4_44: half_adder
port map(
	a => d3_0(44),
	b => d3_1(44),
	s => d2_1(44),
	cout => d2_0(45)
);

d2_2(44) <= d3_2(44);

d2_3(44) <= d3_3(44);

d2_1(45) <= d3_0(45);

d2_2(45) <= d3_1(45);

d2_3(45) <= d3_2(45);

d2_0(46) <= d3_0(46);

d2_1(46) <= d3_1(46);

d2_2(46) <= d3_2(46);

d2_0(47) <= d3_0(47);

d2_1(47) <= d3_1(47);

d1_0(0) <= d2_0(0);

d1_1(0) <= d2_1(0);

d1_0(1) <= d2_0(1);

d1_0(2) <= d2_0(2);

d1_1(2) <= d2_1(2);

d1_2(2) <= d2_2(2);

d1_0(3) <= d2_0(3);

d1_1(3) <= d2_1(3);

i_HA1_3_4: half_adder
port map(
	a => d2_0(4),
	b => d2_1(4),
	s => d1_0(4),
	cout => d1_0(5)
);

d1_1(4) <= d2_2(4);

d1_2(4) <= d2_3(4);

i_HA1_3_5: half_adder
port map(
	a => d2_0(5),
	b => d2_1(5),
	s => d1_1(5),
	cout => d1_0(6)
);

d1_2(5) <= d2_2(5);

i_FA1_2_6: full_adder
port map(
	a => d2_0(6),
	b => d2_1(6),
	cin => d2_2(6),
	s => d1_1(6),
	cout => d1_0(7)
);

d1_2(6) <= d2_3(6);

i_FA1_2_7: full_adder
port map(
	a => d2_0(7),
	b => d2_1(7),
	cin => d2_2(7),
	s => d1_1(7),
	cout => d1_0(8)
);

d1_2(7) <= d2_3(7);

i_FA1_2_8: full_adder
port map(
	a => d2_0(8),
	b => d2_1(8),
	cin => d2_2(8),
	s => d1_1(8),
	cout => d1_0(9)
);

d1_2(8) <= d2_3(8);

i_FA1_2_9: full_adder
port map(
	a => d2_0(9),
	b => d2_1(9),
	cin => d2_2(9),
	s => d1_1(9),
	cout => d1_0(10)
);

d1_2(9) <= d2_3(9);

i_FA1_2_10: full_adder
port map(
	a => d2_0(10),
	b => d2_1(10),
	cin => d2_2(10),
	s => d1_1(10),
	cout => d1_0(11)
);

d1_2(10) <= d2_3(10);

i_FA1_2_11: full_adder
port map(
	a => d2_0(11),
	b => d2_1(11),
	cin => d2_2(11),
	s => d1_1(11),
	cout => d1_0(12)
);

d1_2(11) <= d2_3(11);

i_FA1_2_12: full_adder
port map(
	a => d2_0(12),
	b => d2_1(12),
	cin => d2_2(12),
	s => d1_1(12),
	cout => d1_0(13)
);

d1_2(12) <= d2_3(12);

i_FA1_2_13: full_adder
port map(
	a => d2_0(13),
	b => d2_1(13),
	cin => d2_2(13),
	s => d1_1(13),
	cout => d1_0(14)
);

d1_2(13) <= d2_3(13);

i_FA1_2_14: full_adder
port map(
	a => d2_0(14),
	b => d2_1(14),
	cin => d2_2(14),
	s => d1_1(14),
	cout => d1_0(15)
);

d1_2(14) <= d2_3(14);

i_FA1_2_15: full_adder
port map(
	a => d2_0(15),
	b => d2_1(15),
	cin => d2_2(15),
	s => d1_1(15),
	cout => d1_0(16)
);

d1_2(15) <= d2_3(15);

i_FA1_2_16: full_adder
port map(
	a => d2_0(16),
	b => d2_1(16),
	cin => d2_2(16),
	s => d1_1(16),
	cout => d1_0(17)
);

d1_2(16) <= d2_3(16);

i_FA1_2_17: full_adder
port map(
	a => d2_0(17),
	b => d2_1(17),
	cin => d2_2(17),
	s => d1_1(17),
	cout => d1_0(18)
);

d1_2(17) <= d2_3(17);

i_FA1_2_18: full_adder
port map(
	a => d2_0(18),
	b => d2_1(18),
	cin => d2_2(18),
	s => d1_1(18),
	cout => d1_0(19)
);

d1_2(18) <= d2_3(18);

i_FA1_2_19: full_adder
port map(
	a => d2_0(19),
	b => d2_1(19),
	cin => d2_2(19),
	s => d1_1(19),
	cout => d1_0(20)
);

d1_2(19) <= d2_3(19);

i_FA1_2_20: full_adder
port map(
	a => d2_0(20),
	b => d2_1(20),
	cin => d2_2(20),
	s => d1_1(20),
	cout => d1_0(21)
);

d1_2(20) <= d2_3(20);

i_FA1_2_21: full_adder
port map(
	a => d2_0(21),
	b => d2_1(21),
	cin => d2_2(21),
	s => d1_1(21),
	cout => d1_0(22)
);

d1_2(21) <= d2_3(21);

i_FA1_2_22: full_adder
port map(
	a => d2_0(22),
	b => d2_1(22),
	cin => d2_2(22),
	s => d1_1(22),
	cout => d1_0(23)
);

d1_2(22) <= d2_3(22);

i_FA1_2_23: full_adder
port map(
	a => d2_0(23),
	b => d2_1(23),
	cin => d2_2(23),
	s => d1_1(23),
	cout => d1_0(24)
);

d1_2(23) <= d2_3(23);

i_FA1_2_24: full_adder
port map(
	a => d2_0(24),
	b => d2_1(24),
	cin => d2_2(24),
	s => d1_1(24),
	cout => d1_0(25)
);

d1_2(24) <= d2_3(24);

i_FA1_2_25: full_adder
port map(
	a => d2_0(25),
	b => d2_1(25),
	cin => d2_2(25),
	s => d1_1(25),
	cout => d1_0(26)
);

d1_2(25) <= d2_3(25);

i_FA1_2_26: full_adder
port map(
	a => d2_0(26),
	b => d2_1(26),
	cin => d2_2(26),
	s => d1_1(26),
	cout => d1_0(27)
);

d1_2(26) <= d2_3(26);

i_FA1_2_27: full_adder
port map(
	a => d2_0(27),
	b => d2_1(27),
	cin => d2_2(27),
	s => d1_1(27),
	cout => d1_0(28)
);

d1_2(27) <= d2_3(27);

i_FA1_2_28: full_adder
port map(
	a => d2_0(28),
	b => d2_1(28),
	cin => d2_2(28),
	s => d1_1(28),
	cout => d1_0(29)
);

d1_2(28) <= d2_3(28);

i_FA1_2_29: full_adder
port map(
	a => d2_0(29),
	b => d2_1(29),
	cin => d2_2(29),
	s => d1_1(29),
	cout => d1_0(30)
);

d1_2(29) <= d2_3(29);

i_FA1_2_30: full_adder
port map(
	a => d2_0(30),
	b => d2_1(30),
	cin => d2_2(30),
	s => d1_1(30),
	cout => d1_0(31)
);

d1_2(30) <= d2_3(30);

i_FA1_2_31: full_adder
port map(
	a => d2_0(31),
	b => d2_1(31),
	cin => d2_2(31),
	s => d1_1(31),
	cout => d1_0(32)
);

d1_2(31) <= d2_3(31);

i_FA1_2_32: full_adder
port map(
	a => d2_0(32),
	b => d2_1(32),
	cin => d2_2(32),
	s => d1_1(32),
	cout => d1_0(33)
);

d1_2(32) <= d2_3(32);

i_FA1_2_33: full_adder
port map(
	a => d2_0(33),
	b => d2_1(33),
	cin => d2_2(33),
	s => d1_1(33),
	cout => d1_0(34)
);

d1_2(33) <= d2_3(33);

i_FA1_2_34: full_adder
port map(
	a => d2_0(34),
	b => d2_1(34),
	cin => d2_2(34),
	s => d1_1(34),
	cout => d1_0(35)
);

d1_2(34) <= d2_3(34);

i_FA1_2_35: full_adder
port map(
	a => d2_0(35),
	b => d2_1(35),
	cin => d2_2(35),
	s => d1_1(35),
	cout => d1_0(36)
);

d1_2(35) <= d2_3(35);

i_FA1_2_36: full_adder
port map(
	a => d2_0(36),
	b => d2_1(36),
	cin => d2_2(36),
	s => d1_1(36),
	cout => d1_0(37)
);

d1_2(36) <= d2_3(36);

i_FA1_2_37: full_adder
port map(
	a => d2_0(37),
	b => d2_1(37),
	cin => d2_2(37),
	s => d1_1(37),
	cout => d1_0(38)
);

d1_2(37) <= d2_3(37);

i_FA1_2_38: full_adder
port map(
	a => d2_0(38),
	b => d2_1(38),
	cin => d2_2(38),
	s => d1_1(38),
	cout => d1_0(39)
);

d1_2(38) <= d2_3(38);

i_FA1_2_39: full_adder
port map(
	a => d2_0(39),
	b => d2_1(39),
	cin => d2_2(39),
	s => d1_1(39),
	cout => d1_0(40)
);

d1_2(39) <= d2_3(39);

i_FA1_2_40: full_adder
port map(
	a => d2_0(40),
	b => d2_1(40),
	cin => d2_2(40),
	s => d1_1(40),
	cout => d1_0(41)
);

d1_2(40) <= d2_3(40);

i_FA1_2_41: full_adder
port map(
	a => d2_0(41),
	b => d2_1(41),
	cin => d2_2(41),
	s => d1_1(41),
	cout => d1_0(42)
);

d1_2(41) <= d2_3(41);

i_FA1_2_42: full_adder
port map(
	a => d2_0(42),
	b => d2_1(42),
	cin => d2_2(42),
	s => d1_1(42),
	cout => d1_0(43)
);

d1_2(42) <= d2_3(42);

i_FA1_2_43: full_adder
port map(
	a => d2_0(43),
	b => d2_1(43),
	cin => d2_2(43),
	s => d1_1(43),
	cout => d1_0(44)
);

d1_2(43) <= d2_3(43);

i_FA1_2_44: full_adder
port map(
	a => d2_0(44),
	b => d2_1(44),
	cin => d2_2(44),
	s => d1_1(44),
	cout => d1_0(45)
);

d1_2(44) <= d2_3(44);

i_FA1_2_45: full_adder
port map(
	a => d2_0(45),
	b => d2_1(45),
	cin => d2_2(45),
	s => d1_1(45),
	cout => d1_0(46)
);

d1_2(45) <= d2_3(45);

i_HA1_3_46: half_adder
port map(
	a => d2_0(46),
	b => d2_1(46),
	s => d1_1(46),
	cout => d1_0(47)
);

d1_2(46) <= d2_2(46);

d1_1(47) <= d2_0(47);

d1_2(47) <= d2_1(47);

i_HA1_2_0: half_adder
port map(
	a => d1_0(0),
	b => d1_1(0),
	s => d0_0(0),
	cout => d0_0(1)
);

d0_1(1) <= d1_0(1);

i_HA1_2_2: half_adder
port map(
	a => d1_0(2),
	b => d1_1(2),
	s => d0_0(2),
	cout => d0_0(3)
);

d0_1(2) <= d1_2(2);

i_HA1_2_3: half_adder
port map(
	a => d1_0(3),
	b => d1_1(3),
	s => d0_1(3),
	cout => d0_0(4)
);

i_FA1_1_4: full_adder
port map(
	a => d1_0(4),
	b => d1_1(4),
	cin => d1_2(4),
	s => d0_1(4),
	cout => d0_0(5)
);

i_FA1_1_5: full_adder
port map(
	a => d1_0(5),
	b => d1_1(5),
	cin => d1_2(5),
	s => d0_1(5),
	cout => d0_0(6)
);

i_FA1_1_6: full_adder
port map(
	a => d1_0(6),
	b => d1_1(6),
	cin => d1_2(6),
	s => d0_1(6),
	cout => d0_0(7)
);

i_FA1_1_7: full_adder
port map(
	a => d1_0(7),
	b => d1_1(7),
	cin => d1_2(7),
	s => d0_1(7),
	cout => d0_0(8)
);

i_FA1_1_8: full_adder
port map(
	a => d1_0(8),
	b => d1_1(8),
	cin => d1_2(8),
	s => d0_1(8),
	cout => d0_0(9)
);

i_FA1_1_9: full_adder
port map(
	a => d1_0(9),
	b => d1_1(9),
	cin => d1_2(9),
	s => d0_1(9),
	cout => d0_0(10)
);

i_FA1_1_10: full_adder
port map(
	a => d1_0(10),
	b => d1_1(10),
	cin => d1_2(10),
	s => d0_1(10),
	cout => d0_0(11)
);

i_FA1_1_11: full_adder
port map(
	a => d1_0(11),
	b => d1_1(11),
	cin => d1_2(11),
	s => d0_1(11),
	cout => d0_0(12)
);

i_FA1_1_12: full_adder
port map(
	a => d1_0(12),
	b => d1_1(12),
	cin => d1_2(12),
	s => d0_1(12),
	cout => d0_0(13)
);

i_FA1_1_13: full_adder
port map(
	a => d1_0(13),
	b => d1_1(13),
	cin => d1_2(13),
	s => d0_1(13),
	cout => d0_0(14)
);

i_FA1_1_14: full_adder
port map(
	a => d1_0(14),
	b => d1_1(14),
	cin => d1_2(14),
	s => d0_1(14),
	cout => d0_0(15)
);

i_FA1_1_15: full_adder
port map(
	a => d1_0(15),
	b => d1_1(15),
	cin => d1_2(15),
	s => d0_1(15),
	cout => d0_0(16)
);

i_FA1_1_16: full_adder
port map(
	a => d1_0(16),
	b => d1_1(16),
	cin => d1_2(16),
	s => d0_1(16),
	cout => d0_0(17)
);

i_FA1_1_17: full_adder
port map(
	a => d1_0(17),
	b => d1_1(17),
	cin => d1_2(17),
	s => d0_1(17),
	cout => d0_0(18)
);

i_FA1_1_18: full_adder
port map(
	a => d1_0(18),
	b => d1_1(18),
	cin => d1_2(18),
	s => d0_1(18),
	cout => d0_0(19)
);

i_FA1_1_19: full_adder
port map(
	a => d1_0(19),
	b => d1_1(19),
	cin => d1_2(19),
	s => d0_1(19),
	cout => d0_0(20)
);

i_FA1_1_20: full_adder
port map(
	a => d1_0(20),
	b => d1_1(20),
	cin => d1_2(20),
	s => d0_1(20),
	cout => d0_0(21)
);

i_FA1_1_21: full_adder
port map(
	a => d1_0(21),
	b => d1_1(21),
	cin => d1_2(21),
	s => d0_1(21),
	cout => d0_0(22)
);

i_FA1_1_22: full_adder
port map(
	a => d1_0(22),
	b => d1_1(22),
	cin => d1_2(22),
	s => d0_1(22),
	cout => d0_0(23)
);

i_FA1_1_23: full_adder
port map(
	a => d1_0(23),
	b => d1_1(23),
	cin => d1_2(23),
	s => d0_1(23),
	cout => d0_0(24)
);

i_FA1_1_24: full_adder
port map(
	a => d1_0(24),
	b => d1_1(24),
	cin => d1_2(24),
	s => d0_1(24),
	cout => d0_0(25)
);

i_FA1_1_25: full_adder
port map(
	a => d1_0(25),
	b => d1_1(25),
	cin => d1_2(25),
	s => d0_1(25),
	cout => d0_0(26)
);

i_FA1_1_26: full_adder
port map(
	a => d1_0(26),
	b => d1_1(26),
	cin => d1_2(26),
	s => d0_1(26),
	cout => d0_0(27)
);

i_FA1_1_27: full_adder
port map(
	a => d1_0(27),
	b => d1_1(27),
	cin => d1_2(27),
	s => d0_1(27),
	cout => d0_0(28)
);

i_FA1_1_28: full_adder
port map(
	a => d1_0(28),
	b => d1_1(28),
	cin => d1_2(28),
	s => d0_1(28),
	cout => d0_0(29)
);

i_FA1_1_29: full_adder
port map(
	a => d1_0(29),
	b => d1_1(29),
	cin => d1_2(29),
	s => d0_1(29),
	cout => d0_0(30)
);

i_FA1_1_30: full_adder
port map(
	a => d1_0(30),
	b => d1_1(30),
	cin => d1_2(30),
	s => d0_1(30),
	cout => d0_0(31)
);

i_FA1_1_31: full_adder
port map(
	a => d1_0(31),
	b => d1_1(31),
	cin => d1_2(31),
	s => d0_1(31),
	cout => d0_0(32)
);

i_FA1_1_32: full_adder
port map(
	a => d1_0(32),
	b => d1_1(32),
	cin => d1_2(32),
	s => d0_1(32),
	cout => d0_0(33)
);

i_FA1_1_33: full_adder
port map(
	a => d1_0(33),
	b => d1_1(33),
	cin => d1_2(33),
	s => d0_1(33),
	cout => d0_0(34)
);

i_FA1_1_34: full_adder
port map(
	a => d1_0(34),
	b => d1_1(34),
	cin => d1_2(34),
	s => d0_1(34),
	cout => d0_0(35)
);

i_FA1_1_35: full_adder
port map(
	a => d1_0(35),
	b => d1_1(35),
	cin => d1_2(35),
	s => d0_1(35),
	cout => d0_0(36)
);

i_FA1_1_36: full_adder
port map(
	a => d1_0(36),
	b => d1_1(36),
	cin => d1_2(36),
	s => d0_1(36),
	cout => d0_0(37)
);

i_FA1_1_37: full_adder
port map(
	a => d1_0(37),
	b => d1_1(37),
	cin => d1_2(37),
	s => d0_1(37),
	cout => d0_0(38)
);

i_FA1_1_38: full_adder
port map(
	a => d1_0(38),
	b => d1_1(38),
	cin => d1_2(38),
	s => d0_1(38),
	cout => d0_0(39)
);

i_FA1_1_39: full_adder
port map(
	a => d1_0(39),
	b => d1_1(39),
	cin => d1_2(39),
	s => d0_1(39),
	cout => d0_0(40)
);

i_FA1_1_40: full_adder
port map(
	a => d1_0(40),
	b => d1_1(40),
	cin => d1_2(40),
	s => d0_1(40),
	cout => d0_0(41)
);

i_FA1_1_41: full_adder
port map(
	a => d1_0(41),
	b => d1_1(41),
	cin => d1_2(41),
	s => d0_1(41),
	cout => d0_0(42)
);

i_FA1_1_42: full_adder
port map(
	a => d1_0(42),
	b => d1_1(42),
	cin => d1_2(42),
	s => d0_1(42),
	cout => d0_0(43)
);

i_FA1_1_43: full_adder
port map(
	a => d1_0(43),
	b => d1_1(43),
	cin => d1_2(43),
	s => d0_1(43),
	cout => d0_0(44)
);

i_FA1_1_44: full_adder
port map(
	a => d1_0(44),
	b => d1_1(44),
	cin => d1_2(44),
	s => d0_1(44),
	cout => d0_0(45)
);

i_FA1_1_45: full_adder
port map(
	a => d1_0(45),
	b => d1_1(45),
	cin => d1_2(45),
	s => d0_1(45),
	cout => d0_0(46)
);

i_FA1_1_46: full_adder
port map(
	a => d1_0(46),
	b => d1_1(46),
	cin => d1_2(46),
	s => d0_1(46),
	cout => d0_0(47)
);

i_FA1_1_47: full_adder
port map(
	a => d1_0(47),
	b => d1_1(47),
	cin => d1_2(47),
	s => d0_1(47),
	cout => d0_0(48)
);

sum_output <= d0_0(47) & d0_0(46) & d0_0(45) & d0_0(44) & d0_0(43) & d0_0(42) & d0_0(41) & d0_0(40) & d0_0(39) & d0_0(38) & d0_0(37) & d0_0(36) & d0_0(35) & d0_0(34) & d0_0(33) & d0_0(32) & d0_0(31) & d0_0(30) & d0_0(29) & d0_0(28) & d0_0(27) & d0_0(26) & d0_0(25) & d0_0(24) & d0_0(23) & d0_0(22) & d0_0(21) & d0_0(20) & d0_0(19) & d0_0(18) & d0_0(17) & d0_0(16) & d0_0(15) & d0_0(14) & d0_0(13) & d0_0(12) & d0_0(11) & d0_0(10) & d0_0(9) & d0_0(8) & d0_0(7) & d0_0(6) & d0_0(5) & d0_0(4) & d0_0(3) & d0_0(2) & d0_0(1) & d0_0(0);
carry_output <= d0_1(47) & d0_1(46) & d0_1(45) & d0_1(44) & d0_1(43) & d0_1(42) & d0_1(41) & d0_1(40) & d0_1(39) & d0_1(38) & d0_1(37) & d0_1(36) & d0_1(35) & d0_1(34) & d0_1(33) & d0_1(32) & d0_1(31) & d0_1(30) & d0_1(29) & d0_1(28) & d0_1(27) & d0_1(26) & d0_1(25) & d0_1(24) & d0_1(23) & d0_1(22) & d0_1(21) & d0_1(20) & d0_1(19) & d0_1(18) & d0_1(17) & d0_1(16) & d0_1(15) & d0_1(14) & d0_1(13) & d0_1(12) & d0_1(11) & d0_1(10) & d0_1(9) & d0_1(8) & d0_1(7) & d0_1(6) & d0_1(5) & d0_1(4) & d0_1(3) & d0_1(2) & d0_1(1) & '0';

end structural;