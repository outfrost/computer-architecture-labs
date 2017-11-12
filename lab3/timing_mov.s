.bss
timing_start:
	.int 0

.text
	.global timing_mov
	.type timing_mov, function
timing_mov:
	pushl	%ebx
	
	xorl	%eax, %eax
	cpuid
	rdtsc
	
	movl	%eax, timing_start
	
	xorl	%eax, %eax
	cpuid
	rdtsc
	
	subl	timing_start, %eax
	
	popl	%ebx
	ret
