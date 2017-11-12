	EXIT	= 0x1
	SYSCALL32 = 0x80
	
	.align 32
.data
s_intformat: .ascii "%d"
p_intformat: .ascii "%d\n"
s_charformat: .ascii " %c"
p_charformat: .ascii "%c\n"
s_cstrformat: .ascii "%254s"
p_cstrformat: .ascii "%s\n"
.bss
integer: .int 0
character: .byte 0
	.lcomm buffer, 0x100

.text
	.global _start
_start:
	pushl $integer
	pushl $s_intformat
	call scanf
	addl $8, %esp
	
	pushl $character
	pushl $s_charformat
	call scanf
	addl $8, %esp
	
	pushl $buffer
	pushl $s_cstrformat
	call scanf
	addl $8, %esp
	
	pushl integer
	pushl $p_intformat
	call printf
	addl $8, %esp
	
	pushl character
	pushl $p_charformat
	call printf
	addl $8, %esp
	
	pushl $buffer
	pushl $p_cstrformat
	call printf
	addl $8, %esp
	
	movl $EXIT, %eax
	movl $0x0, %ebx
	int SYSCALL32
