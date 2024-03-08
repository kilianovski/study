// Set i = 0
@i
M=0
(LOOP)
	// If i == R1, terminate loop
	@i
	D=M // D = i
	@R1
	D=M-D // D = R1 - i
	@END
	D;JLE // If R1 - i == 0, jump to END

	// Set *(R0+i) = -1
	@R0
	D=M // D = R0 (base address)
	@i
	A=D+M // A = R0 + i
	M=-1 // Set value at address R0+i to -1

	// i = i + 1
	@i
	M=M+1

	// Loop back
	@LOOP
	0;JMP

(END)
	// Terminate with an infinite loop as a placeholder
	@END
	0;JMP
