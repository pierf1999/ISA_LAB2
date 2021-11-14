d1_0(0) <= d0_0(0);

d1_1(0) <= d0_1(0);

d1_0(1) <= d0_0(1);

d1_0(2) <= d0_0(2);

d1_1(2) <= d0_1(2);

d1_2(2) <= d0_2(2);

d1_0(3) <= d0_0(3);

d1_1(3) <= d0_1(3);

d1_0(4) <= d0_0(4);

d1_1(4) <= d0_1(4);

d1_2(4) <= d0_2(4);

d1_3(4) <= d0_3(4);

d1_0(5) <= d0_0(5);

d1_1(5) <= d0_1(5);

d1_2(5) <= d0_2(5);

i_HA1_0_6: half_adder
port map(
	a => d0_0(6),
	b => d0_1(6),
	s => d1_0(6),
	cout => d1_0(7)
);

d1_1(6) <= d0_2(6);

d1_2(6) <= d0_3(6);

d1_3(6) <= d0_4(6);

i_HA1_0_7: half_adder
port map(
	a => d0_0(7),
	b => d0_1(7),
	s => d1_1(7),
	cout => d1_0(8)
);

d1_2(7) <= d0_2(7);

d1_3(7) <= d0_3(7);

i_FA1_0_8: full_adder
port map(
	a => d0_0(8),
	b => d0_1(8),
	cin => d0_2(8),
	s => d1_1(8),
	cout => d1_0(9)
);

d1_2(8) <= d0_3(8);

d1_3(8) <= d0_4(8);

i_FA1_0_9: full_adder
port map(
	a => d0_0(9),
	b => d0_1(9),
	cin => d0_2(9),
	s => d1_1(9),
	cout => d1_0(10)
);

d1_2(9) <= d0_3(9);

d1_3(9) <= d0_4(9);

i_FA1_0_10: full_adder
port map(
	a => d0_0(10),
	b => d0_1(10),
	cin => d0_2(10),
	s => d1_1(10),
	cout => d1_0(11)
);

d1_2(10) <= d0_3(10);

d1_3(10) <= d0_4(10);

i_FA1_0_11: full_adder
port map(
	a => d0_0(11),
	b => d0_1(11),
	cin => d0_2(11),
	s => d1_1(11),
	cout => d1_0(12)
);

d1_2(11) <= d0_3(11);

d1_3(11) <= d0_4(11);

i_HA1_0_12: half_adder
port map(
	a => d0_0(12),
	b => d0_1(12),
	s => d1_1(12),
	cout => d1_0(13)
);

d1_2(12) <= d0_2(12);

d1_3(12) <= d0_3(12);

d1_1(13) <= d0_0(13);

d1_2(13) <= d0_1(13);

d1_3(13) <= d0_2(13);

d1_0(14) <= d0_0(14);

d1_1(14) <= d0_1(14);

d1_2(14) <= d0_2(14);

d1_0(15) <= d0_0(15);

d1_1(15) <= d0_1(15);

d2_0(0) <= d1_0(0);

d2_1(0) <= d1_1(0);

d2_0(1) <= d1_0(1);

d2_0(2) <= d1_0(2);

d2_1(2) <= d1_1(2);

d2_2(2) <= d1_2(2);

d2_0(3) <= d1_0(3);

d2_1(3) <= d1_1(3);

i_HA1_1_4: half_adder
port map(
	a => d1_0(4),
	b => d1_1(4),
	s => d2_0(4),
	cout => d2_0(5)
);

d2_1(4) <= d1_2(4);

d2_2(4) <= d1_3(4);

i_HA1_1_5: half_adder
port map(
	a => d1_0(5),
	b => d1_1(5),
	s => d2_1(5),
	cout => d2_0(6)
);

d2_2(5) <= d1_2(5);

i_FA1_1_6: full_adder
port map(
	a => d1_0(6),
	b => d1_1(6),
	cin => d1_2(6),
	s => d2_1(6),
	cout => d2_0(7)
);

d2_2(6) <= d1_3(6);

i_FA1_1_7: full_adder
port map(
	a => d1_0(7),
	b => d1_1(7),
	cin => d1_2(7),
	s => d2_1(7),
	cout => d2_0(8)
);

d2_2(7) <= d1_3(7);

i_FA1_1_8: full_adder
port map(
	a => d1_0(8),
	b => d1_1(8),
	cin => d1_2(8),
	s => d2_1(8),
	cout => d2_0(9)
);

