// Convert string of binary digits to 16-bit signed integer

#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <assert.h>

#define N_BITS 16

int16_t sixteen_in(char *bits);

int main(int argc, char *argv[]) {

    for (int arg = 1; arg < argc; arg++) {
        printf("%d\n", sixteen_in(argv[arg]));
    }

    return 0;
}

//
// given a string of binary digits ('1' and '0')
// return the corresponding signed 16 bit integer
//
int16_t sixteen_in(char *bits) {
    int i = 0;
    int16_t real_num = 0;
    while (i < N_BITS) {
        char digit = bits[i];
        if (digit == '1') {
            int16_t mask = 1 << (N_BITS - i - 1);
            real_num |= mask;
        } 
        i++;
    }

    return real_num;
}

