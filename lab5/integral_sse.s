# double calculateIntegralWithSSE(double begin, double delta, int count);
.data
double_one:	.double 1.0
double_two:	.double 2.0

	.global calculateIntegralWithSSE
	.type calculateIntegralWithSSE, function
calculateIntegralWithSSE:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	
	fldl	8(%ebp)
	fldl	16(%ebp)
	faddp
	fstpl	-16(%ebp)
	
	fldl	16(%ebp)
	fldl	double_two
	fmulp
	fstpl	-8(%ebp)
	
	shrl	24(%ebp)
	
	movlpd	8(%ebp), %xmm0
	movhpd	-16(%ebp), %xmm0	# XMM0: begin + delta	, begin
	movsd	16(%ebp), %xmm1
	movlhps	%xmm1, %xmm1		# XMM1: delta		, delta
	movsd	-8(%ebp), %xmm2
	movlhps	%xmm2, %xmm2		# XMM2: 2 * delta	, 2 * delta
	movsd	double_one, %xmm3
	movlhps	%xmm3, %xmm3		# XMM3: 1.0		, 1.0
	
integrate:
	decl	24(%ebp)
	fildl	24(%ebp)
	fstpl	-8(%ebp)
	
	movsd	-8(%ebp), %xmm4
	movlhps	%xmm4, %xmm4		# XMM4: i		, i
	mulpd	%xmm2, %xmm4
	addpd	%xmm0, %xmm4		# XMM4: x + delta	, x
	
	movupd	%xmm4, %xmm5
	mulpd	%xmm4, %xmm5		# XMM5: (x + delta)^2	, x^2
	
	movupd	%xmm3, %xmm6
	subpd	%xmm5, %xmm6		# XMM6: 1 - (x+delta)^2		, 1 - x^2
	divpd	%xmm4, %xmm6		# XMM6: (1-(x+delta)^2)/(x+delta), (1-x^2)/x
	
	addpd	%xmm6, %xmm7
	
	addpd	%xmm1, %xmm4		# XMM4: x + 2*delta	, x + delta
	
	movupd	%xmm4, %xmm5
	mulpd	%xmm4, %xmm5		# XMM5: (x + 2*delta)^2	, (x + delta)^2
	
	movupd	%xmm3, %xmm6
	subpd	%xmm5, %xmm6		# XMM6: 1-(x+2*delta)^2			, 1-(x+delta)^2
	divpd	%xmm4, %xmm6		# XMM6: (1-(x+2*delta)^2)/(x+2*delta)	, (1-(x+delta)^2)/(x+delta)
	
	addpd	%xmm6, %xmm7
	
	cmpl	$0, 24(%ebp)
	jg	integrate
	
	movlpd	%xmm7, -16(%ebp)
	fldl	-16(%ebp)
	movhpd	%xmm7, -16(%ebp)
	faddl	-16(%ebp)
	fmull	16(%ebp)
	fdivl	double_two
	
	addl	$16, %esp
	popl	%ebp
	ret
