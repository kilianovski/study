#include <stdio.h>

// Function to calculate the nth Fibonacci number
int fibonacci(int n) {
    if (n <= 1)
        return n;
    else
        return fibonacci(n-1) + fibonacci(n-2);
}

int main() {
    int number;
    printf("Enter the number to find the fibonacci number: ");
    scanf("%d", &number);

    if (number < 0)
        printf("Fibonacci of negative number is not possible.\n");
    else
        printf("Fibonacci number is: %d\n", fibonacci(number));

    return 0;
}
