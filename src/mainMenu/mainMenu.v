// Main Menu Control Path
// Jonah Diamond
// ECE241 Project

// INPUTS
//// 1. 1 bit, high if 1 on the PS2 is pressed, low if not pressed
//// 2. 1 bit, high if 2 on the PS2 is pressed, low if not pressed
// OUTPUTS
//// 1. 2 bit, output of which mode to display (00 menu, 01 react, 10 chimp)

module mainMenu(input i1, i2, clk, iReset,
    output reg [1:0] oMode);
    //zUltimateTopLevel j45(.one_pressed(i1), .two_pressed(i2));
    reg [3:0] current_state, next_state;
    localparam MENU = 3'd0,
    REACT_WAIT = 3'd1,
    REACT = 3'd2,
    CHIMP_WAIT = 3'd3,
    CHIMP = 3'd4,
    MENU_WAIT = 3'd5;
    always@(*) begin
        case (current_state) 
        MENU: begin
            oMode = 2'd0;
            if (i1) next_state = REACT_WAIT;
            else if (i2) next_state = CHIMP_WAIT;
            else if (iReset) next_state = MENU_WAIT;
            end
        REACT_WAIT: next_state = i1 ? REACT_WAIT : REACT;
        REACT: begin 
            oMode = 2'd1;
            next_state = iReset ? MENU_WAIT : REACT;
            end
        CHIMP_WAIT: next_state = i2 ? CHIMP_WAIT : CHIMP;
        CHIMP: begin
            oMode = 2'd2;
            next_state = iReset ? MENU_WAIT : CHIMP;
            end
        MENU_WAIT: next_state = iReset ? MENU_WAIT : MENU;
        default: next_state = MENU;
        endcase
    end

    always@(posedge clk) begin
        current_state <= next_state;
    end    
endmodule

