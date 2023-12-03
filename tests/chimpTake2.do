vlib work

vlog chimpControlPath.v
vsim chimpControlPath

log -r /*

add wave -r /*

force {clk} 0 0ns, 1 0.25ns -r 0.5ns

force iReset 1;
run 2ns
force iReset 0;
run 2ns
force space 1;
run 2ns
force space 0;
run 2ns