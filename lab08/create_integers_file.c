#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    
    FILE *output_stream = fopen(argv[1], "w+");

    if (output_stream == NULL) {
        perror(argv[1]);
        return EXIT_FAILURE;
    }

    for (int i = atoi(argv[2]); i <= atoi(argv[3]); i++) {
        fprintf(output_stream, "%d\n", i);
    }

    fclose(output_stream);

    return 0;
}