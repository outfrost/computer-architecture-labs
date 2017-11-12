	.global timing_mov
	.type timing_mov, function
timing_mov:
	movl	4(%esp), %esi
	pushl	%ebx
	
	xorl	%eax, %eax
	cpuid
	rdtsc
	
	movl	%eax, (%esi)
	
	xorl	%eax, %eax
	cpuid
	rdtsc
	
	subl	(%esi), %eax
	
	popl	%ebx
	ret
