// Chimp FSM DataPath
// Jonah Diamond
// ECE241 Project

// INPUTS
//// 1. 1 bit, clock
//// 2. 1 bit, high if KEY0 pressed (will reset game to main menu)
//// 4. 5 bit, representing which level the user is up to
//// 5. 8 bit, random number
//// 6. 5 bit, number to load into random cell
//// 7. 1 bit, high if show numbers, low if hide
//// 8. 1 bit, high if load numbers, low if shouldn't load numbers
//// 9. 1 bit, high if reset the board
//// 10. 1 bit, high if mouse clicked
//// 11. 1 bit, high if chose correct num
//// 12. 1 bit, high if chose wrong num
//// 13. 1 bit, high if reset
//// 14. 3 bit, x location of box
//// 15. 3 bit, y location of box
// OUTPUTS
//// 1. 1 bit, high if number loaded
//// 2. 8x8 array of 7 bit [ABCDEFG]: A - high if active, B - high if showing, 
/////// low if hidden, C-G: 0-31 depending on what number is there

module chimpDataPath(input clk, iKey0, [4:0] iLevel, [7:0] iRandNum, [4:0] iNumToLoad, iShowEnable,
    iLoadEnable, iResetBoard, iMouseClick, iNumToChoose, iChoseCorrectNum, iChoseWrongNum, iReset,
    [2:0] iBoxX, [2:0] iBoxY,
    output reg [6:0] board [2:0] [2:0],
    output reg oDoneLoad);
    reg resetX, resetY;
    assign board[3'd0][3'd0][3'd5] = iShowEnable;
    assign board[3'd0][3'd1][3'd5] = iShowEnable;
    assign board[3'd0][3'd2][3'd5] = iShowEnable;
    assign board[3'd0][3'd3][3'd5] = iShowEnable;
    assign board[3'd0][3'd4][3'd5] = iShowEnable;
    assign board[3'd0][3'd5][3'd5] = iShowEnable;
    assign board[3'd0][3'd6][3'd5] = iShowEnable;
    assign board[3'd0][3'd7][3'd5] = iShowEnable;
    assign board[3'd1][3'd0][3'd5] = iShowEnable;
    assign board[3'd1][3'd1][3'd5] = iShowEnable;
    assign board[3'd1][3'd2][3'd5] = iShowEnable;
    assign board[3'd1][3'd3][3'd5] = iShowEnable;
    assign board[3'd1][3'd4][3'd5] = iShowEnable;
    assign board[3'd1][3'd5][3'd5] = iShowEnable;
    assign board[3'd1][3'd6][3'd5] = iShowEnable;
    assign board[3'd1][3'd7][3'd5] = iShowEnable;
    assign board[3'd2][3'd0][3'd5] = iShowEnable;
    assign board[3'd2][3'd1][3'd5] = iShowEnable;
    assign board[3'd2][3'd2][3'd5] = iShowEnable;
    assign board[3'd2][3'd3][3'd5] = iShowEnable;
    assign board[3'd2][3'd4][3'd5] = iShowEnable;
    assign board[3'd2][3'd5][3'd5] = iShowEnable;
    assign board[3'd2][3'd6][3'd5] = iShowEnable;
    assign board[3'd2][3'd7][3'd5] = iShowEnable;
    assign board[3'd3][3'd0][3'd5] = iShowEnable;
    assign board[3'd3][3'd1][3'd5] = iShowEnable;
    assign board[3'd3][3'd2][3'd5] = iShowEnable;
    assign board[3'd3][3'd3][3'd5] = iShowEnable;
    assign board[3'd3][3'd4][3'd5] = iShowEnable;
    assign board[3'd3][3'd5][3'd5] = iShowEnable;
    assign board[3'd3][3'd6][3'd5] = iShowEnable;
    assign board[3'd3][3'd7][3'd5] = iShowEnable;
    assign board[3'd4][3'd0][3'd5] = iShowEnable;
    assign board[3'd4][3'd1][3'd5] = iShowEnable;
    assign board[3'd4][3'd2][3'd5] = iShowEnable;
    assign board[3'd4][3'd3][3'd5] = iShowEnable;
    assign board[3'd4][3'd4][3'd5] = iShowEnable;
    assign board[3'd4][3'd5][3'd5] = iShowEnable;
    assign board[3'd4][3'd6][3'd5] = iShowEnable;
    assign board[3'd4][3'd7][3'd5] = iShowEnable;
    assign board[3'd5][3'd0][3'd5] = iShowEnable;
    assign board[3'd5][3'd1][3'd5] = iShowEnable;
    assign board[3'd5][3'd2][3'd5] = iShowEnable;
    assign board[3'd5][3'd3][3'd5] = iShowEnable;
    assign board[3'd5][3'd4][3'd5] = iShowEnable;
    assign board[3'd5][3'd5][3'd5] = iShowEnable;
    assign board[3'd5][3'd6][3'd5] = iShowEnable;
    assign board[3'd5][3'd7][3'd5] = iShowEnable;
    assign board[3'd6][3'd0][3'd5] = iShowEnable;
    assign board[3'd6][3'd1][3'd5] = iShowEnable;
    assign board[3'd6][3'd2][3'd5] = iShowEnable;
    assign board[3'd6][3'd3][3'd5] = iShowEnable;
    assign board[3'd6][3'd4][3'd5] = iShowEnable;
    assign board[3'd6][3'd5][3'd5] = iShowEnable;
    assign board[3'd6][3'd6][3'd5] = iShowEnable;
    assign board[3'd6][3'd7][3'd5] = iShowEnable;
    assign board[3'd7][3'd0][3'd5] = iShowEnable;
    assign board[3'd7][3'd1][3'd5] = iShowEnable;
    assign board[3'd7][3'd2][3'd5] = iShowEnable;
    assign board[3'd7][3'd3][3'd5] = iShowEnable;
    assign board[3'd7][3'd4][3'd5] = iShowEnable;
    assign board[3'd7][3'd5][3'd5] = iShowEnable;
    assign board[3'd7][3'd6][3'd5] = iShowEnable;
    assign board[3'd7][3'd7][3'd5] = iShowEnable;
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
        if (iLoadEnable && board[iRandNum[2:0]][iRandNum[5:3]][3'd6] == 0) begin
            board[iRandNum[2:0]][iRandNum[5:3]][3'd6] = 1;
            board[iRandNum[2:0]][iRandNum[5:3]][4:0] = iNumToLoad;
            oDoneLoad = 1;
        end
        if (!iShowEnable && board[iRandNum[2:0]][iRandNum[5:3]][3'd6] == 1) begin
            board[iRandNum[2:0]][iRandNum[5:3]][3'd5] = iShowEnable;
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
        if (board[BoxX][BoxY][4:0] == iNumToChoose) oChoseCorrectNum = 1;
        else oChoseWrongNum = 1;
    end

endmodule