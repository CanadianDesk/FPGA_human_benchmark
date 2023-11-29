module mouseCodeToSignal(


    output x_position;
    output y_position;
    
);

always @(posedge clk)
begin
    if (reset == 1'b1) 
    begin
		byte_count <= 0;

		byte_1 <= 0;
		byte_2 <= 0;
		byte_3 <= 0;

		x_position <= 10'd160;  // Center of 320 width
        y_position <= 9'd120;   // Center of 240 height
		
        data_count <= 3'h0;
        data_shift_reg <= 8'h00;
        received_data <= 8'h00;
        received_data_en <= 1'b0;
    end
    else
    begin
        // Data Count Logic
        if ((s_ps2_receiver == PS2_STATE_2_DATA_IN) && (ps2_clk_posedge == 1'b1))
            data_count <= data_count + 3'h1;
        else if (s_ps2_receiver != PS2_STATE_2_DATA_IN)
            data_count <= 3'h0;

        // Data Shift Register Logic
        if ((s_ps2_receiver == PS2_STATE_2_DATA_IN) && (ps2_clk_posedge == 1'b1))
            data_shift_reg <= {ps2_data, data_shift_reg[7:1]};

        // Received Data and Key Press Logic
        if (s_ps2_receiver == PS2_STATE_4_STOP_IN)
        begin

            received_data <= data_shift_reg;
            received_data_en <= 1'b1;

			byte_count <= byte_count + 1; 
			if(byte_count == 1)
			{
				byte_1 <= data_shift_reg;
			}
			else if(byte count == 2)
			{
				byte_2 <= data_shift_reg;
			}
			else if(byte_count == 3)
			{
				byte_3 <= data_shift_reg;
			}
			
   
			if (byte_count == 3) begin // Mouse

				left_button_pressed = byte_1[0]; 

				// Interpret the 8-bit movement data as signed values
				signed [8:0] x_movement_signed = (x_negative) ? -byte_2 : byte_2;
				signed [8:0] y_movement_signed = (y_negative) ? -byte_3 : byte_3;

				// Update X position
				signed [10:0] new_x_position = x_position + (x_movement_signed/x_sensitivity);
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
					x_position = new_x_position[9:0];
				end

				// Update Y position
				signed [9:0] new_y_position = y_position + (y_movement_signed/y_sensitivity);
				if (new_y_position > 240)
				begin
					y_position = 240;
				end 
				else if (new_y_position < 0) 
				begin
					y_position = 0;
				end 
				else 
				begin
					y_position = new_y_position[8:0];
				end

				byte_1 <= 0;
				byte_2 <= 0;
				byte_3 <= 0;
				byte_count <= 0;
			end
        end
		
        else if (s_ps2_receiver != PS2_STATE_4_STOP_IN)
        begin
            received_data_en <= 1'b0;
        end
    end
end
endmodule
