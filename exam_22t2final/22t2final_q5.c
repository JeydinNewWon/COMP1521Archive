// COMP1521 22T2 ... final exam, question 5

#include <stdio.h>

void print_bytes(FILE *file, long n) {
	if (n >= 0) {
		for (long i = 0; i < n; i++) {
			int c = getc(file);
			if (c == EOF) break;
			fputc(c, stdout);
		}

	} else {
		long actual_n = n * -1;
		fseek(file, 0, SEEK_END);

		long len = ftell(file);

		fseek(file, 0, SEEK_SET);
		for (long i = 0; i < len - actual_n; i++) {
			int c = getc(file);
			if (c == EOF) break;
			fputc(c, stdout);
		}
	}

	fclose(file);
}
