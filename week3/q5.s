N_SIZE = 10	
	
	.text
# int main(void) {
main:	

	
	li	$t0, 0		# i = 0;

	# while (i < N_SIZE) {
main__loop_cond:
	# if (i >= N_SIZE)     for logic (if, while for) always take the opposite condition
	bge	$t0, N_SIZE, main__end
main__loop_body:
	li	$v0, 5		#scanf
	syscall

	#output will be in $v0
	move	$t1, $v0
	mul	$t2, $t0, 4		#offset by 4 for each int
	sw	$t1, numbers($t2)	

	addi	$t0, $t0, 1	#i++
	j	main__loop_cond

main__end:
	li	$t1, 20
	lw	$a0, numbers($t1)
	li	$v0, 1
	syscall

	jr	$ra

	.data
numbers: .space N_SIZE*4
