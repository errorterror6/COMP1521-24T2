// In the following program, what are argc and argv? The following program prints 
// number of command-line arguments and each command-line argument on a separate line.

#include <stdio.h>

int main(int argc, char *argv[]) {
    printf("argc=%d\n", argc);
    for (int i = 0; i < argc; i++) {
        printf("argv[%d]=%s\n", i, argv[i]);
    }
    return 0;
}

// What will be the output of the following commands?

// dcc -o print_arguments print_arguments.c
// ./print_arguments I love MIPS

argv[0] = "./print_arguments"

argv[1] = "I"

argv[2] = "love"

argv[3] = "MIPS"