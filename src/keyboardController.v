module keyboard_controller(
	input wire clk,
	input wire reset_n,
	input wire scan_code_ready,
	input wire space_pressed,  
    input wire enter_pressed,
    input wire one_pressed,
    input wire two_pressed,
    output reg SPACE_PRESSED,
    output reg ENTER_PRESSED,
    output reg ONE_PRESSED,
    output reg TWO_PRESSED
);
   // State machine states for the keyboard controller
   localparam WAIT_FOR_KEY   = 2'b00;
   localparam DECODE_KEY     = 2'b01;

   reg [1:0] state;
	
   // Main state machine for the keyboard controller
	always @(posedge clk or negedge reset_n) 
	begin
		if (reset_n == 1)
		begin
			state <= WAIT_FOR_KEY;
		end 
		
		else 
		begin
			case (state)
				WAIT_FOR_KEY: 
				begin
					if (scan_code_ready) 
					begin
						state <= DECODE_KEY;
					end
					
					// Reset the SPACE_PRESSED and ENTER_PRESSED signals by default
					SPACE_PRESSED <= 0;
					ENTER_PRESSED <= 0;
                    ONE_PRESSED <= 0;
                    TWO_PRESSED <= 0;
					
				end
				
				DECODE_KEY: 
				begin
					// This is a placeholder
					if(space_pressed)
					begin
					//the user has pressed the spacebar, meaning that we will have to measure the reaction time and transition from the green state to the 
						SPACE_PRESSED = 1'b1;	
					end
					
					else if (enter_pressed)
					begin
					//the user has pressed enter, meaning that we transition from the results state to the red state
						ENTER_PRESSED = 1'b1;
					end

                    else if(one_pressed)
                    {
                        ONE_PRESSED = 1'b1;
                    }		

                    else if(two_pressed)
                    {
                        TWO_PRESSED = 1'b1;
                    }
					else
					begin
						SPACE_PRESSED = 1'b0;
						ENTER_PRESSED = 1'b0;
                        ONE_PRESSED = 1'b0;
                        TWO_PRESSED = 1'b0;
					end
					
					state <= WAIT_FOR_KEY;
				end
			endcase
		end
	end
	
	
endmodule