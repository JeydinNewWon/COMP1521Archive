// COMP1521 22T3 Assignment 2: mipsc -- a MIPS simulator
// starting point code v1.0 - 24/10/22


// PUT YOUR HEADER COMMENT HERE


#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <errno.h>

// ADD ANY ADDITIONAL #include HERE

#define MAX_LINE_LENGTH 256
#define INSTRUCTIONS_GROW 64

// ADD ANY ADDITIONAL #defines HERE

#define NUM_REGISTERS 34 // includes HI and LO
#define SYSCALL 0xC
#define A0_REG 4
#define V0_REG 2
#define HI_REG 32
#define LO_REG 33

// STRING STUFF

#define INPUT_STR ">>>"
#define OUTPUT_STR "<<<"

// MASKS

#define ADD_MASK 0x20
#define SUB_MASK 0x22
#define SLT_MASK 0x2A
#define MFHI_MASK 0x10
#define MFLO_MASK 0x12
#define MULT_MASK 0x18
#define DIV_MASK 0x1A

#define SUFFIX_MASK 0x7FF
#define MULT_DIV_MASK 0xFFFF

#define MUL_SUFFIX 0b011100
#define BEQ_SUFFIX 0b000100
#define BNE_SUFFIX 0b000101
#define ADDI_SUFFIX 0b001000
#define ORI_SUFFIX 0b001101
#define LUI_SUFFIX 0b00111100000

#define LUI_MASK_SHIFT 21

#define LUI_CALC_SHIFT 16

#define LO_MASK 0xFFFFFFFF
#define HI_MASK 0xFFFFFFFF00000000


// REGISTER_MASKS

#define ADD_REG_MASK_S 0x3E00000
#define ADD_REG_MASK_T ADD_REG_MASK_S >> 5
#define ADD_REG_MASK_D ADD_REG_MASK_T >> 5

// STRUCT

struct STD {
    uint32_t s;
    uint32_t t;
    uint32_t d;
};

struct STI {
    uint32_t s;
    uint32_t t;
    int16_t I;
};

struct cmd_data {
    uint32_t instruction;
    int trace_mode;
};


// FUNCTIONS

void execute_instructions(uint32_t n_instructions,
                          uint32_t instructions[],
                          int trace_mode);
char *process_arguments(int argc, char *argv[], int *trace_mode);
uint32_t *read_instructions(char *filename, uint32_t *n_instructions_p);
uint32_t *instructions_realloc(uint32_t *instructions, uint32_t n_instructions);

// ADD ANY ADDITIONAL FUNCTION PROTOTYPES HERE

void perform_instruction(uint32_t instruction, uint32_t n_instructions, uint32_t registers[NUM_REGISTERS], uint32_t *PC, int trace_mode);

// COMMANDS

void syscall(uint32_t n_instructions, uint32_t registers[NUM_REGISTERS], int trace_mode);
void add(struct cmd_data data, uint32_t registers[NUM_REGISTERS]);
void sub(struct cmd_data data, uint32_t registers[NUM_REGISTERS]);
void slt(struct cmd_data data, uint32_t registers[NUM_REGISTERS]);
void mfhi(struct cmd_data data, uint32_t registers[NUM_REGISTERS]);
void mflo(struct cmd_data data, uint32_t registers[NUM_REGISTERS]);
void mult(struct cmd_data data, uint32_t registers[NUM_REGISTERS]);
void mips_div(struct cmd_data data, uint32_t registers[NUM_REGISTERS]);

void mul(struct cmd_data data, uint32_t registers[NUM_REGISTERS]);
void beq(struct cmd_data data, uint32_t registers[NUM_REGISTERS], uint32_t *PC, uint32_t n_instructions);
void bne(struct cmd_data data, uint32_t registers[NUM_REGISTERS], uint32_t *PC, uint32_t n_instructions);

void addi(struct cmd_data data, uint32_t registers[NUM_REGISTERS]);
void ori(struct cmd_data data, uint32_t registers[NUM_REGISTERS]);
void lui(struct cmd_data data, uint32_t registers[NUM_REGISTERS]);


