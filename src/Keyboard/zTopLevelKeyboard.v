module zTopLevelKeyboard(CLOCK_50, KEY, PS2_CLK, PS2_DAT, HEX, LEDR)
    input CLOCK_50;
    input KEY0;
    inout PS2_CLK;
    inout PS2_DAT;
    output [6:0] HEX0;
    output [6:0] HEX1;
    output [4:0] LEDR;

    wire [7:0] received_data;

    hex_display u0(received_data[3:0], HEX0);
    hex_display u0(received_data[7:4], HEX1);
    PS2_Controller u0(CLOCK_50, KEY0, PS2_CLK, PS2_DAT, received_data, LEDR[4], LEDR[3], LEDR[2], LEDR[1], LEDR[0]);
endmodule