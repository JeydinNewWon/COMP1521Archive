#include <stdio.h>
#include <limits.h>
#include <unistd.h>
#include <string.h>

int main(int argc, char *argv[]) {

    char pathname[PATH_MAX];

    while (1) {
        if (getcwd(pathname, sizeof pathname) == NULL) {
            perror("getcwd");
            return 1;
        }

        printf("getcwd returned %s\n", pathname);

        if (strcmp(pathname, "/") == 0) {
            return 0;
        }

        if (chdir("..") == -1) {
            perror("chdir");
            return 1;
        }
    }
    return 0;
}