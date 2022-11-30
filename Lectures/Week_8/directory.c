#include <stdio.h>
#include <sys/stat.h>

int main(int argc, char *argv[]) {
    for (int i = 1; i < argc; i++) {
        if (mkdir(argv[i], 0555) != 0) {
            perror(argv[i]);
            return 1;
        }

    }
    return 0;

}