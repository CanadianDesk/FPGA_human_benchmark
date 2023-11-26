// Chimp FSM DataPath
// Jonah Diamond
// ECE241 Project

// INPUTS
//// 1. 1 bit, clock
//// 2. 1 bit, high if KEY0 pressed (will reset game to main menu)
//// 3. 2 bit, 10 if chimp game selected, otherwise don't care
// OUTPUTS
//// 1. 7 bit [ABCDEFG]: A - high if active, B - high if showing, low if hidden, C-G: 0-31 depending on what number is there

module chimpDataPath(input clk, iKey0, [4:0] level, [7:0] randNum);
    output reg [6:0] board [2:0] [2:0];
    integer loadBoardX, loadBoardY, boardSize = 3'd8, resetX, resetY;
    always @(iKey0) begin
        if (iKey0){
            for (resetX = 3'd0; resetX < boardSize; resetX = resetX + 1'd1) begin
                for (resetY = 3'd0; resetY < boardSize; resetY = loadBoardY + 1'd1) begin
                    board[resetX][resetY] = 7'd0;
                end
            end
        }
    end
    always @(posedge clk) begin

        // for (loadBoardX = 3'd0; loadBoardX < boardSize; ) begin
            
        // end
    end

endmodule