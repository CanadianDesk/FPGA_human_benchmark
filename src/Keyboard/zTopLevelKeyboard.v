

module zTopLevelKeyboard(CLOCK_50, KEY, PS2_CLK, PS2_DAT, HEX0, HEX1, LEDR);
    input CLOCK_50;
    input [1:0] KEY;
    inout PS2_CLK;
    inout PS2_DAT;
    output [6:0] HEX0;
    output [6:0] HEX1;
    output [4:0] LEDR;

    wire [7:0] received_data;
	 wire command_was_sent;
	 wire error_communication_timed_out;

    hex_display u0(received_data[3:0], HEX0);
    hex_display u1(received_data[7:4], HEX1);
    PS2_Controller u2(CLOCK_50, !KEY[0], PS2_CLK, PS2_DAT, 	command_was_sent, error_communication_timed_out, received_data, LEDR[4], LEDR[3], LEDR[2], LEDR[1], LEDR[0]);
endmodule


