#include <stdio.h>
#include <stdlib.h>

int is_vowel(int c);

int main(int argc, char *argv[]) {
    FILE *file_one_stream = fopen(argv[1], "r");
    FILE *file_two_stream = fopen(argv[2], "w+");

    int c;
    while ((c = fgetc(file_one_stream)) != EOF) {
        if (!is_vowel(c)) {
            fputc(c, file_two_stream);
        }
    }

    fclose(file_one_stream);
    fclose(file_two_stream);

    return 0;
}

int is_vowel(int c) {
    return (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' || c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U');
}