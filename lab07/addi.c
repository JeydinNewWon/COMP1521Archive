// generate the encoded binary for an addi instruction, including opcode and operands

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <assert.h>

#include "addi.h"

// return the encoded binary MIPS for addi $t,$s, i
uint32_t addi(int t, int s, int i) {

    // 001000ssssstttttIIIIIIIIIIIIIIII

    // I: 16
    // T: 21
    // S: 26
    

    uint32_t one_at_end = 1 << 29;
    uint32_t t_shifted = t << 16;
    uint32_t s_shifted = s << 21;
    uint16_t i_changed = (uint16_t) i;

    return (one_at_end | t_shifted | s_shifted | i_changed);
}
