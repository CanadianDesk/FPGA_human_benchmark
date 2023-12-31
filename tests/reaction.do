vlib work

vlog ../src/reaction/reaction.v
vlog ../src/reaction/reactionControl.v
vlog ../src/reaction/reactionData.v
vlog ../src/prng/prng.v

vsim reaction

log -r /*

add wave -r /*


force {clk} 0 0ns, 1 10ns -r 20ns



force {iReset} 1
force {spacePressed} 0
force {onePressed} 0

run 1ms


force {iReset} 0
run 1ms

#THE PROGRAM IS NOW IN THE RESET STATE. HOPEFULLY, THE FSM IS IN THE READY STATE

force {spacePressed} 1
run 1ms
force {spacePressed} 0

#SHOULD NOW BE IN THE NEXT STATE, RED

run 2000ms

# WAITED 2 SECONDS