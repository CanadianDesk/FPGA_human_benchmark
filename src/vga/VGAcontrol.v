//FSM THAT CONTROLS THE VGA
module VGAcontrol(
    input clk,
    input V_SYNC,
    input iReset,
    input keyPress,
    input [1:0] reactScreen,
    input [11:0] currentScore,
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
    reg [2:0] screen3digitsCounter;
    reg [3:0] scoreOnes, scoreTens, scoreHundreds, scoreThousands;
    
    extractDigits digitExtractor(
        .value(currentScore),
        .thousands(scoreThousands),
        .hundreds(scoreHundreds),
        .tens(scoreTens),
        .ones(scoreOnes)
    );

    assign x = xCounter;
    assign y = yCounter;

    wire [2:0] QBACK, QSPRITE, QCURSOR, qMenu, qRed, qBlue, qGreen, qScore, qOne, qTwo, qThree, qFour, qFive, qSix, qSeven, qEight, qNine, qZero;
	assign QCURSOR = 3'b000; 
	reg backEn, cursorEn, spriteEn;
	 
	assign writeEn = backEn || cursorEn || spriteEn;
    assign color = qReading;

    /**********************************************
    Modules to assign the Q values from ROM images
    **********************************************/

    menurom q1(readingAddress, clk, qMenu);
    redrom q2(readingAddress, clk, qRed);
	greenrom q3(readingAddress, clk, qGreen);
	bluerom q4(readingAddress, clk,qBlue);
	scorerom q5(readingAddress, clk, qScore);
    rom0 q6(readingAddress, clk, qZero);
    rom1 q7(readingAddress, clk, qOne);
    rom2 q8(readingAddress, clk, qTwo);
    rom3 q9(readingAddress, clk, qThree);
    rom4 q10(readingAddress, clk, qFour);
    rom5 q11(readingAddress, clk, qFive);
    rom6 q12(readingAddress, clk, qSix);
    rom7 q13(readingAddress, clk, qSeven);
    rom8 q14(readingAddress, clk, qEight);
    rom9 q15(readingAddress, clk, qNine);

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
            2'd0: QBACK = qBlue;
            2'd1: QBACK = qRed;
			2'd2: QBACK = qGreen;
			2'd3: QBACK = qScore;
            default: QBACK = qMenu;
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
			readingAddress <= 0;
            backEn <= 0;
			spriteEn <= 0;
            mxCounter <= 0;
            myCounter <= 0;
			cursorEn <= 0;
            screen3digitsCounter <=0;
        end 
        else if (~V_SYNC && V_SYNC_prev) begin
            backEn <= 1;
            qReading <= QBACK;
            mouseRegX <= iMouseX;
            mouseRegY <= iMouseY;
        end
        else if (backEn) begin
            if (xCounter == 319 && yCounter == 239) begin
                /*OVERITE DRAWING LOGIC SHOULD GO HERE (CURSOR, SPRITES)*/
                readingAddress <= 0;					 
                backEn <= 0;
                if (reactScreen == 3) begin
                    qReading <= QSPRITE;
                    spriteEn <= 1;
                    //DESIGNATE WHICH SPRITE TO DRAW NEXT, AND WHERE:  
                    xCounter <= 120;
                    yCounter <= 155;                    
                    case (scoreThousands)
                        0: QSPRITE <= qZero;
                        1: QSPRITE <= qOne;
                        2: QSPRITE <= qTwo;
                        3: QSPRITE <= qThree; 
                        default: QSPRITE <= qNine; 
                    endcase
                end
                else begin
                    qReading <= QCURSOR;
                    cursorEn <= 1;
                end
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
        else if (spriteEn) begin
            //DRAW SPRITES WOOOOO!!!!
            //for react, start numbers at 120, 155 when reactScreen = 3
            //for chimp, [TODO]
            if (reactScreen == 3) begin
                if (mxCounter == 17 && myCounter == 17) begin //finished drawing one sprite
                    mxCounter <= 0;
                    myCounter <= 0;
                    readingAddress <= 0;
                    if (screen3digitsCounter == 3) begin //finished drawing all sprites
                        screen3digitsCounter <= 0;
                        spriteEn <= 0;
                        qReading <= QCURSOR;
                        cursorEn <= 1;                        
                    end
                    else begin  //need to draw next sprite
                        //DESIGNATE WHICH SPRITE TO DRAW NEXT, and where:
                        screen3digitsCounter <= screen3digitsCounter + 1;
                        xCounter <= ((screen3digitsCounter + 1) * 17) + 120;
                        xCounter <= ((screen3digitsCounter + 1) * 17) + 155;
                        case (screen3digitsCounter)
                            0: begin
                                case (scoreHundreds)
                                    0: QSPRITE <= qZero;
                                    1: QSPRITE <= qOne;
                                    2: QSPRITE <= qTwo;
                                    3: QSPRITE <= qThree;
                                    4: QSPRITE <= qFour;
                                    5: QSPRITE <= qFive;
                                    6: QSPRITE <= qSix;
                                    7: QSPRITE <= qSeven;
                                    8: QSPRITE <= qEight;
                                    9: QSPRITE <= qNine;
                                    default: 
                                endcase
                            end 
                            1: begin
                                case (scoreTens)
                                    0: QSPRITE <= qZero;
                                    1: QSPRITE <= qOne;
                                    2: QSPRITE <= qTwo;
                                    3: QSPRITE <= qThree;
                                    4: QSPRITE <= qFour;
                                    5: QSPRITE <= qFive;
                                    6: QSPRITE <= qSix;
                                    7: QSPRITE <= qSeven;
                                    8: QSPRITE <= qEight;
                                    9: QSPRITE <= qNine;
                                    default: 
                                endcase
                            end
                            2: begin
                                case (scoreOnes)
                                    0: QSPRITE <= qZero;
                                    1: QSPRITE <= qOne;
                                    2: QSPRITE <= qTwo;
                                    3: QSPRITE <= qThree;
                                    4: QSPRITE <= qFour;
                                    5: QSPRITE <= qFive;
                                    6: QSPRITE <= qSix;
                                    7: QSPRITE <= qSeven;
                                    8: QSPRITE <= qEight;
                                    9: QSPRITE <= qNine;
                                    default: 
                                endcase
                            end
                        endcase
                    end
                end
                else if (mxCounter == 17) begin //end row of a sprite
                    myCounter <= myCounter + 1;
                    yCounter <= yCounter + 1;
                    mxCounter <= 0;
                    xCounter <= (screen3digitsCounter * 17) + 120;
                    readingAddress <= readingAddress + 1;
                end 
                else begin
                    xCounter <= xCounter + 1;
                    mxCounter <= mxCounter + 1;
                    readingAddress <= readingAddress + 1;
                end
            end
        end
        else if (cursorEn) begin
            //DRAW CURSOR WOOOOO!!!!
        end
    end
endmodule


module extractDigits (
    input [11:0] value, //the 12 bit input of currentScore
    output reg [3:0] thousands,
    output reg [3:0] hundreds,
    output reg [3:0] tens,
    output reg [3:0] ones
);
    reg [15:0] temp1, temp2, temp3;
    //digit 1
    always @(*) begin
        temp1 = value / 1000;
        ones = temp1 % 10;
        temp2 = value / 100;
        tens = temp2 % 10;
        temp3 = value / 10;
        hundreds = temp3 % 10;
        ones = value % 10;
    end    


    
endmodule
