module zUltimateTopLevel(
	input CLOCK_50,
	input KEY,
	// Bidirectionals
	input PS2_CLK,
	input PS2_DAT,
	input PS2_CLK2,
	input PS2_DAT2.
	output one_pressed,
	output two_pressed,
	output space_pressed,
	output leftClick_pressed,
	output [8:0] x_position,
	output [7:0] y_position
);

zTopLevelKeyboard keyboard(CLOCK_50, KEY, PS2_CLK2, PS2_DAT2, space_pressed, enter_pressed, one_pressed, two_pressed);
zTopLevelMouse mouse(CLOCK_50, KEY, PS2_CLK, PS2_DAT, x_position, y_position, leftClick_pressed);

endmodule