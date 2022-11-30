#include <unistd.h>
#include <stdio.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {

    for (int i = 1; i < argc; i++) {
        struct stat s;
        stat(argv[i], &s);

        printf( (S_ISDIR(s.st_mode)) ? "d" : "-");
        printf( (s.st_mode & S_IRUSR) ? "r" : "-");
        printf( (s.st_mode & S_IWUSR) ? "w" : "-");
        printf( (s.st_mode & S_IXUSR) ? "x" : "-");
        printf( (s.st_mode & S_IRGRP) ? "r" : "-");
        printf( (s.st_mode & S_IWGRP) ? "w" : "-");
        printf( (s.st_mode & S_IXGRP) ? "x" : "-");
        printf( (s.st_mode & S_IROTH) ? "r" : "-");
        printf( (s.st_mode & S_IWOTH) ? "w" : "-");
        printf( (s.st_mode & S_IXOTH) ? "x" : "-");

        printf(" %s\n", argv[i]);
    }

    return 0;
}