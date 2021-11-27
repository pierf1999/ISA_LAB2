library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- M levels of pipeline
-- register to store std_logic_vector

entity reg_N_level_rst_n is
	generic(
		M : positive := 5;
		N : positive := 1               -- pipeline level
	);
	port(
		D     : in  std_logic_vector(M - 1 downto 0);
		clk   : in  std_logic;
		rst_n : in  std_logic;
		Q     : out std_logic_vector(M - 1 downto 0)
	);
end entity reg_N_level_rst_n;

architecture structure of reg_N_level_rst_n is

	component REG_RST_N
		generic(N : positive := 32);
		port(
			D     : in  std_logic_vector(N - 1 downto 0);
			RST_N : in  std_logic;
			CLK   : in  std_logic;
			Q     : out std_logic_vector(N - 1 downto 0)
		);
	end component REG_RST_N;

	type matrix is array (N downto 0) of std_logic_vector(M - 1 downto 0);
	signal Q_temp : matrix;             -- array of M + 1 elements, because the first one corresponds to the input D

begin

	Q_temp(0) <= D;

	G : for i in 0 to N - 1 generate
		r : REG_RST_N
			generic map(
				N => M
			)
			port map(
				D     => Q_temp(i),
				RST_N => rst_n,
				CLK   => clk,
				Q     => Q_temp(i + 1)
			);
	end generate;

	Q <= Q_temp(N);

end architecture structure;
