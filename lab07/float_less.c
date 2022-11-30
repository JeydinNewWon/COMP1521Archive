// Compare 2 floats using bit operations only

#include <stdint.h>
#include <stdlib.h>
#include <assert.h>

#include "floats.h"

#define SIGN_MASK 0x80000000
#define EXPONENT_MASK 0x7F800000
#define FRACTION_MASK 0x7FFFFF

#define SIGN_SHIFT 31
#define EXPONENT_SHIFT 23

#define TRUE 1
#define FALSE 0

float_components_t get_float_components(uint32_t num);

// float_less is given the bits of 2 floats bits1, bits2 as a uint32_t
// and returns 1 if bits1 < bits2, 0 otherwise
// 0 is return if bits1 or bits2 is Nan
// only bit operations and integer comparisons are used

float_components_t get_float_components(uint32_t num) {

    float_components_t f = {
        .sign = (num & SIGN_MASK) >> SIGN_SHIFT,
        .exponent = (num & EXPONENT_MASK) >> EXPONENT_SHIFT,
        .fraction = (num & FRACTION_MASK)
    };

    return f;
}

int is_infinity(float_components_t f) {
    if (f.exponent == 0xFF && f.fraction == 0) {
        return TRUE;
    }

    return FALSE;
}

int is_zero(float_components_t f) {

    if (f.exponent == 0 && f.fraction == 0) {
        return TRUE;
    }

    return FALSE;
}

int is_nan(float_components_t f) {

    if (f.exponent == 0xFF && f.fraction != 0) {
        return TRUE;
    }

    return FALSE;
}

uint32_t float_less(uint32_t bits1, uint32_t bits2) {
    float_components_t float_1 = get_float_components(bits1);
    float_components_t float_2 = get_float_components(bits2);

    if (is_nan(float_1) || is_nan(float_2)) {
        return 0;
    }

    if (is_zero(float_1) && is_zero(float_2)) {
        return 0;
    }

    if (float_1.sign == float_2.sign) {

        if (float_1.sign == 0) {
            if (float_1.exponent < float_2.exponent) {
                return 1;
            } else if (float_1.exponent > float_2.exponent) {
                return 0;
            } else {
                if (float_1.fraction < float_2.fraction) {
                    return 1;
                } else {
                    return 0;
                }
            }
        } else {
            if (float_1.exponent > float_2.exponent) {
                return 1;
            } else if (float_1.exponent < float_2.exponent) {
                return 0;
            } else {
                if (float_1.fraction > float_2.fraction) {
                    return 1;
                } else {
                    return 0;
                }
            }
        }

    } else if (float_1.sign > float_2.sign) {
        return 1;
    } else {
        return 0;
    }

}


