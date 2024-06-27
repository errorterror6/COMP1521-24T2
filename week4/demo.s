	.text

main__prologue:
	# should only include begin and push commands and maybe moving arguments (a0, a1 etc..) into S registers 
	# as neccessary.
	begin
	push	$ra
	push	$s0
	push	$s2
	push	$s1


main__body:
	#your code goes here

	move	$s0, $a0	#inputs to a function come in from a0, a1, a2 etc... in the order it is listed.
	li	$s1, 0		#for each S register you use, push and pop it. 
	li	$s2, 1
	add	$t5, $s1, $s2	#don't push and pop t, a, v registers

	

	move	$v0, $t5	#output of a function comes out from $v0


main__epilogue:
	#there should be no code here except pushing and popping. loading return value into V0 
	#can also be acceptable.
	#pop in the reverse order of push
	pop	$s1
	pop	$s2
	pop	$s0
	pop	$ra
	end
	jr	$ra	#there should be no other code between "end" and "jr $ra"