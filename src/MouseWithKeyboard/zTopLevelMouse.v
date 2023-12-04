
module zTopLevelMouse (
	// Inputs
	CLOCK_50,
	KEY,

	// Bidirectionals
	PS2_CLK,
	PS2_DAT,
	
	// Outputs
	x_position,
	y_position,
	leftClick_pressed
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
output	[8:0] x_position;
output	[7:0] y_position;
output	leftClick_pressed;


// Internal Wires
wire		[7:0]	ps2_key_data;
wire				mouseMoved;


// Internal Registers
reg			[7:0]	last_data_received;


always @(posedge CLOCK_50)
begin
	if (KEY[3] == 1'b0)
		last_data_received <= 8'h00;
	else if (mouseMoved == 1'b1)
		last_data_received <= ps2_key_data;
end

MousePS2_Controller PS2 (
	// Inputs
	.CLOCK_50				(CLOCK_50),
	.reset				(~KEY[3]),

	// Bidirectionals
	.PS2_CLK			(PS2_CLK),
 	.PS2_DAT			(PS2_DAT),

	// Outputs
	.received_data		(ps2_key_data),
	.received_data_en	(mouseMoved)
);


mouseCodeToSignal unit0(CLOCK_50, mouseMoved, ps2_key_data, x_position, y_position, leftClick_pressed);

endmodule
