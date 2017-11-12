	EXIT	= 0x1
	WRITE	= 0x4
	
	STDOUT	= 0x1
	
	SYSCALL32 = 0x80
	
	.align 32
.data
errcode:
	.int 0
length:
	#.int 0x400
	#.int 0x100000
	.int 0x40000000
.bss
	.lcomm bitfield, 0x8000000

.text
	.global _start
_start:
	movl	$0, %ecx
initloop:
	cmpl	length, %ecx
	jnb	endinit
	
	movl	%ecx, %eax
	movl	$0, %edx
	movl	$8, %ebx
	divl	%ebx
	
	bts	%edx, bitfield(%eax)
	incl	%ecx
	jmp	initloop
	
endinit:
	movl	$1, %ecx
outerloop:
	incl	%ecx
	movl	%ecx, %eax
	mull	%eax
	
	cmpl	$0, %edx
	jne	error_mul
	
	cmpl	length, %eax
	jnb	end_outerloop
	
	pushl	%eax
	
	movl	%ecx, %eax
	movl	$0, %edx
	movl	$8, %ebx
	divl	%ebx
	
	bt	%edx, bitfield(%eax)
	jnc	outerloop
	
	pushl	%ecx
	call	innerfunc
	popl	%ecx
	popl	%eax
	
	jmp	outerloop
	
	
innerfunc:
	movl	8(%esp), %ecx

innerloop:
	cmpl	length, %ecx
	jnb	end_innerloop
	
	movl	%ecx, %eax
	movl	$0, %edx
	movl	$8, %ebx
	divl	%ebx
	
	btr	%edx, bitfield(%eax)
	
	addl	4(%esp), %ecx
	jmp	innerloop
	
end_innerloop:
	ret
	
	
error_mul:
	movl	$1, errcode
	jmp	exit
	
	
end_outerloop:
	movl	$WRITE, %eax
	movl	$STDOUT, %ebx
	movl	$bitfield, %ecx
	movl	length, %edx
	shrl	$3, %edx
	int	$SYSCALL32
	
exit:
	movl	$EXIT, %eax
	movl	errcode, %ebx
	int	$SYSCALL32

