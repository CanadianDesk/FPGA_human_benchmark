// Part 2 skeleton

module VGA
	(
		CLOCK_50,						//	On Board 50 MHz
		// Your inputs and outputs here
		KEY,
		LEDR,
		HEX0,
		HEX1,
		HEX2,
		HEX3,
		HEX4,
		HEX5,
		// On Board Keys
		// The ports below are for the VGA output.  Do not change.
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B,   						//	VGA Blue[9:0]
		PS2_DAT,
		PS2_DAT2,
		PS2_CLK,
		PS2_CLK2
	);

	input			CLOCK_50;				//	50 MHz
	inout PS2_DAT;
	inout PS2_DAT2;
	inout PS2_CLK;
	inout PS2_CLK2;
	input	[3:0]	KEY;		
	output [9:0] LEDR;
	// Declare your inputs and outputs here
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[7:0]	VGA_R;   				//	VGA Red[7:0] Changed from 10 to 8-bit DAC
	output	[7:0]	VGA_G;	 				//	VGA Green[7:0]
	output	[7:0]	VGA_B;   				//	VGA Blue[7:0]
	output [6:0] HEX0;
   output [6:0] HEX1;
   output [6:0] HEX2;
   output [6:0] HEX3;
   output [6:0] HEX4;
   output [6:0] HEX5;
	
	wire resetn;
	assign resetn = KEY[0];
	wire leftClick, onePressed, twoPressed;
	wire [6:0] board [7:0][7:0];
	
	// Create the colour, x, y and writeEn wires that are inputs to the controller.

	wire [2:0] colour;
	wire [8:0] x, mouseX;
	wire [7:0] y, mouseY;
	wire writeEn;
	wire [1:0] screen, gameMode;
	wire [11:0] currentScore, highScore;
	wire [4:0] level;
	wire temp;
	wire [5:0] roundCount;
	wire resetBoard;
	wire [6:0] currState;
	
	
//	assign LEDR[0] = |board[0][0] || |board[0][1] || |board[0][2] || |board[0][3] || |board[0][4] || |board[0][5] || |board[0][6] || |board[0][7];
//	assign LEDR[1] = |board[1][0] || |board[1][1] || |board[1][2] || |board[1][3] || |board[1][4] || |board[1][5] || |board[1][6] || |board[1][7];
//	assign LEDR[2] = |board[2][0] || |board[2][1] || |board[2][2] || |board[2][3] || |board[2][4] || |board[2][5] || |board[2][6] || |board[2][7];
//	assign LEDR[3] = |board[3][0] || |board[3][1] || |board[3][2] || |board[3][3] || |board[3][4] || |board[3][5] || |board[3][6] || |board[3][7];
//	assign LEDR[4] = |board[4][0] || |board[4][1] || |board[4][2] || |board[4][3] || |board[4][4] || |board[4][5] || |board[4][6] || |board[4][7];
//	assign LEDR[5] = |board[5][0] || |board[5][1] || |board[5][2] || |board[5][3] || |board[5][4] || |board[5][5] || |board[5][6] || |board[5][7];
//	assign LEDR[6] = |board[6][0] || |board[6][1] || |board[6][2] || |board[6][3] || |board[6][4] || |board[6][5] || |board[6][6] || |board[6][7];
//	assign LEDR[7] = |board[7][0] || |board[7][1] || |board[7][2] || |board[7][3] || |board[7][4] || |board[7][5] || |board[7][6] || |board[7][7];
	assign LEDR[0] = roundCount[0];
	assign LEDR[1] = roundCount[1];
	assign LEDR[2] = roundCount[2];
	assign LEDR[3] = roundCount[3];
	assign LEDR[4] = roundCount[4];
	assign LEDR[5] = roundCount[5];
	
	assign LEDR[6] = leftClick;
	
	assign LEDR[9] = resetBoard;

	
	reaction reactGame(
		.clk(CLOCK_50),
		.iReset(~KEY[0]),
		.spacePressed(leftClick),
		.onePressed(leftClick),
		.screen(screen),
		.currentScore(currentScore),
		.highScore(highScore)
	);
	
	zTopLevelHex darsanqi(
		.CLOCK_50(CLOCK_50),
		.mode(gameMode),
		.reactCurrentScore(currentScore),
		.reactHighScore(highScore),
		.screen(screen),
		.chimpLevel(level),
		.currState(currState),
		.HEX0(HEX0),
		.HEX1(HEX1),
		.HEX2(HEX2),
		.HEX3(HEX3),
		.HEX4(HEX4),
		.HEX5(HEX5)
	);
	
	chimpTake2 jonahsbaby(
		.clk(CLOCK_50),
		.iReset(~KEY[0]),
		.board(board),
		.level(level),
		.roundCount(roundCount),
		.resetBoard(resetBoard),
		.current_state(currState)
	);
	
	zUltimateTopLevel darsansbaby(
		.CLOCK_50(CLOCK_50),
		.KEY(KEY),
		.PS2_CLK(PS2_CLK),
		.PS2_CLK2(PS2_CLK2),
		.PS2_DAT(PS2_DAT),
		.PS2_DAT2(PS2_DAT2),
		.one_pressed(onePressed),
		.two_pressed(twoPressed),
		.leftClick_pressed(leftClick),
		.x_position(mouseX),
		.y_position(mouseY)
	);
	
	mainMenu jonahdiamond(
		.i1(onePressed),
		.i2(twoPressed),
		.clk(CLOCK_50),
		.iReset(~KEY[0]),
		.oMode(gameMode)
	);
	
	
	VGAcontrol u0(
		.clk(CLOCK_50),
		.V_SYNC(VGA_VS),
		.reactScreen(screen),
		.iReset(!KEY[0]),
		.x(x),
		.y(y),
		.color(colour),
		.currentScore(currentScore),
		.iMouseX(mouseX),
		.iMouseY(mouseY),
		.writeEn(writeEn),
		.iMode(gameMode),
		.board(board));

	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(writeEn),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "320x240";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "menu.mif";
			
	// Put your code here. Your code should produce signals x,y,colour and writeEn
	// for the VGA controller, in addition to any other functionality your design may require.
	
	
endmodule
