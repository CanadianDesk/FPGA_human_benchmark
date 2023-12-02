
module zTopLevelMouse (
	// Inputs
	CLOCK_50,
	KEY,

	// Bidirectionals
	PS2_CLK,
	PS2_DAT,
	
	// Outputs
	HEX0,
	HEX1,
	HEX2,
	HEX3,
	HEX4,
	HEX5,
	HEX6,
	HEX7,

   LEDR
);

/*****************************************************************************
 *                           Parameter Declarations                          *
 *****************************************************************************/


/*****************************************************************************
 *                             Port Declarations                             *
 *****************************************************************************/

// Inputs
input				CLOCK_50;
input		[3:0]	KEY;

// Bidirectionals
inout				PS2_CLK;
inout				PS2_DAT;

// Outputs
output		[6:0]	HEX0;
output		[6:0]	HEX1;
output		[6:0]	HEX2;
output		[6:0]	HEX3;
output		[6:0]	HEX4;
output		[6:0]	HEX5;
output		[6:0]	HEX6;
output		[6:0]	HEX7;

output      [9:0]   LEDR;

/*****************************************************************************
 *                 Internal Wires and Registers Declarations                 *
 *****************************************************************************/

// Internal Wires
wire		[7:0]	ps2_key_data;
wire				mouseMoved;
wire 		[9:0] x_position;
wire 		[8:0] y_position;

wire mouseClicked;

// Internal Registers
reg			[7:0]	last_data_received;


assign LEDR[9] = x_position[9];
assign LEDR[8] = x_position[8];

assign LEDR[6] = y_position[8];
// State Machine Registers

/*****************************************************************************
 *                         Finite State Machine(s)                           *
 *****************************************************************************/




/*****************************************************************************
 *                             Sequential Logic                              *
 *****************************************************************************/

always @(posedge CLOCK_50)
begin
	if (KEY[0] == 1'b0)
		last_data_received <= 8'h00;
	else if (mouseMoved == 1'b1)
		last_data_received <= ps2_key_data;
end





/*****************************************************************************
 *                            Combinational Logic                            *
 *****************************************************************************/


/*****************************************************************************
 *                              Internal Modules                             *
 *****************************************************************************/

PS2_Controller PS2 (
	// Inputs
	.CLOCK_50				(CLOCK_50),
	.reset				(~KEY[0]),

	// Bidirectionals
	.PS2_CLK			(PS2_CLK),
 	.PS2_DAT			(PS2_DAT),

	// Outputs
	.received_data		(ps2_key_data),
	.received_data_en	(mouseMoved)
);

Hexadecimal_To_Seven_Segment Segment0 (
	// Inputs
	.hex_number			(x_position[3:0]),

	// Bidirectional

	// Outputs
	.seven_seg_display	(HEX0)
);

Hexadecimal_To_Seven_Segment Segment1 (
	// Inputs
	.hex_number			(x_position[7:4]),

	// Bidirectional

	// Outputs
	.seven_seg_display	(HEX1)
);


Hexadecimal_To_Seven_Segment Segment3 (
	// Inputs
	.hex_number			(y_position[3:0]),

	// Bidirectional

	// Outputs
	.seven_seg_display	(HEX3)
);

Hexadecimal_To_Seven_Segment Segment4 (
	// Inputs
	.hex_number			(y_position[7:4]),

	// Bidirectional

	// Outputs
	.seven_seg_display	(HEX4)
);



mouseCodeToSignal unit0(CLOCK_50, mouseMoved, ps2_key_data, x_position, y_position, LEDR[0]);

endmodule
