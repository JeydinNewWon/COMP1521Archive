// count bits in a uint64_t

#include <assert.h>
#include <stdint.h>
#include <stdlib.h>

// return how many 1 bits value contains
int bit_count(uint64_t value) {
    uint64_t mask = 1;

    int bit_counter = 0;
    for (int i = 0; i < 64; i++) {
        if ((value & mask) != 0) {
            bit_counter++;
        }

        mask = mask << 1;
    }

    return bit_counter;
}
