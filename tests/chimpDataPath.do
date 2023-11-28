vlib work

vlog chimpControlPath.v
vsim chimpControlPath

log -r /*

add wave -r /*

force {clk} 0 0ns, 1 0.25ns -r 0.5ns

force iLevel 5'd7;
run 1ns
force iRandNum 8'd27;
run 1ns
