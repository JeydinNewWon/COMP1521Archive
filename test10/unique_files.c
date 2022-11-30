#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

int main(int argc, char **argv) {
    ino_t seen_files[argc];

    int arr_inc = 0;

    for (int i = 1; i < argc; i++) {
        struct stat s;
        stat(argv[i], &s);
        int found = 0;
        for (int j = 0; j < arr_inc; j++) {
            if (arr_inc == 0) break; 
            if (seen_files[j] == s.st_ino) {
                found = 1;
                break;
            }
        }

        if (!found) {
            printf("%s\n", argv[i]);
            seen_files[arr_inc] = s.st_ino;
            arr_inc++;
        }
    }

    return 0;
}