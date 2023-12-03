module zTopLevelHex(
    input CLOCK_50,
    input mode,
    input [11:0]reactCurrentScore,
    input [11:0]reactHighScore,
    input screen,
    input [4:0] chimpLevel,
    output [6:0] HEX0,
    output [6:0] HEX1,
    output [6:0] HEX2,
    output [6:0] HEX3,
    output [6:0] HEX4,
    output [6:0] HEX5,
    output [6:0] HEX6,
    output [6:0] HEX7
);

reg [3:0] display0;
reg [3:0] display1;
reg [3:0] display2;
reg [3:0] display3;

// Internal variables
integer decimal_value;
integer thousands, hundreds, tens, ones;
	
initial 
begin
    display0 = 0;
    display1 = 0;
    display2 = 0;
    display3 = 0;

end

always @(posedge CLOCK_50)
begin
    if(mode == 0)
    begin
        display0 = 0;
        display1 = 0;
        display2 = 0;
        display3 = 0;
        //do nothing
    end
    else if(mode == 1) //react
    begin
        if(screen == 3)
        begin
            decimal_value = reactCurrentScore; // Interpret binary as decimal
            thousands = decimal_value / 1000;
            hundreds = (decimal_value % 1000) / 100;
            tens = (decimal_value % 100) / 10;
            ones = (decimal_value % 10);
            display0 = ones;
            display1 = tens;
            display2 = hundreds;
            display3 = thousands;
        end
        else
        begin
            decimal_value = reactHighScore; // Interpret binary as decimal
            thousands = decimal_value / 1000;
            hundreds = (decimal_value % 1000) / 100;
            tens = (decimal_value % 100) / 10;
            ones = (decimal_value % 10);
            display0 = ones;
            display1 = tens;
            display2 = hundreds;
            display3 = thousands;
        end
    end
    else if(mode == 2) // chimp
    begin
        decimal_value = chimpLevel; // Interpret binary as decimal
        tens = (decimal_value % 100) / 10;
        ones = (decimal_value % 10);
        display0 = ones;
        display1 = tens;
        display2 = 0;
        display3 = 0;
    end
end

decimal_To_Seven_Segment unit0(display0, HEX0);
decimal_To_Seven_Segment unit1(display1, HEX1);
decimal_To_Seven_Segment unit2(display2, HEX2);
decimal_To_Seven_Segment unit3(display3, HEX3);

endmodule