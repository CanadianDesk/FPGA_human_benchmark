vlib work

vlog zMainMenu.v
vsim zMainMenu

log -r /*

add wave -r /*

force {clk} 0 0ns, 1 5ns -r 10ns


# Reset everything, output  
force i1 0;
force i2 0;
force iKey0 0;
run 10ns

# Test react mode
force i1 1;
run 20ns
force i1 0;
run 10ns

# Test chimp mode
force iKey0 1;
run 10ns
force iKey0 0;
run 10ns
force i2 1;
run 10ns

# Test Reset
force iKey0 1;
run 20ns
