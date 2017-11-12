	EXIT	= 0x1
	SYSCALL32 = 0x80
	
	COUNT	= 0x100000
	COUNTL	= 0x400000
	
.data
format_uint: .asciz "%u\n"
format_newline: .asciz "\n"
	
/*memspace: .space COUNTL*/
tscl: .space COUNTL
	
/*.bss
	.lcomm memspace, COUNTL
	.lcomm tscl, COUNTL
*/	
.text
	.global _start
_start:
	movl	$0, %esi
zero:
	clflush	tscl(,%esi,4)
	incl	%esi
	cmpl	$COUNT, %esi
	jl	zero
	
	movl	$0, %esi
loop:
	
	rdtscp
#	movl	%eax, %edi
	movl	%eax, tscl(,%esi,4)
	
#	movl	memspace(,%esi,4), %eax
	
	rdtscp
	subl	tscl(,%esi,4), %eax
	movl	%eax, tscl(,%esi,4)
	
	incl	%esi
	cmpl	$COUNT, %esi
	jl	loop
	
	movl	$0, %esi
	subl	$8, %esp
	movl	$format_uint, (%esp)
printloop:
	movl	tscl(,%esi,4), %eax
	movl	%eax, 4(%esp)
	call	printf
	
	incl	%esi
	cmpl	$COUNT, %esi
	jl	printloop
	
	movl	$format_newline, (%esp)
	call	printf
	addl	$8, %esp
	
	movl	$EXIT, %eax
	movl	$0x0, %ebx
	int	$SYSCALL32
