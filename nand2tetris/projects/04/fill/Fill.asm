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

// SET SCREEN TO -1 end terminate




@LOOP
D=A
@lc
M=D


(LOOP)
    @KBD
    D=M

    @KBD_IS_PRESSED
    D;JNE // @KBD != 0 --> it is pressed

    // Otherwise, it is not pressed
    @fill_value
    M=0

    @LOOP_END
    0;JMP

    (KBD_IS_PRESSED)
        @fill_value
        M=-1

    

    (LOOP_END)
        // set @lc to (LOOP)
        @LOOP
        D=A
        @lc
        M=D


        // we have @lc = (LOOP) and D = @screen value
        // call SET_SCREEN

        @SET_SCREEN
        0;JMP




// Function that sets screen values to @fill_value and returns to the @lc

(SET_SCREEN)
    @i
    M=0


    (SET_SCREEN_LOOP)
        // check if i >= 8192 (we are done)
        @8192
        D=A
        @i
        D=D-M
        @SET_SCREEN_RETURN
        D;JLE

        @SCREEN
        D=A

        // (SCREEN+i)
        @i
        D=M+D


        @SCREEN_I
        M=D

        @fill_value
        D=M

        @SCREEN_I
        A=M
        M=D

        @i
        M=M+1
        @SET_SCREEN_LOOP
        0;JMP

    (SET_SCREEN_RETURN)
    @lc
    A=M
    0;JMP


