#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
    FILE *file_one = fopen(argv[1], "rb");

    FILE *file_two = fopen(argv[3], "rb");

    fseek(file_one, atol(argv[2]), SEEK_SET);
    int c_one = fgetc(file_one);

    fseek(file_one, 0, SEEK_END);
    int num_bytes_file_one = ftell(file_one);

    fseek(file_two, atol(argv[4]), SEEK_SET);
    int c_two = fgetc(file_two);

    fseek(file_one, 0, SEEK_END);
    int num_bytes_file_two = ftell(file_two);

    if (c_one == c_two && num_bytes_file_one >= atol(argv[2]) && num_bytes_file_two >= atol(argv[4])) {
        printf("byte %ld in %s and byte %ld in %s are the same\n", atol(argv[2]), argv[1], atol(argv[4]), argv[3]);
    } else {
        printf("byte %ld in %s and byte %ld in %s are not the same\n", atol(argv[2]), argv[1], atol(argv[4]), argv[3]);
    }

    fclose(file_one);
    fclose(file_two);

    return 0;

    
}