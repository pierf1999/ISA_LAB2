# analysis of vhdl files
analyze -f vhdl -lib WORK ../src/reg_en_rst_n.vhd
analyze -f vhdl -lib WORK ../src/unpackfp_unpackfp.vhd
analyze -f vhdl -lib WORK ../src/packfp_packfp.vhd
analyze -f vhdl -lib WORK ../src/fpnormalize_fpnormalize.vhd
analyze -f vhdl -lib WORK ../src/fpround_fpround.vhd
analyze -f vhdl -lib WORK ../src/fpmul_stage1_struct.vhd
analyze -f vhdl -lib WORK ../src/fpmul_stage2_struct.vhd
analyze -f vhdl -lib WORK ../src/fpmul_stage3_struct.vhd
analyze -f vhdl -lib WORK ../src/fpmul_stage4_struct.vhd
analyze -f vhdl -lib WORK ../src/fpmul_pipeline.vhd

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
ungroup -all -flatten
set_implementation DW02_mult/csa [find cell *mult*]
compile -exact_map 

# ddc file saving
write -hierarchy -format ddc -output ../netlist/ddc_files/FP_mul_flatten_CSA.ddc

# report
report_power > ../netlist/results/FP_mul_flatten_CSA/power.txt
report_power -net > ../netlist/results/FP_mul_flatten_CSA/power_net.txt
report_power -hier > ../netlist/results/FP_mul_flatten_CSA/power_hier.txt
report_timing > ../netlist/results/FP_mul_flatten_CSA/timing.txt
report_area -hierarchy > ../netlist/results/FP_mul_flatten_CSA/area.txt
report_resources > ../netlist/results/FP_mul_flatten_CSA/resources.txt
