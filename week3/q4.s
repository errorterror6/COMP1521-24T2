	.text

main:

	la   $t0, aa			#la = load address,
	# 0x10010000

	lw   $t0, bb			#lw = load word (contents)
	# 666

	lb   $t0, bb			#dont do this
	# it depends 

	lw   $t0, aa + 4		#lw reg, address(offset)
	#666

	la   $t1, cc
	lw   $t0, ($t1)			#t1 = address of CC
	# 1

	la   $t1, cc
	lw   $t0, 8($t1)	#8($t1) = 8 + address of CC
	#5

	li   $t1, 8
	lw   $t0, cc($t1)
	# 5


	la   $t1, cc
	lw   $t0, 2($t1)
	#probably wont work
	#memory alignment error


	.data
Address       Data Definition
0x10010000    aa:  .word 42
0x10010004    bb:  .word 666
0x10010008    cc:  .word 1
0x1001000C         .word 3
0x10010010         .word 5
0x10010014         .word 7