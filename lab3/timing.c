#include <unistd.h>
#include <stdio.h>

#ifndef STDOUT
#define STDOUT 1
#endif

unsigned long long rdtsc();
unsigned long timing_mov();

int main(int argc, char **argv) {
	char *sample_text = "SAMPLE TEXT\n";
	unsigned long long printf_start = rdtsc();
	printf("%s", sample_text);
	unsigned long long write_start = rdtsc();
	write(STDOUT, sample_text, 12);
	unsigned long long write_end = rdtsc(); 
	unsigned long mov_time = timing_mov();
	
	printf("printf took %llu\nwrite took %llu\nmov took %lu\n",
		write_start - printf_start, write_end - write_start, mov_time);
	
	return 0;
}
