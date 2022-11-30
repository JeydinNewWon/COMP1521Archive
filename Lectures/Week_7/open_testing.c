#include <stdio.h>

void print_bytes(FILE *output_stream) {
    int c = getc(output_stream);
    while (c != EOF) {
        putc(c, stdout);
        c = getc(output_stream);
    }
    printf("\n");
}

int main(int argc, char *argv[]) {
    FILE *output_stream = fopen(argv[1], "r");

    print_bytes(output_stream);

    fseek(output_stream, 0, SEEK_SET);

    print_bytes(output_stream);

    fclose(output_stream);

    
    return 0;
}