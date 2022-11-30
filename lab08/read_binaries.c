#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define TRUE 1
#define FALSE 0

int main(int argc, char *argv[]) {
    FILE *input_stream = fopen(argv[1], "r");

    if (input_stream == NULL) {
        perror(argv[1]);
        fclose(input_stream);
        return 1;
    }


    char buffer[5];

    while (fgets(buffer, 5, input_stream) != NULL) {
        int valid = TRUE;
        for (int i = 0; i < 4; i++) {
            if (!isprint(buffer[i])) {
                valid = FALSE;
            }
        }

        if (valid) {
            printf("%s", buffer);
            int c = getc(input_stream);
            while (isprint(c)) {
                putc(c, stdout);
                c = getc(input_stream);
            }
            printf("\n");
        }
    }

    fclose(input_stream);



    return 0;
}