#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <ctype.h>
#include <string.h>

//
// Store an arbitray length Binary Coded Decimal number.
// bcd points to an array of size n_bcd
// Each array element contains 1 decimal digit.
// Digits are stored in reverse order.
//
// For example if 42 is stored then
// n_bcd == 2
// bcd[0] == 0x02
// bcd[1] == 0x04
//

typedef struct big_bcd {
    unsigned char *bcd;
    int n_bcd;
} big_bcd_t;


big_bcd_t *bcd_add(big_bcd_t *x, big_bcd_t *y);
void bcd_print(big_bcd_t *number);
void bcd_free(big_bcd_t *number);
big_bcd_t *bcd_from_string(char *string);
int len_of_bcd_chars(big_bcd_t *x);

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <number> <number>\n", argv[0]);
        exit(1);
    }

    big_bcd_t *left = bcd_from_string(argv[1]);
    big_bcd_t *right = bcd_from_string(argv[2]);

    big_bcd_t *result = bcd_add(left, right);

    bcd_print(result);
    printf("\n");

    bcd_free(left);
    bcd_free(right);
    bcd_free(result);

    return 0;
}


// DO NOT CHANGE THE CODE ABOVE HERE

big_bcd_t *bcd_add(big_bcd_t *x, big_bcd_t *y) {
    int size_x = x->n_bcd;
    int size_y = y->n_bcd;

    int size_of_res = size_x > size_y ? size_x : size_y;
    int size_x_bigger = size_x > size_y;

    big_bcd_t *result = malloc(sizeof *result);
    int n_digits = size_of_res;
    result->n_bcd = n_digits;
    result->bcd = malloc(n_digits * sizeof result->bcd[0]);

    int carry = 0;
    int count = 0;
    while (carry > 0 || count < n_digits) {
        if (count >= n_digits) {
            result->bcd = realloc(result->bcd, (count + 1) * sizeof result->bcd[0]);
            result->bcd[count] = carry;
            result->n_bcd++;
            carry = 0;
            count++;
            continue;
        }

        if (size_x_bigger) {
            int digit_x = x->bcd[count];
            int digit_y_index = count;
            int digit_y = 0;

            if (digit_y_index < size_y) {
                digit_y = y->bcd[digit_y_index];
            }

            int sum = digit_x + digit_y + carry;
            carry = 0;

            int final_digit = sum % 10;

            result->bcd[count] = final_digit;

            carry = sum / 10;

        } else {
            int digit_y = y->bcd[count];
            int digit_x_index = count;
            int digit_x = 0;

            if (digit_x_index < size_x) {
                digit_x = x->bcd[digit_x_index];  
            }

            int sum = digit_x + digit_y + carry;

            carry = 0;
            
            int final_digit = sum % 10;

            result->bcd[count] = final_digit;

            carry = sum / 10;

        }
        count++;
    }

    return result;
    
}
// DO NOT CHANGE THE CODE BELOW HERE


// print a big_bcd_t number
void bcd_print(big_bcd_t *number) {
    // if you get an error here your bcd_add is returning an invalid big_bcd_t
    assert(number->n_bcd > 0);
    for (int i = number->n_bcd - 1; i >= 0; i--) {
        putchar(number->bcd[i] + '0');
    }
}

// free storage for big_bcd_t number
void bcd_free(big_bcd_t *number) {
    // if you get an error here your bcd_add is returning an invalid big_bcd_t
    // or it is calling free for the numbers it is given
    free(number->bcd);
    free(number);
}

// convert a string to a big_bcd_t number
big_bcd_t *bcd_from_string(char *string) {
    big_bcd_t *number = malloc(sizeof *number);
    assert(number);

    int n_digits = strlen(string);
    assert(n_digits);
    number->n_bcd = n_digits;

    number->bcd = malloc(n_digits * sizeof number->bcd[0]);
    assert(number->bcd);

    for (int i = 0; i < n_digits; i++) {
        int digit = string[n_digits - i - 1];
        assert(isdigit(digit));
        number->bcd[i] = digit - '0';
    }


    return number;
}
 