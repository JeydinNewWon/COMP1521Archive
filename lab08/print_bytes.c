#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

int main(int argc, char *argv[]) {

    FILE *output_stream = fopen(argv[1], "r");

    int c;
    size_t count = 0;
    while ((c = fgetc(output_stream)) != EOF) {
        printf("byte %4ld: %3d 0x%02x", count, c, c);
        if (isprint(c)) {
            printf(" \'%c\'\n", c);
        } else {
            printf("\n");
        }
        count++;
    }


    fclose(output_stream);
    return 0;
}