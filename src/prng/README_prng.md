# PRNG Pseudo-Random Number Generator

## How it works:




## Inputs:
It takes `clk` and `iReset` as an input. RESET MUST BE TOGGLED in order for the PRNG to work.

It also takes a parameter `N`, which is the size of the Linear Feedback Shift Regsiter. The parameter `N` is the number of bits, by default 8. This means that the pattern will repeat 2^`N` clock cycles. Unless more random-ness is needed, do not change `N`.

It also has a localparam `seed`, which can be set to any `N`-bit number. This seed determines the repeating pattern of the PRNG.

## Outputs:

`[N-1 : 0] oOutput` is the `N`-bit output of the PRNG. You may shave off bits if all `N` bits aren't used.