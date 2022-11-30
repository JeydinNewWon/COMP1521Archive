// Call the `final_q5' function for the command-line arguments.
// See the exam paper and `21t3final_q5.c' file for a description of the question.

// Do not change this file.

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

int final_q5(uint32_t value1, uint32_t value2);

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(stderr, "Usage %s <value1> <value2>\n", argv[0]);
        return 1;
    }

    uint32_t value1 = strtol(argv[1], NULL, 0);
    uint32_t value2 = strtol(argv[2], NULL, 0);
    printf("final_q5(0x%08x, 0x%08x) returned %d\n", value1, value2, final_q5(value1, value2));

    return 0;
}
