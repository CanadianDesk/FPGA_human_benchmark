//FSM THAT CONTROLS THE VGA


module VGAcontrol(
    input clk,
    input [1:0] iGameMode,
    output reg menuEnable,
    output reg reactionEnable,
    output reg chimpEnable
);

    always @(posedge clk) begin
        case (iGameMode)
        2d'0: begin
            menuEnable = 1'b1;
            reactionEnable = 1'b0;
            chimpEnable = 1'b0;
        end
        2d'1: begin
            menuEnable = 1'b0;
            reactionEnable = 1'b1;
            chimpEnable = 1'b0;
        end
        2d'2: begin
            menuEnable = 1'b0;
            reactionEnable = 1'b0;
            chimpEnable = 1'b1;
        end
        default: begin
            menuEnable = 1'b0;
            reactionEnable = 1'b0;
            chimpEnable = 1'b0;   
        end
        endcase
    end

endmodule;

