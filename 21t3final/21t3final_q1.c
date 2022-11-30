#include <stdio.h>

// read two integers and print all the integers which have their bottom 2 bits set.

int main(void) {
    int x, y;

    scanf("%d", &x);
    scanf("%d", &y);

    for (int i = x + 1; i < y; i++) {
        if ((i & 0b11) == 0b11) {
            printf("%d\n", i);
        }
    }

    return 0;
}
