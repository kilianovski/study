// Sum of the first `n` digits
// The input `n`: in RAM[0] aka R0
// The output: in RAM[1] aka R1

@R1
M=0
@x
M=1

(LOOP)

// ***---*** ADD x to sum
@x
D=M
@R1
M=M+D
// ***---*** incr x

@x
M=M+1

// ***---*** decrement n
@R0
M=M-1

// ***---*** if n == 0, END 

// @R0
D=M
@END
D;JEQ

// ***---*** ELSE: loop
@LOOP
0;JMP

@END
// TODO: how to halt program?
