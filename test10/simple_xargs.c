#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <spawn.h>
#include <sys/wait.h>
#include <string.h>

#define MAX_LINE 1025

extern char **environ;

int main(int argc, char *argv[]) {
    char *command = argv[1];

    pid_t pid;

    char line[MAX_LINE];

    while (fgets(line, MAX_LINE, stdin) != NULL) {
        line[strlen(line) - 1] = '\0';
        char *args[] = {command, line, NULL};

        if (posix_spawn(&pid, command, NULL, NULL, args, environ) != 0) {
            perror("spawn");
            return 1;
        }

        int exit_status;
        if (waitpid(pid, &exit_status, 0) == -1) {
            perror("waitpid");
            return 1;
        }

    }

    

    return 0;
}