#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <inttypes.h>

// print a specified byte from a file
//
// first command line argument specifies a file
// second command line argument specifies a byte location
//
// output is a single line containing only the byte's value
// printed as a unsigned decimal integer (0..255)
// if the location does not exist in the file
// a single line is printed saying: error

int main(int argc, char *argv[]) {
    long byte_pos = atol(argv[2]);

    char *filename = argv[1];

    FILE *input_stream = fopen(filename, "r");

    fseek(input_stream, 0, SEEK_END);

    long file_len = ftell(input_stream);

    fseek(input_stream, 0, SEEK_SET);

    if (labs(byte_pos) > file_len) {
        printf("error\n");
        return 1;
    }

    uint8_t c;

    if (byte_pos >= 0) {
        fseek(input_stream, byte_pos, SEEK_SET);

        c = fgetc(input_stream);


    } else {
        fseek(input_stream, byte_pos, SEEK_END);
        c = fgetc(input_stream);

    }
    
    printf("%u\n", c);


    return 0;
}
