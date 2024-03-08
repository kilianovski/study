	// **BEGIN [i = 1]
	@i
	M=1
	// **END [i = 1]

	// **BEGIN [sum = 0]
	@sum
	M=0
	// **END [sum = 0]
(LOOP)
	// **BEGIN [if (i > R0) goto STOP]
	@i
	D=M
	@R0
	D=M-D
	@STOP
	D;JLT // if comp < 0 jump
	// **END [if (i > R0) goto STOP]

	// **BEGIN [sum = sum + i]
	@i
	D=M
	@sum
	M=M+D
	// **END [sum = sum + i]

	// **BEGIN [i = i + 1]
	@i
	M=M+1
	// **END [i = i + 1]

	// **BEGIN [goto LOOP]
	@LOOP
	0;JMP
	// **END [goto LOOP]
(STOP)
	// **BEGIN [R1 = sum]
	@sum
	D=M
	@R1
	M=D
	// **END [R1 = sum]
(END)
	@END
	0;JMP
