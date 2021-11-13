import sys

def initRows(r):
    for i in range(int(N/2) + 1):
        r.append("")
        
def initParallelism(parallelism):
    for i in range(int(N/2) + 1):
        if i == int(N/2):
            parallelism.append(N)
        else:
            parallelism.append(N + 1)
    print(parallelism)

def getRows():
    r = [] # list output rows
    parallelism = [] # parallelism partial product
    initRows(r)
    initParallelism(parallelism)
    for i in range(int(N/2) - 1, 1, -1):
        if i != 1:
            r[0] = r[0] + "not(S" + str(i) + ") & '1' & "
    r[0] = r[0] + "not(S0) & S0 & S0 & P0"
    for j in range(1, int(N/2) - 1):
        for i in range(int(N/2), j + 1, -1):
            if  j == 1 and i == int(N/2):
                r[j] = "P" + str(i) + "(" + str(parallelism[i] - 1) + ") & " 
                parallelism[i] = parallelism[i] - 1
            else:
                r[j] = r[j] + "P" + str(i) + "(" + str(parallelism[i] - 1) + " downto " + str(parallelism[i] - 2) + ") & "
                parallelism[i] = parallelism[i] - 2
        r[j] = r[j] + "P" + str(j + 1) + "(" + str(parallelism[j + 1] - 1) + ") & "
        parallelism[j + 1] = parallelism[j + 1] - 1
        if j == 1:
            r[j] = r[j] + "not(S1) & "
        r[j] = r[j] + "P" + str(j) + "(" + str(parallelism[j] - 1) + " downto 0) & '0' & S" + str(j - 1)
        if (j - 1) > 0:
            r[j] = r[j] + " & \"" + ("00" * (j - 1)) + "\""
    r[int(N/2) - 1] = "P" + str(int(N/2)) + "(" + str(parallelism[int(N/2)] - 1) + ") & P" + str(int(N/2) - 1) + "(" + str(parallelism[int(N/2) - 1] - 1) + " downto 0) & '0' & S" + str(int(N/2 - 2)) + " & \"" + ("00" * (int(N/2) - 2)) + "\""
    parallelism[int(N/2)] = parallelism[int(N/2)] - 1
    r[int(N/2)] = "P" + str(int(N/2)) + "(" + str(parallelism[int(N/2)] - 1) + " downto 0) & '0' & S" + str(int(N/2 - 1)) + " & \"" + ("00" * (int(N/2) - 1)) + "\""
    return r

# N: even number of input bits
N = 24

filename = "preconditioning_" + str(N) + "bit.vhd"
try:
    vhdl_file = open(filename, 'w')
except:
    print("ERROR: impossible opening file " + filename + "\n")
    sys.exit()
    
vhdl_file.write("""library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PRECONDITIONING_""" + str(N) + """BIT is
    port(
""")

for i in range(int(N/2)+1):
    if i != int(N/2):
        vhdl_file.write("    P" + str(i) + " : in  std_logic_vector(" + str(N) + " downto 0);\n")
    else:
        vhdl_file.write("    P" + str(i) + " : in  std_logic_vector(" + str(N - 1) + " downto 0);\n")
    if i != int(N/2):
        vhdl_file.write("    S" + str(i) + " : in  std_logic;\n")

parallelism_R = 2 * N
for i in range(int(N/2)+1):
    if i > 1:
        if i > 2 and i < int(N/2):
            parallelism_R = parallelism_R - 2
        else:
            parallelism_R = parallelism_R - 1
    vhdl_file.write("    R" + str(i) + " : out  std_logic_vector(" + str(parallelism_R - 1) + " downto 0);\n")

vhdl_file.write("    );")  
vhdl_file.write("""
end PRECONDITIONING_""" + str(N) + """BIT;

""")

vhdl_file.write("""
architecture STRUCTURAL of PRECONDITIONING_""" + str(N) + """BIT is
    
begin
    
""")

r = getRows()

for i in range(int(N/2)+1):
    vhdl_file.write("    R" + str(i) + " <= " + r[i] + ";\n") 
    
vhdl_file.write("\nend STRUCTURAL;")
    