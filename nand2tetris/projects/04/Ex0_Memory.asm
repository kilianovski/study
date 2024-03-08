// Spec: 


// 1. Set RAM[42] = 4242
@4242
D=A
@42
M=D

// 2. Create a variable x, set it to 43
@43
D=A
@x
M=D
// 3. Write RAM[x] = RAM[42]
// 3.1 Read RAM[42] to D
@42
D=M
// 3.2 select @x
@x
A=M
M=D
