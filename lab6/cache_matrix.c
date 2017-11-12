#include <stdio.h>
#include "rdtsc.h"

#define SIZE 8192

int main(int argc, char **argv) {
	unsigned long long tsc_start;
	unsigned long long tsc_end;
	long long matrix [SIZE][SIZE];
	long long result = 0;
	tsc_start = rdtsc();
	for (long long i = 0; i < SIZE; i++) {
		for (long long k = 0; k < SIZE; k++)
			result += matrix[i][k];
	}
	tsc_end = rdtsc();
	printf("%llu\n", tsc_end - tsc_start);
	printf("%lld\n", result);
	result = 0;
	tsc_start = rdtsc();
	for (long long i = 0; i < SIZE; i++) {
		for (long long k = 0; k < SIZE; k++)
			result += matrix[k][i];
	}
	tsc_end = rdtsc();
	printf("%llu\n", tsc_end - tsc_start);
	printf("%lld\n", result);
	return 0;
}
