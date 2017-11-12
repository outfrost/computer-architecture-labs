	.global rdtsc
	.type rdtsc, function
rdtsc:
	pushl	%ebx
	xorl	%eax, %eax
	cpuid
	
	rdtsc
	
	popl	%ebx
	ret
