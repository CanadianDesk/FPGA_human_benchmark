module chimpTake2DataPath(clk, iResetBoard, iLoadEnable, iShowEnable, iLevel, 
iNumToChoose, iRandNum, iMouseClick, iReset,
 oDoneLoad, oChoseCorrectNum, oChoseWrongNum, board, iBoxX, iBoxY, oRoundCounter);
    input clk, iResetBoard, iLoadEnable, iShowEnable, iMouseClick, iReset;
    input [4:0] iLevel, iNumToChoose;
    input [7:0] iRandNum;
    input [2:0] iBoxX;
    input [2:0] iBoxY;
    output reg oDoneLoad, oChoseCorrectNum, oChoseWrongNum;
    output reg [6:0] board [7:0] [7:0];
    output reg [5:0] oRoundCounter;
    integer boardSize = 3'd8;
    always@(posedge clk)begin
        //coonect the fifth bit of each cell to iShowEnable
		    board[0][0][5] <= iShowEnable;
            board[0][1][5] <= iShowEnable;
            board[0][2][5] <= iShowEnable;
            board[0][3][5] <= iShowEnable;
            board[0][4][5] <= iShowEnable;
            board[0][5][5] <= iShowEnable;
            board[0][6][5] <= iShowEnable;
            board[0][7][5] <= iShowEnable;
            board[1][0][5] <= iShowEnable;
			board[1][1][5] <= iShowEnable;
			board[1][2][5] <= iShowEnable;
			board[1][3][5] <= iShowEnable;
			board[1][4][5] <= iShowEnable;
			board[1][5][5] <= iShowEnable;
			board[1][6][5] <= iShowEnable;
			board[1][7][5] <= iShowEnable;
			board[2][0][5] <= iShowEnable;
			board[2][1][5] <= iShowEnable;
			board[2][2][5] <= iShowEnable;
			board[2][3][5] <= iShowEnable;
			board[2][4][5] <= iShowEnable;
			board[2][5][5] <= iShowEnable;
			board[2][6][5] <= iShowEnable;
			board[2][7][5] <= iShowEnable;
			board[3][0][5] <= iShowEnable;
			board[3][1][5] <= iShowEnable;
			board[3][2][5] <= iShowEnable;
			board[3][3][5] <= iShowEnable;
			board[3][4][5] <= iShowEnable;
			board[3][5][5] <= iShowEnable;
			board[3][6][5] <= iShowEnable;
			board[3][7][5] <= iShowEnable;
			board[4][0][5] <= iShowEnable;
			board[4][1][5] <= iShowEnable;
			board[4][2][5] <= iShowEnable;
			board[4][3][5] <= iShowEnable;
			board[4][4][5] <= iShowEnable;
			board[4][5][5] <= iShowEnable;
			board[4][6][5] <= iShowEnable;
			board[4][7][5] <= iShowEnable;
			board[5][0][5] <= iShowEnable;
			board[5][1][5] <= iShowEnable;
			board[5][2][5] <= iShowEnable;
			board[5][3][5] <= iShowEnable;
			board[5][4][5] <= iShowEnable;
			board[5][5][5] <= iShowEnable;
			board[5][6][5] <= iShowEnable;
			board[5][7][5] <= iShowEnable;
			board[6][0][5] <= iShowEnable;
			board[6][1][5] <= iShowEnable;
			board[6][2][5] <= iShowEnable;
			board[6][3][5] <= iShowEnable;
			board[6][4][5] <= iShowEnable;
			board[6][5][5] <= iShowEnable;
			board[6][6][5] <= iShowEnable;
			board[6][7][5] <= iShowEnable;
			board[7][0][5] <= iShowEnable;
			board[7][1][5] <= iShowEnable;
			board[7][2][5] <= iShowEnable;
			board[7][3][5] <= iShowEnable;
			board[7][4][5] <= iShowEnable;
			board[7][5][5] <= iShowEnable;
			board[7][6][5] <= iShowEnable;
			board[7][7][5] <= iShowEnable;
        //for (integer a = 0; a < boardSize; a = a + 1'd1 ) begin
        //    for (integer b = 0; b < boardSize; b = b + 1'd1) begin
        //        board[a][b][3'd5] <= iShowEnable;
        //    end
        //end
        if (iResetBoard || iReset || oRoundCounter == oLevel) begin //reset the board to all 0 if resetBoard high
            oDoneLoad <= 0; //not done loading 
            oRoundCounter <= 6'd0;
				board[0][0] <= 7'd0;
				board[0][1] <= 7'd0;
				board[0][2] <= 7'd0;
				board[0][3] <= 7'd0;
				board[0][4] <= 7'd0;
				board[0][5] <= 7'd0;
				board[0][6] <= 7'd0;
				board[0][7] <= 7'd0;
				board[1][0] <= 7'd0;
				board[1][1] <= 7'd0;
				board[1][2] <= 7'd0;
				board[1][3] <= 7'd0;
				board[1][4] <= 7'd0;
				board[1][5] <= 7'd0;
				board[1][6] <= 7'd0;
				board[1][7] <= 7'd0;
				board[2][0] <= 7'd0;
				board[2][1] <= 7'd0;
				board[2][2] <= 7'd0;
				board[2][3] <= 7'd0;
				board[2][4] <= 7'd0;
				board[2][5] <= 7'd0;
				board[2][6] <= 7'd0;
				board[2][7] <= 7'd0;
				board[3][0] <= 7'd0;
				board[3][1] <= 7'd0;
				board[3][2] <= 7'd0;
				board[3][3] <= 7'd0;
				board[3][4] <= 7'd0;
				board[3][5] <= 7'd0;
				board[3][6] <= 7'd0;
				board[3][7] <= 7'd0;
				board[4][0] <= 7'd0;
				board[4][1] <= 7'd0;
				board[4][2] <= 7'd0;
				board[4][3] <= 7'd0;
				board[4][4] <= 7'd0;
				board[4][5] <= 7'd0;
				board[4][6] <= 7'd0;
				board[4][7] <= 7'd0;
				board[5][0] <= 7'd0;
				board[5][1] <= 7'd0;
				board[5][2] <= 7'd0;
				board[5][3] <= 7'd0;
				board[5][4] <= 7'd0;
				board[5][5] <= 7'd0;
				board[5][6] <= 7'd0;
				board[5][7] <= 7'd0;
				board[6][0] <= 7'd0;
				board[6][1] <= 7'd0;
				board[6][2] <= 7'd0;
				board[6][3] <= 7'd0;
				board[6][4] <= 7'd0;
				board[6][5] <= 7'd0;
				board[6][6] <= 7'd0;
				board[6][7] <= 7'd0;
				board[7][0] <= 7'd0;
				board[7][1] <= 7'd0;
				board[7][2] <= 7'd0;
				board[7][3] <= 7'd0;
				board[7][4] <= 7'd0;
				board[7][5] <= 7'd0;
				board[7][6] <= 7'd0;
				board[7][7] <= 7'd0;
            /*for (integer i = 0; i < boardSize; i = i + 1'd1 ) begin
                for (integer j = 0; j < boardSize; j = j + 1'd1) begin
                    //for (integer k = 0; k < 3'd7; k = k + 1'd1) begin
                        board[i][j] <= 7'd0; //load a zero into all 7 bits of each cell of the 2d array
                    //end
                end
            end*/
        //if the counter is less than the current level, add in the counter value at a free location
        end else if (oRoundCounter < iLevel) begin 
            if (iLoadEnable && board[iRandNum[5:3]][iRandNum[2:0]][3'd6] == 0) begin
                board[iRandNum[5:3]][iRandNum[2:0]][4:0] <= oRoundCounter + 1'd1;
                board[iRandNum[5:3]][iRandNum[2:0]][3'd6] <= 1; //cell is now shown to be in use
                oRoundCounter <= oRoundCounter + 1'd1;
            end
        end else oDoneLoad <= 1; //board is done loading bc roundCounter > iLevel

        if (iMouseClick && oDoneLoad) begin
				oRoundCounter <= 0;
            if (board[iBoxX][iBoxY][4:0] == iNumToChoose) oChoseCorrectNum <= 1;
            else oChoseWrongNum <= 1;
        end
    end
endmodule