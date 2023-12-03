// Chimp FSM Top-Level Module
// Jonah Diamond
// ECE241 Project

// INPUTS
//// 1. 1 bit, clock
//// 2. 1 bit, high if KEY0 pressed (will reset game to main menu)
//// 3. 1 bit, low if KEY[0] pressed
// OUTPUTS
//// 1. 8X8 bit of 7 bit [ABCDEFG]: A - high if active, B - high if showing, low if hidden, C-G: 0-31 depending on what number is there

module chimpTake2(clk, iReset, board, level);
    input clk, iReset;
    output reg [4:0] level;
    output reg [6:0] board [7:0] [7:0];
    reg [7:0] randNum;
    reg mouse, space, resetBoard, choseCorrectNum, choseWrongNum, loadEnable, doneLoad, showEnable;
    reg [2:0] BoxX, [2:0] BoxY;
    reg [9:0] mouseX, [8:0] mouseY;
    prng j11(.clk(clk), .iReset(iReset), .oOutput(randNum));
    ////find out real module and variable names
    MOUSE_PS2_Controller j12(.x_position(mouseX), .y_position(mouseY), .mousePressed(mouse));
    chimpTake2MouseClick j13 (.iReset(iReset), .clk(clk), .mouseX(mouseX), .mouseY(mouseY),
         .BoxX(BoxX), .BoxY(BoxY));
    ////find out real module and variable names
    Keyboard_PS2_Controller j14(.enter_pressed_out(enterPressed));
    chimpTake2ControlPath j15(.clk(clk), .iSpace(space), .iDoneLoad(doneLoad), .iReset(iReset), .iChoseCorrectNum(choseCorrectNum),
    .iChoseWrongNum(choseWrongNum), .oLevel(level), .oShowEnable(showEnable), .oLoadEnable(loadEnable), .oResetBoard(resetBoard));
    chimpTake2DataPath j16(.clk(clk), .iResetBoard(resetBoard), .iLoadEnable(loadEnable), .iShowEnable(showEnable), .iLevel(level), 
    .iRandNum(randNum), .iMouseClick(mouse), .oDoneLoad(doneLoad), .oChoseCorrectNum(choseCorrectNum), .oChoseWrongNum(choseWrongNum),
    .board(board), .iBoxX(BoxX), .iBoxY(BoxY));
endmodule