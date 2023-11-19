// The main module of the main menu FSM
// Jonah Diamond
// ECE241 Project

// INPUTS
//// 1. 1 bit, high if 1 on the PS2 is pressed, low if not pressed
//// 2. 1 bit, high if 2 on the PS2 is pressed, low if not pressed
// OUTPUTS
//// 1. 2 bit, output of which mode to display (00 menu, 01 react, 10 chimp)

// Internal needs:
//// 

//module mainMenu(clk, i1, i2, iKey0, oDisplayChoice)
module mainMenu(iClock, iReset, iW, iUserChoice, oZ, oCurState);
    input iClock, iReset, iW;
    input [1:0] iUserChoice;
    output iZ;
    output reg [3:0] oCurState;
    reg [3:0] y_Q, Y_D;
    localparam Menu = 2'b00, React = 2'b01, Chimp = 2'b10;
    

        
    
endmodule