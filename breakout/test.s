# .TEXT <print_cell>
        .text
print_cell:
	# Subset:   1
	#
	# Frame:    [...]   <-- FILL THESE OUT!
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - $s0 -> int row
	#   - $s1 -> int col
	#   - $s2 -> int ball count
	#   - $s3 -> return register
	#   - $s4 -> offset calc reg
	#
	# Structure:        <-- FILL THIS OUT!
	#   print_cell
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

print_cell__prologue:
	begin
	push 	$ra
	push	$s0
	push	$s1
	push 	$s2
	push	$s3
	push 	$s4
	push	$s5
	push	$s6
print_cell__body:
	#move a0 and a1 - these are int row & int col respectively
	move 	$s0, $a0
	move	$s1, $a1

	# parameters of function are already in $a0 and $a1
	jal	count_balls_at_coordinate

	#move output
	move 	$s2, $v0	# $s2 = ball_count

if_ball_count_less_than_1_cond:
	ble	$s2, 1, if_ball_count_equal_to_1_cond	 # if(ball_count > 1)

if_ball_count_less_than_1_if_body:
	li	$s3, MANY_BALL_CHAR
	move 	$v0, $s3		# return MANY_BALL_CHAR
	b	print_cell__epilogue	# end func

if_ball_count_equal_to_1_cond:
	bne	$s2, 1, if_ball_count_less_than_1_cond3  # if (ball_count == 1)

if_ball_count_less_than_1_else_1_body:
	li	$s3, ONE_BALL_CHAR
	move 	$v0, $s3		# return ONE_BALL_CHAR
	b 	print_cell__epilogue	# end func

if_ball_count_less_than_1_cond3:
	# if (row == PADDLE_ROW && (paddle_x <= col && col < paddle_x + PADDLE_WIDTH))
		# move to if_ball_count_less_than_1_cond4
	bne	$s0, PADDLE_ROW, if_ball_count_less_than_1_cond4	#row == PADDLE_ROW

	lw	$s5, paddle_x
	bgt	$s5, $s1, if_ball_count_less_than_1_cond4	# paddle_x <= col

	addi	$s5, $s5, PADDLE_WIDTH
	bge	$s1, $s5, if_ball_count_less_than_1_cond4	# col < paddle_x + PADDLE_WIDTH
if_ball_count_less_than_1_else_2_body:
	li	$s3, PADDLE_CHAR   
	move 	$v0, $s3		# return PADDLE_CHAR
	b 	print_cell__epilogue	# end func

if_ball_count_less_than_1_cond4:
	#if (bricks[row][col])
		# otherwise move to if_ball_count_less_than_1_final_else_body

		# (base address + (array width * row index + column index))
	li	$s4, BRICK_WIDTH

	mul	$s5, $s4, $s0
	add	$s5, $s5, $s1

	la	$s4, bricks

	add	$s4, $s4, $s5
	lb	$s4, ($s4)

	bne 	$s4, 0, if_ball_count_less_than_1_final_else_body

if_ball_count_less_than_1_else_3_body:
	# return '0' + (bricks[row][col] - 1); 
	li	$s5, '0'

	li	$s4, BRICK_WIDTH
	mul	$s6, $s4, $s0
	add	$s6, $s6, $s1

	la	$s4, bricks

	add	$s6, $s6, $s4	#final address of bricks[row][col]
	lb	$s6, ($s6)

	subu	$s6, $s6, 1	# - 1
	add	$s6, $s5, $s6	# adding '0'

	move 	$v0, $s6   # (final calculated value)
	b	print_cell__epilogue
if_ball_count_less_than_1_final_else_body:
	li	$s3, EMPTY_CHAR		
	move 	$v0, $s3		# return EMPTY_CHAR

print_cell__epilogue:
	pop	$s6
	pop	$s5
	pop	$s4
	pop	$s3
	pop	$s2
	pop 	$s1
	pop 	$s0
	pop 	$ra
	end
	jr	$r