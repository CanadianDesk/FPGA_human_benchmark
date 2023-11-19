// Main Menu Control Path
// Jonah Diamond
// ECE241 Project

module mainMenuControlPath(input i1, i2, iKey0, clk,
    output oCurrState);
    localparam MENU = 2'd0,
    REACT_WAIT = 2'd1,
    REACT = 2'd2,
    CHIMP_WAIT = 2'd3,
    CHIMP = 2'd4,
    MENU_WAIT = 2'd5;
    always@(*) begin
        case (current_state) 
        MENU: begin
            if (i1) next_state = REACT_WAIT;
            if (i2) next_state = CHIMP_WAIT;
            end
        REACT_WAIT: next_state = i1 ? REACT_WAIT : REACT;
        CHIMP_WAIT: next_state = 12 ? CHIMP_WAIT : CHIMP;
        REACT: next_state = iKey0 ? MENU_WAIT : REACT;
        CHIMP: next_state = iKey0 ? MENU_WAIT : CHIMP;
        MENU_WAIT: next_state = iKey0 ? MENU_WAIT : MENU;
        default: next_state = MENU_WAIT;
        endcase
    end

    always@(posedge clk) begin
        current_state = next_state;
    end    
endmodule

