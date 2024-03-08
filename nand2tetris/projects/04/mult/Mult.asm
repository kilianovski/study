// this program computes the value R0*R1 and stores the result in R2.

    @R2
    M=0

    @i
    M=0

(LOOP)
    // ***---*** CONDITION CHECK
    // if i JGE >= R1
    @i
    D=M
    @R1
    D=M-D

    @STOP
    D;JLE

    // ***---*** LOOP BODY
    @R0
    D=M

    @R2
    M=M+D

    @i
    M=M+1
    // ***---*** END LOOP BODY
    @LOOP
    0;JMP
(STOP)

(END)
    @END
    0;JMP
