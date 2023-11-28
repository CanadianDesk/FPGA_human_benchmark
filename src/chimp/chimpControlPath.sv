// Chimp FSM Top-Level Module
// Jonah Diamond
// ECE241 Project

// INPUTS
//// 1. 1 bit, clock
//// 2. 1 bit, high if KEY0 pressed (will reset game to main menu)
//// 3. 1 bit, high if enter pressed
//// 4. 1 bit, high if done loading number
//// 5. 1 bit, high if reset
//// 6. 1 bit, high if chose correct num
//// 7. 1 bit, high if chose wrong num
// OUTPUTS
//// 1. 1 bit, high if load enabled
//// 2. 1 bit, high if reset board
//// 3. 5 bit, represents level user is on
//// 4. 5 bit, represents number to be loaded to random cell
//// 5. 5 bit, represents number user should choose
//// 6. 1 bit, high if numbers should show on screen, low if hide

module chimpControlPath(input clk, iKey0, iEnter, iDoneLoad, iReset, iChoseCorrectNum, iChoseWrongNum,
output reg oLoadEnable, oResetBoard, [4:0] oLevel, [4:0] oNumToLoad, [4:0] oNumToChoose, oShowEnable);
    reg [6:0] current_state, next_state;
    localparam LOAD_START = 7'd0,
    LOAD_1 = 7'd1,
    LOAD_2 = 7'd2,
    LOAD_3 = 7'd3,
    LOAD_4 = 7'd4,
    LOAD_5 = 7'd5,
    LOAD_6 = 7'd6,
    LOAD_7 = 7'd7,
    LOAD_8 = 7'd8,
    LOAD_9 = 7'd9,
    LOAD_10 = 7'd10,
    LOAD_11 = 7'd11,
    LOAD_12 = 7'd12,
    LOAD_13 = 7'd13,
    LOAD_14 = 7'd14,
    LOAD_15 = 7'd15,
    LOAD_16 = 7'd16,
    LOAD_17 = 7'd17,
    LOAD_18 = 7'd18,
    LOAD_19 = 7'd19,
    LOAD_20 = 7'd20,
    LOAD_21 = 7'd21,
    LOAD_22 = 7'd22,
    LOAD_23 = 7'd23,
    LOAD_24 = 7'd24,
    LOAD_25 = 7'd25,
    LOAD_26 = 7'd26,
    LOAD_27 = 7'd27,
    LOAD_28 = 7'd28,
    LOAD_29 = 7'd29,
    LOAD_30 = 7'd30,
    LOAD_31 = 7'd31,
    START_GAME = 7'd32,
    CHOOSE_1 = 7'd33,
    CHOOSE_2 = 7'd34,
    CHOOSE_3 = 7'd35,
    CHOOSE_4 = 7'd36,
    CHOOSE_5 = 7'd37,
    CHOOSE_6 = 7'd38,
    CHOOSE_7 = 7'd39,
    CHOOSE_8 = 7'd40,
    CHOOSE_9 = 7'd41,
    CHOOSE_10 = 7'd42,
    CHOOSE_11 = 7'd43,
    CHOOSE_12 = 7'd44,
    CHOOSE_13 = 7'd45,
    CHOOSE_14 = 7'd46,
    CHOOSE_15 = 7'd47,
    CHOOSE_16 = 7'd48,
    CHOOSE_17 = 7'd49,
    CHOOSE_18 = 7'd50,
    CHOOSE_19 = 7'd51,
    CHOOSE_20 = 7'd52,
    CHOOSE_21 = 7'd53,
    CHOOSE_22 = 7'd54,
    CHOOSE_23 = 7'd55,
    CHOOSE_24 = 7'd56,
    CHOOSE_25 = 7'd57,
    CHOOSE_26 = 7'd58,
    CHOOSE_27 = 7'd59,
    CHOOSE_28 = 7'd60,
    CHOOSE_29 = 7'd61,
    CHOOSE_30 = 7'd62,
    CHOOSE_31 = 7'd63;
    always @(*) begin
        case (current_state)
            LOAD_START: next_state = iEnter ? LOAD_1 : LOAD_START;
            LOAD_1: next_state = (oLevel < 5'd1) ? START_GAME : ((iDoneLoad == 1) ? LOAD_2 : LOAD_1); 
            LOAD_2: next_state = (oLevel < 5'd2) ? START_GAME : ((iDoneLoad == 1) ? LOAD_3 : LOAD_2);
            LOAD_3: next_state = (oLevel < 5'd3) ? START_GAME : ((iDoneLoad == 1) ? LOAD_4 : LOAD_3);
            LOAD_4: next_state = (oLevel < 5'd4) ? START_GAME : ((iDoneLoad == 1) ? LOAD_5 : LOAD_4);
            LOAD_5: next_state = (oLevel < 5'd5) ? START_GAME : ((iDoneLoad == 1) ? LOAD_6 : LOAD_5);
            LOAD_6: next_state = (oLevel < 5'd6) ? START_GAME : ((iDoneLoad == 1) ? LOAD_7 : LOAD_6);
            LOAD_7: next_state = (oLevel < 5'd7) ? START_GAME : ((iDoneLoad == 1) ? LOAD_8 : LOAD_7);
            LOAD_8: next_state = (oLevel < 5'd8) ? START_GAME : ((iDoneLoad == 1) ? LOAD_9 : LOAD_8);
            LOAD_9: next_state = (oLevel < 5'd9) ? START_GAME : ((iDoneLoad == 1) ? LOAD_10 : LOAD_9);
            LOAD_10: next_state = (oLevel < 5'd10) ? START_GAME : ((iDoneLoad == 1) ? LOAD_11 : LOAD_10);
            LOAD_11: next_state = (oLevel < 5'd11) ? START_GAME : ((iDoneLoad == 1) ? LOAD_12 : LOAD_11);
            LOAD_12: next_state = (oLevel < 5'd12) ? START_GAME : ((iDoneLoad == 1) ? LOAD_13 : LOAD_12);
            LOAD_13: next_state = (oLevel < 5'd13) ? START_GAME : ((iDoneLoad == 1) ? LOAD_14 : LOAD_13);
            LOAD_14: next_state = (oLevel < 5'd14) ? START_GAME : ((iDoneLoad == 1) ? LOAD_15 : LOAD_14);
            LOAD_15: next_state = (oLevel < 5'd15) ? START_GAME : ((iDoneLoad == 1) ? LOAD_16 : LOAD_15);
            LOAD_16: next_state = (oLevel < 5'd16) ? START_GAME : ((iDoneLoad == 1) ? LOAD_17 : LOAD_16);
            LOAD_17: next_state = (oLevel < 5'd17) ? START_GAME : ((iDoneLoad == 1) ? LOAD_18 : LOAD_17);
            LOAD_18: next_state = (oLevel < 5'd18) ? START_GAME : ((iDoneLoad == 1) ? LOAD_19 : LOAD_18);
            LOAD_19: next_state = (oLevel < 5'd19) ? START_GAME : ((iDoneLoad == 1) ? LOAD_20 : LOAD_19);
            LOAD_20: next_state = (oLevel < 5'd20) ? START_GAME : ((iDoneLoad == 1) ? LOAD_21 : LOAD_20);
            LOAD_21: next_state = (oLevel < 5'd21) ? START_GAME : ((iDoneLoad == 1) ? LOAD_22 : LOAD_21);
            LOAD_22: next_state = (oLevel < 5'd22) ? START_GAME : ((iDoneLoad == 1) ? LOAD_23 : LOAD_22);
            LOAD_23: next_state = (oLevel < 5'd23) ? START_GAME : ((iDoneLoad == 1) ? LOAD_24 : LOAD_23);
            LOAD_24: next_state = (oLevel < 5'd24) ? START_GAME : ((iDoneLoad == 1) ? LOAD_25 : LOAD_24);
            LOAD_25: next_state = (oLevel < 5'd25) ? START_GAME : ((iDoneLoad == 1) ? LOAD_26 : LOAD_25);
            LOAD_26: next_state = (oLevel < 5'd26) ? START_GAME : ((iDoneLoad == 1) ? LOAD_27 : LOAD_26);
            LOAD_27: next_state = (oLevel < 5'd27) ? START_GAME : ((iDoneLoad == 1) ? LOAD_28 : LOAD_27);
            LOAD_28: next_state = (oLevel < 5'd28) ? START_GAME : ((iDoneLoad == 1) ? LOAD_29 : LOAD_28);
            LOAD_29: next_state = (oLevel < 5'd29) ? START_GAME : ((iDoneLoad == 1) ? LOAD_30 : LOAD_29);
            LOAD_30: next_state = (oLevel < 5'd30) ? START_GAME : ((iDoneLoad == 1) ? LOAD_31 : LOAD_30);
            LOAD_31: next_state = iDoneLoad ? START_GAME : LOAD_31;
            /* //replaced with above code
            LOAD_2: next_state = (oLevel > 5'd2) ? LOAD_3 : START_GAME;
            LOAD_3: next_state = (oLevel > 5'd3) ? LOAD_4 : START_GAME;
            LOAD_4: next_state = (oLevel > 5'd4) ? LOAD_5 : START_GAME;
            LOAD_5: next_state = (oLevel > 5'd5) ? LOAD_6 : START_GAME;
            LOAD_6: next_state = (oLevel > 5'd6) ? LOAD_7 : START_GAME;
            LOAD_7: next_state = (oLevel > 5'd7) ? LOAD_8 : START_GAME;
            LOAD_8: next_state = (oLevel > 5'd8) ? LOAD_9 : START_GAME;
            LOAD_9: next_state = (oLevel > 5'd9) ? LOAD_10 : START_GAME;
            LOAD_10: next_state = (oLevel > 5'd10) ? LOAD_11 : START_GAME;
            LOAD_11: next_state = (oLevel > 5'd11) ? LOAD_12 : START_GAME;
            LOAD_12: next_state = (oLevel > 5'd12) ? LOAD_13 : START_GAME;
            LOAD_13: next_state = (oLevel > 5'd13) ? LOAD_14 : START_GAME;
            LOAD_14: next_state = (oLevel > 5'd14) ? LOAD_15 : START_GAME;
            LOAD_15: next_state = (oLevel > 5'd15) ? LOAD_16 : START_GAME;
            LOAD_16: next_state = (oLevel > 5'd16) ? LOAD_17 : START_GAME;
            LOAD_17: next_state = (oLevel > 5'd17) ? LOAD_18 : START_GAME;
            LOAD_18: next_state = (oLevel > 5'd18) ? LOAD_19 : START_GAME;
            LOAD_19: next_state = (oLevel > 5'd19) ? LOAD_20 : START_GAME;
            LOAD_20: next_state = (oLevel > 5'd20) ? LOAD_21 : START_GAME;
            LOAD_21: next_state = (oLevel > 5'd21) ? LOAD_22 : START_GAME;
            LOAD_22: next_state = (oLevel > 5'd22) ? LOAD_23 : START_GAME;
            LOAD_23: next_state = (oLevel > 5'd23) ? LOAD_24 : START_GAME;
            LOAD_24: next_state = (oLevel > 5'd24) ? LOAD_25 : START_GAME;
            LOAD_25: next_state = (oLevel > 5'd25) ? LOAD_26 : START_GAME;
            LOAD_26: next_state = (oLevel > 5'd26) ? LOAD_27 : START_GAME;
            LOAD_27: next_state = (oLevel > 5'd27) ? LOAD_28 : START_GAME;
            LOAD_28: next_state = (oLevel > 5'd28) ? LOAD_29 : START_GAME;
            LOAD_29: next_state = (oLevel > 5'd29) ? LOAD_30 : START_GAME;
            LOAD_30: next_state = (oLevel > 5'd30) ? LOAD_31 : START_GAME;
            LOAD_31: next_state = START_GAME;*/
            START_GAME: next_state = iEnter ? CHOOSE_1 : START_GAME;
            CHOOSE_1: begin
                if (iChoseCorrectNum && oLevel > 5'd1) next_state = CHOOSE_2;
                else if (iChoseCorrectNum && oLevel == 5'd1) begin 
                    oLevel = oLevel + 1'd1;
                    next_state = LOAD_1;
                end
                else if (iChoseCorrectNum == 0) next_state = CHOOSE_1;
                if (iChoseWrongNum) next_state = LOAD_START;
                end
            CHOOSE_2: begin
                if (iChoseCorrectNum && oLevel > 5'd2) next_state = CHOOSE_3;
                else if (iChoseCorrectNum && oLevel == 5'd2) begin 
                    oLevel = oLevel + 1'd1;
                    next_state = LOAD_1;
                end
                else if (iChoseCorrectNum == 0) next_state = CHOOSE_2;
                if (iChoseWrongNum) next_state = LOAD_START;
                end
            CHOOSE_3: begin
                if (iChoseCorrectNum && oLevel > 5'd3) next_state = CHOOSE_4;
                else if (iChoseCorrectNum && oLevel == 5'd3) begin 
                    oLevel = oLevel + 1'd1;
                    next_state = LOAD_1;
                end
                else if (iChoseCorrectNum == 0) next_state = CHOOSE_3;
                if (iChoseWrongNum) next_state = LOAD_START;
                end
            CHOOSE_4: begin
                if (iChoseCorrectNum && oLevel > 5'd4) next_state = CHOOSE_5;
                else if (iChoseCorrectNum && oLevel == 5'd4) begin 
                    oLevel = oLevel + 1'd1;
                    next_state = LOAD_1;
                end
                else if (iChoseCorrectNum == 0) next_state = CHOOSE_4;
                if (iChoseWrongNum) next_state = LOAD_START;
                end
            CHOOSE_5: begin
                if (iChoseCorrectNum && oLevel > 5'd5) next_state = CHOOSE_6;
                else if (iChoseCorrectNum && oLevel == 5'd5) begin 
                    oLevel = oLevel + 1'd1;
                    next_state = LOAD_1;
                end
                else if (iChoseCorrectNum == 0) next_state = CHOOSE_5;
                if (iChoseWrongNum) next_state = LOAD_START;
                end
            CHOOSE_6: begin
                if (iChoseCorrectNum && oLevel > 5'd6) next_state = CHOOSE_7;
                else if (iChoseCorrectNum && oLevel == 5'd6) begin 
                    oLevel = oLevel + 1'd1;
                    next_state = LOAD_1;
                end
                else if (iChoseCorrectNum == 0) next_state = CHOOSE_6;
                if (iChoseWrongNum) next_state = LOAD_START;
                end
            CHOOSE_7: begin
                if (iChoseCorrectNum && oLevel > 5'd7) next_state = CHOOSE_8;
                else if (iChoseCorrectNum && oLevel == 5'd7) begin 
                    oLevel = oLevel + 1'd1;
                    next_state = LOAD_1;
                end
                else if (iChoseCorrectNum == 0) next_state = CHOOSE_7;
                if (iChoseWrongNum) next_state = LOAD_START;
                end
            CHOOSE_8: begin
                if (iChoseCorrectNum && oLevel > 5'd8) next_state = CHOOSE_9;
                else if (iChoseCorrectNum && oLevel == 5'd8) begin 
                    oLevel = oLevel + 1'd1;
                    next_state = LOAD_1;
                end
                else if (iChoseCorrectNum == 0) next_state = CHOOSE_8;
                if (iChoseWrongNum) next_state = LOAD_START;
                end
            CHOOSE_9: begin
                if (iChoseCorrectNum && oLevel > 5'd9) next_state = CHOOSE_10;
                else if (iChoseCorrectNum && oLevel == 5'd9) begin 
                    oLevel = oLevel + 1'd1;
                    next_state = LOAD_1;
                end
                else if (iChoseCorrectNum == 0) next_state = CHOOSE_9;
                if (iChoseWrongNum) next_state = LOAD_START;
                end
            CHOOSE_10: begin
                if (iChoseCorrectNum && oLevel > 5'd10) next_state = CHOOSE_11;
                else if (iChoseCorrectNum && oLevel == 5'd10) begin 
                    oLevel = oLevel + 1'd1;
                    next_state = LOAD_1;
                end
                else if (iChoseCorrectNum == 0) next_state = CHOOSE_10;
                if (iChoseWrongNum) next_state = LOAD_START;
                end
            CHOOSE_11: begin
                if (iChoseCorrectNum && oLevel > 5'd11) next_state = CHOOSE_12;
                else if (iChoseCorrectNum && oLevel == 5'd11) begin 
                    oLevel = oLevel + 1'd1;
                    next_state = LOAD_1;
                end
                else if (iChoseCorrectNum == 0) next_state = CHOOSE_11;
                if (iChoseWrongNum) next_state = LOAD_START;
                end
            CHOOSE_12: begin
                if (iChoseCorrectNum && oLevel > 5'd12) next_state = CHOOSE_13;
                else if (iChoseCorrectNum && oLevel == 5'd12) begin 
                    oLevel = oLevel + 1'd1;
                    next_state = LOAD_1;
                end
                else if (iChoseCorrectNum == 0) next_state = CHOOSE_12;
                if (iChoseWrongNum) next_state = LOAD_START;
                end
            CHOOSE_13: begin
                if (iChoseCorrectNum && oLevel > 5'd13) next_state = CHOOSE_14;
                else if (iChoseCorrectNum && oLevel == 5'd13) begin 
                    oLevel = oLevel + 1'd1;
                    next_state = LOAD_1;
                end
                else if (iChoseCorrectNum == 0) next_state = CHOOSE_13;
                if (iChoseWrongNum) next_state = LOAD_START;
                end
            CHOOSE_14: begin
                if (iChoseCorrectNum && oLevel > 5'd14) next_state = CHOOSE_15;
                else if (iChoseCorrectNum && oLevel == 5'd14) begin 
                    oLevel = oLevel + 1'd1;
                    next_state = LOAD_1;
                end
                else if (iChoseCorrectNum == 0) next_state = CHOOSE_14;
                if (iChoseWrongNum) next_state = LOAD_START;
                end
            CHOOSE_15: begin
                if (iChoseCorrectNum && oLevel > 5'd15) next_state = CHOOSE_16;
                else if (iChoseCorrectNum && oLevel == 5'd15) begin 
                    oLevel = oLevel + 1'd1;
                    next_state = LOAD_1;
                end
                else if (iChoseCorrectNum == 0) next_state = CHOOSE_15;
                if (iChoseWrongNum) next_state = LOAD_START;
                end
            CHOOSE_16: begin
                if (iChoseCorrectNum && oLevel > 5'd16) next_state = CHOOSE_17;
                else if (iChoseCorrectNum && oLevel == 5'd16) begin 
                    oLevel = oLevel + 1'd1;
                    next_state = LOAD_1;
                end
                else if (iChoseCorrectNum == 0) next_state = CHOOSE_16;
                if (iChoseWrongNum) next_state = LOAD_START;
                end
            CHOOSE_17: begin
                if (iChoseCorrectNum && oLevel > 5'd17) next_state = CHOOSE_18;
                else if (iChoseCorrectNum && oLevel == 5'd17) begin 
                    oLevel = oLevel + 1'd1;
                    next_state = LOAD_1;
                end
                else if (iChoseCorrectNum == 0) next_state = CHOOSE_17;
                if (iChoseWrongNum) next_state = LOAD_START;
                end
            CHOOSE_18: begin
                if (iChoseCorrectNum && oLevel > 5'd18) next_state = CHOOSE_19;
                else if (iChoseCorrectNum && oLevel == 5'd18) begin 
                    oLevel = oLevel + 1'd1;
                    next_state = LOAD_1;
                end
                else if (iChoseCorrectNum == 0) next_state = CHOOSE_18;
                if (iChoseWrongNum) next_state = LOAD_START;
                end
            CHOOSE_19: begin
                if (iChoseCorrectNum && oLevel > 5'd19) next_state = CHOOSE_20;
                else if (iChoseCorrectNum && oLevel == 5'd19) begin 
                    oLevel = oLevel + 1'd1;
                    next_state = LOAD_1;
                end
                else if (iChoseCorrectNum == 0) next_state = CHOOSE_19;
                if (iChoseWrongNum) next_state = LOAD_START;
                end
            CHOOSE_20: begin
                if (iChoseCorrectNum && oLevel > 5'd20) next_state = CHOOSE_21;
                else if (iChoseCorrectNum && oLevel == 5'd20) begin 
                    oLevel = oLevel + 1'd1;
                    next_state = LOAD_1;
                end
                else if (iChoseCorrectNum == 0) next_state = CHOOSE_20;
                if (iChoseWrongNum) next_state = LOAD_START;
                end
            CHOOSE_21: begin
                if (iChoseCorrectNum && oLevel > 5'd21) next_state = CHOOSE_22;
                else if (iChoseCorrectNum && oLevel == 5'd21) begin 
                    oLevel = oLevel + 1'd1;
                    next_state = LOAD_1;
                end
                else if (iChoseCorrectNum == 0) next_state = CHOOSE_21;
                if (iChoseWrongNum) next_state = LOAD_START;
                end
            CHOOSE_22: begin
                if (iChoseCorrectNum && oLevel > 5'd22) next_state = CHOOSE_23;
                else if (iChoseCorrectNum && oLevel == 5'd22) begin 
                    oLevel = oLevel + 1'd1;
                    next_state = LOAD_1;
                end
                else if (iChoseCorrectNum == 0) next_state = CHOOSE_22;
                if (iChoseWrongNum) next_state = LOAD_START;
                end
            CHOOSE_23: begin
                if (iChoseCorrectNum && oLevel > 5'd23) next_state = CHOOSE_24;
                else if (iChoseCorrectNum && oLevel == 5'd23) begin 
                    oLevel = oLevel + 1'd1;
                    next_state = LOAD_1;
                end
                else if (iChoseCorrectNum == 0) next_state = CHOOSE_23;
                if (iChoseWrongNum) next_state = LOAD_START;
                end
            CHOOSE_24: begin
                if (iChoseCorrectNum && oLevel > 5'd24) next_state = CHOOSE_25;
                else if (iChoseCorrectNum && oLevel == 5'd24) begin 
                    oLevel = oLevel + 1'd1;
                    next_state = LOAD_1;
                end
                else if (iChoseCorrectNum == 0) next_state = CHOOSE_24;
                if (iChoseWrongNum) next_state = LOAD_START;
                end
            CHOOSE_25: begin
                if (iChoseCorrectNum && oLevel > 5'd25) next_state = CHOOSE_26;
                else if (iChoseCorrectNum && oLevel == 5'd25) begin 
                    oLevel = oLevel + 1'd1;
                    next_state = LOAD_1;
                end
                else if (iChoseCorrectNum == 0) next_state = CHOOSE_25;
                if (iChoseWrongNum) next_state = LOAD_START;
                end
            CHOOSE_26: begin
                if (iChoseCorrectNum && oLevel > 5'd26) next_state = CHOOSE_27;
                else if (iChoseCorrectNum && oLevel == 5'd26) begin 
                    oLevel = oLevel + 1'd1;
                    next_state = LOAD_1;
                end
                else if (iChoseCorrectNum == 0) next_state = CHOOSE_26;
                if (iChoseWrongNum) next_state = LOAD_START;
                end
            CHOOSE_27: begin
                if (iChoseCorrectNum && oLevel > 5'd27) next_state = CHOOSE_28;
                else if (iChoseCorrectNum && oLevel == 5'd27) begin 
                    oLevel = oLevel + 1'd1;
                    next_state = LOAD_1;
                end
                else if (iChoseCorrectNum == 0) next_state = CHOOSE_27;
                if (iChoseWrongNum) next_state = LOAD_START;
                end
            CHOOSE_28: begin
                if (iChoseCorrectNum && oLevel > 5'd28) next_state = CHOOSE_29;
                else if (iChoseCorrectNum && oLevel == 5'd28) begin 
                    oLevel = oLevel + 1'd1;
                    next_state = LOAD_1;
                end
                else if (iChoseCorrectNum == 0) next_state = CHOOSE_28;
                if (iChoseWrongNum) next_state = LOAD_START;
                end
            CHOOSE_29: begin
                if (iChoseCorrectNum && oLevel > 5'd29) next_state = CHOOSE_30;
                else if (iChoseCorrectNum && oLevel == 5'd29) begin 
                    oLevel = oLevel + 1'd1;
                    next_state = LOAD_1;
                end
                else if (iChoseCorrectNum == 0) next_state = CHOOSE_29;
                if (iChoseWrongNum) next_state = LOAD_START;
                end
            CHOOSE_30: begin
                if (iChoseCorrectNum && oLevel > 5'd30) next_state = CHOOSE_31;
                else if (iChoseCorrectNum && oLevel == 5'd30) begin 
                    oLevel = oLevel + 1'd1;
                    next_state = LOAD_1;
                end
                else if (iChoseCorrectNum == 0) next_state = CHOOSE_30;
                if (iChoseWrongNum) next_state = LOAD_START;
                end
            CHOOSE_31: begin
                if (iChoseCorrectNum && oLevel > 5'd31) next_state = CHOOSE_32;
                else if (iChoseCorrectNum && oLevel == 5'd31) begin 
                    oLevel = oLevel + 1'd1;
                    next_state = LOAD_1;
                end
                else if (iChoseCorrectNum == 0) next_state = CHOOSE_31;
                if (iChoseWrongNum) next_state = LOAD_START;
                end
            // CHOOSE_31: begin
            //     if (iPressNum == 6'd31 && oLevel == 5'd31) next_state = LOAD_1;
            //     else if (iPressNum == 6'd0) next_state = CHOOSE_31;
            //     else next_state = LOAD_START;
            // end
            default: next_state = LOAD_START;
        endcase
    end

    // enable signals
    always@(*) begin
        oShowEnable = 0;
        oLoadEnable = 0;
        oResetBoard = 0;
        oNumToLoad = 0;
        oNumToChoose = 0;
        if (current_state < 7'd32) oLoadEnable = 1;
        if (current_state < 7'd34) oShowEnable = 1;
        if (current_state < 7'd2 || iKey0 || iReset) oResetBoard = 1;
        case (current_state): begin
            LOAD_1: oNumToLoad = 5'd1;
            LOAD_2: oNumToLoad = 5'd2;
            LOAD_3: oNumToLoad = 5'd3;
            LOAD_4: oNumToLoad = 5'd4;
            LOAD_5: oNumToLoad = 5'd5;
            LOAD_6: oNumToLoad = 5'd6;
            LOAD_7: oNumToLoad = 5'd7;
            LOAD_8: oNumToLoad = 5'd8;
            LOAD_9: oNumToLoad = 5'd9;
            LOAD_10: oNumToLoad = 5'd10;
            LOAD_11: oNumToLoad = 5'd11;
            LOAD_12: oNumToLoad = 5'd12;
            LOAD_13: oNumToLoad = 5'd13;
            LOAD_14: oNumToLoad = 5'd14;
            LOAD_15: oNumToLoad = 5'd15;
            LOAD_16: oNumToLoad = 5'd16;
            LOAD_17: oNumToLoad = 5'd17;
            LOAD_18: oNumToLoad = 5'd18;
            LOAD_19: oNumToLoad = 5'd19;
            LOAD_20: oNumToLoad = 5'd20;
            LOAD_21: oNumToLoad = 5'd21;
            LOAD_22: oNumToLoad = 5'd22;
            LOAD_23: oNumToLoad = 5'd23;
            LOAD_24: oNumToLoad = 5'd24;
            LOAD_25: oNumToLoad = 5'd25;
            LOAD_26: oNumToLoad = 5'd26;
            LOAD_27: oNumToLoad = 5'd27;
            LOAD_28: oNumToLoad = 5'd28;
            LOAD_29: oNumToLoad = 5'd29;
            LOAD_30: oNumToLoad = 5'd30;
            LOAD_31: oNumToLoad = 5'd31;
            CHOOSE_1: oNumToChoose = 5'd1;
            CHOOSE_2: begin
                oNumToChoose = 5'd2;
                oShowEnable = 0;
            end
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
            end
        endcase    
    end    

    always@(posedge clk) begin
        if (iKey0) current_state <= LOAD_START;
        else current_state <= next_state;
    end    
endmodule