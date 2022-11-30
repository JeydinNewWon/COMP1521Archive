#include <string.h>
#include <stdlib.h>
#include <inttypes.h>

/**
 * given a `UTF-8` encoded string,
 * return a new string that is only
 * the characters within the provided range.
 *
 * Note:
 * `range_start` is INCLUSIVE
 * `range_end`   is EXCLUSIVE
 *
 * eg:
 * "hello world", 0, 5
 * would return "hello"
 *
 * "🍓🍇🍈🍍🍐", 2, 5
 * would return "🍈🍍🍐"
**/

int utf8_code_point(uint8_t first_char) {
	unsigned int string_inc;
	if ((first_char) >> 3 == 0b11110) {
		string_inc = 4;
	} else if ((first_char >> 4) == 0b1110) {
		string_inc = 3;
	} else if ((first_char >> 5) == 0b110) {
		string_inc = 2;
	} else {
		string_inc = 1;
	}

	return string_inc;
} 

char *_22t2final_q6(char *utf8_string, unsigned int range_start, unsigned int range_end) {

	char *new_string = malloc((strlen(utf8_string)  +  1) * (sizeof (char)) );
	// char *new_string = calloc(strlen(utf8_string) + 1, (sizeof (char)));

	unsigned int char_count = range_end - range_start;
	
	unsigned int string_index = 0;

	int i = 0;
	while (i < range_start) {
		uint8_t first_char = (uint8_t) utf8_string[string_index];

		unsigned int string_inc = utf8_code_point(first_char);

		string_index += string_inc;
		i++;

	}

	int new_string_index = 0;

	i = 0;

	while (i < char_count) {
		uint8_t first_char = (uint8_t) utf8_string[string_index];

		unsigned int string_inc = utf8_code_point(first_char);
		
		for (int j = 0; j < string_inc; j++) {
			new_string[new_string_index] = utf8_string[string_index];
			new_string_index++;
			string_index++;
		}
		i++;
	}

	new_string[new_string_index] = '\0';


	return new_string;
}