// UTILITY
void init_registers(uint32_t registers[NUM_REGISTERS]);
int check_instruction(int32_t instruction);
struct STD get_std(uint32_t instruction);
struct STI get_sti(uint32_t instruction);
void print_results_I(char cmd_name[], struct STI sti, int32_t final_res);
void print_results_reg(char cmd_name[], struct STD std, int32_t final_res);
void print_branch(int trace_mode, int16_t I, int32_t sum, int32_t n_instructions, uint32_t *PC);
void print_HI_LO(char cmd_name[], struct STD std, uint32_t registers[NUM_REGISTERS]);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// YOU DO NOT NEED TO CHANGE MAIN
// but you can if you really want to
int main(int argc, char *argv[]) {
    int trace_mode;
    char *filename = process_arguments(argc, argv, &trace_mode);

    uint32_t n_instructions;
    uint32_t *instructions = read_instructions(filename, &n_instructions);

    execute_instructions(n_instructions, instructions, trace_mode);

    free(instructions);
    return 0;
}


// simulate execution of  instruction codes in  instructions array
// output from syscall instruction & any error messages are printed
//
// if trace_mode != 0:
//     information is printed about each instruction as it executed
//
// execution stops if it reaches the end of the array
void execute_instructions(uint32_t n_instructions,
                          uint32_t instructions[],
                          int trace_mode) {

    // REPLACE THIS FUNCTION WITH YOUR OWN IMPLEMENTATION

    uint32_t PC = 0;
    uint32_t registers[NUM_REGISTERS];

    init_registers(registers);

    while (PC < n_instructions) {
        if (trace_mode) {
            printf("%u: 0x%08X ", PC, instructions[PC]);
        }

        perform_instruction(instructions[PC], n_instructions, registers, &PC, trace_mode);

        PC++;
    } 

}


void perform_instruction(uint32_t instruction, uint32_t n_instructions, uint32_t registers[NUM_REGISTERS], uint32_t *PC, int trace_mode) {
    if (instruction == SYSCALL) {
        return syscall(n_instructions, registers, trace_mode);
    }

    int32_t shift_26 = instruction >> 26;
    int is_alt_instruction = check_instruction(instruction);
    int not_alt_and_zero = !is_alt_instruction && shift_26 == 0;

    uint32_t suffix_check = instruction & SUFFIX_MASK;
   
    struct cmd_data data = {
        .instruction = instruction,
        .trace_mode = trace_mode
    };


    if ((suffix_check == ADD_MASK) && not_alt_and_zero) {
        add(data, registers);
    } else if ((suffix_check == SUB_MASK) && not_alt_and_zero) {
        sub(data, registers);
    } else if ((suffix_check == SLT_MASK) && not_alt_and_zero) {
        slt(data, registers);
    } else if ((suffix_check == MFHI_MASK) && not_alt_and_zero) {
        mfhi(data, registers);
    } else if ((suffix_check == MFLO_MASK) && not_alt_and_zero) {
        mflo(data, registers);
    } else if ((instruction & MULT_DIV_MASK) == MULT_MASK && not_alt_and_zero) {
        mult(data, registers);
    } else if ((instruction & MULT_DIV_MASK) == DIV_MASK && not_alt_and_zero) {
        mips_div(data, registers);
    } else if ((shift_26) == MUL_SUFFIX) {
        mul(data, registers);
    } else if ((shift_26) == BEQ_SUFFIX) {
        beq(data, registers, PC, n_instructions);
    } else if ((shift_26) == BNE_SUFFIX) {
        bne(data, registers, PC, n_instructions);
    } else if ((shift_26) == ADDI_SUFFIX) {
        addi(data, registers);
    } else if ((shift_26) == ORI_SUFFIX) {
        ori(data, registers);
    } else if ((instruction >> LUI_MASK_SHIFT) == LUI_SUFFIX) {
        lui(data, registers);
    } else {
        fprintf(stderr, "Invalid instruction 0x%08X at PC = %d\n", instruction, *PC);
        exit(EXIT_FAILURE);
    }

}

