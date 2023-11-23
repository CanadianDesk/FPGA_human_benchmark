/*****************************************************************************
 *                                                                           *
 * Module:       Altera_UP_PS2_Data_In                                       *
 * Description:                                                              *
 *      This module accepts incoming data from a PS2 core.                   *
 *                                                                           *
 *****************************************************************************/


module Altera_UP_PS2_Data_In (
	// Inputs
	clk,
	reset,

	wait_for_incoming_data,
	start_receiving_data,

	ps2_clk_posedge,
	ps2_clk_negedge,
	ps2_data,

	// Bidirectionals

	// Outputs
	received_data,
	received_data_en,			// If 1 - new data has been received

	enter_pressed,
	space_pressed,
	one_pressed,
	two_pressed,

	xPos,
	yPos,
	mousePressed
);


/*****************************************************************************
 *                           Parameter Declarations                          *
 *****************************************************************************/


/*****************************************************************************
 *                             Port Declarations                             *
 *****************************************************************************/
// Inputs
input				clk;
input				reset;

input				wait_for_incoming_data;
input				start_receiving_data;

input				ps2_clk_posedge;
input				ps2_clk_negedge;
input			 	ps2_data;

// Outputs
output reg enter_pressed;
output reg space_pressed;
output reg one_pressed;
output reg two_pressed;


reg [8:0] x_movement;  // 9-bit signed integer for X movement
reg [8:0] y_movement;  // 9-bit signed integer for Y movement
reg [9:0] x_position;  // 10-bit integer for X position on screen (0-319)
reg [8:0] y_position;  // 9-bit integer for Y position on screen (0-239)

output reg mousePressed;


// Bidirectionals

// Outputs
output reg	[7:0]	received_data;
output reg		 	received_data_en;

/*****************************************************************************
 *                           Constant Declarations                           *
 *****************************************************************************/
// states
localparam	PS2_STATE_0_IDLE			= 3'h0,
			PS2_STATE_1_WAIT_FOR_DATA	= 3'h1,
			PS2_STATE_2_DATA_IN			= 3'h2,
			PS2_STATE_3_PARITY_IN		= 3'h3,
			PS2_STATE_4_STOP_IN			= 3'h4;

/*****************************************************************************
 *                 Internal wires and registers Declarations                 *
 *****************************************************************************/
// Internal Wires
reg			[3:0]	data_count;
reg			[7:0]	data_shift_reg;

// State Machine Registers
reg			[2:0]	ns_ps2_receiver;
reg			[2:0]	s_ps2_receiver;


reg [2:0] byte_count;  // Counter for the number of bytes received
reg device_type;       // 0 for keyboard, 1 for mouse
reg [7:0] byte_1, byte_2, byte_3;  // Registers to store mouse packet bytes


/*****************************************************************************
 *                         Finite State Machine(s)                           *
 *****************************************************************************/

