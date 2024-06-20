	.text
main:
	la	$t0, a
	move	$a0, $t0
	li	$v0, 1
	syscall

	li	$a0, '\n'
	li	$v0, 11
	syscall

	la	$t0, c
	move	$a0, $t0
	li	$v0, 1
	syscall

	li	$a0, '\n'
	li	$v0, 11
	syscall

	jr $ra


	.data
start: .word 0
a: .asciiz "abcdef"
b: .align   2
c: .byte   3