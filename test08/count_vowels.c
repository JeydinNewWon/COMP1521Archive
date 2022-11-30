#include <stdio.h>
#include <stdlib.h>

int is_vowel(int c);

int main(int argc, char *argv[]) {
    FILE *output_stream = fopen(argv[1], "r");

    int c;
    int vowel_count = 0;
    while ((c = fgetc(output_stream)) != EOF) {
        if (is_vowel(c)) vowel_count++;
    }
    
    printf("%d\n", vowel_count);

    fclose(output_stream);

    return 0;
}

int is_vowel(int c) {
    return (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' || c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U');
}