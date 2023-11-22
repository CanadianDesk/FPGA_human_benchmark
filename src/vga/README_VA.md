# INTERNAL INTERFACING WITH VGA MODULES

**From the Chimp Test:**
VGAencoder.v receives and input of the form ``reg [6:0] arr [2:0] [2:0] ``.

The two 3-bit signals represent the position in the 8x8 array.

The 7-bit signal comprises the least significant 5 bites representing the number stored in the cell, and the two most significant digits reprsenting a one-hot-encoding for where the box is active, and whether the number is showing respectively (both signals active high).

For example, { 1 0 0 0 0 1 0 } { 1 0 0 } { 0 1 0 } would represent a cell at x=4 and y=2, that is active but the number is hidden.
