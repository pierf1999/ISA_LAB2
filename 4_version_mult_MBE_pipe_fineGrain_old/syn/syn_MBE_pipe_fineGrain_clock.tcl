# analysis of vhdl files
analyze -f vhdl -lib WORK ../src/bN_2to1mux.vhd
analyze -f vhdl -lib WORK ../src/bN_mux3to1.vhd
analyze -f vhdl -lib WORK ../src/BRU.vhd
analyze -f vhdl -lib WORK ../src/dadda_tree.vhd
analyze -f vhdl -lib WORK ../src/full_adder.vhd
analyze -f vhdl -lib WORK ../src/half_adder.vhd
analyze -f vhdl -lib WORK ../src/MBE_24bit.vhd
analyze -f vhdl -lib WORK ../src/preconditioning_24bit.vhd
analyze -f vhdl -lib WORK ../src/xor_plane_n_bit.vhd

analyze -f vhdl -lib WORK ../src/common_file/unpackfp_unpackfp.vhd
analyze -f vhdl -lib WORK ../src/common_file/reg_en_rst_n.vhd
analyze -f vhdl -lib WORK ../src/common_file/packfp_packfp.vhd
analyze -f vhdl -lib WORK ../src/common_file/fpnormalize_fpnormalize.vhd
analyze -f vhdl -lib WORK ../src/common_file/fpround_fpround.vhd
analyze -f vhdl -lib WORK ../src/common_file/fpmul_stage1_struct.vhd
analyze -f vhdl -lib WORK ../src/common_file/fpmul_stage2_struct.vhd
analyze -f vhdl -lib WORK ../src/common_file/fpmul_stage3_struct.vhd
analyze -f vhdl -lib WORK ../src/common_file/fpmul_stage4_struct.vhd
analyze -f vhdl -lib WORK ../src/common_file/fpmul_pipeline.vhd

set power_preserve_rtl_hier_names true

# elaboration
elaborate FPmul -arch pipeline -lib WORK

# clock creation
create_clock -name MY_CLK -period 0 {clk}
set_dont_touch_network MY_CLK
set_fix_hold [get_clocks MY_CLK]
set_clock_uncertainty 0.07 [get_clocks MY_CLK]
set_input_delay 0.5 -max -clock MY_CLK [remove_from_collection [all_inputs] clk]
set_output_delay 0.5 -max -clock MY_CLK [all_outputs]
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]

# compilation
compile -exact_map 
optimize_registers

create_clock -name MY_CLK -period 0.83 {clk}

# ddc file saving
write -hierarchy -format ddc -output ../netlist/ddc_files/FP_MBE_fine_grain_pipe.ddc

# report
report_power > ../netlist/results/FP_MBE_fine_grain_pipe_clock/power.txt
report_power -net > ../netlist/results/FP_MBE_fine_grain_pipe_clock/power_net.txt
report_power -hier > ../netlist/results/FP_MBE_fine_grain_pipe_clock/power_hier.txt
report_timing > ../netlist/results/FP_MBE_fine_grain_pipe_clock/timing.txt
report_area -hierarchy > ../netlist/results/FP_MBE_fine_grain_pipe_clock/area.txt
report_resources > ../netlist/results/FP_MBE_fine_grain_pipe_clock/resources.txt

