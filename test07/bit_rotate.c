#include "bit_rotate.h"

// return the value bits rotated left n_rotations
uint16_t bit_rotate(int n_rotations, uint16_t bits) {
    int actual_rotations = n_rotations % 16;

    if (actual_rotations == 0) return bits;

    uint16_t initial_mask = 0xFFFF;

    if (actual_rotations > 0) {
        uint16_t overflow_mask = (initial_mask << (16 - actual_rotations));
        uint16_t overflow = (overflow_mask & bits) >> (16 - actual_rotations);

        uint16_t mask = (initial_mask >> actual_rotations);

        uint16_t rotated = (bits & mask) << actual_rotations;

        return (rotated | overflow);


    } else {
        actual_rotations *= -1;
        uint16_t overflow_mask = (initial_mask >> (16 - actual_rotations));
        uint16_t overflow = (overflow_mask & bits) << (16 - actual_rotations);

        uint16_t mask = (initial_mask << actual_rotations);

        uint16_t rotated = (bits & mask) >> actual_rotations;

        return (rotated | overflow);
    }
}
