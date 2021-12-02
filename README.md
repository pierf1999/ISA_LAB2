# ISA_LAB2
This is the main folder for the second Laboratory of the Integrated System Architecture course.
The second LAB is based on the design and the implementation of FP multiplier, first
with a multiplier behavioral and then inserting a  MBE multiplier.

We have four different folders here:
-  images is just a folder in which have been collected
all the different .jpg and .gif files, representing the two different devices at the schematic and the layout level.
Also waveform picture and VHDL sketch are here collected;

- 1_version_mult_pipe: the first version of the FP multiplier, analyze as it was provide to us;

- 2_version_mult_pipe_input_registers: the second version of the FP multiplier, with input registers added;

- 3_version_mult_pipe_fineGrain: the third version of the FP multiplier, applying an additional level of pipe
where requested, and applying the Synopsys command required;

-4_version_mult_MBE_pipe_fineGrain: the fourth version of the FP multiplier, substituting the behavioral multiplier
with the MBE.
Here, different folders are present, to distinguish the different case analyzed:
	- 1 level of pipe
	- 1 level of pipe with all the architecture flatten
	- 1 level of pipe with only the MBE flatten
	- 2 level of pipe
	- 2 level of pipe with all the architecture flatten
	- 2 level of pipe with only the MBE flatten

Then, each of the two folder has been organized almost in the same way, following the directives
of the Laboratories file.
Furthere README files are present in the different folders.
