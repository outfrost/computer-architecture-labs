#include <stdio.h>
#include <float.h>
#include "printf_bin.h"
#include "fpustctl.h"

int main(int argc, char **argv) {
	int a = 19;
	int b = 29;
	int c = a / b;
	double a_f = (double) a;
	double c_f = (double) c;
	printf_bin16(getFPUState());
	double d_f = a_f / c_f;
	printf_bin16(getFPUState());
	clrFPUExc();
	printf_bin16(getFPUState());
	d_f = DBL_MAX + DBL_MAX;
	printf_bin16(getFPUState());
	
	return 0;
}
