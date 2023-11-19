// Main Menu Control Path
// Jonah Diamond
// ECE241 Project

// INPUTS
//// 1. 1 bit, high if 1 on the PS2 is pressed, low if not pressed
//// 2. 1 bit, high if 2 on the PS2 is pressed, low if not pressed
// OUTPUTS
//// 1. 2 bit, output of which mode to display (00 menu, 01 react, 10 chimp)

module zMainMenu(input i1, i2, iKey0, clk,
    output reg [1:0] oMode);
    reg [3:0] current_state, next_state;
    localparam MENU = 2'd0,
    REACT_WAIT = 2'd1,
    REACT = 2'd2,
    CHIMP_WAIT = 2'd3,
    CHIMP = 2'd4,
    MENU_WAIT = 2'd5;
    always@(*) begin
        case (current_state) 
        MENU: begin
            oMode = 2'd0;
            if (i1) next_state = REACT_WAIT;
            if (i2) next_state = CHIMP_WAIT;
            end
        REACT_WAIT: next_state = i1 ? REACT_WAIT : REACT;
        CHIMP_WAIT: next_state = 12 ? CHIMP_WAIT : CHIMP;
        REACT: begin 
            next_state = iKey0 ? MENU_WAIT : REACT;
            oMode = 2'd1;
            end
        CHIMP: begin
            next_state = iKey0 ? MENU_WAIT : CHIMP;
            oMode = 2'd2;
            end
        MENU_WAIT: next_state = iKey0 ? MENU_WAIT : MENU;
        default: next_state = MENU;
        endcase
    end

    always@(posedge clk) begin
        current_state = next_state;
    end    
endmodule

