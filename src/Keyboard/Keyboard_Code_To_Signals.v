module PS2_Demo (
    input [7:0] key_data,
    output reg space_pressed,
    output reg enter_pressed,
    output reg one_pressed,
    output reg two_pressed
);

    reg break_code_received;

    always @(key_data) begin
        if (key_data == 8'hF0) begin
            // Break code prefix detected
            break_code_received <= 1'b1;
        end 
		  else if (break_code_received) begin
            // Handle key release
            case (key_data)
                8'h29: space_pressed <= 1'b0;
                8'h5A: enter_pressed <= 1'b0;
                8'h16: one_pressed <= 1'b0;
                8'h1E: two_pressed <= 1'b0;
            endcase
            break_code_received <= 1'b0;
        end 
		  else begin
            // Handle key press
            case (key_data)
                8'h29: space_pressed <= 1'b1;
                8'h5A: enter_pressed <= 1'b1;
                8'h16: one_pressed <= 1'b1;
                8'h1E: two_pressed <= 1'b1;
            endcase
        end
    end

    // Initialize the break code flag and output signals
    initial begin
        break_code_received = 1'b0;
        space_pressed = 1'b0;
        enter_pressed = 1'b0;
        one_pressed = 1'b0;
        two_pressed = 1'b0;
    end
endmodule
