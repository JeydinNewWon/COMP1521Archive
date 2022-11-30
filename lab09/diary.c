#include <stdlib.h>
#include <stdio.h>
#include <string.h>


int main(int argc, char *argv[]) {
    char *path = getenv("HOME");
    strcat(path, "/.diary");

    FILE *diary = fopen(path, "a+");

    if (diary == NULL) {
        perror(path);
        return EXIT_FAILURE;
    }

    for (int i = 1; i < argc; i++) {
        if (i == argc - 1) {
            fprintf(diary, "%s\n", argv[i]);
        } else {
            fprintf(diary, "%s ", argv[i]);
        }
    }

    fclose(diary);


    return 0;
}