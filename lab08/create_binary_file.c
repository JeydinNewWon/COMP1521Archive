#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {

    FILE *output_stream = fopen(argv[1], "w+"); 

    if (output_stream == NULL) {
        perror(argv[1]);
        return EXIT_FAILURE;
    }

    for (int i = 2; i < argc; i++) {
        int my_int = atoi(argv[i]);
        fputc(my_int, output_stream);
    }

    fclose(output_stream);
    return 0;
}