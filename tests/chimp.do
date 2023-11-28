vlib work

vlog chimpControlPath.v
vsim chimpControlPath

log -r /*

add wave -r /*

force {clk} 0 0ns, 1 0.25ns -r 0.5ns

#module chimp(input clk, iKey0, iReset, output reg [6:0] board[2:0][2:0]);
#    wire [7:0] iRandNum;
#    wire mousePressed, enterPressed, resetBoard, choseCorrectNum, choseWrongNum, loadEnable, doneLoad;
#    wire [4:0] numToLoad, [4:0] numToChoose;
#    wire [4:0] level;
#    wire [2:0] BoxX, [2:0] BoxY;
#    wire [9:0] mouseX, [8:0] mouseY;

force iReset 0;
force iRandNum 8'd27;
force mousePressed 0;
force enterPressed 1;
force resetBoard 0;
force choseCorrectNum ;
force choseWrongNum ;

