#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int is_ascii(int c) {
    return !(128 <= c && c <= 255);
}

int main(int argc, char *argv[]) {

    FILE *input_stream = fopen(argv[1], "r");

    if (input_stream == NULL) {
        perror(argv[1]);
        exit(1);
    }

    FILE *temp_stream = fopen("temp", "w+");

    fseek(input_stream, 0, SEEK_SET);
    int c;
    while ((c = fgetc(input_stream)) != EOF) {
        if (is_ascii(c)) {
            printf("%c\n", c);
            fputc(c, temp_stream);
        }
    }

    input_stream = freopen(argv[1], "w+", input_stream);
    fseek(temp_stream, 0, SEEK_SET);

    int out_c;
    while ((out_c = fgetc(temp_stream)) != EOF) {
        fputc(out_c, input_stream);
    }
    
    fclose(input_stream);
    fclose(temp_stream);

    return 0;
}