d2_2(8) <= d1_3(8);

i_FA1_1_9: full_adder
port map(
	a => d1_0(9),
	b => d1_1(9),
	cin => d1_2(9),
	s => d2_1(9),
	cout => d2_0(10)
);

d2_2(9) <= d1_3(9);

i_FA1_1_10: full_adder
port map(
	a => d1_0(10),
	b => d1_1(10),
	cin => d1_2(10),
	s => d2_1(10),
	cout => d2_0(11)
);

d2_2(10) <= d1_3(10);

i_FA1_1_11: full_adder
port map(
	a => d1_0(11),
	b => d1_1(11),
	cin => d1_2(11),
	s => d2_1(11),
	cout => d2_0(12)
);

d2_2(11) <= d1_3(11);

i_FA1_1_12: full_adder
port map(
	a => d1_0(12),
	b => d1_1(12),
	cin => d1_2(12),
	s => d2_1(12),
	cout => d2_0(13)
);

d2_2(12) <= d1_3(12);

i_FA1_1_13: full_adder
port map(
	a => d1_0(13),
	b => d1_1(13),
	cin => d1_2(13),
	s => d2_1(13),
	cout => d2_0(14)
);

d2_2(13) <= d1_3(13);

i_HA1_1_14: half_adder
port map(
	a => d1_0(14),
	b => d1_1(14),
	s => d2_1(14),
	cout => d2_0(15)
);

d2_2(14) <= d1_2(14);

d2_1(15) <= d1_0(15);

d2_2(15) <= d1_1(15);

i_HA1_2_0: half_adder
port map(
	a => d2_0(0),
	b => d2_1(0),
	s => d3_0(0),
	cout => d3_0(1)
);

d3_1(1) <= d2_0(1);

i_HA1_2_2: half_adder
port map(
	a => d2_0(2),
	b => d2_1(2),
	s => d3_0(2),
	cout => d3_0(3)
);

d3_1(2) <= d2_2(2);

i_HA1_2_3: half_adder
port map(
	a => d2_0(3),
	b => d2_1(3),
	s => d3_1(3),
	cout => d3_0(4)
);

i_FA1_2_4: full_adder
port map(
	a => d2_0(4),
	b => d2_1(4),
	cin => d2_2(4),
	s => d3_1(4),
	cout => d3_0(5)
);

i_FA1_2_5: full_adder
port map(
	a => d2_0(5),
	b => d2_1(5),
	cin => d2_2(5),
	s => d3_1(5),
	cout => d3_0(6)
);

i_FA1_2_6: full_adder
port map(
	a => d2_0(6),
	b => d2_1(6),
	cin => d2_2(6),
	s => d3_1(6),
	cout => d3_0(7)
);

i_FA1_2_7: full_adder
port map(
	a => d2_0(7),
	b => d2_1(7),
	cin => d2_2(7),
	s => d3_1(7),
	cout => d3_0(8)
);

i_FA1_2_8: full_adder
port map(
	a => d2_0(8),
	b => d2_1(8),
	cin => d2_2(8),
	s => d3_1(8),
	cout => d3_0(9)
);

i_FA1_2_9: full_adder
port map(
	a => d2_0(9),
	b => d2_1(9),
	cin => d2_2(9),
	s => d3_1(9),
	cout => d3_0(10)
);

i_FA1_2_10: full_adder
port map(
	a => d2_0(10),
	b => d2_1(10),
	cin => d2_2(10),
	s => d3_1(10),
	cout => d3_0(11)
);

i_FA1_2_11: full_adder
port map(
	a => d2_0(11),
	b => d2_1(11),
	cin => d2_2(11),
	s => d3_1(11),
	cout => d3_0(12)
);

i_FA1_2_12: full_adder
port map(
	a => d2_0(12),
	b => d2_1(12),
	cin => d2_2(12),
	s => d3_1(12),
	cout => d3_0(13)
);

i_FA1_2_13: full_adder
port map(
	a => d2_0(13),
	b => d2_1(13),
	cin => d2_2(13),
	s => d3_1(13),
	cout => d3_0(14)
);

i_FA1_2_14: full_adder
port map(
	a => d2_0(14),
	b => d2_1(14),
	cin => d2_2(14),
	s => d3_1(14),
	cout => d3_0(15)
);

i_FA1_2_15: full_adder
port map(
	a => d2_0(15),
	b => d2_1(15),
	cin => d2_2(15),
	s => d3_1(15),
	cout => d3_0(16)
);

