// Swap bytes of a short

#include <stdint.h>
#include <stdlib.h>
#include <assert.h>
#include <stdio.h>

// given uint16_t value return the value with its bytes swapped
uint16_t short_swap(uint16_t value) {
    uint16_t mask = 0xFF;
    uint16_t byte_one = value & mask;
    mask = mask << 8;
    uint16_t byte_two = value & mask;

    byte_one = byte_one << 8;
    byte_two = byte_two >> 8;

    uint16_t final_value = (byte_one) | (byte_two);

    return final_value;
}
