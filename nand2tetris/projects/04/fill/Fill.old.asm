// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen
// by writing 'black' in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen by writing
// 'white' in every pixel;
// the screen should remain fully clear as long as no key is pressed.

//// Replace this comment with your code.

// screen size in words = (512*256) / 16 = 8192

@SCREEN
D=A

@CURR_SCREEN
M=D

@i
M=0

(LOOP)

    // ***---*** CONDITION CHECK
    // if i JGE >= R1
    @i
    D=M
    @8192
    D=A-D

    @END
    D;JLE

    @KBD
    D=M
    @fill_value
    M=D

    @SKIP_ONEFICATION
    D;JNE

    D=-1

    (SKIP_ONEFICATION)

    @CURR_SCREEN
    A=M


    M=D
    @CURR_SCREEN
    M=M+1

    // incr i
    @i
    M=M+1

    @LOOP
    0;JMP



(END)
    @END
    0;JMP
