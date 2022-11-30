#include <stdio.h>
#include <stdlib.h>

#define SERIES_MAX 30

int fibonnaci(int pos) {
    if (pos == 0) {
        return 0;
    }

    if (pos == 1) {
        return 1;
    }

    return fibonnaci(pos - 1) + fibonnaci(pos - 2);
}

int main(void) {
    int num;
    while (scanf(" %d", &num) == 1) {
        int res = fibonnaci(num);
        printf("%d\n", res);
    }
    return EXIT_SUCCESS;
}
