module code_to_signal (
    input clk,  // System clock at 50 MHz
    input [7:0] key_data,
    input reset,
    output reg space_pressed,
    output reg enter_pressed,
    output reg one_pressed,
    output reg two_pressed
);

    reg break_code_received;
    reg [23:0] delay_counter;  // Enough to count 12,500,000 cycles
    reg delay_active;

    always @(posedge clk) begin
        if (reset) begin
            // Reset logic
            space_pressed <= 1'b0;
            enter_pressed <= 1'b0;
            one_pressed <= 1'b0;
            two_pressed <= 1'b0;
            break_code_received <= 1'b0;
            delay_counter <= 0;
            delay_active <= 1'b0;
        end else begin
            if (delay_active) begin
                // Count down the delay period
                if (delay_counter > 0) begin
                    delay_counter <= delay_counter - 1;
                end else begin
                    // Delay period has ended
                    delay_active <= 1'b0;
                    space_pressed <= 1'b0;
                    enter_pressed <= 1'b0;
                    one_pressed <= 1'b0;
                    two_pressed <= 1'b0;
                end
            end else if (key_data == 8'hF0) begin
                // Break code prefix detected
                break_code_received <= 1'b1;
            end else if (break_code_received) begin
                // Start the delay period
                delay_counter <= 12500000;  // For a quarter of a second delay at 50 MHz
                delay_active <= 1'b1;
                break_code_received <= 1'b0;
            end else begin
                // Handle key press
                case (key_data)
                    8'h29: if (!delay_active) space_pressed <= 1'b1;
                    8'h5A: if (!delay_active) enter_pressed <= 1'b1;
                    8'h16: if (!delay_active) one_pressed <= 1'b1;
                    8'h1E: if (!delay_active) two_pressed <= 1'b1;
                endcase
            end
        end
    end

    // Initialize the break code flag and output signals
    initial begin
        break_code_received = 1'b0;
        delay_active = 1'b0;
        delay_counter = 0;
        space_pressed = 1'b0;
        enter_pressed = 1'b0;
        one_pressed = 1'b0;
        two_pressed = 1'b0;
    end
endmodule
