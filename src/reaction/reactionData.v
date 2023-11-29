module reactionData (
    input clk,
    input iReset,
    input iPRNG_en,
    input iStart_up_count,
    input iStart_down_count
);
    wire m_clk;

    rateDivider a0(clk, iReset, m_clk);

    
endmodule



module rateDivider (
    input clk,
    input iReset,
    output m_clk
);

    reg [5:0] downCount;

    always @(posedge clk ) begin
        if (iReset || downCount == 0)
            downCount <= 49;
        else
            downCount <= downCount - 1;
    end

    assign m_clk = (downCount == 0) ? 1 : 0;
    
endmodule

module upCounter (
    input iStart_up_count,
    input iReset,
    input clk,
    output reg [11:0] upCount
);

    always @(posedge clk ) begin
        if (iReset || iStart_up_count || upCount == 12'd4095)
            upCount <= 0;
        else
            upCount <= upCount + 1;
    end
    
endmodule

module downCoutner (
    input clk,
    input iReset,
    input iPRNG,
    input iStart_down_count
    output countComplete
);
    reg [12:0] downCount;

    always @(posedge clk ) begin
        if (iReset || iStart_down_count || downCount == 0)
            downCount <= iPRNG;
        else    
            downCount <= downCount - 1;
    end

    assign countComplete = (downCount == 0 ? 1 : 0);
    
endmodule


//takes a value from the PRNG (max 8 bits) and converts it linearly to a value between 3000 and 6000
module PRNG_scaler (
    input clk,
    input [7:0] PRNG,
    input PRNG_en,
    output reg [12:0] m_PRNG,
);
    reg [19:0] temp;

    always @(posedge clk ) begin
        if (PRNG_en) begin
            temp = 3000 * PRNG;
            m_PRNG = (temp / 255) + 300;
        end
    end

endmodule
