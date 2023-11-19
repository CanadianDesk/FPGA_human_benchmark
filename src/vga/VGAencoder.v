
//TOP LEVEL MODULE FOR VGA ENCODER

//NEEDS INPUTS:
////1: 2 bits, 00 if Menu, 01 of React, 10 if Chimp


module zVGAencoder ( 
    input clk,
    input [1:0] iGameMode
);
    wire menuEnable, reactionEnable, chimpEnable;
    VGAcontrol u1(clk, iGameMode, menuEnable, reactionEnable, chimpEnable);
endmodule   