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

reg [10:0] counter;
reg continue;


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


always @(posedge clk)
begin
    if (reset == 1'b1) 
    begin

        count <= 1'b0;
		continue <= 1'b1;

        data_count <= 3'h0;
        data_shift_reg <= 8'h00;
        received_data <= 8'h00;
        received_data_en <= 1'b0;

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
			if(continue == 0)
			begin
				count = count + 1;
				if(count == 100)
				begin
					continue = 1'b1;
					count = 1'b0;
				end
			end
            received_data <= data_shift_reg;
            received_data_en <= 1'b1;

			// Check for key press and release
			if (data_shift_reg == 8'hF0)  // Check if the previous data was a release indicator
			begin
				case (data_shift_reg)
					8'h29: space_pressed <= 1'b0;
					8'h5A: enter_pressed <= 1'b0;
					8'h16: one_pressed <= 1'b0;
					8'h1E: two_pressed <= 1'b0;
				endcase
				//we want this to stop the system from receiving anything for a fraction of a second
				continue <= 1'b0;
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

