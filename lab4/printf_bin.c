#include <stdio.h>
#include "printf_bin.h"

void printf_bin16(unsigned short field) {
	for (unsigned short i = 0x8000; i; i >>= 1) {
		printf("%c", field & i ? '1' : '0');
	}
	printf("\n");
}

void printf_bin32(unsigned long field) {
	for (unsigned long i = 0x80000000; i; i >>= 1) {
		printf("%c", field & i ? '1' : '0');
	}
	printf("\n");
}
