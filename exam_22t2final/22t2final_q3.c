#include <stdint.h>

/**
 * Return the provided value but with its bytes reversed.
 *
 * For example, 22t2final_q3(0x12345678) => 0x78563412
 *
 * *Note* that your task is to
 * reverse the order of *bytes*,
 * *not* to reverse the order of bits.
 **/

#include <stdio.h>

uint32_t _22t2final_q3(uint32_t value) {
    uint32_t mask = 0b11111111;
    uint32_t final_num = 0;

    for (int i = 3; i >= 0; i--) {
        uint32_t res = (value & mask) >> (8 * (3 - i));
        res = res << (i  * 8);

        final_num |= res;
        mask = mask << 8;
    }

    return final_num;

}
