	EXIT	= 0x1
	READ	= 0x3
	WRITE	= 0x4
	
	STDIN	= 0x0
	STDOUT	= 0x1
	
	SYSCALL32 = 0x80
	
	.align 32
.data
errcode:
	.int 0
	
.bss
calcoperands:
	.space 512
	
.text
	.global _start
_start:
	movl	$READ, %eax
	movl	$STDIN, %ebx
	movl	$calcoperands, %ecx
	movl	$0x1, %edx
	int	$SYSCALL32
	
	movb	calcoperands, %dl
	
	movl	$READ, %eax
	movl	$STDIN, %ebx
	movl	$calcoperands, %ecx
	int	$SYSCALL32
	
	cmpl	%edx, %eax
	jne	err_read
	
	
