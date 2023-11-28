// Chimp FSM Top-Level Module
// Jonah Diamond
// ECE241 Project

// INPUTS
//// 1. 1 bit, clock
//// 2. 1 bit, high if KEY0 pressed (will reset game to main menu)
// OUTPUTS
//// 1. 7 bit [ABCDEFG]: A - high if active, B - high if showing, low if hidden, C-G: 0-31 depending on what number is there

module chimp(input clk, iKey0, iReset, output reg [6:0] board[2:0][2:0]);
    wire [7:0] iRandNum;
    wire mousePressed, enterPressed, resetBoard, choseCorrectNum, choseWrongNum, loadEnable, doneLoad;
    wire [4:0] numToLoad, [4:0] numToChoose;
    wire [4:0] level;
    wire [2:0] BoxX, [2:0] BoxY;
    wire [9:0] mouseX, [8:0] mouseY;
    prng j0(.clk(clk), .iReset(iReset) .oOutput(iRandNum));
    MOUSE_PS2_Controller j1(.x_position(mouseX), .y_position(mouseY), .mousePressed(mousePressed));
    Keyboard_PS2_Controller j2(.enter_pressed_out(enterPressed));
    chimpMouseClick j3 (.iReset(iReset), .clk(clk), .mouseX(mouseX), .mouseY(mouseY),
         .BoxX(BoxX), .BoxY(BoxY));
    mainMenuKey j4(.iKey0(iKey0));
    chimpControlPath j5(.clk(clk), .iKey0(iKey0), .iEnter(enterPressed), .iDoneLoad(doneLoad). oResetBoard(resetBoard), 
        .iReset(iReset), .iChoseCorrectNum(choseCorrectNum), .iChoseWrongNum(choseWrongNum), .oLoadEnable(loadEnable), 
        .oLevel(level), .oNumToLoad(numToLoad), .oNumToChoose(chooseNum));
    chimpDataPath j6(.clk(clk), .iKey0(iKey0), .iLevel(level), .iRandNum(iRandNum), .iNumToLoad(loadNum), .iShowEnable(showEnable),
        .iLoadEnable(loadEnable), .iResetBoard(resetBoard), .iMouseClick(mousePressed), .iNumToChoose(numToChoose),
        .iBoxX(BoxX), .iBoxY(BoxY), .board(board), .oDoneLoad(doneLoad));
    //chimpControlPath();
endmodule