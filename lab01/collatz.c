#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv)
{
	int start = atoi(argv[1]);

	while (start != 1) {
		printf("%d\n", start);
		if (start % 2 == 0) {
			start /= 2;
		} else {
			start = 3*start + 1;
		}
	}

	printf("%d\n", start);
	return EXIT_SUCCESS;
}
