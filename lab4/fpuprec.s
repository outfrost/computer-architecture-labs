#include "printf_bin.h"
#include "fpustctl.h"

	EXIT	= 0x1
	SYSCALL32 = 0x80
	
	.align 32
.data
double_a:	.quad 0x3E2D2EB3750E4F04	# a > 0, a < 1
double_b:	.quad 0x4037584810000000	# b > 1
format_fp:	.ascii "%e\n"
	
.text
	.global _start
_start:
	fldl	double_a
	subl	$8, %esp
	fstl	(%esp)
	pushl	$format_fp
	call	printf
	addl	$12, %esp

	fldl	double_b
	subl	$8, %esp
	fstl	(%esp)
	pushl	$format_fp
	call	printf
	addl	$12, %esp
	
	fmulp
	
	subl	$8, %esp
	fstl	(%esp)
	pushl	$format_fp
	call	printf
	addl	$12, %esp
	
	call	getFPUCtl
	andw	$0xFCFF, %ax
	pushl	%eax
	call	setFPUCtl
	addl	$4, %esp
	
test:
	fldl	double_a
	subl	$8, %esp
	fstl	(%esp)
	pushl	$format_fp
	call	printf
	addl	$12, %esp
	
	fldl	double_b
	subl	$8, %esp
	fstl	(%esp)
	pushl	$format_fp
	call	printf
	addl	$12, %esp
	
	fmulp
	
#	call	getFPUState_noexc
#	pushl	%eax
#	call	printf_bin16
#	addl	$4, %esp
	
	subl	$8, %esp
	fstl	(%esp)
	pushl	$format_fp
	call	printf
	addl	$12, %esp
	
	movl	$EXIT, %eax
	movl	$0x0, %ebx
	int	$SYSCALL32
