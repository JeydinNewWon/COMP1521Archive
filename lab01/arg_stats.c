#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {

	int min;
	int max;
	int sum;
	int prod;
	int mean;

	for (int i = 1; i < argc; i++) {
		int num = atoi(argv[i]);
		if (i == 1) {
			min = max = sum = prod = mean = num;
		} else {
			if (num < min) {
				min = num;
			}

			if (num > max) {
				max = num;
			}

			sum += num;
			prod *= num;

			mean = sum / i;
		}
	}

	printf("MIN:  %d\n", min);
	printf("MAX:  %d\n", max);
	printf("SUM:  %d\n", sum);
	printf("PROD: %d\n", prod);
	printf("MEAN: %d\n", mean);
	return 0;
}
