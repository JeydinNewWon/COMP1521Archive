#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <assert.h>

#define N_BCD_DIGITS 8

uint32_t packed_bcd(uint32_t packed_bcd);

int main(int argc, char *argv[]) {

    for (int arg = 1; arg < argc; arg++) {
        long l = strtol(argv[arg], NULL, 0);
        assert(l >= 0 && l <= UINT32_MAX);
        uint32_t packed_bcd_value = l;

        printf("%lu\n", (unsigned long)packed_bcd(packed_bcd_value));
    }

    return 0;
}

// given a packed BCD encoded value between 0 .. 99999999
// return the corresponding integer
uint32_t packed_bcd(uint32_t packed_bcd_value) {

    uint32_t mask = 0x000F;
    uint32_t my_decimal = 0;
    int tens_indexer = 1;

    for (int i = 0; i < 8; i++) {
        uint32_t res = mask & packed_bcd_value;
        res = res >> (4 * i);
        my_decimal += tens_indexer * res;
        tens_indexer *= 10;
        mask = mask << 4;
    }

    return my_decimal;
}
