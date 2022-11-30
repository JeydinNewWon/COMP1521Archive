#include <stdlib.h>
#include <stdint.h>

// given 2 uint32_t values
// return the number of bits which are set (1) in both values

int final_q5(uint32_t value1, uint32_t value2) {
    uint32_t mask = 1;
    int same_bits = 0;
    for (int i = 0; i < 32; i++) {
        if ((value1 & mask) != 0 && (value2 & mask) != 0) {
            same_bits++;
        }

        mask = mask << 1;
    }

    return same_bits;
}
