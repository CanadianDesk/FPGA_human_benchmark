// Main Menu Control Path
// Jonah Diamond
// ECE241 Project

module mainctrlpath(input iMode, iQuit, [1:0] iUserChoice/*, output*/);
    localparam LOAD_MODE = 2'd0,
    LOAD_MODE_WAIT = 2'd1,
    LOAD_SCREEN = 2'd2;
    always@(*) begin
        case (current_state) 
        LOAD_MODE: next_state = iMode ? LOAD_MODE_WAIT : LOAD_MODE;
        LOAD_MODE_WAIT: next_state = iMode ? LOAD_MODE_WAIT : LOAD_SCREEN;
        LOAD_SCREEN: begin
            if (iQuit) next_state = LOAD_MODE;
            else if (!iQuit) next_state = LOAD_SCREEN;
            else if (iMode) next_state = LOAD_MODE_WAIT;
            else if (!iMode) next_state = LOAD_MODE;
            end
        default: next_state = LOAD_MODE;
        endcase
    end

    output reg menu, react, chimp;

    always@(*) begin
        //set signals to 0 by default
        menu = 1'b0;
        react = 1'b0;
        chimp = 1'b0;
        case (next_state)
        LOAD_MODE: begin
            if (iUserChoice == 2'd0) menu = 1;
            else if (iUserChoice == 2'd1) react = 1;
            else if (iUserChoice == 2'd2) chimp = 1;
            end
        LOAD_MODE_WAIT: begin
            ///confused
            end
    end

endmodule

