#include <stdio.h>
#include <string.h>
#include <ctype.h>

int is_vowel(char c) {
	if (!isalpha(c) || c == ' ') return 0;

	char res = tolower(c);
	return res == 'a' || res == 'e' || res == 'i' || res == 'o' || res == 'u';
}

int main(void) {
	char c;
	while (scanf("%c", &c) == 1) {
		if (!is_vowel(c) || c == ' ') {
			printf("%c", c);
		}
	}

	return 0;
	
}