void add(struct cmd_data data, uint32_t registers[NUM_REGISTERS]) {
    struct STD std = get_std(data.instruction);

    int32_t calc = registers[std.s] + registers[std.t];
    if (std.d != 0) registers[std.d] = calc;

    if (data.trace_mode) {
        print_results_reg("add ", std, calc);
    }

}

void sub(struct cmd_data data, uint32_t registers[NUM_REGISTERS]) {
    struct STD std = get_std(data.instruction);

    int32_t calc = registers[std.s] - registers[std.t];
    if (std.d != 0) registers[std.d] = calc;

    if (data.trace_mode) {
        print_results_reg("sub ", std, calc);
    }
}

void slt(struct cmd_data data, uint32_t registers[NUM_REGISTERS]) {
    struct STD std = get_std(data.instruction);

    int32_t calc = registers[std.s] < registers[std.t];
    if (std.d != 0)  registers[std.d] = calc;

    if (data.trace_mode) {
        print_results_reg("slt ", std, calc);
    }
}

void mfhi(struct cmd_data data, uint32_t registers[NUM_REGISTERS]) {
    struct STD std = get_std(data.instruction);

    if (std.d != 0) registers[std.d] = registers[HI_REG];

    if (data.trace_mode) {
        printf("mfhi $%d\n", std.d);
        printf("%s $%d = %d\n", INPUT_STR, std.d, registers[HI_REG]);
    }
}

void mflo(struct cmd_data data, uint32_t registers[NUM_REGISTERS]) {
    struct STD std = get_std(data.instruction);

    registers[std.d] = registers[LO_REG];

    if (data.trace_mode) {
        printf("mflo $%d\n", std.d);
        printf("%s $%d = %d\n", INPUT_STR, std.d, registers[std.d]);
    }
}

void mult(struct cmd_data data, uint32_t registers[NUM_REGISTERS]) {
    struct STD std = get_std(data.instruction);

    uint64_t res = (int64_t) registers[std.s] * registers[std.t];
    uint32_t lo = res & LO_MASK;
    uint32_t hi = (res & (HI_MASK) ) >> 32;

    registers[HI_REG] = hi;
    registers[LO_REG] = lo;

    if (data.trace_mode) {
        print_HI_LO("mult", std, registers);
    }
}

void mips_div(struct cmd_data data, uint32_t registers[NUM_REGISTERS]) {
    struct STD std = get_std(data.instruction);

    if (registers[std.t] == 0) {
        registers[HI_REG] = 0;
        registers[LO_REG] = 0;
    } else {
        registers[HI_REG] = (int32_t) registers[std.s] % registers[std.t];
        registers[LO_REG] = (int32_t) registers[std.s] / registers[std.t];
    }

    if (data.trace_mode) {
        print_HI_LO("div ", std, registers);
    }

}

void mul(struct cmd_data data, uint32_t registers[NUM_REGISTERS]) {
    struct STD std = get_std(data.instruction);

    registers[std.d] = registers[std.s] * registers[std.t];

    if (data.trace_mode) {
        print_results_reg("mul ", std, registers[std.d]);
    }
}

void beq(struct cmd_data data, uint32_t registers[NUM_REGISTERS], uint32_t *PC, uint32_t n_instructions) {
    struct STI sti = get_sti(data.instruction);
    int32_t sum = *PC + sti.I;

    if (data.trace_mode) printf("beq  $%d, $%d, %d\n", sti.s, sti.t, sti.I);

    if (registers[sti.s] != registers[sti.t]) {
        if (data.trace_mode) printf("%s branch not taken\n", INPUT_STR);
        return;
    }

    print_branch(data.trace_mode, sti.I, sum, n_instructions, PC);
}

