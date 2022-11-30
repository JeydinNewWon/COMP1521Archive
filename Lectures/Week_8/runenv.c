#include <spawn.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <stdio.h>

extern char **environ;

#define COMMAND "./a.out"

int main(int argc, char *argv[]) {
    pid_t pid;

    setenv("STATUS", argv[1], 1);

    char *args[] = {COMMAND, "STATUS", NULL};

    if (posix_spawn(&pid, COMMAND, NULL, NULL, args, environ) != 0) {
        perror(argv[1]);
        return 1;
    }

    int wstatus;
    if (waitpid(pid, &wstatus, 0) == -1) {
        perror(argv[1]);
        return 1;
    }

    return 0;

}