// Chimp FSM DataPath
// Jonah Diamond
// ECE241 Project

// INPUTS
//// 1. 1 bit, clock
//// 2. 1 bit, high if KEY0 pressed (will reset game to main menu)
//// 3. 2 bit, 10 if chimp game selected, otherwise don't care
// OUTPUTS
//// 1. 7 bit [ABCDEFG]: A - high if active, B - high if showing, low if hidden, C-G: 0-31 depending on what number is there

module chimpDataPath(input clk, iKey0, [4:0] iLevel, [7:0] iRandNum, [4:0] iLoadNum, 
    iLoadEnable, iResetBoard, iMouseClick, iChooseNum,
    [2:0] iBoxX, [2:0] iBoxY,
    output reg [6:0] board [2:0] [2:0],
    output reg oDoneLoad);
    integer loadBoardX, loadBoardY, boardSize = 3'd8, resetX, resetY;
    // always @(iKey0) begin // reset all cells to 7'd0 if iKey0 pressed to reset
    //     if (iKey0) begin
    //         for (resetX = 3'd0; resetX < boardSize; resetX = resetX + 1'd1) begin
    //             for (resetY = 3'd0; resetY < boardSize; resetY = loadBoardY + 1'd1) begin
    //                 board[resetX][resetY] = 7'd0;
    //             end
    //         end
    //     end
    // end
    always @(posedge clk)begin
        oDoneLoad = 0;
        oChoseCorrectNum = 0;
        oChoseWrongNum = 0;
        // load relevant numbers if cell is unused
        if (iLoadEnable && board[iRandNum[2:0]][iRandNum[5:3]][6] == 0) begin
            board[iRandNum[2:0]][iRandNum[5:3]][6] = 1;
            board[iRandNum[2:0]][iRandNum[5:3]][4:0] = iLandNum;
            oDoneLoad = 1;
        end
        // clear board if new round or new game
        if (iResetBoard) begin
            for (resetX = 3'd0; resetX < boardSize; resetX = resetX + 1'd1) begin
                for (resetY = 3'd0; resetY < boardSize; resetY = loadBoardY + 1'd1) begin
                    board[resetX][resetY] = 7'd0;
                end
            end
        end
    end
    always @(posedge iMouseClick) begin
        if (board[BoxX][BoxY][4:0] == iChooseNum) oChoseCorrectNum = 1;
        else oChoseWrongNum = 1;
    end

endmodule