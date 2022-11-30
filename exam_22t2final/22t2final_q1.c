// COMP1521 22T2 ... final exam, question 1

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

int count_zero_bits(uint32_t x) {
	uint32_t mask = 1;

	int zero_count = 0;
	for (int i = 0; i < 32; i++) {
		if ((x & mask) == 0) {
			zero_count++;
		}
		mask = mask << 1;
	}

	return zero_count;
}
