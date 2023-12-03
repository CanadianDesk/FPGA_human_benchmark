module chimpTake2DataPath(clk, iResetBoard, iLoadEnable, iShowEnable, iLevel, iRandNum, iMouseClick,
 oDoneLoad, oChoseCorrectNum, oChoseWrongNum, board, iBoxX, iBoxY);
    input clk, iResetBoard, iLoadEnable, iShowEnable, iMouseClick;
    input [4:0] iLevel;
    input [7:0] iRandNum;
    input [2:0] iBoxX;
    input [2:0] iBoxY;
    output reg oDoneLoad, oChoseCorrectNum, oChoseWrongNum;
    output reg [6:0] board [7:0] [7:0];
    reg [5:0] roundCounter;
    integer boardSize = 3'd8;
    always@(posedge clk)begin
        //coonect the fifth bit of each cell to iShowEnable
        for (integer a = 0; a < boardSize; a = a + 1'd1 ) begin
            for (integer b = 0; b < boardSize; b = b + 1'd1) begin
                board[a][b][3'd5] <= iShowEnable;
            end
        end
        if (iResetBoard) begin //reset the board to all 0 if resetBoard high
            oDoneLoad <= 0; //not done loading 
            roundCounter <= 6'd0;
            for (integer i = 0; i < boardSize; i = i + 1'd1 ) begin
                for (integer j = 0; j < boardSize; j = j + 1'd1) begin
                    for (integer k = 0; k < 3'd7; k = k + 1'd1) begin
                        board[i][j][k] <= 0; //load a zero into all 7 bits of each cell of the 2d array
                    end
                end
            end
        //if the counter is less than the current level, add in the counter value at a free location
        end else if (roundCounter <= iLevel) begin 
            if (iLoadEnable && board[iRandNum[5:3]][iRandNum[2:0]][3'd6] == 0) begin
                board[iRandNum[5:3]][iRandNum[2:0]][4:0] <= roundCounter;
                board[iRandNum[5:3]][iRandNum[2:0]][3'd6] <= 1; //cell is now shown to be in use
                roundCounter <= roundCounter + 1'd1;
            end
        end else oDoneLoad <= 1; //board is done loading bc roundCounter > iLevel

        if (iMouseClick && oDoneLoad) begin
            if (board[iBoxX][iBoxY][4:0] == iNumToChoose) oChoseCorrectNum <= 1;
            else oChoseCorrectNum <= 1;
        end
    end
endmodule