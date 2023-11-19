vlib work

vlog ../src/zMainMenu.v
vsim zMainMenu

log -r /*

add wave -r /*

force {clk} 0 0ns, 1 0.25ns -r 0.5ns


# Reset everything, output  
force i1 0;
force i2 0;
force iKey0 0;
run 1ns

# Test react mode
force i1 1;
run 5ns
force i1 0;
run 5ns

# Test chimp mode
force iKey0 1;
run 5ns
force iKey0 0;
run 5ns
force i2 1;
run 5ns
force i2 0;
run 5ns
run 20ns

# Test Reset
force iKey0 1;
run 20ns
