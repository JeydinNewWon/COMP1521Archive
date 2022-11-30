// swap pairs of bits of a 64-bit value, using bitwise operators

#include <assert.h>
#include <stdint.h>
#include <stdlib.h>

// return value with pairs of bits swapped
uint64_t bit_swap(uint64_t value) {
    uint64_t mask = 1;
    
    uint64_t result = 0;
    for (int i = 1; i < 64; i += 2 ) {
        uint64_t prev_bit = value & (mask << (i - 1));
        uint64_t curr_bit = value & (mask << i);

        prev_bit = prev_bit << 1;
        curr_bit = curr_bit >> 1;

        result = (result) | (prev_bit) | (curr_bit);
    }

    return result;
}
