#include <stdio.h>
#include <stdlib.h>

int main(void) {
    char *value = getenv("HOME");
    printf("%s\n", value);

    return 0;
}