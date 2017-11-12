#include <stdio.h>

unsigned long long rdtsc();

int main(int argc, char **argv) {
	unsigned long long test = rdtsc();
	printf("%llu\n", test);
	return 0;
}
