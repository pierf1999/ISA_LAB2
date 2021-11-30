In this section, we are performing two different logic synthesis of the fine grain pipeline structure:
   -Logic Synthesis with compile and optmize_register commands;
    -Logic Synthesis with compile ultra command;

The different folder are organized as usual.
Moreover, both in syn and in netlist/results folders we have two different scripts and two 
different sets of results for each of the three synthesis:

- no CLK pedix present :  just to find the maximum clock frequency of our design, forcing a 0 ns
 clock period. 
- CLK pedix present: we are synthetizing with 0 ns clock, but imposing the proper clock period in order to
find more accurate power's results;

Moreover, a "RetimingMoreRegisters" analysis has been performed, adding different 
layers of registers in order to see if there are any improvements in the design.