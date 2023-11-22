vlib work

vlog chimpControlPath.v
vsim chimpControlPath

log -r /*

add wave -r /*

force {clk} 0 0ns, 1 0.25ns -r 0.5ns

force level 5'd4

# Go into LOAD_1, LOAD_2, LOAD_3, LOAD_4, and then START_GAME
force iEnter 1; 
run 10ns
force iPressNum 6'd1;
run 0.5ns
# should go into CHOOSE_2
force iPressNum 6'd0;
run 0.5ns
 