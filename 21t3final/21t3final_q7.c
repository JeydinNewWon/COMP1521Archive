#include <stdio.h>
#include <inttypes.h>

// copy file specified as command line argument 1 to
// file specified as command line argument 2
// convert UTF8 to ASCII by replacing multibyte UTF8 characters with '?'

int is_num_bytes(int first_char) {
    uint8_t changed_char = (uint8_t) first_char;
    //printf("%x = %c = %x\n", first_char, first_char);
    if ((changed_char >> 3) == 0b11110) {
        return 4;
    } else if ((changed_char >> 4) == 0b1110) {
        return 3;
    } else if ((changed_char >> 5) == 0b110) {
        return 2;
    } else if ((changed_char >> 7) == 0) {
        return 1;
    } else {
        return -1;
    }
}

int main(int argc, char *argv[]) {

    FILE *input_stream = fopen(argv[1], "r");
    FILE *output_stream = fopen(argv[2], "w+");


    int c = fgetc(input_stream);
    while (c != EOF) {
        if (is_num_bytes(c) == 1) {
            fprintf(output_stream, "%c", c);
        } else if (is_num_bytes(c) > 0)  {
            for (int i = 0; i < is_num_bytes(c) - 1; i++) {
                c = fgetc(input_stream);
            }
            fprintf(output_stream, "?");
        }
        c = fgetc(input_stream);
    }


    return 0;
}
