#include <stdio.h>
#include <ctype.h>

int main(void) {
	int c = getchar();
	while (c != EOF) {
		if (isupper(c)) {
			putchar(tolower(c));
		} else {
			putchar(c);
		}

		c = getchar();
	}
	return 0;
}
