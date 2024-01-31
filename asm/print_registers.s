// https://smist08.wordpress.com/2021/01/08/apple-m1-assembly-language-hello-world/
// Assembler program to print the value of a register to stdout.
//
// X0-X2 - parameters to MacOS function services
// X16 - MacOS function number
//
.global _start             // Provide program starting address to linker
.align 2

// Setup the parameters to print the value of a register
// and then call MacOS to do it.

_start: 
        mov X0, #1     // 1 = StdOut
        adr X1, helloworld // string to print
        mov X2, #13     // length of our string
        mov X16, #4     // MacOS write system call
        svc 0     // Call linux to output the string

        // Assuming we want to print the value in X0 for example
        mov X0, #1         // [[x] Correct] 1 = StdOut
        mov X2, #8         // We're going to print 8 bytes (64 bits)
        mov X16, #4        // [[x] Correct] MacOS write system call
        sub SP, SP, #16    // Allocate stack space for the string
        mov x4, 98
        add x4, x4, x0
        stur X4, [SP]      // Store the value of X4 at the allocated space
        mov X1, SP         // Pass the pointer to the string (value of X0) to X1
        // adr x1, helloworld
        svc 0              // [[x] Correct] Call MacOS to output the string
        add SP, SP, #16    // Deallocate stack space

// Setup the parameters to exit the program
// and then call MacOS to do it.

        mov     X0, #0      // Use 0 return code
        mov     X16, #1     // Service command code 1 terminates this program
        svc     0           // Call MacOS to terminate the program

// Data section for any constants or predefined data
// .section .data

// The .ascii directive would be used if we had a predefined string to print
helloworld:      .ascii  "Hello World!\n"
