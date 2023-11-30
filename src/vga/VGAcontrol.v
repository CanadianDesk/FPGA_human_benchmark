//FSM THAT CONTROLS THE VGA


module VGAcontrol(
    input clk,
    input [1:0] iGameMode,
    input V_SYNC,
    input iReset;
    output reg [8:0] x,
    output reg [7:0] y
    output [2:0] color,
    output writeEn;
);

    reg [2:0] qReading;
    reg [8:0] xCounter;
    reg [7:0] yCounter;
    reg qMenu;
    reg [16:0] readingAdress;

    assign x = xCounter;
    assign y = yCounter;

    reg [2:0] currentQ;
    assign color = currentQ;
    //Modules to assign the Q values
    menurom q1(readingAdress, clk, qMenu);


    /**********************************************
    STATE MACHINE TO CHOOSE THE RIGHT Q
    **********************************************/
    //States


    //State transition logic


    //Signals

    


    /**********************************************
    DRAWING LOGIC
    **********************************************/
    always @(negedge V_SYNC) begin
        xCounter <= 0;
        yCounter <= 0;
        readingAdress <= 0;
        writeEn <= 1;
    end

    always @(posedge clk) begin
        if (iReset) begin
            xCounter <= 0;
            yCounter <= 0;
            writeEn <= 0;
        end        

        if (writeEn) begin
            if (xCounter == 319 && yCounter == 249) begin
                writeEn = 0;
            end
            else if (xCounter == 319) begin
                yCounter = yCounter + 1;
                xCounter = 0;
                readingAdress = readingAdress + 1;
            end
            else begin
                xCounter = xCounter + 1;
                readingAdress = readingAdress + 1;
            end
        end
    end

    
endmodule