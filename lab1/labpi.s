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
bufin:
	.byte 0
bufout:
	.byte 0

.text
	.global _start
_start:
	movl	$0x1, %edx

stream:
	movl	$READ, %eax
	movl	$STDIN, %ebx
	movl	$bufin, %ecx
	int	$SYSCALL32

	cmpl	$1, %eax
	jne	streamend

	xorl	%eax, %eax

	movb	bufin, %al
	shrb	$4, %al
	addb	$'0, %al

	cmpb	$':, %al
	jb	decdigit1

	addb	$7, %al
decdigit1:

	movb	%al, bufout
	movl	$WRITE, %eax
	movl	$STDOUT, %ebx
	movl	$bufout, %ecx
	int	$SYSCALL32

	movb	bufin, %al
	andb	$0x0F, %al

	addb	$'0, %al
	cmpb	$':, %al
	jb	decdigit2

	addb	$7, %al
decdigit2:

	movb	%al, bufout
	movl	$WRITE, %eax
	movl	$STDOUT, %ebx
	movl	$bufout, %ecx
	int	$SYSCALL32

	movb	$' , bufout
	movl	$WRITE, %eax
	int	$SYSCALL32

	jmp	stream

streamend:
	movl	$EXIT, %eax
	movl	errcode, %ebx
	int	$SYSCALL32
