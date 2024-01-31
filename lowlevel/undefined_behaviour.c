

#include <stdio.h>

void printStack(int *stack, int top) {
    printf("stack = [ ");
    for (int i = 0; i < top; i++) {
        printf("%i ", stack[i]);
    }

    printf("]\n");
}

int main() {
    int stack[5];
    int top;


    stack[0] = 4;
    stack[1] = 2;
    top = 2;
    printStack(stack, top);
    stack[top++] = stack[--top] / stack[--top];
    printStack(stack, top);


    stack[0] = 4;
    stack[1] = 2;
    top = 2;
    printStack(stack, top);
    stack[top++] = stack[--top] - stack[--top];
    printStack(stack, top);

    // printf("Hello, World!\n");
    return 0;
}

// To compile and run this program in Bash, use:
// gcc -o ub.bin undefined_behaviour.c && ./ub.bin
