import sys

# N: even number of input bits
N = 24

filename = "MBE_" + str(N) + "bit.vhd"
try:
    vhdl_file = open(filename, 'w')
except:
    print("ERROR: impossible opening file " + filename + "\n")
    sys.exit()
    
vhdl_file.write("""library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MBE_""" + str(N) + """BIT is
    port(
        A : in  std_logic_vector(""" + str(N - 1) + """ downto 0);
        B : in  std_logic_vector(""" + str(N - 1) + """ downto 0);
        P : out std_logic_vector(""" + str(2*N - 1) + """ downto 0));
end MBE_""" + str(N) + """BIT;

----------------------------------------------------------------------------------
--Architecture
-----------------------------------------------------------------------------------

architecture STRUCTURAL of MBE_""" + str(N) + """BIT is

    -------------------------------------------------------------------------------
    ---COMPONENTS------------------------------------------------------------------
    -------------------------------------------------------------------------------
    
    component bN_3to1mux
        generic(N : integer := 9);
        port(
            X, Y, Z : in  std_logic_vector(N - 1 downto 0);
            S       : in  std_logic_vector(1 downto 0);
            OUTPUT  : out std_logic_vector(N - 1 downto 0)
        );
    end component bN_3to1mux;

    component bN_2to1mux
        generic(N : positive := 8);
        port(
            x, y   : in  std_logic_vector(N - 1 downto 0);
            s      : in  std_logic;
            output : out std_logic_vector(N - 1 downto 0)
        );
    end component bN_2to1mux;

    component BRU
        port(
            BRU_input  : in  std_logic_vector(2 downto 0);
            BRU_output : out std_logic_vector(1 downto 0)
        );
    end component BRU;

    component xor_plane_n_bit
        generic(N : positive := 8);
        port(
            XOR_PLANE_N_BIT_IN_PP   : in  std_logic_vector(N - 1 downto 0);
            XOR_PLANE_N_BIT_IN_MULT : in  std_logic;
            XOR_PLANE_N_BIT_OUT     : out std_logic_vector(N - 1 downto 0)
        );
    end component xor_plane_n_bit;
    
    component PRECONDITIONING_""" + str(N) + """BIT
        port(
""");

for i in range(int(N/2)+1):
    if i != int(N/2):
        vhdl_file.write("            P" + str(i) + " : in  std_logic_vector(" + str(N) + " downto 0);\n")
    else:
        vhdl_file.write("            P" + str(i) + " : in  std_logic_vector(" + str(N - 1) + " downto 0);\n")
    if i != int(N/2):
        vhdl_file.write("            S" + str(i) + " : in  std_logic;\n")
        
parallelism_R = 2 * N
for i in range(int(N/2)+1):
    if i > 1:
        if i > 2 and i < int(N/2):
            parallelism_R = parallelism_R - 2
        else:
            parallelism_R = parallelism_R - 1
    vhdl_file.write("            R" + str(i) + " : out  std_logic_vector(" + str(parallelism_R - 1) + " downto 0)")
    if i != int(N/2):
        vhdl_file.write(";\n")
    else:
        vhdl_file.write("\n")

vhdl_file.write("        );")  
vhdl_file.write("""
    end component PRECONDITIONING_""" + str(N) + """BIT;
""")

vhdl_file.write("""
    component dadda_tree
        port(
""")

parallelism_R = 2 * N
for i in range(int(N/2)+1):
    if i > 1:
        if i > 2 and i < int(N/2):
            parallelism_R = parallelism_R - 2
        else:
            parallelism_R = parallelism_R - 1
    vhdl_file.write("            d5_" + str(i) + " : in  std_logic_vector(" + str(parallelism_R - 1) + " downto 0);\n")
vhdl_file.write("""            sum_output   : out std_logic_vector(47 downto 0);
            carry_output : out std_logic_vector(47 downto 0)
""")
vhdl_file.write("        );")  
vhdl_file.write("""
    end component dadda_tree;

""")

vhdl_file.write("""
    --------signals--------------------------------------
    signal B_dummy: std_logic_vector(""" + str(N + 2) + """ downto 0);
    signal SEL_BRU_MUX: std_logic_vector(""" + str(N + 1) + """ downto 0);
    signal PP_MUX_1C: std_logic_vector(""" + str(int(0.5 * (N**2) + (1.5 * N) - 1)) + """ downto 0);
    signal PP_1C_PRECOND : std_logic_vector(""" + str(int(0.5 * (N**2) + (1.5 * N) - 1)) + """ downto 0);
""")

parallelism_R = 2 * N
for i in range(int(N/2)+1):
    if i > 1:
        if i > 2 and i < int(N/2):
            parallelism_R = parallelism_R - 2
        else:
            parallelism_R = parallelism_R - 1
    vhdl_file.write("    signal R" + str(i) + " : std_logic_vector(" + str(parallelism_R - 1) + " downto 0);\n")
    
