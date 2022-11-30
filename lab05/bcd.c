#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <assert.h>

int bcd(int bcd_value);

int main(int argc, char *argv[]) {

    for (int arg = 1; arg < argc; arg++) {
        long l = strtol(argv[arg], NULL, 0);
        assert(l >= 0 && l <= 0x0909);
        int bcd_value = l;

        printf("%d\n", bcd(bcd_value));
    }

    return 0;
}

// given a  BCD encoded value between 0 .. 99
// return corresponding integer
int bcd(int bcd_value) {

    int32_t my_bcd = (int32_t) bcd_value;
    int my_decimal = 0;

    uint32_t mask_one = 0b11111111;
    uint32_t res_one = my_bcd & mask_one;

    my_decimal += res_one;

    int32_t mask_two = mask_one << 8;
    uint32_t res_two = my_bcd & mask_two;
    res_two = res_two >> 8;

    my_decimal += 10 * res_two;

    return my_decimal;
}

