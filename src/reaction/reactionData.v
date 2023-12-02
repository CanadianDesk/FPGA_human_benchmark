module reactionData (
    input clk,
    input iReset,
    input [7:0] PRNG,
    input iStart_up_count,
    input iStart_down_count,
    input iLoad_score,
    output reg [13:0] highScore,
    output screen,
    output reg [13:0] currentScore,
    output countComplete
);
    wire m_clk;
    wire [12:0] m_PRNG;
    wire [13:0] upCount;

    rateDivider oneMHzClock(clk, iReset, m_clk);
    PRNG_scaler scaler(.cll(clk), .PRNG(PRNG), .m_PRNG(m_PRNG));
    upCounter countUP(.iStart_up_count(iStart_up_count), .iReset(iReset), .clk(m_clk),.upCount(upCount));
    downCounter countDown(
        .clk(m_clk) , 
        .iReset(iReset), 
        .iPRNG(m_PRNG), 
        .iStart_down_count(iStart_down_count), 
        .countComplete(countComplete)
    );

    always @(posedge iLoad_score) begin
        currentScore <= upCount;
        if (upCount < highScore) 
            highScore <= upCount;
    end

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
    input [12:0] iPRNG,
    input iStart_down_count,
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
    output reg [12:0] m_PRNG
);
    reg [19:0] temp;

    always @(posedge clk ) begin
        temp = 3000 * PRNG;
        m_PRNG = (temp / 255) + 300;
    end

endmodule

