module mouseCodeToSignal(
    input [7:0] mouseData,
    input reset,
    input clk,
    output reg [9:0] x_position,
    output reg [8:0] y_position,
    output reg left_button_pressed
);

reg [1:0] byte_count;
reg [7:0] byte_0;
reg [7:0] byte_1;
reg [7:0] byte_2;

reg x_negative;
reg y_negative;


reg[10:0] new_x_position;
reg[10:0] new_y_position;

initial 
begin
    byte_count <= 1'b0;
    byte_0 = 1'b0;
    byte_1 = 1'b0;
    byte_2 = 1'b0;
    x_negative = 1'b0;
    y_negative = 1'b0;
end

always @(posedge clk)
begin 
    if (reset == 1'b1) 
    begin
		byte_count <= 0;
		byte_0 <= 0;
		byte_1 <= 0;
		byte_2 <= 0;

		x_position <= 10'd160;  // Center of 320 width
        y_position <= 9'd120;   // Center of 240 height
    end
end

always @(mouseData)
begin
    if(byte_count == 0)
    begin
        byte_0 <= mouseData;
        left_button_pressed = byte_0[0]; 
        x_negative <= byte_0[4];
        y_negative <= byte_0[5];
    end

    else if(byte_count == 1)
    begin
        byte_1 <= mouseData;
        if(x_negative)
        begin
            new_x_position = x_position - byte_1;
        end

        else
        begin
            new_x_position = x_position + byte_1;
        end
       
        if (new_x_position > 320) 
        begin
            x_position = 320;
        end 
        else if (new_x_position < 0) 
        begin
            x_position = 0;
        end 
        else 
        begin
            x_position = new_x_position;
        end
    end

    else if(byte_count == 2)
    begin
        byte_2 <= mouseData;
        if(y_negative)
        begin
            new_y_position = y_position - byte_2;
        end
        else
        begin
            new_y_position = y_position + byte_2;
        end
       
        if (new_y_position > 320) 
        begin
            y_position = 320;
        end 
        else if (new_y_position < 0) 
        begin
            y_position = 0;
        end 
        else 
        begin
            y_position = new_y_position;
        end
    end

    byte_count <= byte_count + 1;
 
    if(byte_count == 3)
    begin
        byte_count <= 0;
    end
    
end
endmodule
