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
    assign board[0][0][5] = showEnable;
    assign board[1][1][5] = showEnable;
    assign board[2][2][5] = showEnable;
    assign board[3][3][5] = showEnable;
    assign board[4][4][5] = showEnable;
    assign board[5][5][5] = showEnable;
    assign board[6][6][5] = showEnable;
    assign board[7][7][5] = showEnable;
    assign board[8][8][5] = showEnable;
    assign board[9][9][5] = showEnable;
    assign board[10][10][5] = showEnable;
    assign board[11][11][5] = showEnable;
    assign board[12][12][5] = showEnable;
    assign board[13][13][5] = showEnable;
    assign board[14][14][5] = showEnable;
    assign board[15][15][5] = showEnable;
    assign board[16][16][5] = showEnable;
    assign board[17][17][5] = showEnable;
    assign board[18][18][5] = showEnable;
    assign board[19][19][5] = showEnable;
    assign board[20][20][5] = showEnable;
    assign board[21][21][5] = showEnable;
    assign board[22][22][5] = showEnable;
    assign board[23][23][5] = showEnable;
    assign board[24][24][5] = showEnable;
    assign board[25][25][5] = showEnable;
    assign board[26][26][5] = showEnable;
    assign board[27][27][5] = showEnable;
    assign board[28][28][5] = showEnable;
    assign board[29][29][5] = showEnable;
    assign board[30][30][5] = showEnable;
    assign board[31][31][5] = showEnable;
    assign board[32][32][5] = showEnable;
    assign board[33][33][5] = showEnable;
    assign board[34][34][5] = showEnable;
    assign board[35][35][5] = showEnable;
    assign board[36][36][5] = showEnable;
    assign board[37][37][5] = showEnable;
    assign board[38][38][5] = showEnable;
    assign board[39][39][5] = showEnable;
    assign board[40][40][5] = showEnable;
    assign board[41][41][5] = showEnable;
    assign board[42][42][5] = showEnable;
    assign board[43][43][5] = showEnable;
    assign board[44][44][5] = showEnable;
    assign board[45][45][5] = showEnable;
    assign board[46][46][5] = showEnable;
    assign board[47][47][5] = showEnable;
    assign board[48][48][5] = showEnable;
    assign board[49][49][5] = showEnable;
    assign board[50][50][5] = showEnable;
    assign board[51][51][5] = showEnable;
    assign board[52][52][5] = showEnable;
    assign board[53][53][5] = showEnable;
    assign board[54][54][5] = showEnable;
    assign board[55][55][5] = showEnable;
    assign board[56][56][5] = showEnable;
    assign board[57][57][5] = showEnable;
    assign board[58][58][5] = showEnable;
    assign board[59][59][5] = showEnable;
    assign board[60][60][5] = showEnable;
    assign board[61][61][5] = showEnable;
    assign board[62][62][5] = showEnable;
    assign board[63][63][5] = showEnable;
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
        if (!showEnable && board[iRandNum[2:0]][iRandNum[5:3]][6] == 1) begin
            board[iRandNum[2:0]][iRandNum[5:3]][5] = showEnable;
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