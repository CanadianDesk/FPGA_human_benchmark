// Chimp FSM Control Path
// Jonah Diamond
// ECE241 Project

module chimpTake2ControlPath();
    output reg [4:0] oLevel, [4:0] oNumToLoad, [4:0] oNumToChoose;
    output reg oShowEnable, oLoadEnable, oResetBoard;
    reg [6:0] current_state, next_state;
    localparam LOAD_START = 7'd0,
    LOAD_START_WAIT = 7'd1,
    LOAD_1 = 7'd2,
    LOAD_2 = 7'd3,
    LOAD_3 = 7'd4,
    LOAD_4 = 7'd5,
    LOAD_5 = 7'd6,
    LOAD_6 = 7'd7,
    LOAD_7 = 7'd8,
    LOAD_8 = 7'd9,
    LOAD_9 = 7'd10,
    LOAD_10 = 7'd11,
    LOAD_11 = 7'd12,
    LOAD_12 = 7'd13,
    LOAD_13 = 7'd14,
    LOAD_14 = 7'd15,
    LOAD_15 = 7'd16,
    LOAD_16 = 7'd17,
    LOAD_17 = 7'd18,
    LOAD_18 = 7'd19,
    LOAD_19 = 7'd20,
    LOAD_20 = 7'd21,
    LOAD_21 = 7'd22,
    LOAD_22 = 7'd23,
    LOAD_23 = 7'd24,
    LOAD_24 = 7'd25,
    LOAD_25 = 7'd26,
    LOAD_26 = 7'd27,
    LOAD_27 = 7'd28,
    LOAD_28 = 7'd29,
    LOAD_29 = 7'd30,
    LOAD_30 = 7'd31,
    LOAD_31 = 7'd32,
    START_GAME = 7'd33,
    START_GAME_WAIT = 7'd34,
    CHOOSE_1 = 7'd35,
    CHOOSE_2 = 7'd36,
    CHOOSE_3 = 7'd37,
    CHOOSE_4 = 7'd38,
    CHOOSE_5 = 7'd39,
    CHOOSE_6 = 7'd40,
    CHOOSE_7 = 7'd41,
    CHOOSE_8 = 7'd42,
    CHOOSE_9 = 7'd43,
    CHOOSE_10 = 7'd44,
    CHOOSE_11 = 7'd45,
    CHOOSE_12 = 7'd46,
    CHOOSE_13 = 7'd47,
    CHOOSE_14 = 7'd48,
    CHOOSE_15 = 7'd49,
    CHOOSE_16 = 7'd50,
    CHOOSE_17 = 7'd51,
    CHOOSE_18 = 7'd52,
    CHOOSE_19 = 7'd53,
    CHOOSE_20 = 7'd54,
    CHOOSE_21 = 7'd55,
    CHOOSE_22 = 7'd56,
    CHOOSE_23 = 7'd57,
    CHOOSE_24 = 7'd58,
    CHOOSE_25 = 7'd59,
    CHOOSE_26 = 7'd60,
    CHOOSE_27 = 7'd61,
    CHOOSE_28 = 7'd62,
    CHOOSE_29 = 7'd63,
    CHOOSE_30 = 7'd64,
    CHOOSE_31 = 7'd65;
    always @(*) begin
        case (current_state)
            LOAD_START: next_state = iSpace ? LOAD_START_WAIT : LOAD_START;
            LOAD_START_WAIT: next_state = iSpace ? LOAD_START_WAIT : LOAD_1;
            LOAD_1: next_state = (oLevel <= 5'd1) ? START_GAME : (iDoneLoad == 1)
            default: 
        endcase
    end
endmodule