always @(posedge clk)
begin
	if (reset == 1'b1)
		s_ps2_receiver <= PS2_STATE_0_IDLE;
	else
		s_ps2_receiver <= ns_ps2_receiver;
end

always @(*)
begin
	// Defaults
	ns_ps2_receiver = PS2_STATE_0_IDLE;

    case (s_ps2_receiver)
	PS2_STATE_0_IDLE:
		begin
			if ((wait_for_incoming_data == 1'b1) && 
					(received_data_en == 1'b0))
				ns_ps2_receiver = PS2_STATE_1_WAIT_FOR_DATA;
			else if ((start_receiving_data == 1'b1) && 
					(received_data_en == 1'b0))
				ns_ps2_receiver = PS2_STATE_2_DATA_IN;
			else
				ns_ps2_receiver = PS2_STATE_0_IDLE;
		end
	PS2_STATE_1_WAIT_FOR_DATA:
		begin
			if ((ps2_data == 1'b0) && (ps2_clk_posedge == 1'b1))
				ns_ps2_receiver = PS2_STATE_2_DATA_IN;
			else if (wait_for_incoming_data == 1'b0)
				ns_ps2_receiver = PS2_STATE_0_IDLE;
			else
				ns_ps2_receiver = PS2_STATE_1_WAIT_FOR_DATA;
		end
	PS2_STATE_2_DATA_IN:
		begin
			if ((data_count == 3'h7) && (ps2_clk_posedge == 1'b1))
				ns_ps2_receiver = PS2_STATE_3_PARITY_IN;
			else
				ns_ps2_receiver = PS2_STATE_2_DATA_IN;
		end
	PS2_STATE_3_PARITY_IN:
		begin
			if (ps2_clk_posedge == 1'b1)
				ns_ps2_receiver = PS2_STATE_4_STOP_IN;
			else
				ns_ps2_receiver = PS2_STATE_3_PARITY_IN;
		end
	PS2_STATE_4_STOP_IN:
		begin
			if (ps2_clk_posedge == 1'b1)
				ns_ps2_receiver = PS2_STATE_0_IDLE;
			else
				ns_ps2_receiver = PS2_STATE_4_STOP_IN;
		end
	default:
		begin
			ns_ps2_receiver = PS2_STATE_0_IDLE;
		end
	endcase
end

/*****************************************************************************
 *                             Sequential logic                              *
 *****************************************************************************/

reg [7:0] previous_data;  // Register to hold the previous scan code

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
		
        device_type <= 0; // Default to keyboard, can be changed based on initialization response

        data_count <= 3'h0;
        data_shift_reg <= 8'h00;
        received_data <= 8'h00;
        received_data_en <= 1'b0;
        previous_data <= 8'h00;  // Reset the previous data register
        // Reset the key state variables
        space_pressed <= 1'b0;
        enter_pressed <= 1'b0;
        one_pressed <= 1'b0;
        two_pressed <= 1'b0;
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

			if (byte_count == 0) 
			begin
				// Checking if the packet is likely from a mouse
				if (data_shift_reg[3] == 1'b1) 
				begin
					// The packet matches the structure expected from a mouse
					device_type <= 1;  // Set device type to mouse
				end 
				else 
				begin
					// The packet does not match the mouse structure
					device_type <= 0;  // Set device type to keyboard
				end
			end

			if(device_type == 1)
			{
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
			}
			
			if(device_type == 0)
			{
				// Check for key press and release
				if (previous_data == 8'hF0)  // Check if the previous data was a release indicator
				begin
					case (data_shift_reg)
						8'h29: space_pressed <= 1'b0;
						8'h5A: enter_pressed <= 1'b0;
						8'h16: one_pressed <= 1'b0;
						8'h1E: two_pressed <= 1'b0;
					endcase
				end
				else 
				begin
					case (data_shift_reg)
						8'h29: space_pressed <= 1'b1;
						8'h5A: enter_pressed <= 1'b1;
						8'h16: one_pressed <= 1'b1;
						8'h1E: two_pressed <= 1'b1;
					endcase
				end
			}
   
			if (byte_count == 3) begin // Mouse

				left_button_pressed = byte_1[0]; 

				// Interpret the 8-bit movement data as signed values
				signed [8:0] x_movement_signed = (x_negative) ? -byte_2 : byte_2;
				signed [8:0] y_movement_signed = (y_negative) ? -byte_3 : byte_3;

				// Update X position
				signed [10:0] new_x_position = x_position + x_movement_signed;
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
				signed [9:0] new_y_position = y_position + y_movement_signed;
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



            previous_data <= data_shift_reg;  // Update the previous data
        end
        else if (s_ps2_receiver != PS2_STATE_4_STOP_IN)
        begin
            received_data_en <= 1'b0;
        end
    end
end



/*****************************************************************************
 *                            Combinational logic                            *
 *****************************************************************************/


/*****************************************************************************
 *                              Internal Modules                             *
 *****************************************************************************/


endmodule

