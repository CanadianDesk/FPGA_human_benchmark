# VGA Drivers/Modules

## How it works:

The VGA uses



---
## Internal Interfacing:

### From chimp

VGAencoder.v has an input port of the form `input reg [6:0] arr [2:0] [2:0] `.

The two 3-bit signals represent the position in the 8x8 array.

The 7-bit signal comprises the least significant 5 bits representing the number stored in the cell, and the two most significant bits reprsenting a one-hot-encoding for where the box is active, and whether the number is showing respectively (both signals active high).

For example, { 1 0 0 0 0 1 0 } @ { 1 0 0 } { 0 1 0 } would represent a cell at x=4 and y=2, that is active but the number is hidden.

### From reaction

VGAencoder.v has a 1-bit input port `iReactionScreen` which goes high when the test is in its WAIT state, and low when its in its CLICK state.

### From the PS/2 mouse

VGAencoder.v has 2 multi-bit inputs,`iMouseX` and `iMouseY` repersenting the x and y coordinate of the current position of the mouse on a 320px x 240px screen.

### From the main menu

VGAencoder.v has a 2-bit input port `[1:0] iGameMode` which directs which of the three game modes to display on the screen. `iGameMode` is `00` if the Main Menu is being displayed, `01` if the React game is being displayed, and `10` if the Chimp game is being displayed. `11` should never be the value at this port and indicates an issue.




