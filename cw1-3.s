	EXIT	= 1
	READ	= 3
	WRITE	= 4
	
	STDIN	= 0
	STDOUT	= 1
	
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
	movl	$bufin, %ecx
	movl	$0x1, %edx
	
stream:
	movl	$READ, %eax
	movl	$STDIN, %ebx
	int	$SYSCALL32
	
	cmpl	$0x1, %eax
	jne	streamend
	
	cmpb	$0x30, bufin
	jb	inerr
	cmpb	$0x46, bufin
	ja	inerr
	cmpb	$0x3a, bufin
	jb	convert
	cmpb	$0x41, bufin
	jb	inerr
	
	subb	$0x07, bufin
	
convert:
	movl	$STDOUT, %ebx
	movl	$bufout, %ecx
	
	cmpb	$0x38, bufin
	jb	conv8d0
	
	movb	$0x31, (%ecx)
	subb	$0x08, bufin
	jmp	conv8wrt
	
conv8d0:
	movb	$0x30, (%ecx)
	
conv8wrt:
	movl	$WRITE, %eax
	int	$SYSCALL32
	
	cmpb	$0x34, bufin
	jb	conv4d0
	
	movb	$0x31, (%ecx)
	subb	$0x04, bufin
	jmp	conv4wrt
	
conv4d0:
	movb	$0x30, (%ecx)
	
conv4wrt:
	movl	$WRITE, %eax
	int	$SYSCALL32
	
	cmpb	$0x32, bufin
	jb	conv2d0
	
	movb	$0x31, (%ecx)
	subb	$0x02, bufin
	jmp	conv2wrt
	
conv2d0:
	movb	$0x30, (%ecx)
	
conv2wrt:
	movl	$WRITE, %eax
	int	$SYSCALL32
	
	movl	$bufin, %ecx
	movl	$WRITE, %eax
	int	$SYSCALL32
	
	jmp	stream
	
inerr:
	movl	$0x1, errcode
streamend:
	movl	$EXIT, %eax
	movl	errcode, %ebx
	int	$SYSCALL32
