module reactionControl (
    input clk,
    input iReset,
    input spacePressed,
    input onePressed,
    input downCountComplete, 
    output reg [1:0] screen,
    output reg startUpCount,
    output reg startDownCount,
    output reg loadScore
);

    //States
    reg [2:0] current_state, next_state;

    localparam READY_WAIT = 0,
    READY = 1,
    RED_WAIT = 2,
    RED = 3,
    GREEN = 4,
    DONE_WAIT = 5,
    DONE = 6;


    //State transition logic
    always @(*) begin
        case (current_state)
            READY_WAIT: next_state = spacePressed ? READY_WAIT : READY;
            READY: next_state = spacePressed ? RED_WAIT : READY;
            RED_WAIT: next_state = spacePressed ? RED_WAIT : RED;
            RED: next_state = downCountComplete ? GREEN : RED;
            GREEN: next_state = onePressed ? DONE_WAIT : GREEN;
            DONE_WAIT: next_state = DONE;
            DONE: next_state = spacePressed ? READY_WAIT : DONE;
        endcase
    end

    //Signals
    always @(*) begin
        startUpCount = 0;
        startDownCount = 0;
        loadScore = 0;
        case (current_state)
            READY: screen = 0;
            RED_WAIT: startDownCount = 1;
            RED: begin
                screen = 1; 
                startUpCount = 1;
            end
            GREEN: screen = 2;
            DONE_WAIT: loadScore = 1;
            DONE: screen = 3;
        endcase
    end
    
    //State transition
    always @(posedge clk ) begin
        if (iReset)
            current_state <= READY;
        else 
            current_state <= next_state;
    end
endmodule