void bne(struct cmd_data data, uint32_t registers[NUM_REGISTERS], uint32_t *PC, uint32_t n_instructions) {
    struct STI sti = get_sti(data.instruction);
    int32_t sum = *PC + sti.I;

    if (data.trace_mode) printf("bne  $%d, $%d, %d\n", sti.s, sti.t, sti.I);

    if (registers[sti.s] == registers[sti.t]) {
        if (data.trace_mode) printf("%s branch not taken\n", INPUT_STR);
        return;
    }

    print_branch(data.trace_mode, sti.I, sum, n_instructions, PC);
}

void addi(struct cmd_data data, uint32_t registers[NUM_REGISTERS]) {
    struct STI sti = get_sti(data.instruction); 

    int32_t calc = registers[sti.s] + sti.I;

    if (sti.t != 0) registers[sti.t] = calc;

    if (data.trace_mode) {
        print_results_I("addi", sti, calc);

    }
}

void ori(struct cmd_data data, uint32_t registers[NUM_REGISTERS]) {
    struct STI sti = get_sti(data.instruction); 

    int32_t calc = registers[sti.s] | (uint16_t) sti.I;

    if (sti.t != 0) registers[sti.t] = calc;

    if (data.trace_mode) {
        print_results_I("ori ", sti, calc);
    }
}

void lui(struct cmd_data data, uint32_t registers[NUM_REGISTERS]) {
    struct STI sti = get_sti(data.instruction);

    uint32_t calc = (uint32_t) sti.I << LUI_CALC_SHIFT;

    if (sti.t != 0) registers[sti.t] = calc;

    if (data.trace_mode) {
        printf("lui  $%d, %d\n", sti.t, sti.I);
        printf("%s $%d = %d\n", INPUT_STR, sti.t, calc);
    }

}

void syscall(uint32_t n_instructions, uint32_t registers[NUM_REGISTERS], int trace_mode) {
    int32_t a0_reg = registers[A0_REG];
    int32_t v0_reg = registers[V0_REG];

    if (trace_mode) {
        printf("syscall\n");
        printf("%s syscall %d\n", INPUT_STR, v0_reg);
    }

    if (v0_reg == 1) {
        if (trace_mode) {
            printf("%s %d\n", OUTPUT_STR, a0_reg);
        } else {
            printf("%d", a0_reg);
        }
    } else if (v0_reg == 10) {
        exit(0);
    } else if (v0_reg == 11) {
        if (trace_mode) {
            printf("%s %c\n", OUTPUT_STR, a0_reg);
        } else {
            printf("%c", a0_reg);
        }
    } else {
        fprintf(stderr, "Unknown system call: %d\n", v0_reg);
        exit(EXIT_FAILURE);
    }
}

// UTILITY FUNCTIONS

void init_registers(uint32_t registers[NUM_REGISTERS]) {
    for (int i = 0; i < NUM_REGISTERS; i++) {
        registers[i] = 0;
    }
}

int check_instruction(int32_t instruction) {
    int32_t shift_26 = instruction >> 26;

    int is_mul = (shift_26) == MUL_SUFFIX;
    int is_beq = (shift_26) == BEQ_SUFFIX;

    int is_bne = (shift_26) == BNE_SUFFIX;

    int is_addi = (shift_26) == ADDI_SUFFIX;

    int is_ori = (shift_26) == ORI_SUFFIX;

    int is_lui = (instruction >> LUI_MASK_SHIFT) == LUI_SUFFIX;


    return (is_mul || is_beq || is_bne || is_addi || is_ori || is_lui);
}


struct STD get_std(uint32_t instruction) {
    struct STD std = {
        .s = (instruction & ADD_REG_MASK_S) >> 21,
        .t = (instruction & ADD_REG_MASK_T) >> 16,
        .d = (instruction & ADD_REG_MASK_D) >> 11
    };

    return std;

}
struct STI get_sti(uint32_t instruction) {
    struct STI sti = {
        .s = (instruction & ADD_REG_MASK_S) >> 21,
        .t = (instruction & ADD_REG_MASK_T) >> 16,
        .I = (int16_t) (instruction & 0xFFFF)
    };

    return sti;
}



