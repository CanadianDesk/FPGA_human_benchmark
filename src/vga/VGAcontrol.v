//FSM THAT CONTROLS THE VGA


module VGAcontrol(
    input clk,
    input V_SYNC,
    input iReset,
    input keyPress,
	 input [1:0] reactScreen,
//	 input [11:0] currentScore,
    //input [8:0] iMouseX
    //input [7:0] iMouseY
    output [8:0] x,
    output [7:0] y,
    output [2:0] color,
    output reg writeEn
);

    reg [2:0] qReading;
    reg [8:0] xCounter/*, mouseRegX*/;
    reg [7:0] yCounter/*, mouseRegY*/;
    reg [16:0] readingAddress;
	 reg [4:0] mxCounter, myCounter;

    assign x = xCounter;
    assign y = yCounter;

    wire [2:0] qMenu, qRed, qBlue, qGreen, qScore;
    assign color = qReading;

    /**********************************************
    Modules to assign the Q values from ROM images
    **********************************************/

    menurom q1(readingAddress, clk, qMenu);
    redrom q2(readingAddress, clk, qRed);
	 greenrom q3(readingAddress, clk, qGreen);
	 bluerom q4(readingAddress, clk,qBlue);
	 scorerom q5(readingAddress, clk, qScore);

    /**********************************************
    STATE MACHINE TO CHOOSE THE RIGHT Q
    **********************************************/

//    reg [3:0] current_state, next_state;

//    //States
//    localparam MENU_WAIT = 0,
//    MENU = 1,
//    RED_WAIT = 2,
//    RED = 3;

    //State transition logic
//    always @(*) begin
//        case (current_state)
//            MENU_WAIT: next_state = keyPress ? MENU_WAIT : MENU;
//            MENU: next_state = keyPress ? RED_WAIT : MENU;
//            RED_WAIT: next_state = keyPress ? RED_WAIT : RED;
//            RED: next_state = keyPress ? MENU_WAIT: RED;
//            default: next_state = MENU;
//        endcase
//    end

    //Signals
    always @(*) begin
        case (reactScreen)
            2'd0: qReading = qBlue;
            2'd1: qReading = qRed;
				2'd2: qReading = qGreen;
				2'd3: qReading = qScore;
            default: qReading = qMenu;
        endcase
    end

//    //State transition
//    always @(posedge clk ) begin
//        if (iReset)
//            current_state <= MENU;
//        else
//            current_state <= next_state;
//    end
    


    /**********************************************
    DRAWING LOGIC
    **********************************************/
    reg V_SYNC_prev;

    always @(posedge clk) begin
        V_SYNC_prev <= V_SYNC;
        if (iReset) begin
            xCounter <= 0;
            yCounter <= 0;
				mxCounter <= 0;
				myCounter <= 0;
				readingAddress <= 0;
            writeEn <= 0;
        end 
        else if (~V_SYNC && V_SYNC_prev) begin
            writeEn <= 1;
            // mouseRegX <= iMouseX;
            // mouseRegY <= iMouseY;
        end
        else if (writeEn) begin
            if (xCounter == 319 && yCounter == 239) begin
					 /*OVERITE DRAWING LOGIC SHOULD GO HERE (CURSOR, SPRITES)*/
					 if (screen = 3) begin
						
					 end
					 else begin
						yCounter <= 0;
						xCounter <= 0;
						mxCounter <= 0;
						myCounter <= 0;
						readingAddress <= 0;					 
						writeEn <= 0
					 end
                yCounter <= 0;
                xCounter <= 0;
                readingAddress <= 0;					 
					 writeEn <= 0;
            end
            else if (xCounter == 319) begin
                yCounter <= yCounter + 1;
                xCounter <= 0;
                readingAddress <= readingAddress + 1;
            end
            else begin
                xCounter <= xCounter + 1;
                readingAddress <= readingAddress + 1;
            end
        end
    end

    
endmodule
