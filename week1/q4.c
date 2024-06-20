#include <stdio.h>

int main(void) {
    char str[10];
    str[0] = 'H';
    str[1] = 'i';
    str[2] = '\0';
    printf("%s\n", str);
    return 0;
}


//  What will happen when the above program is compiled and executed?

// In particular, what does this look like in memory?

// How could we fix this program? 