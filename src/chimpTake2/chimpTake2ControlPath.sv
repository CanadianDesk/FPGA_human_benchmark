// Chimp FSM Control Path
// Jonah Diamond
// ECE241 Project

module chimpTake2ControlPath(clk, iSpace, iDoneLoad, iReset, 
iChoseCorrectNum, iChoseWrongNum, oShowEnable, oLoadEnable, 
oNumToChoose, oResetBoard, iRoundCount, oLevel); ///removed current_state
    //output wire [4:0] olevel;
    input clk, iDoneLoad, iReset, iChoseCorrectNum, iChoseWrongNum;
	 input wire iSpace;
	 input [5:0] iRoundCount;
    output reg [4:0] oNumToChoose;
	 output reg [4:0] oLevel;
	 //assign olevel = oLevel;
    output reg oShowEnable, oLoadEnable, oResetBoard;
     reg [6:0] current_state; ///removed output
	 reg [6:0] next_state;
    localparam LOAD_START = 7'd0,
    LOAD_START_WAIT = 7'd1,
    LOAD_1 = 7'd2,
    CHOOSE_1 = 7'd3,
    CHOOSE_2 = 7'd4,
    CHOOSE_3 = 7'd5,
    CHOOSE_4 = 7'd6,
    CHOOSE_5 = 7'd7,
    CHOOSE_6 = 7'd8,
    CHOOSE_7 = 7'd9,
    CHOOSE_8 = 7'd10,
    CHOOSE_9 = 7'd11,
    CHOOSE_10 = 7'd12,
    CHOOSE_11 = 7'd13,
    CHOOSE_12 = 7'd14,
    CHOOSE_13 = 7'd15,
    CHOOSE_14 = 7'd16,
    CHOOSE_15 = 7'd17,
    CHOOSE_16 = 7'd18,
    CHOOSE_17 = 7'd19,
    CHOOSE_18 = 7'd20,
    CHOOSE_19 = 7'd21,
    CHOOSE_20 = 7'd22,
    CHOOSE_21 = 7'd23,
    CHOOSE_22 = 7'd24,
    CHOOSE_23 = 7'd25,
    CHOOSE_24 = 7'd26,
    CHOOSE_25 = 7'd27,
    CHOOSE_26 = 7'd28,
    CHOOSE_27 = 7'd29,
    CHOOSE_28 = 7'd30,
    CHOOSE_29 = 7'd31,
    CHOOSE_30 = 7'd32,
    CHOOSE_31 = 7'd33,
    CHOOSE_INCREMENT = 7'd34; /////added state
    always @(*) begin
			//oLevel = oLevel + 1 - 1;
        case (current_state)
            LOAD_START: begin 
					next_state = iSpace ? LOAD_START_WAIT : LOAD_START;
				oLevel = 5'd4;
				end
            LOAD_START_WAIT: next_state = iSpace ? LOAD_START_WAIT : LOAD_1;
            LOAD_1: next_state = (iDoneLoad) ? CHOOSE_1 : LOAD_1; //////////reversed from LOAD_1 : CHOOSE_1;
            CHOOSE_1: begin
				if (iChoseWrongNum) next_state = LOAD_START;
				else if (iChoseCorrectNum && oLevel > 5'd1) next_state = CHOOSE_2;
				else if (iChoseCorrectNum && oLevel == 5'd1) begin
					//oLevel = oLevel + 1'd1;
					//next_state = LOAD_1;
					next_state = CHOOSE_INCREMENT;
				end
				else if (iChoseCorrectNum == 0) next_state = CHOOSE_1;
				else next_state <= LOAD_START;
			end
			
CHOOSE_2: begin
	if (iChoseWrongNum) next_state = LOAD_START;
	else if (iChoseCorrectNum && oLevel > 5'd2) next_state = CHOOSE_3;
	else if (iChoseCorrectNum && oLevel == 5'd2) begin
		//oLevel = oLevel + 1'd1;
		//next_state = LOAD_1;
		next_state = CHOOSE_INCREMENT;
	end
	else if (iChoseCorrectNum == 0) next_state = CHOOSE_2;
	else next_state = LOAD_START;
end
CHOOSE_3: begin
	if (iChoseWrongNum) next_state = LOAD_START;
	else if (iChoseCorrectNum && oLevel > 5'd3) next_state = CHOOSE_4;
	else if (iChoseCorrectNum && oLevel == 5'd3) begin
		//oLevel = oLevel + 1'd1;
		//next_state = LOAD_1;
		next_state = CHOOSE_INCREMENT;
	end
	else if (iChoseCorrectNum == 0) next_state = CHOOSE_3;
	else next_state = LOAD_START;
end
CHOOSE_4: begin
	if (iChoseWrongNum) next_state = LOAD_START;
	else if (iChoseCorrectNum && oLevel > 5'd4) next_state = CHOOSE_5;
	else if (iChoseCorrectNum && oLevel == 5'd4) begin
		//oLevel = oLevel + 1'd1;
		//next_state = LOAD_1;
		next_state = CHOOSE_INCREMENT;
	end
	else if (iChoseCorrectNum == 0) next_state = CHOOSE_4;
	else next_state = LOAD_START;
end
CHOOSE_5: begin
	if (iChoseWrongNum) next_state = LOAD_START;
	else if (iChoseCorrectNum && oLevel > 5'd5) next_state = CHOOSE_6;
	else if (iChoseCorrectNum && oLevel == 5'd5) begin
		//oLevel = oLevel + 1'd1;
		//next_state = LOAD_1;
		next_state = CHOOSE_INCREMENT;
	end
	else if (iChoseCorrectNum == 0) next_state = CHOOSE_5;
	else next_state = LOAD_START;
end
CHOOSE_6: begin
	if (iChoseWrongNum) next_state = LOAD_START;
	else if (iChoseCorrectNum && oLevel > 5'd6) next_state = CHOOSE_7;
	else if (iChoseCorrectNum && oLevel == 5'd6) begin
		//oLevel = oLevel + 1'd1;
		//next_state = LOAD_1;
		next_state = CHOOSE_INCREMENT;
	end
	else if (iChoseCorrectNum == 0) next_state = CHOOSE_6;
	else next_state = LOAD_START;
end
CHOOSE_7: begin
	if (iChoseWrongNum) next_state = LOAD_START;
	else if (iChoseCorrectNum && oLevel > 5'd7) next_state = CHOOSE_8;
	else if (iChoseCorrectNum && oLevel == 5'd7) begin
		//oLevel = oLevel + 1'd1;
		//next_state = LOAD_1;
		next_state = CHOOSE_INCREMENT;
	end
	else if (iChoseCorrectNum == 0) next_state = CHOOSE_7;
	else next_state = LOAD_START;
end
CHOOSE_8: begin
	if (iChoseWrongNum) next_state = LOAD_START;
	else if (iChoseCorrectNum && oLevel > 5'd8) next_state = CHOOSE_9;
	else if (iChoseCorrectNum && oLevel == 5'd8) begin
		//oLevel = oLevel + 1'd1;
		//next_state = LOAD_1;
		next_state = CHOOSE_INCREMENT;
	end
	else if (iChoseCorrectNum == 0) next_state = CHOOSE_8;
	else next_state = LOAD_START;
end
CHOOSE_9: begin
	if (iChoseWrongNum) next_state = LOAD_START;
	else if (iChoseCorrectNum && oLevel > 5'd9) next_state = CHOOSE_10;
	else if (iChoseCorrectNum && oLevel == 5'd9) begin
		//oLevel = oLevel + 1'd1;
		//next_state = LOAD_1;
		next_state = CHOOSE_INCREMENT;
	end
	else if (iChoseCorrectNum == 0) next_state = CHOOSE_9;
	else next_state = LOAD_START;
end
CHOOSE_10: begin
	if (iChoseWrongNum) next_state = LOAD_START;
	else if (iChoseCorrectNum && oLevel > 5'd10) next_state = CHOOSE_11;
	else if (iChoseCorrectNum && oLevel == 5'd10) begin
		//oLevel = oLevel + 1'd1;
		//next_state = LOAD_1;
		next_state = CHOOSE_INCREMENT;
	end
	else if (iChoseCorrectNum == 0) next_state = CHOOSE_10;
	else next_state = LOAD_START;
end
CHOOSE_11: begin
	if (iChoseWrongNum) next_state = LOAD_START;
	else if (iChoseCorrectNum && oLevel > 5'd11) next_state = CHOOSE_12;
	else if (iChoseCorrectNum && oLevel == 5'd11) begin
		//oLevel = oLevel + 1'd1;
		//next_state = LOAD_1;
		next_state = CHOOSE_INCREMENT;
	end
	else if (iChoseCorrectNum == 0) next_state = CHOOSE_11;
	else next_state = LOAD_START;
end
CHOOSE_12: begin
	if (iChoseWrongNum) next_state = LOAD_START;
	else if (iChoseCorrectNum && oLevel > 5'd12) next_state = CHOOSE_13;
	else if (iChoseCorrectNum && oLevel == 5'd12) begin
		//oLevel = oLevel + 1'd1;
		//next_state = LOAD_1;
		next_state = CHOOSE_INCREMENT;
	end
	else if (iChoseCorrectNum == 0) next_state = CHOOSE_12;
	else next_state = LOAD_START;
end
CHOOSE_13: begin
	if (iChoseWrongNum) next_state = LOAD_START;
	else if (iChoseCorrectNum && oLevel > 5'd13) next_state = CHOOSE_14;
	else if (iChoseCorrectNum && oLevel == 5'd13) begin
		//oLevel = oLevel + 1'd1;
		//next_state = LOAD_1;
		next_state = CHOOSE_INCREMENT;
	end
	else if (iChoseCorrectNum == 0) next_state = CHOOSE_13;
	else next_state = LOAD_START;
end
CHOOSE_14: begin
	if (iChoseWrongNum) next_state = LOAD_START;
	else if (iChoseCorrectNum && oLevel > 5'd14) next_state = CHOOSE_15;
	else if (iChoseCorrectNum && oLevel == 5'd14) begin
		//oLevel = oLevel + 1'd1;
		//next_state = LOAD_1;
		next_state = CHOOSE_INCREMENT;
	end
	else if (iChoseCorrectNum == 0) next_state = CHOOSE_14;
	else next_state = LOAD_START;
end
CHOOSE_15: begin
	if (iChoseWrongNum) next_state = LOAD_START;
	else if (iChoseCorrectNum && oLevel > 5'd15) next_state = CHOOSE_16;
	else if (iChoseCorrectNum && oLevel == 5'd15) begin
		//oLevel = oLevel + 1'd1;
		//next_state = LOAD_1;
		next_state = CHOOSE_INCREMENT;
	end
	else if (iChoseCorrectNum == 0) next_state = CHOOSE_15;
	else next_state = LOAD_START;
end
CHOOSE_16: begin
	if (iChoseWrongNum) next_state = LOAD_START;
	else if (iChoseCorrectNum && oLevel > 5'd16) next_state = CHOOSE_17;
	else if (iChoseCorrectNum && oLevel == 5'd16) begin
		//oLevel = oLevel + 1'd1;
		//next_state = LOAD_1;
		next_state = CHOOSE_INCREMENT;
	end
	else if (iChoseCorrectNum == 0) next_state = CHOOSE_16;
	else next_state = LOAD_START;
end
CHOOSE_17: begin
	if (iChoseWrongNum) next_state = LOAD_START;
	else if (iChoseCorrectNum && oLevel > 5'd17) next_state = CHOOSE_18;
	else if (iChoseCorrectNum && oLevel == 5'd17) begin
		//oLevel = oLevel + 1'd1;
		//next_state = LOAD_1;
		next_state = CHOOSE_INCREMENT;
	end
	else if (iChoseCorrectNum == 0) next_state = CHOOSE_17;
	else next_state = LOAD_START;
end
CHOOSE_18: begin
	if (iChoseWrongNum) next_state = LOAD_START;
	else if (iChoseCorrectNum && oLevel > 5'd18) next_state = CHOOSE_19;
	else if (iChoseCorrectNum && oLevel == 5'd18) begin
		//oLevel = oLevel + 1'd1;
		//next_state = LOAD_1;
		next_state = CHOOSE_INCREMENT;
	end
	else if (iChoseCorrectNum == 0) next_state = CHOOSE_18;
	else next_state = LOAD_START;
end
CHOOSE_19: begin
	if (iChoseWrongNum) next_state = LOAD_START;
	else if (iChoseCorrectNum && oLevel > 5'd19) next_state = CHOOSE_20;
	else if (iChoseCorrectNum && oLevel == 5'd19) begin
		//oLevel = oLevel + 1'd1;
		//next_state = LOAD_1;
		next_state = CHOOSE_INCREMENT;
	end
	else if (iChoseCorrectNum == 0) next_state = CHOOSE_19;
	else next_state = LOAD_START;
end
CHOOSE_20: begin
	if (iChoseWrongNum) next_state = LOAD_START;
	else if (iChoseCorrectNum && oLevel > 5'd20) next_state = CHOOSE_21;
	else if (iChoseCorrectNum && oLevel == 5'd20) begin
		//oLevel = oLevel + 1'd1;
		//next_state = LOAD_1;
		next_state = CHOOSE_INCREMENT;
	end
	else if (iChoseCorrectNum == 0) next_state = CHOOSE_20;
	else next_state = LOAD_START;
end
CHOOSE_21: begin
	if (iChoseWrongNum) next_state = LOAD_START;
	else if (iChoseCorrectNum && oLevel > 5'd21) next_state = CHOOSE_22;
	else if (iChoseCorrectNum && oLevel == 5'd21) begin
		//oLevel = oLevel + 1'd1;
		//next_state = LOAD_1;
		next_state = CHOOSE_INCREMENT;
	end
	else if (iChoseCorrectNum == 0) next_state = CHOOSE_21;
	else next_state = LOAD_START;
end
CHOOSE_22: begin
	if (iChoseWrongNum) next_state = LOAD_START;
	else if (iChoseCorrectNum && oLevel > 5'd22) next_state = CHOOSE_23;
	else if (iChoseCorrectNum && oLevel == 5'd22) begin
		//oLevel = oLevel + 1'd1;
		//next_state = LOAD_1;
		next_state = CHOOSE_INCREMENT;
	end
	else if (iChoseCorrectNum == 0) next_state = CHOOSE_22;
	else next_state = LOAD_START;
end
CHOOSE_23: begin
	if (iChoseWrongNum) next_state = LOAD_START;
	else if (iChoseCorrectNum && oLevel > 5'd23) next_state = CHOOSE_24;
	else if (iChoseCorrectNum && oLevel == 5'd23) begin
		//oLevel = oLevel + 1'd1;
		//next_state = LOAD_1;
		next_state = CHOOSE_INCREMENT;
	end
	else if (iChoseCorrectNum == 0) next_state = CHOOSE_23;
	else next_state = LOAD_START;
end
CHOOSE_24: begin
	if (iChoseWrongNum) next_state = LOAD_START;
	else if (iChoseCorrectNum && oLevel > 5'd24) next_state = CHOOSE_25;
	else if (iChoseCorrectNum && oLevel == 5'd24) begin
		//oLevel = oLevel + 1'd1;
		//next_state = LOAD_1;
		next_state = CHOOSE_INCREMENT;
	end
	else if (iChoseCorrectNum == 0) next_state = CHOOSE_24;
	else next_state = LOAD_START;
end
CHOOSE_25: begin
	if (iChoseWrongNum) next_state = LOAD_START;
	else if (iChoseCorrectNum && oLevel > 5'd25) next_state = CHOOSE_26;
	else if (iChoseCorrectNum && oLevel == 5'd25) begin
		//oLevel = oLevel + 1'd1;
		//next_state = LOAD_1;
		next_state = CHOOSE_INCREMENT;
	end
	else if (iChoseCorrectNum == 0) next_state = CHOOSE_25;
	else next_state = LOAD_START;
end
CHOOSE_26: begin
	if (iChoseWrongNum) next_state = LOAD_START;
	else if (iChoseCorrectNum && oLevel > 5'd26) next_state = CHOOSE_27;
	else if (iChoseCorrectNum && oLevel == 5'd26) begin
		//oLevel = oLevel + 1'd1;
		//next_state = LOAD_1;
		next_state = CHOOSE_INCREMENT;
	end
	else if (iChoseCorrectNum == 0) next_state = CHOOSE_26;
	else next_state = LOAD_START;
end
CHOOSE_27: begin
	if (iChoseWrongNum) next_state = LOAD_START;
	else if (iChoseCorrectNum && oLevel > 5'd27) next_state = CHOOSE_28;
	else if (iChoseCorrectNum && oLevel == 5'd27) begin
		//oLevel = oLevel + 1'd1;
		//next_state = LOAD_1;
		next_state = CHOOSE_INCREMENT;
	end
	else if (iChoseCorrectNum == 0) next_state = CHOOSE_27;
	else next_state = LOAD_START;
end
CHOOSE_28: begin
	if (iChoseWrongNum) next_state = LOAD_START;
	else if (iChoseCorrectNum && oLevel > 5'd28) next_state = CHOOSE_29;
	else if (iChoseCorrectNum && oLevel == 5'd28) begin
		//oLevel = oLevel + 1'd1;
		//next_state = LOAD_1;
		next_state = CHOOSE_INCREMENT;
	end
	else if (iChoseCorrectNum == 0) next_state = CHOOSE_28;
	else next_state = LOAD_START;
end
CHOOSE_29: begin
	if (iChoseWrongNum) next_state = LOAD_START;
	else if (iChoseCorrectNum && oLevel > 5'd29) next_state = CHOOSE_30;
	else if (iChoseCorrectNum && oLevel == 5'd29) begin
		//oLevel = oLevel + 1'd1;
		//next_state = LOAD_1;
		next_state = CHOOSE_INCREMENT;
	end
	else if (iChoseCorrectNum == 0) next_state = CHOOSE_29;
	else next_state = LOAD_START;
end
CHOOSE_30: begin
	if (iChoseWrongNum) next_state = LOAD_START;
	else if (iChoseCorrectNum && oLevel > 5'd30) next_state = CHOOSE_31;
	else if (iChoseCorrectNum && oLevel == 5'd30) begin
		//oLevel = oLevel + 1'd1;
		//next_state = LOAD_1;
		next_state = CHOOSE_INCREMENT;
	end
	else if (iChoseCorrectNum == 0) next_state = CHOOSE_30;
	else next_state = LOAD_START;
end
            		CHOOSE_31: next_state <= LOAD_START;
			CHOOSE_INCREMENT: begin
				oLevel = oLevel + 1'd1;
				oResetBoard  = 1;
				next_state = LOAD_1;
			end
            default: next_state = LOAD_START;
        endcase
    end
    always@(*) begin
        oNumToChoose = 0;
//		  if (iReset) oLevel = 5'd4;
        if (current_state < 7'd4) oLoadEnable = 1;
        else oLoadEnable = 0;
        if (current_state < 7'd4) oShowEnable = 1;
        else oShowEnable = 0;
        if (current_state < 7'd2 || iReset || current_state == 7'd34) oResetBoard = 1;
        else oResetBoard = 0;
        case(current_state)
            CHOOSE_1: oNumToChoose = 5'd1;
            CHOOSE_2: oNumToChoose = 5'd2;
            CHOOSE_3: oNumToChoose = 5'd3;
            CHOOSE_4: oNumToChoose = 5'd4;
            CHOOSE_5: oNumToChoose = 5'd5;
            CHOOSE_6: oNumToChoose = 5'd6;
            CHOOSE_7: oNumToChoose = 5'd7;
            CHOOSE_8: oNumToChoose = 5'd8;
            CHOOSE_9: oNumToChoose = 5'd9;
            CHOOSE_10: oNumToChoose = 5'd10;
            CHOOSE_11: oNumToChoose = 5'd11;
            CHOOSE_12: oNumToChoose = 5'd12;
            CHOOSE_13: oNumToChoose = 5'd13;
            CHOOSE_14: oNumToChoose = 5'd14;
            CHOOSE_15: oNumToChoose = 5'd15;
            CHOOSE_16: oNumToChoose = 5'd16;
            CHOOSE_17: oNumToChoose = 5'd17;
            CHOOSE_18: oNumToChoose = 5'd18;
            CHOOSE_19: oNumToChoose = 5'd19;
            CHOOSE_20: oNumToChoose = 5'd20;
            CHOOSE_21: oNumToChoose = 5'd21;
            CHOOSE_22: oNumToChoose = 5'd22;
            CHOOSE_23: oNumToChoose = 5'd23;
            CHOOSE_24: oNumToChoose = 5'd24;
            CHOOSE_25: oNumToChoose = 5'd25;
            CHOOSE_26: oNumToChoose = 5'd26;
            CHOOSE_27: oNumToChoose = 5'd27;
            CHOOSE_28: oNumToChoose = 5'd28;
            CHOOSE_29: oNumToChoose = 5'd29;
            CHOOSE_30: oNumToChoose = 5'd30;
            CHOOSE_31: oNumToChoose = 5'd31;
				default: oNumToChoose = 5'd0;
        endcase    
    end

    always@(posedge clk)begin
        if (iReset) current_state <= LOAD_START;
        else current_state <= next_state;
		end
endmodule
