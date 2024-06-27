FLAG_ROWS = 6
FLAG_COLS = 12
	
	.text

main:
main__prologue:
	begin
	push	$ra

main__body:
#take the opposite condition, and goto: end of that code.
	li	$t0, 0		#row = $t0
main__for_loop_1_cond:
	bge  	$t0, FLAG_ROWS, main__for_loop_1_end		#for (int row = 0; row < FLAG_ROWS; row++)
	li	$t1, 0		#col = $t1
main__for_loop_2_cond:
	bge	$t1, FLAG_COLS, main__for_loop_2_end		#for (int col = 0; col < FLAG_COLS; col++) 
main__for_loop_2_body:
	la	$t2, flag
	mul	$t3, $t0, FLAG_COLS			
	add	$t3, $t3, $t1
	mul	$t3, $t3, 1	
	add	$t3, $t3, $t2			
	lb	$t4, ($t3)			#flag[row][col] = $t3

	li	$v0, 11
	move	$a0, $t4
	syscall					#printf("%c", flag[row][col]);

	addi	$t1, $t1, 1
	j	main__for_loop_2_cond

main__for_loop_2_end:
main__for_loop_1_body:
	li	$a0, '\n'		
	li	$v0, 11
	syscall				#printf("\n");

	addi	$t0, $t0, 1
	j 	main__for_loop_1_cond

main__for_loop_1_end:

main__epilogue:

	pop	$ra
	end
	jr	$ra

	.data
flag:
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
	.byte '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'
	.byte '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'