// GOAL: starting from @x address, fill RAM with Fibs!

// Step 1: create variable x and set it to 22
@22
D=A
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
@LOOP
0;JMP
