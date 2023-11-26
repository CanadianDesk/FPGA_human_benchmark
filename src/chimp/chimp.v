// Chimp FSM Top-Level Module
// Jonah Diamond
// ECE241 Project

// INPUTS
//// 1. 1 bit, clock
//// 2. 1 bit, high if KEY0 pressed (will reset game to main menu)
//// 3. 2 bit, 10 if chimp game selected, otherwise don't care
// OUTPUTS
//// 1. 7 bit [ABCDEFG]: A - high if active, B - high if showing, low if hidden, C-G: 0-31 depending on what number is there

module chimp(input clk, iKey0, [1:0] iGameMode, iReset, output reg [6:0] board [2:0] [2:0] );
    wire [7:0] iRandNum;
    wire mousePressed;
    wire [2:0] BoxX, [2:0] BoxY;
    wire [9:0] mouseX, [8:0] mouseY;
    prng j0(.clk(clk), .iReset(iReset) .oOutput(iRandNum));
    PS2_Controller j1(.x_position(mouseX), .y_position(mouseY), .mousePressed(mousePressed));
    chimpMouseClick j2 (.iReset(iReset), .clk(clk), .mouseX(mouseX), .mouseY(mouseY),
         .BoxX(BoxX), .BoxY(BoxY));
    mainMenuKey j3(.iKey0(iKey0));
    chimpControlPath j4(.clk(clk), .iKey0(iKey0), .iEnter())
    //chimpControlPath();
endmodule