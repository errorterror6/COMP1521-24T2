#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <errno.h>

int main(int argc, char *argv[]) {

    if (argc != 2) {
        fprintf(stderr, "invalid args");
    }
    FILE *stream = fopen(argv[1], "a");
    if (stream == NULL) {
        perror(argv[1]);
        exit(1);
    }
    char string[999];
    fgets(string, 998, stdin);
    fputs(string, stream);
}