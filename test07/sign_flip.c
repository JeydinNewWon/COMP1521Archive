#include "sign_flip.h"

// given the 32 bits of a float return it with its sign flipped
uint32_t sign_flip(uint32_t f) {
    uint32_t sign = (f & 0x80000000) >> 31;

    uint32_t new_sign = (~ sign) << 31;

    if (sign == 0) {
        return (f | new_sign);
    } else {
        return (f & 0x7FFFFFFF);
    }
}
