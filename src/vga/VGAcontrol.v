//FSM THAT CONTROLS THE VGA
module VGAcontrol(
    input clk,
    input V_SYNC,
    input iReset,
    input [1:0] reactScreen,
    input [11:0] currentScore,
    output [8:0] x,
    output [7:0] y,
    output [2:0] color,
    output writeEn
);

    reg [2:0] qReading;
    reg [8:0] xCounter/*, mouseRegX*/;
    reg [7:0] yCounter/*, mouseRegY*/;
    reg [16:0] readingAddress;
	reg [4:0] mxCounter, myCounter;
    reg [2:0] screen3digitsCounter;
    wire [3:0] scoreOnes, scoreTens, scoreHundreds, scoreThousands;
    
    extractDigits digitExtractor(
        .value(currentScore),
        .thousands(scoreThousands),
        .hundreds(scoreHundreds),
        .tens(scoreTens),
        .ones(scoreOnes)
    );

    assign x = xCounter;
    assign y = yCounter;

    wire [2:0] QCURSOR, qMenu, qRed, qBlue, qGreen, qScore, qOne, qTwo, qThree, qFour, qFive, qSix, qSeven, qEight, qNine, qZero;
    reg [2:0] QBACK, QSPRITE;
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
            2'd0: QBACK <= qBlue;
            2'd1: QBACK <= qRed;
			2'd2: QBACK <= qGreen;
			2'd3: QBACK <= qScore;
            default: QBACK <= qMenu;
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
            mouseRegX <= iMouseX;
            mouseRegY <= iMouseY;
            xCounter <= 0;
            yCounter <= 0;
        end
        else if (backEn) begin
            qReading <= QBACK;
            if (xCounter == 319 && yCounter == 239) begin
                /*OVERITE DRAWING LOGIC SHOULD GO HERE (CURSOR, SPRITES)*/
                readingAddress <= 0;					 
                backEn <= 0;
                if (reactScreen == 3) begin
                    spriteEn <= 1;
                    //DESIGNATE WHERE TO DRAW SPRITE NEXT:  
                    xCounter <= 120;
                    yCounter <= 155;                    
                end
                else begin
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
            qReading <= QSPRITE;
            if (reactScreen == 3) begin
                //UPDATE THE COLORS FROM ROM
                case (screen3digitsCounter)
                    0: begin
                        case (scoreThousands)
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
                        endcase
                    end 
                    1: begin
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
                        endcase
                    end
                    2: begin
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
                        endcase
                    end
                    3: begin
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
                        endcase
                    end                    
                endcase                
                if (mxCounter == 17 && myCounter == 17) begin //finished drawing one sprite
                    mxCounter <= 0;
                    myCounter <= 0;
                    readingAddress <= 0;
                    if (screen3digitsCounter == 3) begin //finished drawing all sprites
                        screen3digitsCounter <= 0;
                        spriteEn <= 0;
                        cursorEn <= 1;
                        xCounter <= 0;
                        yCounter <= 0;                        
                    end
                    else begin  //need to draw next sprite
                        //DESIGNATE WHERE TO DRAW NEXT:
                        screen3digitsCounter <= screen3digitsCounter + 1;
                        xCounter <= ((screen3digitsCounter + 1) * 17) + 120;
                        yCounter <= 155;
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
            qReading <= QCURSOR;
            //DRAW CURSOR WOOOOO!!!!
            if (mxCounter == 3 && myCounter == 3) begin //done drawing cursor
                xCounter <= 0;
                yCounter <= 0;
                mxCounter <= 0;
                myCounter <= 0;
                cursorEn <= 0;
            end 
            else if (mxCounter == 3) begin
                mxCounter <= 0;
                xCounter <= mouseRegX - 2;
                yCounter <= yCounter + 1;
                myCounter <= myCounter + 1;
            end 
            else begin
                mxCounter <= mxCounter
            end
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
        thousands = temp1 % 10;
        temp2 = value / 100;
        hundreds = temp2 % 10;
        temp3 = value / 10;
        tens = temp3 % 10;
        ones = value % 10;
    end    
    
endmodule