vhdl_file.write("""    signal SUM_DADDA_ADDER, CARRY_DADDA_ADDER : std_logic_vector(47 downto 0);

begin

    B_dummy <= "00" & B & '0';

    --N/2+1 BRU are needed, considering the zero padding of the multiplicand that is needed
    --when implementing a radix-4 algorithm  
    i_BRU_units_generate : for I in 0 to """ + str(int(N/2)) + """ generate
        i_BRU_I : BRU
            port map(
                BRU_input  => B_dummy(2 * I + 2 downto 2 * I),
                BRU_output => SEL_BRU_MUX(2 * I + 1 downto 2 * I));
    end generate i_BRU_units_generate;

    --we need N/2 MUX, for the first N/2 partial products, whose selector are taken from the output of the different
    --BRU units
    i_MUX_units_generate : for I in 0 to """ + str(int(N/2) - 1) + """ generate
        i_MUX_I : bN_3to1mux
            generic map(
                N => """ + str(N + 1) + """
            )
            port map(
                X                 => (OTHERS => '0'),
                Y(""" + str(N) + """ downto 1)     => A,
                Y(0)              => '0',
                Z(""" + str(N) + """)              => '0',
                Z(""" + str(N - 1) + """ downto 0) => A,
                S                 => SEL_BRU_MUX(2 * I + 1 downto 2 * I),
                OUTPUT            => PP_MUX_1C(""" + str(N + 1) + """ * I + """ + str(N) + """ downto """ + str(N + 1) + """ * I));
    end generate i_MUX_units_generate;

    --the last MUX can be simplified, considering a MUX with just two input, 0 and A
    i_last_MUX : bN_2to1mux
        generic map(
            N => """ + str(N) + """
        )
        port map(
            x      => (OTHERS => '0'),
            y      => A,
            s      => SEL_BRU_MUX(""" + str(N) + """), --the MSB-1 of the last BRU unit, the MSB is not needed, since
                                          --the inputs are limited to A and 0
            output => PP_MUX_1C(""" + str((N + 1) * int(N/2) + N - 1) + """ downto """ + str((N + 1) * int(N/2)) + """));

    i_XOR_units_generate : for I in 0 to """ + str(int(N/2) - 1) + """ generate
        i_XOR_plane_I : xor_plane_n_bit
            generic map(
                N => """ + str(N + 1) + """
            )
            port map(
                XOR_PLANE_N_BIT_IN_PP   => PP_MUX_1C(""" + str(N + 1) + """ * I + """ + str(N) + """ downto """ + str(N + 1) + """ * I),
                XOR_PLANE_N_BIT_IN_MULT => B_dummy(2 * I + 2),
                XOR_PLANE_N_BIT_OUT     => PP_1C_PRECOND(""" + str(N + 1) + """ * I + """ + str(N) + """ downto """ + str(N + 1) + """ * I)
            );
    end generate i_XOR_units_generate;
    
    PP_1C_PRECOND(""" + str((N + 1) * int(N/2) + N - 1) + """ downto """ + str((N + 1) * int(N/2)) + """) <= PP_MUX_1C(""" + str((N + 1) * int(N/2) + N - 1) + """ downto """ + str((N + 1) * int(N/2)) + """);
""")

vhdl_file.write("""
    i_PRECONDITIONING: PRECONDITIONING_""" + str(N) + """BIT
        port map(
""")

for i in range(int(N/2)+1):
    if i != int(N/2):
        vhdl_file.write("            P" + str(i) + " => PP_1C_PRECOND(" + str((N + 1) * i + N) + " downto " + str((N + 1) * i) + "),\n")
    else:
        vhdl_file.write("            P" + str(i) + " => PP_1C_PRECOND(" + str((N + 1) * i + N - 1) + " downto " + str((N + 1) * i) + "),\n")
    if i != int(N/2):
        vhdl_file.write("            S" + str(i) + " => B_dummy(" + str(2*i + 2) + "),\n")
        
parallelism_R = 2 * N
for i in range(int(N/2)+1):
    if i > 1:
        if i > 2 and i < int(N/2):
            parallelism_R = parallelism_R - 2
        else:
            parallelism_R = parallelism_R - 1
    vhdl_file.write("            R" + str(i) + " => R" + str(i))
    if i != int(N/2):
        vhdl_file.write(",\n")
    else:
        vhdl_file.write("\n")

vhdl_file.write("        );\n") 

vhdl_file.write("""
    i_DADDATREE: dadda_tree
            port map(
""")

parallelism_R = 2 * N
for i in range(int(N/2)+1):
    if i > 1:
        if i > 2 and i < int(N/2):
            parallelism_R = parallelism_R - 2
        else:
            parallelism_R = parallelism_R - 1
    vhdl_file.write("            d5_" + str(i) + " => R" + str(i) + ",\n")
vhdl_file.write("""            sum_output   => SUM_DADDA_ADDER,
            carry_output => CARRY_DADDA_ADDER
""")
vhdl_file.write("        );\n")  

vhdl_file.write("    P <= std_logic_vector(unsigned(SUM_DADDA_ADDER) + unsigned(CARRY_DADDA_ADDER));")

vhdl_file.write("\nend STRUCTURAL;")