#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

int main(int argc, char *argv[]) {
    FILE *the_file = fopen(argv[1], "r");

    if (the_file == NULL) {
        perror(argv[1]);
        return EXIT_FAILURE;
    }


    for (int i = 2; i < argc; i++) {
        fseek(the_file, atol(argv[i]), SEEK_SET);
        int c = fgetc(the_file);

        printf("%d - 0x%X - '%c'\n", c, c, c);
    }

    fclose(the_file);

    return 0;
}