`timescale 1ns/1ns

module reaction (
    input clk,
    input iReset,
    input spacePressed,
    input onePressed,
    output [1:0] screen,
    output [13:0] currentScore,
    output [13:0] highScore
);
    wire downCountComplete, startUpCount, startDownCount, loadScore;
    wire [7:0] PRNG_out;

    reactionControl reationGameControlPath(
        .clk(clk),
        .iReset(iReset),
        .spacePressed(spacePressed),
        .onePressed(onePressed),
        .downCountComplete(downCountComplete),
        .screen(screen),
        .startUpCount(startUpCount),
        .startDownCount(startDownCount),
        .loadScore(loadScore)
    );

    reactionData reactionGameDataPath(
        .clk(clk),
        .iReset(iReset),
        .PRNG(PRNG_out),
        .iStart_up_count(startUpCount),
        .iStart_down_count(startDownCount),
        .iLoad_score(loadScore),
        .highScore(highScore),
        .screen(screen),
        .currentScore(currentScore),
        .countComplete(downCountComplete)
    );

    prng reactPRNG(
        .clk(clk),
        .iReset(iReset),
        .oOutput(PRNG_out)
    );


endmodule