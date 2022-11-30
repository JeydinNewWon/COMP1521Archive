#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    FILE *file_one_stream = fopen(argv[1], "r");
    FILE *file_two_stream = fopen(argv[2], "r");

    fseek(file_one_stream, 0L, SEEK_END);

    int f_one_size = ftell(file_one_stream);

    if (f_one_size == 0) {
        printf("EOF on %s\n", argv[1]);
        fclose(file_one_stream);
        fclose(file_two_stream);
        return 0;
    }

    int file_one_contents[f_one_size];
    fseek(file_one_stream, 0L, SEEK_SET);

    int f_one_c;
    int i = 0;
    while ((f_one_c = fgetc(file_one_stream)) != EOF) {
        file_one_contents[i] = f_one_c;
        i++;
    }

    fseek(file_two_stream, 0L, SEEK_END);
    int f_two_size = ftell(file_two_stream);

    if (f_two_size == 0) {
        printf("EOF on %s\n", argv[2]);
        fclose(file_one_stream);
        fclose(file_two_stream);
        return 0;
    }

    int file_two_contents[f_two_size];
    fseek(file_two_stream, 0L, SEEK_SET);

    int f_two_c;
    int j = 0;

    while ((f_two_c = fgetc(file_two_stream)) != EOF) {
        file_two_contents[j] = f_two_c;
        j++;
    }

    int f_size_bigger = f_one_size > f_two_size ? f_one_size : f_two_size;

    fclose(file_one_stream);
    fclose(file_two_stream);

    for (int f_comp = 0; f_comp < f_size_bigger; f_comp++) {
        if (f_comp >= f_two_size) {
            printf("EOF on %s\n", argv[2]);
            return 0;
        }

        if (f_comp >= f_one_size) {
            printf("EOF on %s\n", argv[1]);
            return 0;
        }

        if (file_one_contents[f_comp] != file_two_contents[f_comp]) {
            printf("Files differ at byte %d\n", f_comp);
            return 0;
        }
    }

    printf("Files are identical\n");

    return 0;
}