//FSM THAT CONTROLS THE VGA


module VGAcontrol(
    input clk,
    input [1:0] iGameMode,
    output reg oMenuEnable,
    output reg oReactionEnable,
    output reg oChimpEnable
);

    reg [2:0] qReading

    always@(*) begin
        


    end

    

    always @(posedge clk) begin
        case (iGameMode)
        2d'0: begin
            oMenuEnable = 1'b1;
            oReactionEnable = 1'b0;
            oChimpEnable = 1'b0;
        end
        2d'1: begin
            oMenuEnable = 1'b0;
            oReactionEnable = 1'b1;
            oChimpEnable = 1'b0;
        end
        2d'2: begin
            oMenuEnable = 1'b0;
            oReactionEnable = 1'b0;
            oChimpEnable = 1'b1;
        end
        default: begin
            oMenuEnable = 1'b0;
            oReactionEnable = 1'b0;
            oChimpEnable = 1'b0;   
        end
        endcase
    end

endmodule;

