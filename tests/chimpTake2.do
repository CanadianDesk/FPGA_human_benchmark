vlib work

vlog prng.v
vlog chimpTake2MouseClick.sv
vlog chimpTake2ControlPath.sv
vlog chimpTake2DataPath.sv
vlog chimpTake2.sv
vsim chimpTake2

log -r /*

add wave -r /*
add wave sim:/chimpTake2/j16/board


force {clk} 0 0ns, 1 0.1ns -r 0.2ns

force iReset 1;
force space 0;
run 2ns
force iReset 0;
run 2ns
force space 1;
run 2ns
force space 0;
run 20ns
force choseCorrectNum 1;
run 5ns
force choseCorrectNum 0;
run 8ns
force choseCorrectNum 1;
run 2ns
force choseCorrectNum 0;
run 2ns
force choseWrongNum 1;
run 2ns
