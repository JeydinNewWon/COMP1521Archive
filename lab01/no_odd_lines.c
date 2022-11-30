#include <stdio.h>
#include <string.h>

#define MAX_CHARS 1025

int main(void) {
	char my_string[MAX_CHARS];

	while (fgets(my_string, MAX_CHARS, stdin) != NULL) {
		if (strlen(my_string) % 2 == 0) {
			fputs(my_string, stdout);
		}
	}
	return 0;
}
