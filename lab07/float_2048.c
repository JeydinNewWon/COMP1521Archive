// Multiply a float by 2048 using bit operations only

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <assert.h>

#include "floats.h"

// float_2048 is given the bits of a float f as a uint32_t
// it uses bit operations and + to calculate f * 2048
// and returns the bits of this value as a uint32_t
//
// if the result is too large to be represented as a float +inf or -inf is returned
//
// if f is +0, -0, +inf or -inf, or Nan it is returned unchanged
//
// float_2048 assumes f is not a denormal number
//
uint32_t float_2048(uint32_t f) {
    uint32_t sign_mask = 0x80000000;
    uint32_t exponent_mask = 0x7F800000;
    uint32_t fraction_mask = 0x7FFFFF;

    uint32_t f_sign = (f & sign_mask) >> 31;
 
    uint32_t f_multiplied = exponent_mask & f;
    uint32_t f_exponent = f_multiplied >> 23;

    uint32_t f_frac = (f & fraction_mask);


    if (f_exponent == 0 && f_frac == 0) {
        if (f_sign == 0) {
            return 0;
        } else {
            return 0x80000000;
        }
    }

    if (f_exponent == 0xFF && f_frac != 0) {
        return f;
    }

    if (f_exponent + 11 > 256) {
        if (f_sign == 0) {
            return 0x7F800000;
        } else {
            return 0xFF800000;
        }
    } else {
        f_exponent += 11;
        uint32_t f_new_exp = f_exponent << 23;
        uint32_t f_new_sign = f_sign << 31;
        return (f_new_sign | f_new_exp | f_frac);
    }
}
