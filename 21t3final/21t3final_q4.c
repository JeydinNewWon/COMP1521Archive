// Read 10 numbers
// then print the positive numbers on a line
// and print the negative  numbers on a line

#include <stdio.h>

int numbers[10];

int main(void) {
    int i;

    for (i = 0; i < 10; i++) {
        scanf("%d", &numbers[i]);
    }

    for (i = 0; i < 10; i++) {
        if (numbers[i] > 0) {
            printf("%d ", numbers[i]);
        }
    }
    printf("\n");

    for (i = 0; i < 10; i++) {
        if (numbers[i] < 0) {
            printf("%d ", numbers[i]);
        }
    }
    printf("\n");
}
