import numpy

def tree_generator(N_bits):
	if N_bits%2!=0:
		print("\nERROR:\nThe number of bits inserted is not even. Insert an even number of bits.\n")
		exit()

	# the number of the operands is computed assuming a Booth encoding on 3 bits at a time
	N_operands = int(N_bits/2+1)

	# write the initial number of dots in the columns starting from the LSB
	# (deprecated, we implemented an automatic way)
	#dots_cols = [2, 1, 3, 2, 4, 3, 5, 4, 5, 5, 5, 5, 4, 3, 3, 2, 0]

	# here the number of initial dots for each column is generated
	dots_cols = [2, 1]
	for i in range(N_bits - 2):
		dots_cols.append(dots_cols[i] + 1)
	dots_cols.extend(4*[N_operands])
	dots_cols.append(N_operands-1)
	for i in range(N_bits+5, 2*N_bits-1, 2):
		dots_cols.extend(2*[dots_cols[i-1] - 1])
	dots_cols.append(2)
	dots_cols.append(0)

	# open the file to be written
	file = open("dadda_tree.vhd", "w")

	# generate the maximum height for each level
	levels_height = [2]
	for elem in levels_height:
		if elem >= N_operands:
			break
		else:
			levels_height.append(int(3*elem/2))
	levels_height.reverse()
	# for the first level we do not use the maximum height admittable, but the actual height
	# that you have (number of operands)
	levels_height[0] = N_operands
	print("\nMaximum height for each level: " + str(levels_height) + "\n")

	entity_signals_vhdl = ""
	for k in range(levels_height[0]):
		# this seems a very complex line, but it is simply a possible way to find the required parallelism
		# for the signal representing the row (k) you are considering in this level (i)
		MSB_dot = 2*N_bits - numpy.where(numpy.array([dots - k for dots in dots_cols[::-1]])>0)[0][0]
		# the first level signals has to be instatiated in the entity, therefore the string is different
		entity_signals_vhdl += "\t\td" + str(len(levels_height) - 1) + "_" + str(k) + \
		" : in std_logic_vector(" + str(MSB_dot) + " downto 0);\n"
	# declare the output signals of the entity
	entity_signals_vhdl += "\t\tsum_output : out std_logic_vector(" + str(2*N_bits - 1) + " downto 0);\n"
	entity_signals_vhdl += "\t\tcarry_output : out std_logic_vector(" + str(2*N_bits - 1) + " downto 0)\n);"
	# complete the entity with the library declaration and other syntax stuffs
	entity_vhdl = "library ieee;\nuse ieee.std_logic_1164.all;\nuse ieee.numeric_std.all;\n\n" + \
	"entity dadda_tree is\n" + "\tport(\n" + entity_signals_vhdl + "\nend dadda_tree;\n\n\n"

	# write the string related to the declarative part in the architecture
	architecture_inst_vhdl = "architecture structural of dadda_tree is\n\n"
	architecture_inst_vhdl += "\tcomponent half_adder\n\t\tport(\n" + \
	"\t\t\ta : in std_logic;\n" + "\t\t\tb : in std_logic;\n" + "\t\t\ts : out std_logic;\n" + \
	"\t\t\tcout : out std_logic);\n" + \
	"\tend component;\n\n"
	architecture_inst_vhdl += "\tcomponent full_adder\n\tport(\n" + \
	"\t\t\ta : in std_logic;\n" + "\t\t\tb : in std_logic;\n" + "\t\t\tcin : in std_logic;\n" + \
	"\t\t\ts : out std_logic;\n" + "\t\t\tcout : out std_logic);\n" + \
	"\tend component;\n\n"

	# string initializations
	tree_vhdl = ""
	# iterate to "solve" the tree
	# with i we iterate through the different levels
	for i in range(len(levels_height) - 1):
		print("Number of dots per column (starting from the LSB): " + str(dots_cols))
		# define the current and next level index (5 is the upper one, 0 the bottom one)
		current_level = (len(levels_height)-1) - i
		next_level = current_level - 1

		# This variable is needed to store the number of dots currently present in the considered column (j), but it
		# will be used in the next iteration (j+1). It's needed only in the vhdl writing for the part related to the
		# dots not covered by FAs and HAs, since after the instantiation of the FAs and HAs in this iteration,
		# the value of dots_cols[j+1] will be updated with the carries, but we will need the original value in the
		# next iteration (j+1).
		dots_actually_present_current_col = dots_cols[0]

		# useful for the console printing
		FAs_total = 0
		HAs_total = 0

		# these variables are used in the vhdl writing part as a sort of indexes, together with i, j and k.
		offset_inputs = 0
		offset_outputs_sum = 0
		offset_outputs_carry = 0
		# with j we iterate through the columns of the current level to simplify it for the next level
		for j in range(len(dots_cols)-1):
			# initialization stuffs
			FAs = 0
			HAs = 0
			FAs_vhdl = ""
			HAs_vhdl = ""
			remaining_dots_vhdl = ""
			# this variable is useful during the vhdl files writing
			offset_inputs = 0
			# dots to be compressed on the current column
			# on the last level, when the height is already 2, no dots to compress, thus we need this if clause
			if i < (len(levels_height) - 1):
				dots_to_compress = dots_cols[j] - levels_height[i+1]
			else:
				dots_to_compress = 0
			# the following if clause is needed because of a special case regarding the LSB of the last level:
			# at that point will be convenient to instantiate an HA on the LSB in order to save a RCA at the end
			if next_level != 0 or j!=0:
				if dots_to_compress > 0:
					# we instatiate FAs and HAs
					FAs = int(dots_to_compress/2)
					HAs = int(dots_to_compress%2)
					print(str(current_level) + ", " + str(j) + ":\t\t" + "FAs: " + str(FAs) + ", HAs: " + str(HAs))
				else:
					print(str(current_level) + ", " + str(j) + ":\t\t" + "Nothing to do")
			else:
				# this is the special case in the last step, on the LSB: it's convenient to instantiate an HA in order to
				# save a RCA at the end
				FAs = 0
				HAs = 1
				print(str(current_level) + ", " + str(j) + ":\t\t" + "FAs: " + str(FAs) + ", HAs: " + str(HAs))
			# useful for the console printing
			FAs_total += FAs
			HAs_total += HAs

			# write the vhdl code of the FAs
			for k in range(FAs):
				FAs_vhdl += "i_FA" + str(k+1) + "_" + str(current_level) + "_" + str(j) + ": full_adder\nport map(" + \
				"\n\ta => d" + str(current_level) + "_" + str(offset_inputs + 3*k) + "(" + str(j) + ")"\
				",\n\tb => d" + str(current_level) + "_" + str(offset_inputs + 3*k + 1) + "(" + str(j) + ")"\
				",\n\tcin => d" + str(current_level) + "_" + str(offset_inputs + 3*k + 2) + "(" + str(j) + ")"\
				",\n\ts => d" + str(next_level) + "_" + str(offset_outputs_sum + k) + "(" + str(j) + ")"\
				",\n\tcout => d" + str(next_level) + "_" + str(offset_outputs_carry + k) + "(" + str(j+1) + ")"\
				"\n);\n\n"
			# offset_inputs equal to the dots already covered by the FAs
			offset_inputs += 3*FAs
			# offset_outputs equal to the output dots given as output for the next stage by FAs
			offset_outputs_sum += FAs
			offset_outputs_carry += FAs

			# write the vhdl code of the HAs
			for k in range(HAs):
				HAs_vhdl += "i_HA" + str(k+1) + "_" + str(len(levels_height) - i) + "_" + str(j) + ": half_adder\nport map(" + \
				"\n\ta => d" + str(current_level) + "_" + str(offset_inputs + 2*k) + "(" + str(j) + ")"\
				",\n\tb => d" + str(current_level) + "_" + str(offset_inputs + 2*k + 1) + "(" + str(j) + ")"\
				",\n\ts => d" + str(next_level) + "_" + str(offset_outputs_sum + k) + "(" + str(j) + ")"\
				",\n\tcout => d" + str(next_level) + "_" + str(offset_outputs_carry + k) + "(" + str(j+1) + ")"\
				"\n);\n\n"
			# offset_inputs equal to the dots already covered by the FAs+HAs
			offset_inputs += 2*HAs
			# offset_outputs equal to the output dots given as output for the next stage by FAs and HAs
			offset_outputs_sum += HAs
			offset_outputs_carry += HAs

			# write the vhdl code of the dots not covedered by neither FAs and HAs (here the variable
			# "dots_actually_present_current_col" is needed, as explained above)
			for k in range(dots_actually_present_current_col - 3*FAs - 2*HAs):
				remaining_dots_vhdl += "d" + str(next_level) + "_" + str(offset_outputs_sum + k) + "(" + str(j) + ") <= " \
				"d" + str(current_level) + "_" + str(offset_inputs + k) + "(" + str(j) + ")"\
				";\n\n"

			# string to be written into the file
			tree_vhdl += FAs_vhdl + HAs_vhdl + remaining_dots_vhdl

			# we update the number of dots of the current column in order to prepare it
			# for the next iteration
			dots_cols[j] -= 2*FAs + HAs
			# This variable is needed to store the number of dots currently stored in the column, since
			# after the instantiation of the FAs and HAs the value of dots_cols[j+1] will be updated with the
			# carries, but we need the original value in order to know how many dots are actually present, without
			# the carries. It's useful in the vhdl writing for the part related to the dots not covered by FAs and HAs.
			dots_actually_present_current_col = dots_cols[j+1]
			# the next column will have additional dots due to the carries of the FAs and HAs
			# instantiated before
			dots_cols[j+1] += FAs + HAs

			# this variable is referred to the number of dots on the current column already analyzed
			# (inputs because they are the inputs of FAs and HAs)
			offset_inputs = 0
			# here we store the number of carries generated by FAs and HAs. Since the carries are
			# instantiated in the FIRST positions of the next columns in the next level, when we will
			# analyze the next column of this level (j+1), we will take into account that there are carries.
			offset_outputs_sum = offset_outputs_carry
			offset_outputs_carry = 0

		# this print is just to better visualize the log on the console
		print("Total number of FAs: " + str(FAs_total))
		print("Total number of HAs: " + str(HAs_total) + "\n")
		# here I write the vhdl signals (to be instatiated in the architecture declarative part)
		# for the next level
		for k in range(levels_height[i+1]):
			# this seems a very complex line, but it is simply a possible way to find the required parallelism
			# for the signal representing the row (k) you are considering in this level (i)
			MSB_dot = 2*N_bits - numpy.where(numpy.array([dots - k for dots in dots_cols[::-1]])>0)[0][0]
			# these are the intermediate signals between the levels
			architecture_inst_vhdl += "\tsignal d" + str(next_level) + "_" + str(k) + \
			" : std_logic_vector(" + str(MSB_dot) + " downto 0);\n"

	# complete the architecture part
	architecture_inst_vhdl += "\nbegin\n\n"
	# assign the outputs starting from the MSB, as the vhdl syntax requires
	output_assignment_vhdl = "sum_output <= "
	for k in range(2*N_bits - 1, -1, -1):
		output_assignment_vhdl += "d0_0(" + str(k) + ")"
		if k > 0:
			output_assignment_vhdl += " & "
	output_assignment_vhdl += ";\n"

	output_assignment_vhdl += "carry_output <= "
	for k in range(2*N_bits - 1, 0, -1):
		output_assignment_vhdl += "d0_1(" + str(k) + ")"
		if k > 1:
			output_assignment_vhdl += " & "
	output_assignment_vhdl += " & '0';\n\n"

	# write all in the vhd file
	file.write(entity_vhdl + architecture_inst_vhdl + tree_vhdl + output_assignment_vhdl)
	file.write("end structural;")
	# close the file
	file.close()




def main():
	tree_generator(24)

if __name__ == '__main__':
	main()
