#include <stdio.h>
#include <string.h>
#include <ctype.h>

#define MAX_STRING_LENGTH 100

// Function to check if a string is a palindrome
int isPalindrome(char *s) {
    int len = strlen(s);
    for (int i = 0; i < len/2; i++) { 
        if (s[i] != s[len-1-i]) return 0;
    }
    return 1;
}

int main() {
    char str[MAX_STRING_LENGTH];

    printf("Enter a string: ");
    fgets(str, MAX_STRING_LENGTH, stdin); // Read input string from the user

    // Remove the newline character at the end of the input string if present
    if (str[strlen(str) - 1] == '\n') {
        str[strlen(str) - 1] = '\0';
    }

    if (isPalindrome(str)) {
        printf("\"%s\" is a palindrome.\n", str);
    } else {
        printf("\"%s\" is not a palindrome.\n", str);
    }

    return 0;
}
