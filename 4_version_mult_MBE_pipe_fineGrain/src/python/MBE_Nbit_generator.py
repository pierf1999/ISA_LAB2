import sys

# N: even number of input bits
N = 24

filename = "MBE_Nbit.vhd"
try:
    vhdl_file = open(filename, 'w')
except:
    print("ERROR: impossible opening file " + filename + "\n")
    sys.exit()
    
vhdl_file.write("""library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MBE_Nbit is
    generic(N : positive := 8);
    port(
        A : in  std_logic_vector(N - 1 downto 0);
        B : in  std_logic_vector(N - 1 downto 0);
        P : out std_logic_vector(2 * N - 1 downto 0));
end MBE_Nbit;

architecture STRUCTURAL of MBE_Nbit is

    component bN_3to1mux
        generic(N : integer := 9);
        port(
            X, Y, Z : in  std_logic_vector(N - 1 downto 0);
            S       : in  std_logic_vector(1 downto 0);
            OUTPUT  : out std_logic_vector(N - 1 downto 0)
        );
    end component bN_3to1mux;

    component BRU
        port(
            BRU_input  : in  std_logic_vector(2 downto 0);
            BRU_output : out std_logic_vector(1 downto 0)
        );
    end component BRU;
    
    component PRECONDITIONING_24BIT
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
    vhdl_file.write("            R" + str(i) + " : out  std_logic_vector(" + str(parallelism_R - 1) + " downto 0);\n")

vhdl_file.write("        );")  
vhdl_file.write("""
    end component PRECONDITIONING_""" + str(N) + """BIT;

""")

################################# INSERISCI COMPONENT dadda_tree #################################

vhdl_file.write("""
    --------signals--------------------------------------
    signal ZERO : std_logic_vector(N downto 0) ;
    signal B_dummy: std_logic_vector(N+2 downto 0);
    signal SEL_BRU_MUX: std_logic_vector(N-2 downto 0);
    signal PP_MUX_1C: std_logic_vector(1/2*(N**2)+(3/2*N)+1 downto 0);
    signal """)

for i in range(int(N/2)+1):
    if i == int(N/2):
        vhdl_file.write("R" + str(i) + ";\n")
    else:
        vhdl_file.write("R" + str(i) + ", ")
    
vhdl_file.write("""

begin

""")

################################# ISTANZIAZIONE PRECONDITIONING #################################

vhdl_file.write("""
    i_PRECONDITIONING: PRECONDITIONING_24BIT
        port map(
""")

for i in range(int(N/2)+1):
    if i != int(N/2):
        vhdl_file.write("            P" + str(i) + " => P" + str(i) + ";\n")
    else:
        vhdl_file.write("            P" + str(i) + " => P" + str(i) + ";\n")
    if i != int(N/2):
        vhdl_file.write("            S" + str(i) + " => B_dummy(" + str(2*i + 2) + ");\n")
        
parallelism_R = 2 * N
for i in range(int(N/2)+1):
    if i > 1:
        if i > 2 and i < int(N/2):
            parallelism_R = parallelism_R - 2
        else:
            parallelism_R = parallelism_R - 1
    vhdl_file.write("            R" + str(i) + " => R" + str(i) + ";\n")

vhdl_file.write("        );\n") 

vhdl_file.write("\nend STRUCTURAL;")