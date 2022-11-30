#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>


int main(int argc, char *argv[]) {
    int file_d = open(argv[1], O_RDONLY);

    if (file_d == -1) {
        perror(argv[1]);
        return EXIT_FAILURE;
    }

    char buffer[50];

    read(file_d, buffer, 50);

    write(STDOUT_FILENO, buffer, 50);

    write(STDOUT_FILENO, "\n", 1);

    close(file_d);

    return 0;
}
