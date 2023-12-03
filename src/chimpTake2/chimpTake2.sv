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
    reg [2:0] BoxX, BoxY;
    reg [9:0] mouseX;
	 reg [8:0] mouseY;
	 reg [5:0] roundCount;
	 reg [4:0] numToChoose;
    prng j11(.clk(clk), .iReset(iReset), .oOutput(randNum));
    //zUltimateTopLevel j12(.x_position(mouseX), .y_position(mouseY), .space_pressed(space), .leftClick_pressed(mouse));
    chimpTake2MouseClick j13 (.iReset(iReset), .clk(clk), .mouseX(mouseX), .mouseY(mouseY),
         .BoxX(BoxX), .BoxY(BoxY));
    chimpTake2ControlPath j15(.clk(clk), .iSpace(space), .iDoneLoad(doneLoad), .iReset(iReset), .iChoseCorrectNum(choseCorrectNum),
    .iChoseWrongNum(choseWrongNum), .oLevel(level), .oShowEnable(showEnable), .iRoundCount(roundCount),
	 .oNumToChoose(numToChoose), .oLoadEnable(loadEnable), .oResetBoard(resetBoard));
    chimpTake2DataPath j16(.clk(clk), .iResetBoard(resetBoard), .iLoadEnable(loadEnable), .iShowEnable(showEnable), .iLevel(level), 
    .iRandNum(randNum), .iMouseClick(mouse), .oDoneLoad(doneLoad), .oChoseCorrectNum(choseCorrectNum), .oChoseWrongNum(choseWrongNum),
    .board(board), .iBoxX(BoxX), .iBoxY(BoxY), .oRoundCounter(roundCount), .iNumToChoose(numToChoose),
	 .iReset(iReset));
endmodule