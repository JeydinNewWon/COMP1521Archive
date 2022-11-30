#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#define HIGH_MASK 0xFF00
#define LESS_MASK 0xFF

int main(int argc, char *argv[]) {

    FILE *output_stream = fopen(argv[1], "w+");
    if (output_stream == NULL) {
        perror(argv[1]);
        return EXIT_FAILURE;
    }

    for (int i = atoi(argv[2]); i <= atoi(argv[3]); i++) {
        uint16_t most_sig = (i & HIGH_MASK) >> 8;
        uint16_t least_sig = (i & LESS_MASK);

        fputc(most_sig, output_stream);
        fputc(least_sig, output_stream);

    }

    fclose(output_stream);

    return 0;
}