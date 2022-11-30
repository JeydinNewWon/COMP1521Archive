// COMP1521 22T2 ... final exam, question 10

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <assert.h>
#include <spawn.h>
#include <fcntl.h>
#include <glob.h>

#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/wait.h>

#define MAX_LINE_LENGTH     1024     // Useful for input string.
#define MAX_DIR_LENGTH      1024     // Useful for the current working directory.
#define MAX_COMMAND_LENGTH  128      // Useful for the command to pass to `posix_spawn`.
#define MAX_ARGUMENTS       32       // Useful for the arguments to pass to `posix_spawn`.
#define MAX_ARG_LENGTH      128      // Useful for the arguments to pass to `posix_spawn`.
#define DIRECTORY_SEPARATOR '/'      // Useful to tell if a command is absolute or not.
#define PATH_TOKENIZER      ":"      // Useful to tokenize the PATH environment variable.

bool is_executable(const char *pathname);
glob_t do_glob(char *text);

int main(void) {
    // Don't buffer stdout.
    setbuf(stdout, NULL);

    // Pass this to `posix_spawn` for the environment.
    extern char **environ;
    (void) environ; // Suppress unused warning; feel free to remove

    char cwd[MAX_DIR_LENGTH];
    getcwd(cwd, sizeof cwd);

    char line[MAX_LINE_LENGTH];

    while (true) {
        printf("[rush] ");

        // Get input from user or exit
        if (!fgets(line, sizeof line, stdin)) {
            break;
        }

        // Remove trailing newline
        char *newline = strrchr(line, '\n');
        if (newline) *newline = '\0';

        printf("TODO: add your code here\n");
    }
}

//
// Check whether this process can execute a certain file.
// Useful for checking whether a command is in the PATH.
//
bool is_executable(const char *pathname) {
    struct stat s;
    return
        // does the file exist?
        stat(pathname, &s) == 0 &&
        // is the file a regular file?
        S_ISREG(s.st_mode) &&
        // can we execute it?
        faccessat(AT_FDCWD, pathname, X_OK, AT_EACCESS) == 0;
}

//
// Glob some given text with the required options for the shell.
// Useful for globbing arguments in feature 5.
//
glob_t do_glob(char *text) {
    glob_t results = {};
    assert(glob(text, GLOB_NOCHECK | GLOB_TILDE, NULL, &results) == 0);

    return results;
}
