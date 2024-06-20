// The following program sums up command-line arguments.

// Why do we need the function atoi in the following program?

// The program assumes that command-line arguments are integers. What if they are not integer values? 

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    int sum = 0;
    for (int i = 0; i < argc; i++) {
        sum += atoi(argv[i]);
    }
    printf("sum of command-line arguments = %d\n", sum);
    return 0;
}