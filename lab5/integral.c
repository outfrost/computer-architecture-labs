#include <stdio.h>
#include "integral_legacy.h"
#include "integral_sse.h"
#include "rdtsc.h"

#define	BEGIN 2.0
#define	END 4.0
#define STEPS 4194304.0

int main(int argc, char **argv) {
	double delta = 1.0 / STEPS;
	int count = (int)(STEPS * (END - BEGIN));
	double result = 0.0;
	unsigned long long tscBeforeLegacy = rdtsc();
	result = calculateIntegralLegacyWay(BEGIN, delta, count);
	unsigned long long tscAfterLegacy = rdtsc();
	printf("%e\n%.50f\nLegacy computation took %llu cycles\n", result, result, tscAfterLegacy - tscBeforeLegacy);
	unsigned long long tscBeforeSSE = rdtsc();
	result = calculateIntegralWithSSE(BEGIN, delta, count);
	unsigned long long tscAfterSSE = rdtsc();
	printf("%e\n%.50f\nComputation using SSE took %llu cycles\n", result, result, tscAfterSSE - tscBeforeSSE);
	return 0;
}
