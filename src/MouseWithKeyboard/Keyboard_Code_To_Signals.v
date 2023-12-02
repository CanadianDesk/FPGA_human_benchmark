module code_to_signal (
    input [7:0] last_data_received,
    input key_pressed,
    input reset,
    output reg space_pressed,
    output reg enter_pressed,
    output reg one_pressed,
    output reg two_pressed
);

    reg read;
    reg read1;

    // Initialize the break code flag and output signals
    initial begin
        
        space_pressed = 1'b0;
        enter_pressed = 1'b0;
        one_pressed = 1'b0;
        two_pressed = 1'b0;
        read = 1'b0;
        read1 = 1'b0;
    end

    always @(posedge key_pressed) begin
        if (reset) begin
            // Reset logic
            space_pressed <= 1'b0;
            enter_pressed <= 1'b0;
            one_pressed <= 1'b0;
            two_pressed <= 1'b0;
          
        end 
        else 
        begin
            case (last_data_received)
            8'h29:
                begin
                    if(read == 1'b0 && read1 == 1'b0)
                    begin
                        space_pressed <= 1'b1;
                        read <= 1'b1;
                        read1 <= 1'b1;
                    end
                    if(read1 == 1'b0)
                    begin
                        read <= 1b'0;
                    end
                end

            8'h5A:
                begin
                    if(read == 1'b0 && read1 == 1'b0)
                    begin
                        enter_pressed <= 1'b1;
                        read <= 1'b1;
                        read1 <= 1'b1;
                    end
                    if(read1 == 1'b0)
                    begin
                        read <= 1b'0;
                    end
                end
            8'h16:
                begin
                    if(read == 1'b0 && read1 == 1'b0)
                    begin
                        one_pressed <= 1'b1;
                        read <= 1'b1;
                        read1 <= 1'b1;
                    end
                    if(read1 == 1'b0)
                    begin
                        read <= 1b'0;
                    end
                end
            8'h1E:
                begin
                    if(read == 1'b0 && read1 == 1'b0)
                    begin
                        two_pressed <= 1'b1;
                        read <= 1'b1;
                        read1 <= 1'b1;
                    end
                    if(read1 == 1'b0)
                    begin
                        read <= 1b'0;
                    end
                end
            8'hf0:
                begin
                    read1 <= 1'b0;
                    space_pressed <= 1'b0;
                    enter_pressed <= 1'b0;
                    one_pressed <= 1'b0;
                    two_pressed <= 1'b0;
                end

            endcase
        end
    end
endmodule





