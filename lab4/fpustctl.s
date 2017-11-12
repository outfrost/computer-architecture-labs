.data
fpuctl:	.byte 0, 0

.text
	.global	getFPUState
	.type	getFPUState, function
getFPUState:
	xorl	%eax, %eax
	fstsw	%ax
	ret

	.global	getFPUState_noexc
	.type	getFPUState_noexc, function
getFPUState_noexc:
	xorl	%eax, %eax
	fnstsw	%ax
	ret

	.global	clrFPUExc
	.type	clrFPUExc, function
clrFPUExc:
	fclex
	ret

	.global	getFPUCtl
	.type	getFPUCtl, function
getFPUCtl:
	xorl	%eax, %eax
	fstcw	fpuctl
	mov	fpuctl, %ax
	ret

	.global	setFPUCtl
	.type	setFPUCtl, function
setFPUCtl:
	fclex
	fldcw	6(%esp)
	ret
