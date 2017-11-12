#include <unistd.h>
#include <stdio.h>

unsigned long long rdtsc();
unsigned long timing_mov(unsigned long * tmp);

int main(int argc, char **argv) {
	char *sample_text = "SAMPLE TEXT\n";
	unsigned long long printf_start = rdtsc();
	printf("%s", sample_text);
	unsigned long long write_start = rdtsc();
	write(1, sample_text, 12);
	unsigned long long write_end = rdtsc(); 
	unsigned long tmp = 0u;
	unsigned long mov_time = timing_mov(&tmp);
	
	printf("printf\n%llu\n%llu\nwrite\n%llu\n%llu\nmov took %lu\n",
		printf_start, write_start, write_start, write_end, mov_time);
	
	return 0;
}
