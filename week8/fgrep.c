#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#define MAX 999
//todo: incomplete! error is fscanf is currently only scanning in 
//1 word at a time and not 1 line. suggest scanning %s\n instead.


int main(int argc, char* argv[]) {

    if (argc <= 1) {
        fprintf(stderr, "not enough args");
    }
    if (argc == 2) {
        //read lines from stdin and print them out to stdout
        char compare[MAX];

        while (fscanf(stdin, "%s", compare) != EOF) {;
            if (strstr(compare, argv[1]) != NULL) {
                fprintf(stdout, "%s", compare);
                
            }
            // *compare = "";
        }
    } else if (argc > 2) {
        //treat args after the first as filenames
        // print lines they contain which contain the string
        //specified as first command line arg
        for (int i = 2; i < argc; i++) {
            FILE *stream = fopen(argv[i], "r");
            if (stream == NULL) {
                fprintf(stderr, "file unsuccesssful");
            }
            char compare[MAX];
            int counter = 1;
            while (fscanf(stream, "%s", compare) != EOF) {
                if (strstr(compare, argv[1]) != NULL) {
                    fprintf(stdout, "line: %d, %s", counter, compare);
                }
                counter++;
                // compare = "";
            }
            
        }
    }





    return 0;
}