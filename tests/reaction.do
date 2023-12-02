vlib work

vlog ../src/reaction/reaction.v
vlog ../src/reaction/reactionControl.v
vlog ../src/reaction/reactionData.v
vlog ../src/prng/prng.v

vsim reaction

log -r /*

add wave -r /*


force {clk} 0 0ns, 1 1ns -r 2ns



force {iReset} 1
force {spacePressed} 0
force {onePressed} 0

run 10ms


force {iReset} 0
run 10mns

#THE PROGRAM IS NOW IN THE RESET STATE. HOPEFULLY, THE FSM IS IN THE READY STATE

force {spacePressed} 1
run 10ms
force {spacePressed} 0

#SHOULD NOW BE IN THE NEXT STATE, RED

run 2000ms

# WAITED 2 SECONDS