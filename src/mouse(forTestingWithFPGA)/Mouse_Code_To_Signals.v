module mouseCodeToSignal(  
	 input clk,
	 input mouseMoved,
    input [7:0] mouseData,
    output reg [9:0] x_position,
    output reg [8:0] y_position,
    output reg left_button_pressed
);

reg [1:0] byte_count;

reg x_negative;
reg y_negative;

reg reset;
reg reset1;


reg  [9:0] x_movement_signed;
reg  [11:0] new_x_position;

reg [9:0] y_movement_signed;
reg [11:0] new_y_position;

initial begin 
	reset = 1'b1;
	reset1 = 1'b1;
	x_movement_signed = 9'b0;
	new_x_position = 12'd160;
	y_movement_signed = 9'b0;
	new_y_position = 12'd120;
	x_position = 10'd160;  // Center of 320 width
   y_position = 10'd120;   // Center of 240 height
	byte_count = 2'b0;
end
	


always@(posedge clk)
begin
	 if (reset == 1'b1) 
    begin
	 x_position <= 10'd160;  // Center of 320 width
    y_position <= 10'd120;   // Center of 240 height
    end
	 else 
	 begin
	 x_position <= new_x_position[9:0];
	 y_position <= new_y_position[8:0];
	 end

end


always @(negedge mouseMoved)
begin
//this is a weird fsm because the mouse behaves so strangely and it sends 2 signals at the start so this accounts for that
	 if (reset == 1'b1) 
    begin
	 byte_count = 0;

	 reset <= 0;
    end
	 else if (reset1 == 1'b1) 
	 begin
		byte_count = 0;

		reset1 <= 0;
	 end
	
	
	 else if(byte_count == 2'b00)
	 begin
		  left_button_pressed <= mouseData[0]; 
		  x_negative <= mouseData[4];
		  y_negative <= mouseData[5];
		  byte_count = byte_count + 2'b1;
		  
	 end

	 else if(byte_count == 2'b01)
	 begin
		if(x_negative)
		begin
			if((x_position < ((mouseData) ^ 8'b11111111) + 1) )
			begin
				new_x_position <= 0;
			end
			else
			begin
				new_x_position <= (x_position - ((mouseData ^ 8'b11111111) + 1));
			end
		end
		else
		begin
			
			if(x_position + mouseData > 320)
			begin
				new_x_position <= 320;
			end
			else
				new_x_position <= x_position + mouseData;
		end

		byte_count = byte_count + 2'b01;

	end


	else if(byte_count == 2'b10)
	begin
		
		if(y_negative)
		begin
			if((y_position + ((mouseData ^ 8'b11111111) + 1)) > 240)
			begin
				new_y_position <= 240;
			end
			else
			begin
				new_y_position <= (y_position + ((mouseData ^ 8'b11111111) + 1));
			end
		end
		else
		begin
			
			if(y_position < mouseData)
			begin
				new_y_position <= 0;
			end
			else
				new_y_position <= y_position - mouseData;
		end
		
		byte_count = 2'b00;
			
	end

	 		 
end
endmodule



