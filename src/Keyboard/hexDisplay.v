module hex_display(SW, HEX0);
	input [3:0] SW;
	output [6:0] HEX0;
	
	hex_decoder u1(SW, HEX0);
	
endmodule



module hex_decoder(c, display);
	input [3:0] c;
	output [6:0] display;
	
	//IMPORTANT: COMMON ANODE DISPLAY, SO SEGMENTS ARE TRIGGERED ON BY A LOGIC ZERO, NOT A LOGIC ONE
	
	assign display[0] = !( (c[3] | c[2] | c[1] | ~c[0]) & (c[3] | ~c[2] | c[1] | c[0]) & (~c[3] | c[2] | ~c[1] | ~c[0]) & (~c[3] | ~c[2] | c[1] | ~c[0]) );
	assign display[1] = !( (c[3] | ~c[2] | c[1] | ~c[0]) & (c[3] | ~c[2] | ~c[1] | c[0]) & (~c[3] | c[2] | ~c[1] | c[0]) & (~c[3] | ~c[2] | c[1] | c[0]) & (~c[3] | ~c[2] | ~c[1] | c[0]) & (~c[3] | ~c[2] | ~c[1] | ~c[0]) );
	assign display[2] = !( (c[3] | c[2] | ~c[1] | c[0]) & (~c[3] | ~c[2] | c[1] | c[0]) & (~c[3] | ~c[2] | ~c[1] | c[0]) & (~c[3] | ~c[2] | ~c[1] | ~c[0]) );
	assign display[3] = !( (c[3] | c[2] | c[1] | ~c[0]) & (c[3] | ~c[2] | c[1] | c[0]) & (c[3] | ~c[2] | ~c[1] | ~c[0]) & (~c[3] | c[2] | c[1] | ~c[0]) & (~c[3] | c[2] | ~c[1] | c[0]) & (~c[3] | ~c[2] | ~c[1] | ~c[0]) );
	assign display[4] = !( (c[3] | c[2] | c[1] | ~c[0]) & (c[3] | c[2] | ~c[1] | ~c[0]) & (c[3] | ~c[2] | c[1] | c[0]) & (c[3] | ~c[2] | c[1] | ~c[0]) & (c[3] | ~c[2] | ~c[1] | ~c[0] ) & (~c[3] | c[2] | c[1] | ~c[0]) );
	assign display[5] = !( (c[3] | c[2] | c[1] | ~c[0]) & (c[3] | c[2] | ~c[1] | c[0]) & (c[3] | c[2] | ~c[1] | ~c[0]) & (c[3] | ~c[2] | ~c[1] | ~c[0]) & (~c[3] | ~c[2] | c[1] | ~c[0]) );
	assign display[6] = !( (c[3] | c[2] | c[1] | c[0]) & (c[3] | c[2] | c[1] | ~c[0]) & (c[3] | ~c[2] | ~c[1] | ~c[0]) & (~c[3] | ~c[2] | c[1] | c[0]) );
	
endmodule 