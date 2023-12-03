//FSM THAT CONTROLS THE VGA


module VGAcontrol(
    input clk,
    input V_SYNC,
    input iReset,
    input keyPress,
    input [8:0] iMouseX,
    input [7:0] iMouseY,
    output [8:0] x,
    output [7:0] y,
    output [2:0] color,
    output reg writeEn
);

    reg [2:0] qReading;
    reg [8:0] xCounter, mouseRegX;
    reg [7:0] yCounter, mouseRegY;
    reg [16:0] readingAddress;

    reg cursorPos;


    assign x = xCounter;
    assign y = yCounter;

    wire [2:0] qMenu, qRed;
    assign color = cursorPos ? 3'b000 : qReading;

    /**********************************************
    Modules to assign the Q values from ROM images
    *********************************************/

    menurom q1(readingAddress, clk, qMenu);
    redrom q2(readingAddress, clk, qRed);

    /**********************************************
    STATE MACHINE TO CHOOSE THE RIGHT Q
    **********************************************/

    reg [3:0] current_state, next_state;

    //States
    localparam MENU_WAIT = 0,
    MENU = 1,
    RED_WAIT = 2,
    RED = 3;

    //State transition logic
    always @(*) begin
        case (current_state)
            MENU_WAIT: next_state = keyPress ? MENU_WAIT : MENU;
            MENU: next_state = keyPress ? RED_WAIT : MENU;
            RED_WAIT: next_state = keyPress ? RED_WAIT : RED;
            RED: next_state = keyPress ? MENU_WAIT: RED;
            default: next_state = MENU;
        endcase
    end

    //Signals
    always @(*) begin
        case (current_state)
            MENU: qReading = qMenu;
            RED: qReading = qRed;
            default: qReading = qMenu;
        endcase
    end

    //State transition
    always @(posedge clk ) begin
        if (iReset)
            current_state <= MENU;
        else
            current_state <= next_state;
    end
    


    /**********************************************
    DRAWING LOGIC
    **********************************************/
    reg V_SYNC_prev;

    always @(posedge clk) begin
        V_SYNC_prev <= V_SYNC;
        if (iReset) begin
            xCounter = 0;
            yCounter = 0;
            writeEn = 0;
            cursorPos = 0;
        end 
        else if (~V_SYNC && V_SYNC_prev) begin //checks if negedge V_SYNC, stores mouseX and mouseY in register
            writeEn <= 1;
            mouseRegX <= iMouseX;
            mouseRegY <= iMouseY;
        end
        else if (writeEn) begin
            if (xCounter == 319 && yCounter == 249) begin
                cursorPos <= (mouseRegX == xCounter || mouseRegY == yCounter) ? 1 : 0;
                writeEn <= 0;
                yCounter <= 0;
                xCounter <= 0;
                readingAddress <= 0;
            end
            else if (xCounter == 319) begin
                cursorPos <= (mouseRegX == xCounter || mouseRegY == yCounter) ? 1 : 0;
                yCounter <= yCounter + 1;
                xCounter <= 0;
                readingAddress <= readingAddress + 1;
            end
            else begin
                cursorPos <= (mouseRegX == xCounter || mouseRegY == yCounter) ? 1 : 0;
                xCounter <= xCounter + 1;
                readingAddress <= readingAddress + 1;
            end
        end
    end

    
endmodule