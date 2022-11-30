#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

int main(int argc, char *argv[]) {
    FILE *output_stream = fopen(argv[1], "r");

    if (output_stream == NULL) {
        perror(argv[1]);
        return EXIT_FAILURE;
    }

    /*
    int c;
    int n_lines = 0;
    while ((c = fgetc(output_stream)) != EOF) {
        if (c == '\n' || c == '\t') n_lines++;
    }

    printf("%d\n", n_lines);*/

    /*
    output_stream = fopen(argv[1], "r");

    int new_c;
    for (int i = 0; int i < n_lines; i++) {
        char bytes[4];
        read()

    }*/

    int c;
    char buffer[4];
    int count = 0;
    int PRINT = 0;
    int prev_printed_char = '\n';
    while ((c = fgetc(output_stream)) != EOF) {
        if (isprint(c) && !PRINT && count < 4) {
            buffer[count] = c;
            count++;
        }

        if (count < 4 && !isprint(c)) {
            count = 0;
            PRINT = 0;
        }

        if (count == 4) {
            PRINT = 1;
            for (int i = 0; i < count; i++) {
                printf("%c", buffer[i]);
            }
            prev_printed_char = buffer[count - 1];
            count++;
        } else if (PRINT && isprint(c)) {
            printf("%c", c);
            prev_printed_char = c;
        } else if (PRINT && !isprint(c)) {
            PRINT = 0;
            count = 0;
            prev_printed_char = '\n';
            printf("\n");
        }
    }

    if (prev_printed_char != '\n') printf("\n");


    fclose(output_stream);
    return 0;
}