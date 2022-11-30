#include <stdio.h>
#include <string.h>
#include <stdlib.h>

// print the location of a specified byte sequence in a file
// the first command line argument is a filname
// other command line arguments are integers specifying a byte sequence
// the first position the byte sequence occurs in the file is printed

long length(int *test_string) {
    for (long i = 0;;i++) {
        if (test_string[i] == 0) {
            return i + 1;
        }
    }
}

int check_sequence(FILE *input_stream, int *test_string) {
    for (long i = 1; i < length(test_string) - 1; i++) {
        int c = fgetc(input_stream);
        if (c != test_string[i]) {
            fseek(input_stream, -1 * i + 1, SEEK_CUR);
            return 0;
        }

    }

    fseek(input_stream, -1 * (length(test_string)) + 1, SEEK_CUR);

    return 1;
}

int main(int argc, char *argv[]) {

    int *test_string = malloc((sizeof(int)) * (argc - 1));

    for (int i = 2; i < argc; i++) {
        test_string[i - 2] = atoi(argv[i]);
    }

    test_string[argc - 2] = '\0';
    FILE *input_stream = fopen(argv[1], "r");

    int c = fgetc(input_stream);
    int found_sequence = 0;

    while (c != EOF && !found_sequence) {
        if (c == test_string[0]) {
            if (check_sequence(input_stream, test_string)) {
                found_sequence = 1;
                break;
            }
        }
        c = fgetc(input_stream);
    } 

    long pos = ftell(input_stream);
    if (found_sequence) {
        printf("Sequence found at byte position: %ld\n", pos);
    } else {
        printf("Sequence not found\n");
    }

    free(test_string);


    return 0;
}
