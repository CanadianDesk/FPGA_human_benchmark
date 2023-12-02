module prng #(
    parameter N = 8
) (
    input clk,
    input iReset,
    output reg [N-1:0] oOutput
);
    localparam seed = 31;
    wire feedback;
    assign feedback = oOutput[N-1] ^ oOutput[5] ^ oOutput[4] ^ oOutput[3];

    always @(posedge clk, posedge iReset) begin
        if (iReset)
            oOutput <= seed;
        else 
            oOutput <= {oOutput[N-2:0], feedback};
    end
    
endmodule