// Chimp FSM Top-Level Module
// Jonah Diamond
// ECE241 Project

// INPUTS
//// 1. 1 bit, clock
//// 2. 1 bit, high if KEY0 pressed (will reset game to main menu)
//// 3. 2 bit, 10 if chimp game selected, otherwise don't care
// OUTPUTS
//// 1. 

module chimpControlPath(input clk, iKey0, iEnter, [5:0] iPressNum);
    reg [6:0] current_state, next_state;
    reg [4:0] level;
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
            LOAD_1: next_state = (level > 5'd1) ? LOAD_2 : START_GAME;
            LOAD_2: next_state = (level > 5'd2) ? LOAD_3 : START_GAME;
            LOAD_3: next_state = (level > 5'd3) ? LOAD_4 : START_GAME;
            LOAD_4: next_state = (level > 5'd4) ? LOAD_5 : START_GAME;
            LOAD_5: next_state = (level > 5'd5) ? LOAD_6 : START_GAME;
            LOAD_6: next_state = (level > 5'd6) ? LOAD_7 : START_GAME;
            LOAD_7: next_state = (level > 5'd7) ? LOAD_8 : START_GAME;
            LOAD_8: next_state = (level > 5'd8) ? LOAD_9 : START_GAME;
            LOAD_9: next_state = (level > 5'd9) ? LOAD_10 : START_GAME;
            LOAD_10: next_state = (level > 5'd10) ? LOAD_11 : START_GAME;
            LOAD_11: next_state = (level > 5'd11) ? LOAD_12 : START_GAME;
            LOAD_12: next_state = (level > 5'd12) ? LOAD_13 : START_GAME;
            LOAD_13: next_state = (level > 5'd13) ? LOAD_14 : START_GAME;
            LOAD_14: next_state = (level > 5'd14) ? LOAD_15 : START_GAME;
            LOAD_15: next_state = (level > 5'd15) ? LOAD_16 : START_GAME;
            LOAD_16: next_state = (level > 5'd16) ? LOAD_17 : START_GAME;
            LOAD_17: next_state = (level > 5'd17) ? LOAD_18 : START_GAME;
            LOAD_18: next_state = (level > 5'd18) ? LOAD_19 : START_GAME;
            LOAD_19: next_state = (level > 5'd19) ? LOAD_20 : START_GAME;
            LOAD_20: next_state = (level > 5'd20) ? LOAD_21 : START_GAME;
            LOAD_21: next_state = (level > 5'd21) ? LOAD_22 : START_GAME;
            LOAD_22: next_state = (level > 5'd22) ? LOAD_23 : START_GAME;
            LOAD_23: next_state = (level > 5'd23) ? LOAD_24 : START_GAME;
            LOAD_24: next_state = (level > 5'd24) ? LOAD_25 : START_GAME;
            LOAD_25: next_state = (level > 5'd25) ? LOAD_26 : START_GAME;
            LOAD_26: next_state = (level > 5'd26) ? LOAD_27 : START_GAME;
            LOAD_27: next_state = (level > 5'd27) ? LOAD_28 : START_GAME;
            LOAD_28: next_state = (level > 5'd28) ? LOAD_29 : START_GAME;
            LOAD_29: next_state = (level > 5'd29) ? LOAD_30 : START_GAME;
            LOAD_30: next_state = (level > 5'd30) ? LOAD_31 : START_GAME;
            LOAD_31: next_state = START_GAME;
            START_GAME: next_state = iEnter ? CHOOSE_1 : START_GAME;
            CHOOSE_1: begin
                if (iPressNum == 6'd1 && level > 5'd1) next_state = CHOOSE_2;
                else if (iPressNum == 6'd1 && level == 5'd1) next_state = LOAD_1;
                else if (iPressNum == 6'd0) next_state = CHOOSE_1;
                else next_state = LOAD_START;
            end
            CHOOSE_2: begin
                if (iPressNum == 6'd2 && level > 5'd2) next_state = CHOOSE_3;
                else if (iPressNum == 6'd2 && level == 5'd2) next_state = LOAD_1;
                else if (iPressNum == 6'd0) next_state = CHOOSE_2;
                else next_state = LOAD_START;
            end
            CHOOSE_3: begin
                if (iPressNum == 6'd3 && level > 5'd3) next_state = CHOOSE_4;
                else if (iPressNum == 6'd3 && level == 5'd3) next_state = LOAD_1;
                else if (iPressNum == 6'd0) next_state = CHOOSE_3;
                else next_state = LOAD_START;
            end
            CHOOSE_4: begin
                if (iPressNum == 6'd4 && level > 5'd4) next_state = CHOOSE_5;
                else if (iPressNum == 6'd4 && level == 5'd4) next_state = LOAD_1;
                else if (iPressNum == 6'd0) next_state = CHOOSE_4;
                else next_state = LOAD_START;
            end
            CHOOSE_5: begin
                if (iPressNum == 6'd5 && level > 5'd5) next_state = CHOOSE_6;
                else if (iPressNum == 6'd5 && level == 5'd5) next_state = LOAD_1;
                else if (iPressNum == 6'd0) next_state = CHOOSE_5;
                else next_state = LOAD_START;
            end
            CHOOSE_6: begin
                if (iPressNum == 6'd6 && level > 5'd6) next_state = CHOOSE_7;
                else if (iPressNum == 6'd6 && level == 5'd6) next_state = LOAD_1;
                else if (iPressNum == 6'd0) next_state = CHOOSE_6;
                else next_state = LOAD_START;
            end
            CHOOSE_7: begin
                if (iPressNum == 6'd7 && level > 5'd7) next_state = CHOOSE_8;
                else if (iPressNum == 6'd7 && level == 5'd7) next_state = LOAD_1;
                else if (iPressNum == 6'd0) next_state = CHOOSE_7;
                else next_state = LOAD_START;
            end
            CHOOSE_8: begin
                if (iPressNum == 6'd8 && level > 5'd8) next_state = CHOOSE_9;
                else if (iPressNum == 6'd8 && level == 5'd8) next_state = LOAD_1;
                else if (iPressNum == 6'd0) next_state = CHOOSE_8;
                else next_state = LOAD_START;
            end
            CHOOSE_9: begin
                if (iPressNum == 6'd9 && level > 5'd9) next_state = CHOOSE_10;
                else if (iPressNum == 6'd9 && level == 5'd9) next_state = LOAD_1;
                else if (iPressNum == 6'd0) next_state = CHOOSE_9;
                else next_state = LOAD_START;
            end
            CHOOSE_10: begin
                if (iPressNum == 6'd10 && level > 5'd10) next_state = CHOOSE_11;
                else if (iPressNum == 6'd10 && level == 5'd10) next_state = LOAD_1;
                else if (iPressNum == 6'd0) next_state = CHOOSE_10;
                else next_state = LOAD_START;
            end
            CHOOSE_11: begin
                if (iPressNum == 6'd11 && level > 5'd11) next_state = CHOOSE_12;
                else if (iPressNum == 6'd11 && level == 5'd11) next_state = LOAD_1;
                else if (iPressNum == 6'd0) next_state = CHOOSE_11;
                else next_state = LOAD_START;
            end
            CHOOSE_12: begin
                if (iPressNum == 6'd12 && level > 5'd12) next_state = CHOOSE_13;
                else if (iPressNum == 6'd12 && level == 5'd12) next_state = LOAD_1;
                else if (iPressNum == 6'd0) next_state = CHOOSE_12;
                else next_state = LOAD_START;
            end
            CHOOSE_13: begin
                if (iPressNum == 6'd13 && level > 5'd13) next_state = CHOOSE_14;
                else if (iPressNum == 6'd13 && level == 5'd13) next_state = LOAD_1;
                else if (iPressNum == 6'd0) next_state = CHOOSE_13;
                else next_state = LOAD_START;
            end
            CHOOSE_14: begin
                if (iPressNum == 6'd14 && level > 5'd14) next_state = CHOOSE_15;
                else if (iPressNum == 6'd14 && level == 5'd14) next_state = LOAD_1;
                else if (iPressNum == 6'd0) next_state = CHOOSE_14;
                else next_state = LOAD_START;
            end
            CHOOSE_15: begin
                if (iPressNum == 6'd15 && level > 5'd15) next_state = CHOOSE_16;
                else if (iPressNum == 6'd15 && level == 5'd15) next_state = LOAD_1;
                else if (iPressNum == 6'd0) next_state = CHOOSE_15;
                else next_state = LOAD_START;
            end
            CHOOSE_16: begin
                if (iPressNum == 6'd16 && level > 5'd16) next_state = CHOOSE_17;
                else if (iPressNum == 6'd16 && level == 5'd16) next_state = LOAD_1;
                else if (iPressNum == 6'd0) next_state = CHOOSE_16;
                else next_state = LOAD_START;
            end
            CHOOSE_17: begin
                if (iPressNum == 6'd17 && level > 5'd17) next_state = CHOOSE_18;
                else if (iPressNum == 6'd17 && level == 5'd17) next_state = LOAD_1;
                else if (iPressNum == 6'd0) next_state = CHOOSE_17;
                else next_state = LOAD_START;
            end
            CHOOSE_18: begin
                if (iPressNum == 6'd18 && level > 5'd18) next_state = CHOOSE_19;
                else if (iPressNum == 6'd18 && level == 5'd18) next_state = LOAD_1;
                else if (iPressNum == 6'd0) next_state = CHOOSE_18;
                else next_state = LOAD_START;
            end
            CHOOSE_19: begin
                if (iPressNum == 6'd19 && level > 5'd19) next_state = CHOOSE_20;
                else if (iPressNum == 6'd19 && level == 5'd19) next_state = LOAD_1;
                else if (iPressNum == 6'd0) next_state = CHOOSE_19;
                else next_state = LOAD_START;
            end
            CHOOSE_20: begin
                if (iPressNum == 6'd20 && level > 5'd20) next_state = CHOOSE_21;
                else if (iPressNum == 6'd20 && level == 5'd20) next_state = LOAD_1;
                else if (iPressNum == 6'd0) next_state = CHOOSE_20;
                else next_state = LOAD_START;
            end
            CHOOSE_21: begin
                if (iPressNum == 6'd21 && level > 5'd21) next_state = CHOOSE_22;
                else if (iPressNum == 6'd21 && level == 5'd21) next_state = LOAD_1;
                else if (iPressNum == 6'd0) next_state = CHOOSE_21;
                else next_state = LOAD_START;
            end
            CHOOSE_22: begin
                if (iPressNum == 6'd22 && level > 5'd22) next_state = CHOOSE_23;
                else if (iPressNum == 6'd22 && level == 5'd22) next_state = LOAD_1;
                else if (iPressNum == 6'd0) next_state = CHOOSE_22;
                else next_state = LOAD_START;
            end
            CHOOSE_23: begin
                if (iPressNum == 6'd23 && level > 5'd23) next_state = CHOOSE_24;
                else if (iPressNum == 6'd23 && level == 5'd23) next_state = LOAD_1;
                else if (iPressNum == 6'd0) next_state = CHOOSE_23;
                else next_state = LOAD_START;
            end
            CHOOSE_24: begin
                if (iPressNum == 6'd24 && level > 5'd24) next_state = CHOOSE_25;
                else if (iPressNum == 6'd24 && level == 5'd24) next_state = LOAD_1;
                else if (iPressNum == 6'd0) next_state = CHOOSE_24;
                else next_state = LOAD_START;
            end
            CHOOSE_25: begin
                if (iPressNum == 6'd25 && level > 5'd25) next_state = CHOOSE_26;
                else if (iPressNum == 6'd25 && level == 5'd25) next_state = LOAD_1;
                else if (iPressNum == 6'd0) next_state = CHOOSE_25;
                else next_state = LOAD_START;
            end
            CHOOSE_26: begin
                if (iPressNum == 6'd26 && level > 5'd26) next_state = CHOOSE_27;
                else if (iPressNum == 6'd26 && level == 5'd26) next_state = LOAD_1;
                else if (iPressNum == 6'd0) next_state = CHOOSE_26;
                else next_state = LOAD_START;
            end
            CHOOSE_27: begin
                if (iPressNum == 6'd27 && level > 5'd27) next_state = CHOOSE_28;
                else if (iPressNum == 6'd27 && level == 5'd27) next_state = LOAD_1;
                else if (iPressNum == 6'd0) next_state = CHOOSE_27;
                else next_state = LOAD_START;
            end
            CHOOSE_28: begin
                if (iPressNum == 6'd28 && level > 5'd28) next_state = CHOOSE_29;
                else if (iPressNum == 6'd28 && level == 5'd28) next_state = LOAD_1;
                else if (iPressNum == 6'd0) next_state = CHOOSE_28;
                else next_state = LOAD_START;
            end
            CHOOSE_29: begin
                if (iPressNum == 6'd29 && level > 5'd29) next_state = CHOOSE_30;
                else if (iPressNum == 6'd29 && level == 5'd29) next_state = LOAD_1;
                else if (iPressNum == 6'd0) next_state = CHOOSE_29;
                else next_state = LOAD_START;
            end
            CHOOSE_30: begin
                if (iPressNum == 6'd30 && level > 5'd30) next_state = CHOOSE_31;
                else if (iPressNum == 6'd30 && level == 5'd30) next_state = LOAD_1;
                else if (iPressNum == 6'd0) next_state = CHOOSE_30;
                else next_state = LOAD_START;
            end
            CHOOSE_31: begin
                if (iPressNum == 6'd31 && level == 5'd31) next_state = LOAD_1;
                else if (iPressNum == 6'd0) next_state = CHOOSE_31;
                else next_state = LOAD_START;
            end
            default: next_state = LOAD_START;
        endcase
    end

    // enable signals
    always@(*) begin
        //level = 5'd0;
        ////do we do anything in this ????
    end    

    always@(posedge clk) begin
        if (iKey0) current_state <= LOAD_START;
        else current_state <= next_state;
    end    
endmodule