void print_results_I(char cmd_name[], struct STI sti, int32_t final_res) {
    printf("%s $%d, $%d, %d\n", cmd_name, sti.t, sti.s, sti.I);
    printf("%s $%d = %d\n", INPUT_STR, sti.t, final_res); 

}

void print_results_reg(char cmd_name[], struct STD std, int32_t final_res) {
    printf("%s $%d, $%d, $%d\n", cmd_name, std.d, std.s, std.t);
    printf("%s $%d = %d\n", INPUT_STR, std.d, final_res); 
}

void print_branch(int trace_mode, int16_t I, int32_t sum, int32_t n_instructions, uint32_t *PC) {
    if (sum > n_instructions || sum < 0) {
        fprintf(stderr, "Illegal branch to non-instruction: PC = %u\n", sum);
        exit(1);
    } else {
        *PC += (I - 1);
        if (trace_mode) printf("%s branch taken to PC = %u\n", INPUT_STR, sum);
    }
}

void print_HI_LO(char cmd_name[], struct STD std, uint32_t registers[NUM_REGISTERS]) {
    printf("%s $%d, $%d\n", cmd_name, std.s, std.t);
    printf("%s HI = %d\n", INPUT_STR, registers[HI_REG]);
    printf("%s LO = %d\n", INPUT_STR, registers[LO_REG]);
}



// DO NOT CHANGE CODE BELOW HERE
// check_arguments is given command-line arguments
// it sets *trace_mode to 0 if -r is specified
//         *trace_mode is set to 1 otherwise
// the filename specified in command-line arguments is returned
char *process_arguments(int argc, char *argv[], int *trace_mode) {
    if (
        argc < 2 ||
        argc > 3 ||
        (argc == 2 && strcmp(argv[1], "-r") == 0) ||
        (argc == 3 && strcmp(argv[1], "-r") != 0)
    ) {
        fprintf(stderr, "Usage: %s [-r] <file>\n", argv[0]);
        exit(1);
    }
    *trace_mode = (argc == 2);
    return argv[argc - 1];
}


// read hexadecimal numbers from filename one per line
// numbers are return in a malloc'ed array
// *n_instructions is set to size of the array
uint32_t *read_instructions(char *filename, uint32_t *n_instructions_p) {
    FILE *f = fopen(filename, "r");
    if (f == NULL) {
        perror(filename);
        exit(1);
    }

    uint32_t *instructions = NULL;
    uint32_t n_instructions = 0;
    char line[MAX_LINE_LENGTH + 1];
    while (fgets(line, sizeof line, f) != NULL) {

        // grow instructions array in steps of INSTRUCTIONS_GROW elements
        if (n_instructions % INSTRUCTIONS_GROW == 0) {
            instructions = instructions_realloc(instructions, n_instructions + INSTRUCTIONS_GROW);
        }

        char *endptr;
        instructions[n_instructions] = (uint32_t)strtoul(line, &endptr, 16);
        if (*endptr != '\n' && *endptr != '\r' && *endptr != '\0') {
            fprintf(stderr, "line %d: invalid hexadecimal number: %s",
                    n_instructions + 1, line);
            exit(1);
        }
        if (instructions[n_instructions] != strtoul(line, &endptr, 16)) {
            fprintf(stderr, "line %d: number too large: %s",
                    n_instructions + 1, line);
            exit(1);
        }
        n_instructions++;
    }
    fclose(f);
    *n_instructions_p = n_instructions;
    // shrink instructions array to correct size
    instructions = instructions_realloc(instructions, n_instructions);
    return instructions;
}


// instructions_realloc is wrapper for realloc
// it calls realloc to grow/shrink the instructions array
// to the specified size
// it exits if realloc fails
// otherwise it returns the new instructions array
uint32_t *instructions_realloc(uint32_t *instructions, uint32_t n_instructions) {
    instructions = realloc(instructions, n_instructions * sizeof *instructions);
    if (instructions == NULL) {
        fprintf(stderr, "out of memory");
        exit(1);
    }
    return instructions;
}
