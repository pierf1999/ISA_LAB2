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
	print(dots_cols)

	# open the file to be written
	file_tree = open("dadda_tree.vhd", "w")
	file_signals = open("dadda_tree_signals.vhd", "w")
	file_log = open("log.txt", "w")

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
	print(levels_height)

	# iterate to "solve" the tree
	# with i we iterate through the different levels
	for i in range(len(levels_height) - 1):
		# here I write the vhdl signals for the current level
		signals_vhdl = ""
		for k in range(levels_height[i]):
			# this seems a very complex line, but itis simply a possible way to find the required parallelism
			# for the signal representing the row (k) you are considering in this level (i)
			MSB_dot = 2*N_bits - numpy.where(numpy.array([dots - k for dots in dots_cols[::-1]])>0)[0][0]
			signals_vhdl += "signal d" + str(i) + "_" + str(k) + \
			": std_logic_vector(" + str(MSB_dot) + " downto 0);\n"
		file_signals.write(signals_vhdl)

		# This variable is needed to store the number of dots currently present in the considered column (j), but it
		# will be used in the next iteration (j+1). It's needed only in the vhdl writing for the part related to the
		# dots not covered by FAs and HAs, since after the instantiation of the FAs and HAs in this iteration,
		# the value of dots_cols[j+1] will be updated with the carries, but we will need the original value in the
		# next iteration (j+1).
		dots_actually_present_current_col = dots_cols[0]

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
			# dots to be compressed on the current columns: if <= 0, no dot to compress
			dots_to_compress = dots_cols[j] - levels_height[i+1]
			# this if clause is needed because of a special case regarding the LSB of the last level: at that point
			# will be convenient to instantiate an HA in order to save a RCA at the end, therefore with this if
			# we check which that condition has not been reached.
			if i != (len(levels_height) - 2) or j!=0:
				if dots_to_compress > 0:
					# we instatiate FAs and HAs
					FAs = int(dots_to_compress/2)
					HAs = int(dots_to_compress%2)
					print(str(i) + ", " + str(j) + ":\t\t" + "FAs: " + str(FAs) + ", HAs: " + str(HAs))
				else:
					print(str(i) + ", " + str(j) + ":\t\t" + "Nothing to do")
			else:
				# this is the special case in the last step, on the LSB: it's convenient to instantiate an HA in order to
				# save a RCA at the end
				FAs = 0
				HAs = 1
				print(str(i) + ", " + str(j) + ":\t\t" + "FAs: " + str(FAs) + ", HAs: " + str(HAs))

			# write the vhdl code of the FAs
			for k in range(FAs):
				FAs_vhdl += "i_FA" + str(k+1) + "_" + str(i) + "_" + str(j) + ": full_adder\nport map(" + \
				"\n\ta => d" + str(i) + "_" + str(offset_inputs + 3*k) + "(" + str(j) + ")"\
				",\n\tb => d" + str(i) + "_" + str(offset_inputs + 3*k + 1) + "(" + str(j) + ")"\
				",\n\tcin => d" + str(i) + "_" + str(offset_inputs + 3*k + 2) + "(" + str(j) + ")"\
				",\n\ts => d" + str(i+1) + "_" + str(offset_outputs_sum + k) + "(" + str(j) + ")"\
				",\n\tcout => d" + str(i+1) + "_" + str(offset_outputs_carry + k) + "(" + str(j+1) + ")"\
				"\n);\n\n"
			# offset_inputs equal to the dots already covered by the FAs
			offset_inputs += 3*FAs
			# offset_outputs equal to the output dots given as output for the next stage by FAs
			offset_outputs_sum += FAs
			offset_outputs_carry += FAs

			# write the vhdl code of the HAs
			for k in range(HAs):
				HAs_vhdl += "i_HA" + str(k+1) + "_" + str(i) + "_" + str(j) + ": half_adder\nport map(" + \
				"\n\ta => d" + str(i) + "_" + str(offset_inputs + 2*k) + "(" + str(j) + ")"\
				",\n\tb => d" + str(i) + "_" + str(offset_inputs + 2*k + 1) + "(" + str(j) + ")"\
				",\n\ts => d" + str(i+1) + "_" + str(offset_outputs_sum + k) + "(" + str(j) + ")"\
				",\n\tcout => d" + str(i+1) + "_" + str(offset_outputs_carry + k) + "(" + str(j+1) + ")"\
				"\n);\n\n"
			# offset_inputs equal to the dots already covered by the FAs+HAs
			offset_inputs += 2*HAs
			# offset_outputs equal to the output dots given as output for the next stage by FAs and HAs
			offset_outputs_sum += HAs
			offset_outputs_carry += HAs

			# write the vhdl code of the dots not covedered by neither FAs and HAs (here the variable
			# "dots_actually_present_current_col" is needed, as explained above)
			for k in range(dots_actually_present_current_col - 3*FAs - 2*HAs):
				remaining_dots_vhdl += "d" + str(i+1) + "_" + str(offset_outputs_sum + k) + "(" + str(j) + ") <= " \
				"d" + str(i) + "_" + str(offset_inputs + k) + "(" + str(j) + ")"\
				";\n\n"

			# write into the file
			file_tree.write(FAs_vhdl + HAs_vhdl + remaining_dots_vhdl)

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
		print("")
		
	# close files
	file_tree.close()
	file_signals.close()
	file_log.close()




def main():
	tree_generator(8)

if __name__ == '__main__':
	main()