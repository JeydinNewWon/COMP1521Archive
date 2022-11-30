#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

int main(int argc, char *argv[]) {
    FILE *output_stream = fopen(argv[1], "r");

    if (output_stream == NULL) {
        perror(argv[1]);
        return EXIT_FAILURE;
    }

    int c;
    while ((c = fgetc(output_stream)) != EOF) {
        if (isprint(c)) {
            printf("%c", c);
        }
    }
    return 0;
}