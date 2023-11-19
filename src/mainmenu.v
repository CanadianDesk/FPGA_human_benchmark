// The main module of the main menu FSM
// Jonah Diamond
// ECE241 Project


// External needs:
//// Input: 1, 2 (ie whether they're pressed)
//// Output: 2'b output of which to display (00 menu, 01 react, 10 chimp)
// Internal needs:
//// 

module mainMenu(iClock, iReset, iW, iUserChoice, oZ, oCurState);
    input iClock, iReset, iW;
    input [1:0] iUserChoice;
    output iZ;
    output reg [3:0] oCurState;
    reg [3:0] y_Q, Y_D;
    localparam Menu = 2'b00, React = 2'b01, Chimp = 2'b10;
    

        
    end
endmodule