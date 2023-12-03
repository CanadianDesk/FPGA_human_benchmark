module decimal_To_Seven_Segment (
	// Inputs
	dec_number,
	// Outputs
	seven_seg_display
);


// Inputs
input		[3:0]	dec_number;

// Bidirectional

// Outputs
output		[6:0]	seven_seg_display;


assign seven_seg_display =
    ({7{(dec_number == 4'h0)}} & 7'b1000000) | // 0
    ({7{(dec_number == 4'h1)}} & 7'b1111001) | // 1
    ({7{(dec_number == 4'h2)}} & 7'b0100100) | // 2
    ({7{(dec_number == 4'h3)}} & 7'b0110000) | // 3
    ({7{(dec_number == 4'h4)}} & 7'b0011001) | // 4
    ({7{(dec_number == 4'h5)}} & 7'b0010010) | // 5
    ({7{(dec_number == 4'h6)}} & 7'b0000010) | // 6
    ({7{(dec_number == 4'h7)}} & 7'b1111000) | // 7
    ({7{(dec_number == 4'h8)}} & 7'b0000000) | // 8
    ({7{(dec_number == 4'h9)}} & 7'b0010000);  // 9
endmodule

