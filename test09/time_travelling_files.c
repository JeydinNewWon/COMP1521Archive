#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(int argc, char *argv[]) {
    time_t now = time(NULL);
    for (int i = 1; i < argc; i++) {
        struct stat s;

        stat(argv[i], &s);

        if (difftime(s.st_mtime, now) > 0 || s.st_atime > now) {
            printf("%s has a timestamp that is in the future\n", argv[i]);
        } 
    }
}