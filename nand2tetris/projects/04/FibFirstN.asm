// GOAL: starting from @x address, fill RAM with @n Fibs!
// @n is in R4 


// Step 0: create @n, and store 42 there

@R4
D=M
@n
M=D

// Step 1: create variable x and set it to 22
@20
D=A
@R3
M=D
@x
M=D


// Step 2: Init
// RAM[x] = 0
// RAM[x+1] = 1
A=M
M=0
A=A+1
M=1
A=A+1

@x
D=M
@i
M=D+1
M=M+1
// 3.x:
(LOOP)
@i
A=M
D=0
A=A-1
D=D+M
A=A-1
D=D+M
A=A+1
A=A+1
M=D
@i
M=M+1

@n
M=M-1
D=M
@END
D;JEQ

@LOOP
0;JMP
(END)
