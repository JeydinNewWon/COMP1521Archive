// compile .c files specified as command line arguments
//
// if my_program.c and other_program.c is speicified as an argument then the follow two command will be executed:
// /usr/local/bin/dcc my_program.c -o my_program
// /usr/local/bin/dcc other_program.c -o other_program

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <spawn.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>

#define DCC_PATH "/usr/local/bin/dcc"

extern char **environ;

int main(int argc, char **argv) {
    
    for (int i = 1; i < argc; i++) {
        pid_t pid;

        char program_name[strlen(argv[i]) - 1];
        for (int j = 0; j < strlen(argv[i]) - 2; j++) {
            program_name[j] = argv[i][j];
        }

        program_name[strlen(argv[i]) - 2] = '\0';

        FILE *test_out = fopen(program_name, "r");

        if (test_out != NULL) {
            fclose(test_out);
            struct stat s_binary;
            struct stat s_c_file;
            if (stat(program_name, &s_binary) != 0 || stat(argv[i], &s_c_file) != 0) {
                perror(program_name);
                exit(1);
            }

            if (s_binary.st_mtime > s_c_file.st_mtime) {
                printf("%s does not need compiling\n", argv[i]);
                continue;
            }
        }

        char *dcc_args[] = {DCC_PATH, argv[i], "-o", program_name, NULL};

        if (posix_spawn(&pid, DCC_PATH, NULL, NULL, dcc_args, environ) != 0) {
            perror("spawn");
            exit(EXIT_FAILURE);
        }

        printf("running the command: \"%s %s -o %s\"\n", DCC_PATH, argv[i], program_name);

        int exit_status;
        if (waitpid(pid, &exit_status, 0) == -1) {
            perror("waitpid");
            exit(1);
        }

    }



    return EXIT_SUCCESS;
}
