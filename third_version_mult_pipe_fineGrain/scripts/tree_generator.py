'''
BUG TO BE SOLVED:
The sum and carry bits fall in the same position sometimes because we should allocate one at the beginning
and one at the end. Could we use a list with append?
'''


import numpy as np

def main():
	# write the initial number of dots in the columns starting from the LSB
	dots_cols = [2, 1, 3, 2, 4, 3, 5, 4, 5, 5, 5, 5, 4, 3, 3, 2, 0]
	N_operands = max(dots_cols)
	levels_max_height = [2]

	# open the file to be written
	file = open("dadda_tree.txt", "w")

	# generate the maximum height for each level
	for elem in levels_max_height:
		if elem >= N_operands:
			break
		else:
			levels_max_height.append(int(3*elem/2))
	levels_max_height.reverse()
	print(levels_max_height)

	# iterate to "solve" the tree
	# with i we iterate through the different levels needed
	for i in range(1, len(levels_max_height)):
		# This variable is needed to store the number of dots currently stored in the column, since
		# after the instantiation of the FAs and HAs the value of dots_cols[j+1] will be updated with the
		# carries, but we need the original value in order to know how many dots are actually present, without
		# the carries. It's useful in the vhdl writing for the part related to the dots not covered by FAs and HAs.
		dots_actually_present_current_col = dots_cols[0]

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
			# this variable is useful during the vhdl files "writing"
			offset_inputs = 0
			# dots to be compressed on the current columns: if <= 0, no dot to compress
			dots_to_compress = dots_cols[j] - levels_max_height[i]
			if i < (len(levels_max_height) - 1) or j!=0:
				if dots_to_compress > 0:
					# we instatiate FAs and HAs
					FAs = int(dots_to_compress/2)
					HAs = int(dots_to_compress%2)
					print(str(i) + ", " + str(j) + ":\t\t" + "FAs: " + str(FAs) + ", HAs: " + str(HAs))
				else:
					print(str(i) + ", " + str(j) + ":\t\t" + "Nothing to do")
			else:
				# this is a special case in the last step, on the LSB: it's convenient to instantiate an HA in order to
				# save a RCA at the end
				FAs = 0
				HAs = 1
				print(str(i) + ", " + str(j) + ":\t\t" + "FAs: " + str(FAs) + ", HAs: " + str(HAs))

			for k in range(FAs):
				FAs_vhdl += "i_FA" + str(k+1) + "_" + str(i) + "_" + str(j) + ": full_adder\nport map(" + \
				"\n\ta => d" + str(i) + "_" + str(j) + "_" + str(offset_inputs + 3*k) + \
				",\n\tb => d" + str(i) + "_" + str(j) + "_" + str(offset_inputs + 3*k + 1) + \
				",\n\tcin => d" + str(i) + "_" + str(j) + "_" + str(offset_inputs + 3*k + 2) + \
				",\n\ts => d" + str(i+1) + "_" + str(j) + "_" + str(offset_outputs_sum + k) + \
				",\n\tcout => d" + str(i+1) + "_" + str(j+1) + "_" + str(offset_outputs_carry + k) + \
				"\n);\n\n"
			# offset_inputs equal to the dots already covered by the FAs
			offset_inputs += 3*FAs
			# offset_outputs equal to the output dots given as output for the next stage by FAs
			offset_outputs_sum += FAs
			offset_outputs_carry += FAs

			for k in range(HAs):
				HAs_vhdl += "i_HA" + str(k+1) + "_" + str(i) + "_" + str(j) + ": half_adder\nport map(" + \
				"\n\ta => d" + str(i) + "_" + str(j) + "_" + str(offset_inputs + 2*k) + \
				",\n\tb => d" + str(i) + "_" + str(j) + "_" + str(offset_inputs + 2*k + 1) + \
				",\n\ts => d" + str(i+1) + "_" + str(j) + "_" + str(offset_outputs_sum + k) + \
				",\n\tcout => d" + str(i+1) + "_" + str(j+1) + "_" + str(offset_outputs_carry + k) + \
				"\n);\n\n"
			# offset_inputs equal to the dots already covered by the FAs+HAs
			offset_inputs += 2*HAs
			# offset_outputs equal to the output dots given as output for the next stage by FAs and HAs
			offset_outputs_sum += HAs
			offset_outputs_carry += HAs

			for k in range(dots_actually_present_current_col - 3*FAs - 2*HAs):
				remaining_dots_vhdl += "d" + str(i+1) + "_" + str(j) + "_" + str(offset_outputs_sum + k) + " <= " \
				"d" + str(i) + "_" + str(j) + "_" + str(offset_inputs + k) + \
				";\n\n"

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

			file.write(FAs_vhdl + HAs_vhdl + remaining_dots_vhdl)
		print("")

	file.close();

if __name__ == '__main__':
	main()



'''
I_HA: half_adder 
        port map( 
            a    => a, 
            b    => b, 
            s    => s, 
            cout => cout 
        ); 
         
I_FA: full_adder 
        port map( 
	        a    => a, 
	        b    => b, 
	        cin  => cin, 
	        s    => s, 
	        cout => cout 
        );
'''