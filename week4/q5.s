	.text
main:
main__prologue:
	# Subset:   0
	#
	# Frame:    $ra   <-- FILL THESE OUT!
	# Uses:     $a0, $a1, $a2, $a3, $v0, $t0
	# Clobbers:  $a0, $a1, $a2, $a3, $v0, $t0
	#
	# Locals:
	#   - $t0 = result
	#
	# Structure:
	#   print_welcome
	#   -> [prologue]
	#       -> body
	#	-> print
	#   -> [epilogue]


	begin
	push	$ra
	push	$s0


main__body:
	li	$a0, 11
	li	$a1, 13
	li	$a2, 17
	li	$a3, 19
	jal 	sum4

	move	$s0, $v0      # int result = sum4(11, 13, 17, 19);
main__print:
	li	$v0, 1
	move	$a0, $s0
	syscall

	li	$v0, 11
	li	$a0, '\n'
	syscall


main__epilogue:

	pop	$s0
	pop	$ra
	end	
	jr	$ra


sum4:
sum4__prologue:
	# Subset:   0
	#
	# arugments: $a0 = a
	#		$a1 = b
	#
	# Frame:    $ra, $s0, $s1, $s2, $s3, $s5   <-- FILL THESE OUT!
	# Uses:     $ra, $s0, $s1, $s2, $s3, $s5, $a0, $a1, $v0
	# Clobbers: $a0, $a1, $v0
	#
	# Locals:
	#   - $s5 = res1
	#   - $s0 = $a0
	#	$s1 = $a1
	# 	$s2 = $a2
	#	#s3 = a3
	#
	# Structure:
	#   print_welcome
	#   -> [prologue]
	#       -> body
		# -> sum4__first_sum
		# -> sum4__second sum
	#   -> [epilogue]

	begin
	push	$ra
	push	$s0
	push	$s1
	push	$s2
	push	$s3
	push	$s5

	move	$s0, $a0
	move	$s1, $a1
	move	$s2, $a2
	move	$s3, $a3
sum4__body:
sum4__first_sum:
	move	$a0, $s0
	move	$a1, $s1
	jal	sum2
	#output res1 is in v0
	move	$s5, $v0	#s5 = res1
sum4__second_sum:
	move 	$a0, $s2
	move	$a1, $s3
	jal	sum2
	add	$v0, $v0, $s5

sum4__epilogue:
	pop	$s5
	pop	$s3
	pop	$s2
	pop	$s1
	pop	$s0
	pop	$ra
	end
	jr	$ra



sum2:
sum2__prologue:
	# Subset:   0
	#
	# Frame:    [...]   <-- FILL THESE OUT!
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:
	#   - None
	#
	# Structure:
	#   print_welcome
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]
	begin
	push 	$ra
sum2__body:
	add	$v0, $a0, $a1

	

sum2__epilogue:
	pop	$ra
	end
	jr	$ra



	.data
