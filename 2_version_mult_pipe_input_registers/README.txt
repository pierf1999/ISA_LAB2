In this section, we are performing three different logic synthesis:
    -Logic Synthesis without forced implementation;
    -Logic Synthesis forcing the CSA implementation;
    -Logic Synthesis forcing the PPARCH implementation;

The different folder are organized as usual.
Moreover, both in syn and in netlist/results folders we have two different scripts and two 
different sets of results for each of the three synthesis:

- no CLK pedix present :  just to find the maximum clock frequency of our design, forcing a 0 ns
 clock period. 
- CLK pedix present: we are synthetizing with 0 ns clock, but imposing the proper clock period in order to
find more accurate power's results;