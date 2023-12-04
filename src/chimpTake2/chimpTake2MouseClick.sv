



// INPUTS: Reset, clk, mouseX, mouseY
// OUTPUTS: BoxX, BoxY

module chimpTake2MouseClick(input iReset, clk, [9:0] mouseX, [8:0] mouseY, output reg [2:0] BoxX, [2:0] BoxY);

    always @(posedge clk ) begin
        
        //DEAL WITH X:
        if (mouseX > 16 && mouseX < 37)
            BoxX <= 0;
        else if (mouseX > 53 && mouseX < 74)
            BoxX <= 1;
        else if (mouseX > 90 && mouseX < 111)
            BoxX <= 2;
        else if (mouseX > 127 && mouseX < 148)
            BoxX <= 3;
        else if (mouseX > 164 && mouseX < 185)
            BoxX <= 4;
        else if (mouseX > 201 && mouseX < 222)
            BoxX <= 5;
        else if (mouseX > 238 && mouseX < 259)
            BoxX <= 6;
        else if (mouseX > 275 && mouseX < 296)
            BoxX <= 7;
        else
            BoxX <= 0;

        //DEAL WITH Y:
        if (mouseY > 7 && mouseY < 28)
            BoxY <= 0;
        else if (mouseY > 35 && mouseY < 56)
            BoxY    <= 1;
        else if (mouseY > 63 && mouseY < 84)
            BoxY <= 2;
        else if (mouseY > 91 && mouseY < 112)
            BoxY <= 3;
        else if (mouseY > 119 && mouseY < 140)
            BoxY <= 4;
        else if (mouseY > 147 && mouseY < 168)
            BoxY <= 5;
        else if (mouseY > 175 && mouseY < 196)
            BoxY <= 6;
        else if (mouseY > 203 && mouseY < 224)
            BoxY <= 7;
        else
            BoxY <= 0;
    end


endmodule