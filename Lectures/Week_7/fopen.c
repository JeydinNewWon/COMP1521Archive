#include <stdlib.h>
#include <stdio.h>
#include <spawn.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>

extern char **environ;

#define DCC_PATH "/usr/local/bin/dcc"

int main(int argc, char *argv[]) {

    FILE *input_str = fopen(argv[1], "r");
    FILE *output_str = fopen(argv[2], "w+");


    if (input_str == NULL) {
        perror(argv[1]);
        return EXIT_FAILURE;
    }

    int c = fgetc(input_str);
    while (c != EOF) {
        putc(c, output_str);
        c = fgetc(input_str);
    }

    fclose(input_str);
    fclose(output_str);

    char output_name[strlen(argv[2]) + 1];
    strcpy(output_name, argv[2]);
    output_name[strlen(output_name) - 2] = '\0';

    char *args[] = {DCC_PATH, argv[2], "-o", output_name, NULL};

    pid_t pid;

    if (posix_spawn(&pid, DCC_PATH, NULL, NULL, args, environ) != 0) {
        perror(argv[2]);
        return EXIT_FAILURE;
    }

    int wstatus;

    if (waitpid(pid, &wstatus, 0)  == -1) {
        perror(argv[2]);
        return EXIT_FAILURE;
    }


    return 0;
}