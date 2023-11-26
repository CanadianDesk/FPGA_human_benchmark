module prng #(
    N = 8;
) (
    input clk,
    input iReset,
    output reg [N-1:0] oOutput
);

    wire feedback;
    assign feedback = out[N-1] ^ out[5] ^ out[4] ^ out[3];

    always @(posedge clk, posedge iReset) begin
        if (iReset)
            out <= 1;
        else 
            out <= {out[N-2:0], feedback};
    end
    
endmodule