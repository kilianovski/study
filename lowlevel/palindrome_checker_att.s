	.section	__TEXT,__text,regular,pure_instructions // Define a section for the code
	.build_version macos, 14, 0	sdk_version 14, 2 // Specify the build and SDK versions for macOS
	.globl	_isPalindrome                   ; Declare the isPalindrome function as global (accessible from other files)
	.p2align	2                              ; Align the code on a 4-byte boundary for performance
_isPalindrome:                              ; Label for the start of the isPalindrome function
	.cfi_startproc                           ; Begin a procedure for debugging information
; %bb.0:                                    ; Basic block 0 (a straight-line code sequence with no branches in except to the entry and no branches out except at the exit)
	sub	sp, sp, #48                       ; Subtract 48 from the stack pointer to allocate space on the stack
	.cfi_def_cfa_offset 48                 ; Adjust the current frame address offset for debugging
	stp	x29, x30, [sp, #32]             ; Save the frame pointer and return address on the stack
	add	x29, sp, #32                     ; Set up the new frame pointer
	.cfi_def_cfa w29, 16                  ; Define the call frame address and offset for debugging
	.cfi_offset w30, -8                   ; Set the return address offset for debugging
	.cfi_offset w29, -16                  ; Set the frame pointer offset for debugging
	str	x0, [sp, #16]                    ; Store the argument (pointer to string) on the stack
	ldr	x0, [sp, #16]                    ; Load the argument (pointer to string) into x0
	bl	_strlen                          ; Call the strlen function to get the length of the string
	mov	x8, x0                           ; Move the result (string length) into x8
	str	w8, [sp, #12]                    ; Store the string length on the stack
	str	wzr, [sp, #8]                    ; Initialize the loop counter to 0
	b	LBB0_1                           ; Branch to the beginning of the loop
LBB0_1:                                     ; Loop header (checks if the loop should continue)
	ldr	w8, [sp, #8]                     ; Load the loop counter
	ldr	w9, [sp, #12]                    ; Load the string length
	mov	w10, #2                          ; Load the constant 2
	sdiv	w9, w9, w10                      ; Divide the string length by 2 (find the midpoint)
	subs	w8, w8, w9                       ; Subtract the midpoint from the loop counter
	cset	w8, ge                           ; Set w8 to 1 if the loop counter is greater or equal to 0 (we haven't reached the midpoint)
	tbnz	w8, #0, LBB0_6                   ; If w8 is 1, branch to the end of the loop (all checks passed)
	b	LBB0_2                           ; Otherwise, continue with the loop
LBB0_2:                                     ; Loop body (compares characters on both ends of the string)
	ldr	x8, [sp, #16]                    ; Load the string pointer
	ldrsw	x9, [sp, #8]                    ; Load the loop counter (sign-extended to 64 bits)
	ldrsb	w8, [x8, x9]                    ; Load the character at the current position from the string
	ldr	x9, [sp, #16]                    ; Load the string pointer again
	ldr	w10, [sp, #12]                   ; Load the string length
	subs	w10, w10, #1                    ; Subtract 1 from the string length (to get the last valid index)
	ldr	w11, [sp, #8]                    ; Load the loop counter
	subs	w10, w10, w11                   ; Calculate the index of the character from the other end of the string
	ldrsb	w9, [x9, w10, sxtw]             ; Load the character from the other end of the string
	subs	w8, w8, w9                       ; Subtract the two characters (compare them)
	cset	w8, eq                           ; Set w8 to 1 if the characters are equal
	tbnz	w8, #0, LBB0_4                   ; If the characters are equal, continue the loop
	b	LBB0_3                           ; If the characters are not equal, branch to set the result to 0 (not a palindrome)
LBB0_3:                                     ; Set the result to 0 (not a palindrome)
	stur	wzr, [x29, #-4]                  ; Store 0 in the result variable (using the frame pointer)
	b	LBB0_7                           ; Branch to the end of the function
LBB0_4:                                     ; Continue the loop
	b	LBB0_5                           ; Branch to increment the loop counter
LBB0_5:                                     ; Increment the loop counter
	ldr	w8, [sp, #8]                     ; Load the loop counter
	add	w8, w8, #1                       ; Add 1 to the loop counter
	str	w8, [sp, #8]                    ; Store the updated loop counter
	b	LBB0_1                           ; Branch back to the loop header
LBB0_6:                                     ; Set the result to 1 (is a palindrome)
	mov	w8, #1                           ; Move 1 into w8 (to indicate a palindrome)
	stur	w8, [x29, #-4]                  ; Store 1 in the result variable (using the frame pointer)
	b	LBB0_7                           ; Branch to the end of the function
LBB0_7:                                     ; End of the function
	ldur	w0, [x29, #-4]                  ; Load the result into w0 (return value)
	ldp	x29, x30, [sp, #32]             ; Restore the frame pointer and return address from the stack
	add	sp, sp, #48                     ; Deallocate the stack space
	ret                                 ; Return from the function
	.cfi_endproc                         ; End of the procedure for debugging information
                                        ; -- End function
	.globl	_main                           ; Declare the main function as global
	.p2align	2                              ; Align the code on a 4-byte boundary for performance
_main:                                      ; Label for the start of the main function
	.cfi_startproc                           ; Begin a procedure for debugging information
; %bb.0:                                    ; Basic block 0 of the main function
	sub	sp, sp, #160                       ; Allocate space on the stack for local variables
	.cfi_def_cfa_offset 160                 ; Adjust the current frame address offset for debugging
	stp	x29, x30, [sp, #144]                ; Save the frame pointer and return address on the stack
	add	x29, sp, #144                       ; Set up the new frame pointer
	.cfi_def_cfa w29, 16                    ; Define the call frame address and offset for debugging
	.cfi_offset w30, -8                     ; Set the return address offset for debugging
	.cfi_offset w29, -16                    ; Set the frame pointer offset for debugging
	adrp	x8, ___stack_chk_guard@GOTPAGE    ; Load the address of the stack check guard variable
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF] ; Load the value of the stack check guard variable
	ldr	x8, [x8]                           ; Load the value of the stack check guard variable
	stur	x8, [x29, #-8]                    ; Store the stack check guard value on the stack
	str	wzr, [sp, #32]                    ; Clear the space for the string on the stack
	adrp	x0, l_.str@PAGE                   ; Load the address of the "Enter a string: " string
	add	x0, x0, l_.str@PAGEOFF            ; Add the offset to get the actual address of the string
	bl	_printf                           ; Call printf to print the prompt
	adrp	x8, ___stdinp@GOTPAGE             ; Load the address of the stdin pointer
	ldr	x8, [x8, ___stdinp@GOTPAGEOFF]    ; Load the stdin pointer
	ldr	x2, [x8]                           ; Load the stdin pointer into x2
	add	x0, sp, #36                        ; Calculate the address of the buffer for fgets
	str	x0, [sp, #24]                     ; Store the buffer address on the stack
	mov	w1, #100                          ; Set the maximum number of characters to read
	bl	_fgets                            ; Call fgets to read a string from stdin
	ldr	x0, [sp, #24]                     ; Load the buffer address into x0
	bl	_strlen                           ; Call strlen to get the length of the input string
	ldr	x8, [sp, #24]                     ; Load the buffer address again
	subs	x9, x0, #1                        ; Subtract 1 from the string length to get the index of the last character
	ldrsb	w8, [x8, x9]                     ; Load the last character of the string
	subs	w8, w8, #10                       ; Subtract the newline character code from the last character
	cset	w8, ne                           ; Set w8 to 1 if the last character is not a newline
	tbnz	w8, #0, LBB1_2                    ; If the last character is not a newline, skip the newline removal
	b	LBB1_1                            ; Otherwise, proceed to remove the newline
LBB1_1:                                     ; Remove the newline character from the end of the string
	add	x0, sp, #36                        ; Calculate the address of the buffer
	str	x0, [sp, #16]                     ; Store the buffer address on the stack
	bl	_strlen                           ; Call strlen to get the new length of the string
	ldr	x8, [sp, #16]                     ; Load the buffer address again
	subs	x9, x0, #1                        ; Subtract 1 from the string length to get the index of the last character
	add	x8, x8, x9                        ; Calculate the address of the last character
	strb	wzr, [x8]                         ; Set the last character to null (removing the newline)
	b	LBB1_2                            ; Skip to the next part of the function
LBB1_2:                                     ; Check if the string is a palindrome
	add	x0, sp, #36                        ; Calculate the address of the string
	bl	_isPalindrome                     ; Call isPalindrome to check if the string is a palindrome
	subs	w8, w0, #0                        ; Subtract 0 from the result to set the flags
	cset	w8, eq                           ; Set w8 to 1 if the result is 0 (not a palindrome)
	tbnz	w8, #0, LBB1_4                    ; If the string is not a palindrome, branch to print the "not a palindrome" message
	b	LBB1_3                            ; Otherwise, print the "is a palindrome" message
LBB1_3:                                     ; Print the "is a palindrome" message
	mov	x9, sp                            ; Move the stack pointer into x9
	add	x8, sp, #36                       ; Calculate the address of the string
	str	x8, [x9]                          ; Store the string address on the stack
	adrp	x0, l_.str.1@PAGE                ; Load the address of the "is a palindrome" message
	add	x0, x0, l_.str.1@PAGEOFF         ; Add the offset to get the actual address of the message
	bl	_printf                           ; Call printf to print the message
	b	LBB1_5                            ; Skip to the end of the function
LBB1_4:                                     ; Print the "is not a palindrome" message
	mov	x9, sp                            ; Move the stack pointer into x9
	add	x8, sp, #36                       ; Calculate the address of the string
	str	x8, [x9]                          ; Store the string address on the stack
	adrp	x0, l_.str.2@PAGE                ; Load the address of the "is not a palindrome" message
	add	x0, x0, l_.str.2@PAGEOFF         ; Add the offset to get the actual address of the message
	bl	_printf                           ; Call printf to print the message
	b	LBB1_5                            ; Skip to the end of the function
LBB1_5:                                     ; End of the main function
	ldur	x9, [x29, #-8]                    ; Load the stack check guard value from the stack
	adrp	x8, ___stack_chk_guard@GOTPAGE    ; Load the address of the stack check guard variable
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF] ; Load the value of the stack check guard variable
	ldr	x8, [x8]                           ; Load the value of the stack check guard variable
	subs	x8, x8, x9                        ; Compare the stack check guard values
	cset	w8, eq                           ; Set w8 to 1 if the stack check guard values match
	tbnz	w8, #0, LBB1_7                    ; If the stack check guard values match, skip the stack check failure
	b	LBB1_6                            ; Otherwise, handle the stack check failure
LBB1_6:                                     ; Handle the stack check failure
	bl	___stack_chk_fail                 ; Call the stack check failure function
LBB1_7:                                     ; Return from the main function
	mov	w0, #0                            ; Set the return value to 0
	ldp	x29, x30, [sp, #144]              ; Restore the frame pointer and return address from the stack
	add	sp, sp, #160                      ; Deallocate the stack space
	ret                                 ; Return from the function
	.cfi_endproc                         ; End of the procedure for debugging information
                                        ; -- End function
	.section	__TEXT,__cstring,cstring_literals // Define a section for constant strings
l_.str:                                     ; Label for the "Enter a string: " string
	.asciz	"Enter a string: "             ; Null-terminated string constant

l_.str.1:                                   ; Label for the "is a palindrome" message
	.asciz	"\"%s\" is a palindrome.\n"    ; Null-terminated string constant with a format specifier

l_.str.2:                                   ; Label for the "is not a palindrome" message
	.asciz	"\"%s\" is not a palindrome.\n" ; Null-terminated string constant with a format specifier

.subsections_via_symbols                    ; Direct the assembler to use symbols to divide sections
