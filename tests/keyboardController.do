vlib work

vlog ../src/keyboardController.v

vsim keyboard_controller

log {/*}

add wave {/*}



#Simulate Enter key press

force {reset_n} 0
force {scan_code_ready} 1
force {scan_code} 8'h5A
force {clk} 0 0ns, 1 5ns -r 10ns
run 20ns


# Now simulate Enter key release (break code)
force {scan_code_ready} 1
force {scan_code} 8'hF0 
run 10ns 

force {scan_code_ready} 1
force {scan_code} 8'h5A 
run 10ns

# Clear the scan_code_ready to indicate the end of the scan code transmission
force {scan_code_ready} 0
run 10ns


#simulate space key press
force {reset_n} 0
force {scan_code_ready} 1
force {scan_code} 8'h29
force {clk} 0 0ns, 1 5ns -r 10ns
run 10ns








