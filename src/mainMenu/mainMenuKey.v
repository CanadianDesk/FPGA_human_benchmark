// Main Menu Key
// Jonah Diamond
// ECE241 Project

// INPUTS
//// 1. 1 bit, output of whether KEY[0] is pressed
// OUTPUTS
////

module mainMenuKey(input KEY[0]);
    mainMenu mM(.iKey0(KEY[0]));
endmodule