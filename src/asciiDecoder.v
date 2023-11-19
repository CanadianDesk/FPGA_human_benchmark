
module scancode_to_ascii(
	input wire clk, 
	input wire reset_n,
   input wire [7:0] scan_code,
   input wire scan_code_ready, // A flag that indicates a new scan code has been captured
   output reg enter_pressed,
   output reg space_pressed,
	output reg one_pressed,
	output reg two_pressed
);

    always @(posedge clk) 
	 begin
		 if (reset_n == 1) 
		 begin
			  // Reset the flags if the system is reset
			  enter_pressed <= 1'b0;
			  space_pressed <= 1'b0;
		 end 
		 else if (scan_code_ready)
		 begin
			  // Check the scan_code and set flags accordingly
			  case (scan_code)
					//enter pressed
					8'h5A: 
					begin
						 enter_pressed <= 1'b1;
					end
					//space pressed
					8'h29: 
					begin
						 space_pressed <= 1'b1;
					end
					// '1' pressed
					8'h16: 
					begin
						 one_pressed <= 1'b1;
					end
					// '2' pressed
					8'h1E: begin
						two_pressed <= 1'b1;
					end
					// Enter released (break code)
					8'hF0, 8'h5A: begin
						 enter_pressed <= 1'b0;
					end
					// Space released (break code)
					8'hF0, 8'h29: begin
						 space_pressed <= 1'b0;
					end
					// '1' released (break code)
					8'hF0, 8'h16: begin
						 one_pressed <= 1'b0;
					end
					// '2' released (break code)
					8'hF0, 8'h1E: begin
						 two_pressed <= 1'b0;
					end
            default: begin
                // If none of the above, clear all flags
                enter_pressed <= 1'b0;
                space_pressed <= 1'b0;
                one_pressed <= 1'b0;
                two_pressed <= 1'b0;
            end
					
			endcase
		 end 
		 else 
		 begin
			  // Clear the flags if no new scan code is ready
			  enter_pressed <= 1'b0;
			  space_pressed <= 1'b0;
		 end
	end


endmodule



module scancode_to_ascii(
    input wire clk, 
    input wire reset_n,
    input wire [7:0] scan_code,
    input wire scan_code_ready, // A flag that indicates a new scan code has been captured
    output reg enter_pressed,
    output reg space_pressed,
    output reg one_pressed,
    output reg two_pressed
);

    reg break_code_received; // Flag to indicate that the next scan code is a break code

    always @(posedge clk) begin
        if (reset_n == 1) begin
            // Reset the flags if the system is reset
            enter_pressed <= 1'b0;
            space_pressed <= 1'b0;
            one_pressed <= 1'b0;
            two_pressed <= 1'b0;
            break_code_received <= 1'b0;
        end 
        else if (scan_code_ready) begin
            if (scan_code == 8'hF0) begin
                // If we receive the break code prefix, set our flag and wait for the next code
                break_code_received <= 1'b1;
            end
            else if (break_code_received) begin
                // If the break code prefix was received, check the following scan code
                case (scan_code)
                    8'h5A: enter_pressed <= 1'b0; // Enter key released
                    8'h29: space_pressed <= 1'b0; // Space key released
                    8'h16: one_pressed <= 1'b0;   // '1' key released
                    8'h1E: two_pressed <= 1'b0;   // '2' key released
                endcase
                // Reset the break code received flag after handling the break code
                break_code_received <= 1'b0;
            end
            else begin
                // If it's not a break code, handle the make code
                case (scan_code)
                    8'h5A: enter_pressed <= 1'b1; // Enter key pressed
                    8'h29: space_pressed <= 1'b1; // Space key pressed
                    8'h16: one_pressed <= 1'b1;   // '1' key pressed
                    8'h1E: two_pressed <= 1'b1;   // '2' key pressed
                endcase
            end
        end
        else begin
            // If scan_code_ready is not high, don't change the state of the output signals
            // This else block can actually be removed if we're not clearing the outputs
            // when scan_code_ready is low.
        end
    end

endmodule
