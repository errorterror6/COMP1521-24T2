########################################################################
# COMP1521 24T2 -- Assignment 1 -- Breakout!
#
#
# !!! IMPORTANT !!!
# Before starting work on the assignment, make sure you set your tab-width to 8!
# It is also suggested to indent with tabs only.
# Instructions to configure your text editor can be found here:
#   https://cgi.cse.unsw.edu.au/~cs1521/24T2/resources/mips-editors.html
# !!! IMPORTANT !!!
#
#
# This program was written by Iffat Chaudhari (z5492036)
# on 15/06/2024
#
# Version 1.0 (2024-06-11): Team COMP1521 <cs1521@cse.unsw.edu.au>
#
########################################################################

#![tabsize(8)]

# ##########################################################
# ####################### Constants ########################
# ##########################################################

# C constants
FALSE = 0
TRUE  = 1

MAX_GRID_WIDTH = 60
MIN_GRID_WIDTH = 6
GRID_HEIGHT    = 12

BRICK_ROW_START = 2
BRICK_ROW_END   = 7
BRICK_WIDTH     = 3
PADDLE_WIDTH    = 6
PADDLE_ROW      = GRID_HEIGHT - 1

BALL_FRACTION  = 24
BALL_SIM_STEPS = 3
MAX_BALLS      = 3
BALL_NONE      = 'X'
BALL_NORMAL    = 'N'
BALL_SUPER     = 'S'

VERTICAL       = 0
HORIZONTAL     = 1

MAX_SCREEN_UPDATES = 24

KEY_LEFT        = 'a'
KEY_RIGHT       = 'd'
KEY_SUPER_LEFT  = 'A'
KEY_SUPER_RIGHT = 'D'
KEY_STEP        = '.'
KEY_BIG_STEP    = ';'
KEY_SMALL_STEP  = ','
KEY_DEBUG_INFO  = '?'
KEY_SCREEN_UPD  = 's'
KEY_HELP        = 'h'

# NULL is defined in <stdlib.h>
NULL  = 0

# Other useful constants
SIZEOF_CHAR = 1
SIZEOF_INT  = 4

BALL_X_OFFSET      = 0
BALL_Y_OFFSET      = 4
BALL_X_FRAC_OFFSET = 8
BALL_Y_FRAC_OFFSET = 12
BALL_DX_OFFSET     = 16
BALL_DY_OFFSET     = 20
BALL_STATE_OFFSET  = 24
# <implicit 3 bytes of padding>
SIZEOF_BALL = 28

SCREEN_UPDATE_X_OFFSET = 0
SCREEN_UPDATE_Y_OFFSET = 4
SIZEOF_SCREEN_UPDATE   = 8

MANY_BALL_CHAR = '#'
ONE_BALL_CHAR  = '*'
PADDLE_CHAR    = '-'
EMPTY_CHAR     = ' '
GRID_TOP_CHAR  = '='
GRID_SIDE_CHAR = '|'

	.data
# ##########################################################
# #################### Global variables ####################
# ##########################################################

# !!! DO NOT ADD, REMOVE, OR MODIFY ANY OF THESE DEFINITIONS !!!

grid_width:			# int grid_width;
	.word	0

balls:				# struct ball balls[MAX_BALLS];
	.byte	0:MAX_BALLS*SIZEOF_BALL

bricks:				# char bricks[GRID_HEIGHT][MAX_GRID_WIDTH];
	.byte	0:GRID_HEIGHT*MAX_GRID_WIDTH

bricks_destroyed:		# int bricks_destroyed;
	.word	0

total_bricks:			# int total_bricks;
	.word	0

paddle_x:			# int paddle_x;
	.word	0

score:				# int score;
	.word	0

combo_bonus:			# int combo_bonus;
	.word	0

screen_updates:			# struct screen_update screen_updates[MAX_SCREEN_UPDATES];
	.byte	0:MAX_SCREEN_UPDATES*SIZEOF_SCREEN_UPDATE

num_screen_updates:		# int num_screen_updates;
	.word	0

whole_screen_update_needed:	# int whole_screen_update_needed;
	.word	0

no_auto_print:			# int no_auto_print;
	.word	0


# ##########################################################
# ######################### Strings ########################
# ##########################################################

# !!! DO NOT ADD, REMOVE, OR MODIFY ANY OF THESE STRINGS !!!

str_print_welcome_1:
	.asciiz	"Welcome to 1521 breakout! In this game you control a "
str_print_welcome_2:
	.asciiz	"paddle (---) with\nthe "
str_print_welcome_3:	# note: this string is used twice
	.asciiz	" and "
str_print_welcome_4:
	.asciiz	" (or "
str_print_welcome_5:
	.asciiz	" for fast "
str_print_welcome_6:
	.asciiz	"movement) keys, and your goal is\nto bounce the ball ("
str_print_welcome_7:
	.asciiz	") off of the bricks (digits). Every ten "
str_print_welcome_8:
	.asciiz	"bricks\ndestroyed spawns an extra ball. The "
str_print_welcome_9:
	.asciiz	" key will advance time one step.\n\n"

str_read_grid_width_prompt:
	.asciiz	"Enter the width of the playing field: "
str_read_grid_width_out_of_bounds_1:
	.asciiz	"Bad input, the width must be between "
str_read_grid_width_out_of_bounds_2:
	.asciiz	" and "
str_read_grid_width_not_multiple:
	.asciiz	"Bad input, the grid width must be a multiple of "

str_game_loop_win:
	.asciiz	"\nYou win! Congratulations!\n"
str_game_loop_game_over:
	.asciiz	"Game over :(\n"
str_game_loop_final_score:
	.asciiz	"Final score: "

str_print_game_score:
	.asciiz	" SCORE: "

str_hit_brick_bonus_ball:
	.asciiz	"\n!! Bonus ball !!\n"

str_run_command_prompt:
	.asciiz	" >> "
str_run_command_bad_cmd_1:
	.asciiz	"Bad command: '"
str_run_command_bad_cmd_2:
	.asciiz	"'. Run `h` for help.\n"

str_print_debug_info_1:
	.asciiz	"      grid_width = "
str_print_debug_info_2:
	.asciiz	"        paddle_x = "
str_print_debug_info_3:
	.asciiz	"bricks_destroyed = "
str_print_debug_info_4:
	.asciiz	"    total_bricks = "
str_print_debug_info_5:
	.asciiz	"           score = "
str_print_debug_info_6:
	.asciiz	"     combo_bonus = "
str_print_debug_info_7:
	.asciiz	"        num_screen_updates = "
str_print_debug_info_8:
	.asciiz	"whole_screen_update_needed = "
str_print_debug_info_9:
	.asciiz	"ball["
str_print_debug_info_10:
	.asciiz	"  y: "
str_print_debug_info_11:
	.asciiz	", x: "
str_print_debug_info_12:
	.asciiz	"  x_fraction: "
str_print_debug_info_13:
	.asciiz	"  y_fraction: "
str_print_debug_info_14:
	.asciiz	"  dy: "
str_print_debug_info_15:
	.asciiz	", dx: "
str_print_debug_info_16:
	.asciiz	"  state: "
str_print_debug_info_17:
	.asciiz	" ("
str_print_debug_info_18:
	.asciiz	")\n"
str_print_debug_info_19:
	.asciiz	"\nbricks["
str_print_debug_info_20:
	.asciiz	"]: "
str_print_debug_info_21:
	.asciiz	"]:\n"

# !!! Reminder to not not add to or modify any of the above !!!
# !!! strings or any other part of the data segment.        !!!
# !!! If you add more strings you will likely break the     !!!
# !!! autotests and automarking.                            !!!


############################################################
####                                                    ####
####   Your journey begins here, intrepid adventurer!   ####
####                                                    ####
############################################################

################################################################################
#
# Implement the following functions,
# and check these boxes as you finish implementing each function.
#
#  SUBSET 0
#  - [X] print_welcome
#  - [X] main
#  SUBSET 1
#  - [X] read_grid_width
#  - [X] game_loop
#  - [ ] initialise_game
#  - [ ] move_paddle
#  - [X] count_total_active_balls
#  - [ ] print_cell
#  SUBSET 2
#  - [X] register_screen_update
#  - [X] count_balls_at_coordinate
#  - [ ] print_game
#  - [ ] spawn_new_ball
#  - [ ] move_balls
#  SUBSET 3
#  - [ ] move_ball_in_axis
#  - [ ] hit_brick
#  - [ ] check_ball_paddle_collision
#  - [ ] move_ball_one_cell
#  PROVIDED
#  - [X] print_debug_info
#  - [X] run_command
#  - [X] print_screen_updates


################################################################################
# .TEXT <print_welcome>
        .text
print_welcome:
	# Subset:   0
	#
	# Frame:    [$ra]   
	# Uses:     [$a0, $v0, $ra]
	# Clobbers: [$a0, $v0]
	#
	# Locals:
	#   - None
	#
	# Structure:
	#   print_welcome
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

# Print out information on how to play this game.
print_welcome__prologue:

print_welcome__body:
	li $v0, 4                   # syscall 4: print_string  
	la $a0, str_print_welcome_1 # load address of the string	 
	syscall			    # printf("Welcome to 1521 breakout! In this game you control a ")

	li $v0, 4                   # syscall 4: print_string
	la $a0, str_print_welcome_2 # load address of the string
    	syscall			    # printf("paddle (---) with\nthe ")

	li $v0, 11    		    # syscall 11: print_char                
    	la $a0, KEY_LEFT 	    # load address of the byte (ASCII value) of KEY_LEFT
    	syscall			    # printf("      ")

	li $v0, 4                   # syscall 4: print_string
	la $a0, str_print_welcome_3 # load address of the string
    	syscall			    # printf(" and ")


	li $v0, 11    		    # syscall 11: print_char                
    	la $a0, KEY_RIGHT 	    # load address of the string
    	syscall			    # make syscall to print character
    

	li $v0, 4                   # syscall 4: print_string
	la $a0, str_print_welcome_4 # load address of the string
    	syscall			    # printf(" (or  ")
    	

	li $v0, 11    		    # syscall 11: print_char                
    	la $a0, KEY_SUPER_LEFT      # load address of the string
    	syscall			    # make syscall to print character
    	

	li $v0, 4                   # syscall 4: print_string
	la $a0, str_print_welcome_3 # load address of the string
    	syscall			    # printf(" and ")
    	

	li $v0, 11    		    # syscall 11: print_char                
    	la $a0, KEY_SUPER_RIGHT     # load address of the string
    	syscall			    # make syscall to print character

	li $v0, 4                   # syscall 4: print_string
	la $a0, str_print_welcome_5 # load address of the string
    	syscall			    # printf(" for fast ")
    	

	li $v0, 4                   # syscall 4: print_string
	la $a0, str_print_welcome_6 # load address of the string
    	syscall			    # printf(" movement) keys, and your goal is\nto bounce the ball (")
    

	li $v0, 11    		    # syscall 11: print_char                
    	la $a0, ONE_BALL_CHAR       # load address of the string
    	syscall			    # make syscall to print character


	li $v0, 4                   # syscall 4: print_string
	la $a0, str_print_welcome_7 # load address of the string
    	syscall			    # printf(") off of the bricks (digits). Every ten ")
    

	li $v0, 4                   # syscall 4: print_string
	la $a0, str_print_welcome_8 # load address of the string
    	syscall			    # printf("bricks\ndestroyed spawns an extra ball. The")
    	

	li $v0, 11    		    # syscall 11: print_char                
    	la $a0, KEY_STEP            # load address of the string
    	syscall			    # make syscall to print character

	li $v0, 4                   # syscall 4: print_string
	la $a0, str_print_welcome_9 # load address of the string
    	syscall			    # printf("key will advance time one step.\n\n")
    	

print_welcome__epilogue:
	jr      $ra		    # return

################################################################################
# .TEXT <main>
        .text
main:
	# Subset:   0
	#
	# Frame:    [$ra]  
	# Uses:     [$ra,$v0]
	# Clobbers: [$v0]
	#
	# Locals:
	#   - None
	#
	# Structure:
	#   main
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

# Entry point to the game
main__prologue:
	begin 
	push    $ra             # setting up stack frame

main__body:
	jal print_welcome       # Call print_welcome function

	jal read_grid_width     # Call read_grid_width function

	jal initialise_game     # Call initialise_game function

	jal game_loop  		# Call game_loop function 

main__epilogue:
	pop 	$ra		# Restore return address
	end                     # End of stack frame setup
	li      $v0, 0 		# Set return value to 0 (indicating successful execution)
	jr	$ra		# return

################################################################################
# .TEXT <read_grid_width>
        .text
read_grid_width:
	# Subset:   1
	#
	# Frame:    [$ra]   <-- FILL THESE OUT!
	# Uses:     [$ra,$v0, $a0, $a1, $t0, $t1, $t2]
	# Clobbers: [$v0, $a0, $t0, $t1, $t2]
	#
	# Locals:          
	#   -  # $t1: MIN_GRID_WIDTH (constant)
        #   -  # $t2: MAX_GRID_WIDTH (constant)
	#
	# Structure:        
	#   read_grid_width
	#   -> [prologue]
	#       -> body
	#	 -> read_loop
	#               -> check_upper_bound
	#               -> check_multiple
	#               -> bad_input_bounds
	#               -> bad_input_multiple
	#               -> store_and_exit
	#   -> [epilogue]

# Read in and validate the grid width.
read_grid_width__prologue:
	begin 
	push    $ra           	                # setting up stack frame

read_grid_width__body:
read_loop:
	li      $v0, 4                          # syscall 4: print_string
	la      $a0, str_read_grid_width_prompt
	syscall

	li      $v0, 5                          # syscall 5: read_integer
	syscall
	move    $t0, $v0                        # Store input in $t0


	li      $t1, MIN_GRID_WIDTH		# Load MIN_GRID_WIDTH into $t1
	bge     $t0, $t1, check_upper_bound     # Check_upper_bound if $t0 >= $t
	li      $t2, MAX_GRID_WIDTH             # Load MAX_GRID_WIDTH into $t2
	bgt     $t0, $t2, bad_input_bounds      # To bad_input_bounds if $t0 > $t2
	j       bad_input_bounds                # Jump to bad_input_bounds if conditions are met

check_upper_bound:
	li      $t1, MAX_GRID_WIDTH             # Load MAX_GRID_WIDTH into $t1
	ble     $t0, $t1, check_multiple        # Check_multiple if $t0 <= $t1
	j       bad_input_bounds                # Jump to bad_input_bounds if condition is not met

check_multiple:
	li      $t1, BRICK_WIDTH                # Load BRICK_WIDTH into $t1
	rem     $t2, $t0, $t1                   # Calculate $t0 % $t1
	beq     $t2, $zero, store_and_exit      # Branch to store_and_exit if remainder is zero (multiple)
	j       bad_input_multiple              # Jump to bad_input_multiple if remainder is not zero

bad_input_bounds:
	li      $v0, 4                          # syscall 4: print_string
	la      $a0, str_read_grid_width_out_of_bounds_1
	syscall

	li      $v0, 1                          # syscall 1: print_int
	li      $a0, MIN_GRID_WIDTH
	syscall

	li      $v0, 4                      	# syscall 4: print_string
	la      $a0, str_read_grid_width_out_of_bounds_2
	syscall

	li      $v0, 1                      	# syscall 1: print_int
	li      $a0, MAX_GRID_WIDTH
	syscall

	li      $v0, 11                     	# syscall 11: print_char
	li      $a0, '\n'
	syscall

	j       read_loop                       # Jump back to read_loop to prompt for new input

bad_input_multiple:
	li      $v0, 4                          # syscall 4: print_string
	la      $a0, str_read_grid_width_not_multiple
	syscall

	li      $v0, 1                      	# syscall 1: print_int
	li      $a0, BRICK_WIDTH
	syscall

	li      $v0, 11                     	# syscall 11: print_char
	li      $a0, '\n'
	syscall

	j       read_loop			# Jump back to read_loop to prompt for new input

store_and_exit:
	la      $t1, grid_width          	# Load address of grid_width into $t1
	sw      $t0, 0($t1)              	# Store the valid width ($t0) in grid_width
	li      $v0, 11                  	# syscall 11: print_char
	li      $a0, '\n'
	syscall

read_grid_width__epilogue:
	pop     $ra                 		# Restore return address
	end                         		# End of stack frame setup
	jr	$ra	            		# Return

################################################################################
# .TEXT <game_loop>
        .text
game_loop:
	# Subset:   1
	#
	# Frame:    [$ra]   
	# Uses:     [$ra,$s0, $s1, $t0, $t1, $t2, $t3, $t4]
	# Clobbers: [$s0, $s1, $t0, $t1, $t2, $t3, $t4]
	#
	# Locals:          
	#   - $t0: Temporary register for loading addresses
	#   - $t1: Temporary register for holding bricks_destroyed count
	#   - $t2: Temporary register for loading total_bricks count
	#   - $t3: Temporary register for preserving total_bricks across function calls
	#   - $t4: Temporary register for boolean comparison
	#
	# Structure:        
	#   game_loop
	#   -> [prologue]
	#       -> body
	#	-> game_loop__game_over
	#               -> game_loop__print_score
	#           -> game_loop__not_win
	#               -> game_loop__print_score
	#   -> [epilogue]

game_loop__prologue:
	begin
	push    $ra             			# Save return address
    	push    $s0             			# Save $s0 (preserving total_bricks)

game_loop__body:
	la      $t0, bricks_destroyed			# Load current value of bricks_destroyed into $t1
	lw      $t1, 0($t0)             		# $t1 = bricks_destroyed
	
	la      $t2, total_bricks			# Load total_bricks into $t3 and preserve it in $s0
	lw      $t3, 0($t2)             		# $t3 = total_bricks
	
	move    $s0, $t3                		# Preserve total_bricks in $s0

	slt     $t4, $t1, $t3           		# $t4 = (bricks_destroyed < total_bricks)

	beq     $t4, $zero, game_loop__game_over   	# If bricks_destroyed < total_bricks Exit loop if false

	
	jal     count_total_active_balls		# Call count_total_active_balls()
	move    $t0, $v0                		# $t0 = count_total_active_balls()

							# Reload total_bricks from $s0 into $t3
	move    $t3, $s0 				# Restore total_bricks into $t3

							# Check condition: $t0 > 0
	sgt     $t1, $t0, $zero         		# $t1 = ($t0 > 0)

	# If $t1 (count_total_active_balls() > 0)
	beq     $t1, $zero, game_loop__game_over        # If $t1 (count_total_active_balls() > 0), Exit loop if false

	
	la      $t0, no_auto_print			# Load value of no_auto_print into $t1
	lw      $t1, 0($t0)             		# $t1 = no_auto_print
	bne     $t1, $zero, game_loop__skip_print  	# Skip printing if true

	jal     print_game             			# Print game

game_loop__skip_print:
	# Run command loop
game_loop__run_command_loop:
	jal     run_command             		# Execute player's command

	
	beq     $v0, $zero, game_loop__run_command_loop # Loop until run_command() returns true

	
	j game_loop__body				# End of loop, jump back to body

game_loop__game_over:
							# Check if bricks_destroyed == total_bricks
	bne     $t1, $t3, game_loop__not_win   		# Branch if not equal

	li      $v0, 4					# Print "You win! Congratulations!"
	la      $a0, str_game_loop_win
	syscall

	j       game_loop__print_score			# Jump to print_score

game_loop__not_win:
	# Print "Game over :("
	li      $v0, 4
	la      $a0, str_game_loop_game_over
	syscall

game_loop__print_score:
							# Print final messages
	la      $a0, str_game_loop_final_score   	# Load address of final score string
	li      $v0, 4                           	# syscall 4: print_string
	syscall

							# Print the score stored in the variable 'score'
	lw      $a0, score                       	# Load 'score' into $a0
	li      $v0, 1                           	# syscall 1: print_int
	syscall

							# Print newline
	li      $v0, 11                          	# syscall 11: print_char
	li      $a0, '\n'
	syscall

	j       game_loop__epilogue			# Jump to epilogue

game_loop__epilogue:               
	pop     $s0             # Restore $s0
	pop     $ra             # Restore return address
    	end                     # End of function
    	jr      $ra             # Return 
################################################################################
# .TEXT <initialise_game>
        .text
initialise_game:
	# Subset:   1
	#
	# Frame:    [$ra,$a0]  
	# Uses:     []
	# Clobbers: []
	#
	# Locals:
	#   - $t0: Outer loop index for rows
	#   - $t1: Inner loop index for columns
	#   - $t2: Address calculation for bricks array
	#   - $t3: BRICK_ROW_START constant
	#   - $t4: BRICK_ROW_END constant
	#   - $t5: BRICK_WIDTH constant
	#   - $t6: Remainder from division (col % BRICK_WIDTH)
	#   - $t7: Starting value for bricks[row][col] assignment
	#   - $t8: Calculated value for bricks[row][col]
	#   - $t9: Default value (0) for bricks[row][col] when out of range
	#   
	# Structure:
	#   initialise_game
	#   -> [prologue]
	#       -> body
	#           -> state_loop_initial
	#               -> state_loop_body
	#           -> init_game_outer_loop
	#               -> init_game_inner_loop
	#                   -> end_inner_loop
	#   -> [epilogue]
	

initialise_game__prologue:
	begin
	push 	$a0		        # Save argument register
	push    $ra                     # Save return address

initialise_game__body:
    	li      $t0, 0                  # t0 = row = 0

init_game_outer_loop:
	li      $t1, 0                  # t1 = col = 0

init_game_inner_loop:
	mul $t2, $t0, MAX_GRID_WIDTH    # row * MAX_GRID_WIDTH
	add $t2, $t2, $t1               # row * MAX_GRID_WIDTH + col
	la      $a0, bricks             # Load base address of bricks array
    	add     $t2, $a0, $t2           # Address of bricks[row][col]
	
	
	li $t3, BRICK_ROW_START		# Load constants for comparison
	li $t4, BRICK_ROW_END
	li $t5, BRICK_WIDTH

					# Condition check: BRICK_ROW_START <= row && row <= BRICK_ROW_END
	bge $t0, $t3, in_range
	j out_of_range
	in_range:
	blt $t0, $t4, in_range_inner
	j out_of_range

in_range_inner:
    					# bricks[row][col] = 1 + ((col / BRICK_WIDTH) % 10);
    	div $t1, $t5           		# col / BRICK_WIDTH
   	mfhi $t6               		# Remainder (col % BRICK_WIDTH)

    	li $t7, 1              		# Start value for bricks[row][col]
    	add $t8, $t6, $t7      		# 1 + ((col / BRICK_WIDTH) % 10)
    	sb $t8, 0($t2)         		# Store value in bricks[row][col]
    	j end_inner_loop       		# Jump to end of inner loop

out_of_range:
	li $t9, 0             		# Default value (0) for bricks[row][col]
	sb $t9, 0($t2)         		# Store 0 in bricks[row][col]

end_inner_loop:
	addi $t1, $t1, 1               # Increment inner loop counter (col++)
	blt $t1, MAX_GRID_WIDTH, init_game_inner_loop
				       # Continue inner loop if col < MAX_GRID_WIDTH

	addi $t0, $t0, 1       	       # Increment outer loop counter (row++)
	blt $t0, GRID_HEIGHT, init_game_outer_loop
				      # Continue outer loop if row < GRID_HEIGHT
	

state_loop_initial:
	li      $t0, 0          	# Outer loop index for rows

state_loop_body:
					# Check if i >= MAX_BALLS
	li $t1, MAX_BALLS
	bge $t0, $t1, initialise_game__epilogue   # if (i >= MAX_BALLS) break

					# Calculate address of balls[i].state
	la  $t2, balls         		# Load base address of balls array
	li $t3, SIZEOF_BALL      	# Load SIZEOF_BALL into $t6
	mul $t4, $t0, $t3         	# Calculate i * sizeof(ball)
	add $t2, $t2, $t4        	# balls + i * sizeof(ball)


	li $t7, BALL_NONE              # Load BALL_NONE into $t7
	sw $t7, BALL_STATE_OFFSET($t2) # Store BALL_NONE in balls[i].state
	
	addi $t0, $t0, 1       	       # i++   
        j state_loop_body              # repeat the loop

	jal spawn_new_ball	       # call spawn_new_ball

initialise_game__epilogue:
	pop    	$ra                    # Restore return address
	pop     $a0                    # Restore argument register
    	end                            # End of function
    	jr      $ra                    # Return to caller

################################################################################
# .TEXT <move_paddle>
        .text
move_paddle:
	# Subset:   1
	#
	# Frame:    [$ra,$s0, $s1, $t0, $t1]   
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:           
	#   - $s0: Temporary storage for grid_width and paddle_x
	#   - $s1: Current grid width
	#   - $t0: Current paddle_x position
	#   - $t1: Temporary for bounds checking
	#
	# Structure:        <-- FILL THIS OUT!
	#   move_paddle
	#   -> [prologue]
	#       -> body
	#           -> move_left
	#           -> move_right
	#           -> move_super_left
	#           -> move_super_right
	#   -> [epilogue]

move_paddle__prologue:
	begin
	push    $ra                 		 	# Save return address
	push    $s0                 			# Save $s0 (grid_width and paddle_x)
	push    $s1                 			# Save $s1
	push    $t0                 			# Save $t0
	push    $t1                 			# Save $t1

move_paddle__body:
	la      $s0, grid_width     			# Load grid_width
	lw      $s1, 0($s0)

	la      $s0, paddle_x       			# Load paddle_x
	lw      $t0, 0($s0)

	beq     $t0, KEY_LEFT, move_left		# Check paddle movement based on key input
	beq     $t0, KEY_RIGHT, move_right
	beq     $t0, KEY_SUPER_LEFT, move_super_left
	beq     $t0, KEY_SUPER_RIGHT, move_super_right
	j       move_paddle__epilogue

move_left:
	addi    $t0, $t0, -1				# Move paddle left by 1 unit
	blt     $t0, $zero, set_to_zero
	sw      $t0, 0($s0)
	j       move_paddle__epilogue

move_right:
	addi    $t0, $t0, 1				# Move paddle right by 1 unit
	add     $t1, $t0, PADDLE_WIDTH
	bgt     $t1, $s1, set_to_max
	sw      $t0, 0($s0)
	j       move_paddle__epilogue

move_super_left:
	addi    $t0, $t0, -3				# Move paddle left by 3 units
	blt     $t0, $zero, set_to_zero
	sw      $t0, 0($s0)
	j       move_paddle__epilogue

move_super_right:
	addi    $t0, $t0, 3				# Move paddle right by 3 units
	add     $t1, $t0, PADDLE_WIDTH
	bgt     $t1, $s1, set_to_max
	sw      $t0, 0($s0)
	j       move_paddle__epilogue

set_to_zero:
	li      $t0, 0					 # Set paddle_x to 0 if out of bounds left
	sw      $t0, 0($s0)
	j       move_paddle__epilogue

set_to_max:
	sub     $t0, $s1, PADDLE_WIDTH			  # Set paddle_x to maximum position if out of bounds right
	sw      $t0, 0($s0)

update_position:
	sw      $t0, 0($s0)         			  # Update paddle_x in memory
    	jal     check_ball_paddle_collision   	          # Call check_ball_paddle_collision()

	move    $a0, $t0            		          # Set $a0 to updated paddle_x
	li      $a1, PADDLE_ROW                           # Assuming PADDLE_ROW is defined elsewhere
	jal     register_screen_update                    # Call register_screen_update()
	
	                                                  # After collision, adjust positions for update
	add     $t1, $t0, PADDLE_WIDTH                    # Calculate paddle_x + PADDLE_WIDTH
	sub     $t2, $t1, 1                               # Calculate paddle_x + PADDLE_WIDTH - 1

	                                                  # Call register_screen_update with corrected positions
	li      $a0, 0                                    # Assuming PADDLE_ROW is 0
	move    $a1, $t0                                  # $a1 = paddle_x
	jal     register_screen_update                    # Call register_screen_update()

	li      $a0, 0                                    # Assuming PADDLE_ROW is 0
	move    $a1, $t2                                  # $a1 = paddle_x + PADDLE_WIDTH - 1
	jal     register_screen_update                    # Call register_screen_update()

	j       move_paddle__epilogue                     # jump to move_paddle__epilogue  

move_paddle__epilogue:
	pop     $t1                         # Restore registers and return
	pop     $t0
	pop     $s1
	pop     $s0
	pop     $ra
	end
	jr	$ra
################################################################################
# .TEXT <count_total_active_balls>
        .text
count_total_active_balls:
	# Subset:   1
	#
	# Frame:    [$ra]   
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:           
	#   - $t0: count (total active balls)
	#   - $t1: loop index (i)
	#   - $t2: temporary storage for ball state
	#   - $t3: base address of balls array
	#   - $t5: MAX_BALLS constant
	#   - $t6: SIZEOF_BALL constant
	#   - $t7: BALL_NONE constant
	#
	# Structure:        
	#   count_total_active_balls
	#   -> [prologue]
	#       -> body
	#       -> loop_cond
	#           -> loop_continue
	#   -> [epilogue]

count_total_active_balls__prologue:
	begin
	push    $ra                     		 # Save return address

count_total_active_balls__body:
							 # Initialize count to 0
	li $t0, 0                			 # count = 0

							 # Initialize i to 0
	li $t1, 0                			 # i = 0

							 # Load base address of balls array
	la $t3, balls            			 # base address of balls array

loop_cond:
    							 # Check if i < MAX_BALLS
	li $t5, MAX_BALLS
	bge $t1, $t5, count_total_active_balls__epilogue # if (i >= MAX_BALLS) break

							 # Calculate address of balls[i].state
	li $t6, SIZEOF_BALL      			 # Load SIZEOF_BALL into $t6
	mul $t6, $t1, $t6         			 # Calculate i * sizeof(ball)
	add $t2, $t3, $t6         			 # balls + i * sizeof(ball)
	lb $t2, BALL_STATE_OFFSET($t2)  		 # Load balls[i].state into $t2

							 # Check if balls[i].state != BALL_NONE
	li $t7, BALL_NONE
	beq $t2, $t7, loop_continue 			 # if (balls[i].state == BALL_NONE) continue

							 # Increment count
	addi $t0, $t0, 1                                 # count++

loop_continue:
   							 # Increment i
    addi $t1, $t1, 1         				 # i++
    j loop_cond              				 # repeat the loop


count_total_active_balls__epilogue:
	move $v0, $t0                			 # return count in $v0
	pop $ra                    			 # Restore saved return address
	end                         			 # End of function
	jr $ra                      			 # Return to caller

################################################################################
# .TEXT <print_cell>
        .text
print_cell:
	# Subset:   1
	#
	# Frame:    [$ra, $a0, $a1]  
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:           
	#   - $t0: Temporary storage for ball_count
	#   - $t1: Temporary storage for PADDLE_ROW
	#   - $t2: Temporary storage for PADDLE_WIDTH
	#   - $t3: Temporary storage for paddle_x
	#   - $t4: Temporary storage for row (function parameter)
	#   - $t5: Temporary storage for col (function parameter)
	#
	# Structure:        
	#   print_cell
	#   -> [prologue]
	#       -> body
	#           -> return_many_ball_char
	#           -> return_one_ball_char
	#           -> return_paddle_char
	#           -> return_empty_char
	#   -> [epilogue]

print_cell__prologue:
	jr	$ra
	begin
	push    $ra                         # Save return address
	push 	$a0
    	push 	$a1

print_cell__body:
        				    # Load ball_count = count_balls_at_coordinate(row, col)
        move $a0, $t0      		    # Assuming row is passed in $a0
        move $a1, $t1      		    # Assuming col is passed in $a1
        
	jal count_balls_at_coordinate
        move $t0, $v0      		    # $t0 = ball_count

         				    # Check if ball_count > 1
        li   $t1, 1              	    # Load 1 into $t1
    	bgt  $t0, $t1, return_many_ball_char# If ball_count > 1, return MANY_BALL_CHAR

    					    # Check if ball_count == 1
    	beq  $t0, $t1, return_one_ball_char # If ball_count == 1, return ONE_BALL_CHAR

    					    # Load PADDLE_ROW and PADDLE_WIDTH
	lw   $t1, PADDLE_ROW     	    # Load PADDLE_ROW into $t1
	lw   $t2, PADDLE_WIDTH   	    # Load PADDLE_WIDTH into $t2
	lw   $t3, paddle_x       	    # Load paddle_x into $t3

		                            # Check if row == PADDLE_ROW
	lw   $t4, 16($sp)        	    # Load row from stack into $t4
	bne  $t4, $t1, check_brick     	    # If row != PADDLE_ROW, check brick

					    # Check if paddle_x <= col < paddle_x + PADDLE_WIDTH
	lw   $t5, 12($sp)        	    # Load col from stack into $t5
	ble  $t3, $t5,check_col_limit  	    # If paddle_x <= col, check col < paddle_x + PADDLE_WIDTH

check_col_limit:
	add  $t6, $t3, $t2       	    # Calculate paddle_x + PADDLE_WIDTH
	blt  $t5, $t6, return_paddle_char   # If col < paddle_x + PADDLE_WIDTH, return PADDLE_CHAR
	j    check_brick                    # Otherwise, check brick

check_brick:
					    # Check if bricks[row][col] != 0
	sll  $t7, $t4, 6         	    # Calculate row * 64 (assuming 64 columns per row)
	lw   $t8, 12($sp)        	    # Load col from stack into $t8
	add  $t7, $t7, $t8       	    # Calculate bricks[row][col] offset
	la   $t9, bricks         	    # Load bricks base address
	add  $t7, $t7, $t9       	    # Complete bricks[row][col] address
	lb   $t5, 0($t7)        	    # Load bricks[row][col] into $t5
	beq  $t5, $zero, return_empty_char # If bricks[row][col] == 0, return EMPTY_CHAR

					    # Calculate '0' + (bricks[row][col] - 1)
	addi $t5, $t5, -1      	    # bricks[row][col] - 1
	addi $t5, $t5, '0'     	    # '0' + (bricks[row][col] - 1)
	move  $v0, $t5          	    # Move result to $v0
	j    print_cell__epilogue   	    # Jump to epilogue

return_many_ball_char:
	la   $v0, MANY_BALL_CHAR 	    # Load MANY_BALL_CHAR into $v0
	lb   $v0, 0($v0)         	    # Load character from memory
	j    print_cell__epilogue   	    # Jump to epilogue

return_one_ball_char:
	la   $v0, ONE_BALL_CHAR  	    # Load ONE_BALL_CHAR into $v0
	lb   $v0, 0($v0)         	    # Load character from memory
	j    print_cell__epilogue   	    # Jump to epilogue

return_paddle_char:
	la   $v0, PADDLE_CHAR    	    # Load PADDLE_CHAR into $v0
	lb   $v0, 0($v0)         	    # Load character from memory
	j    print_cell__epilogue   	    # Jump to epilogue

return_empty_char:
	la   $v0, EMPTY_CHAR     	    # Load EMPTY_CHAR into $v0
	lb   $v0, 0($v0)         	    # Load character from memory

print_cell__epilogue:
	 		    		   # Restore registers
        pop $ra
        pop $a1
        pop $a0
	jr	$ra

################################################################################
# .TEXT <register_screen_update>
        .text
register_screen_update:
	# Subset:   2
	#
	# Frame:    [$ra]   
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:           
	#   - $t0: Temporarily holds TRUE value for comparison and setting
	#   - $t1: Temporarily holds value of whole_screen_update_needed
	#   - $t2: Temporarily holds TRUE value for comparison
	#   - $t3: Temporarily holds address of num_screen_updates
	#   - $t4: Temporarily holds current value of num_screen_updates
	#   - $t5: Holds MAX_SCREEN_UPDATES value for comparison
	#   - $t6: Holds SIZEOF_SCREEN_UPDATE for byte offset calculation
	#   - $t7: Holds base address of screen_updates array
	#   - $t8: Temporarily holds byte offset calculation result
	#   - $t9: Temporarily holds address of screen_updates[num_screen_updates]
	#
	# Structure:       
	#   register_screen_update
	#   -> [prologue]
	#       -> body
	#	 -> check_num_screen_updates
	#	 -> set_update_needed
	#   -> [epilogue]

register_screen_update__prologue:
	begin
	push    $ra                  			# Save return address

register_screen_update__body:
							# Check if whole_screen_update_needed
	la      $t0, whole_screen_update_needed         # Load address of whole_screen_update_needed
	lw      $t1, ($t0)                        	# Load value of whole_screen_update_needed into $t1
	li      $t2, TRUE                         	# Load TRUE (assumed constant) into $t2
	bne     $t1, $t2, check_num_screen_updates 	# Branch if not equal to TRUE

	j register_screen_update__epilogue         	# Jump to epilogue if whole screen update not needed

check_num_screen_updates:
							# Check if num_screen_updates >= MAX_SCREEN_UPDATES
	la      $t3, num_screen_updates                 # Load address of num_screen_updates
	lw      $t4, 0($t3)                             # Load value of num_screen_updates into $t4
	li      $t5, MAX_SCREEN_UPDATES                 # Load MAX_SCREEN_UPDATES into $t5
	bge     $t4, $t5, set_update_needed             # Branch if num_screen_updates >= MAX_SCREEN_UPDATES

	li      $t6, SIZEOF_SCREEN_UPDATE              # Load size of each screen_update structure into $t6
	la      $t7, screen_updates                    # Load base address of screen_updates array into $t7
	mul     $t8, $t6, $t4                          # Calculate offset in bytes for screen_updates[num_screen_updates]
	add     $t9, $t7, $t8                          # Calculate address of screen_updates[num_screen_updates]

	sw      $a0, SCREEN_UPDATE_X_OFFSET($t9)       # Store x in screen_updates[num_screen_updates].x
	sw      $a1, SCREEN_UPDATE_Y_OFFSET($t9)       # Store y in screen_updates[num_screen_updates].y

	
	addi    $t4, $t4, 1                           # Increment num_screen_updates
	sw      $t4, 0($t3)                           # Store updated num_screen_updates

	j       register_screen_update__epilogue      # Jump to epilogue

set_update_needed:
						      # Set whole_screen_update_needed = TRUE
	li      $t0, TRUE                             # Load TRUE (assumed constant) into $t0
	la      $t1, whole_screen_update_needed       # Load address of whole_screen_update_needed
	sw      $t0, 0($t1)                           # Store TRUE in whole_screen_update_needed

register_screen_update__epilogue:
	pop     $ra             		     # Restore return address
	end
	jr	$ra
################################################################################
# .TEXT <count_balls_at_coordinate>
        .text
count_balls_at_coordinate:
	# Subset:   2
	#
	# Frame:    [$ra, $s0, $s1]   
	# Uses:     []
	# Clobbers: [...]
	#
	# Locals:           
	#   - $t2: Holds MAX_BALLS constant for loop termination
	#   - $t3: Holds base address of balls array
	#   - $t4-$t5: Temporarily hold state, y, and x values of balls[i]
	#   - $t6-$t8: Temporarily hold loop index and address calculation values
	#
	# Structure:       
	#   count_balls_at_coordinate
	#   -> [prologue]
	#       -> body
	#        -> count_balls_at_coordinate__body
	#        -> count_balls_at_coordinate__next
	#   -> [epilogue]

count_balls_at_coordinate__prologue:
	begin 
	push 	$ra
	push    $s0              			   # Save $s0 register
	push    $s1             			   # Save $s1 register

	move    $s0, $a0         			  # Save row in $s0
	move    $s1, $a1         			  # Save col in $s1

	li      $t0, 0           			  # Initialize count to 0
	li      $t1, 0           			  # Initialize i to 0
	la      $t3, balls         			  # Load base address of balls array

count_balls_at_coordinate__body:
	li      $t2, MAX_BALLS     			  # Load MAX_BALLS constant
	bge     $t1, $t2, count_balls_at_coordinate__epilogue # Exit loop if i >= MAX_BALLS

							  # Calculate address of balls[i]
	li      $t6, SIZEOF_BALL   			  # Load SIZEOF_BALL into $t6
	mul     $t7, $t1, $t6     			  # Calculate i * sizeof(Ball)
	add     $t8, $t3, $t7    			  # Address of balls[i]

							  # Load balls[i].state, balls[i].y, and balls[i].x
	lb      $t9, BALL_STATE_OFFSET($t8)  		  # Load balls[i].state
	lw      $t4, BALL_Y_OFFSET($t8)      		  # Load balls[i].y
	lw      $t5, BALL_X_OFFSET($t8)      		  # Load balls[i].x

							  # Check conditions
	li      $t6, BALL_NONE
	beq     $t9, $t6, count_balls_at_coordinate_next  # Skip if balls[i].state == BALL_NONE
	bne     $t4, $s0, count_balls_at_coordinate_next  # Skip if balls[i].y != row
	bne     $t5, $s1, count_balls_at_coordinate_next  # Skip if balls[i].x != col

							  # Increment count
	addi    $t0, $t0, 1

count_balls_at_coordinate_next:
	addi    $t1, $t1, 1        			  # Increment i
	j       count_balls_at_coordinate__body

count_balls_at_coordinate__epilogue:
	move    $v0, $t0           			  # Move count to $v0 (return value)
	pop     $s1                			  # Restore $s1 register
	pop     $s0                		          # Restore $s0 register
	pop     $ra                	                  # Restore return address
	end
	jr	$ra


################################################################################
# .TEXT <print_game>
        .text
print_game:
	# Subset:   2
	#
	# Frame:    [$ra,$s0,$s1]   
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:           
	#   - ...
	#
	# Structure:        
	#   print_game
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

print_game__prologue:
	begin
	push    $ra
    	push    $s0
	push	$s1

print_game__body:
print_game__header:
				# Print " SCORE: %d\n"
	li	$v0, 4
    	la      $a0, str_print_game_score
	syscall

				# Print score value
	lw $a0, score      	# Load score into $a0
	li $v0, 1          	# System call for print_int
	syscall
	
	# Print newline
	li      $v0, 11         # syscall 11: print_char
	li      $a0, '\n'
	syscall

print_game__for_loop_rows_init:
	# Initialize row = -1
	li      $s0, -1

print_game__for_rows_loop_cond:
   	bge		$s0, GRID_HEIGHT, print_game__epilogue
	
print_game__for_loop_cols_init:
	# Initialize col = -1
	li      $s1, -1

print_game__for_cols_loop_cond:
	# Check the loop condition: col <= grid_width
	bge     $s1, grid_width, print_game__epilogue


print_field__for_loop_cols_body: 
	# Check conditions for printing characters
	# Check if row == -1
	beq     $s0, -1, print_game__for_loop_cols_if

	# Check if col == -1 or col == grid_width
		beq     $s1, -1, print_game__for_loop_cols_else
	beq     $s1, grid_width, print_game__for_loop_cols_else

	# Otherwise, print the cell content
	jal     print_cell                  # Call print_cell function
	move    $a0, $s0                    # Pass row as argument
	move    $a1, $s1                    # Pass col as argument
	
	j       print_game__for_loop_cols_step


print_game__for_loop_cols_if:
	li      $v0, 11                     # syscall 11 for print_char
	la      $a0, GRID_TOP_CHAR
	syscall
	j       print_game__for_loop_cols_step


print_game__for_loop_cols_else:
	li      $v0, 11                     # syscall 11 for print_char
	la      $a0, GRID_SIDE_CHAR
	syscall
	j       print_game__for_loop_cols_step


print_game__for_loop_cols_step:
	addi    $s1, $s1, 1                 # Increment column counter
	j       print_game__for_cols_loop_cond


print_game__for_loop_rows_step:
	li      $v0, 11                     # syscall 11 for print_char
	li      $a0, '\n'
	syscall
		
	addi    $s0, $s0, 1                 # Increment row counter
	j       print_game__for_rows_loop_cond


print_game__epilogue:
    	pop     $s1
	pop		$s0
    	pop     $ra
	end
	jr	$ra

################################################################################
# .TEXT <spawn_new_ball>
        .text
spawn_new_ball:
	# Subset:   2
	#
	# Frame:    [...]   <-- FILL THESE OUT!
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - ...
	#
	# Structure:        <-- FILL THIS OUT!
	#   spawn_new_ball
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

spawn_new_ball__prologue:

spawn_new_ball__body:

spawn_new_ball__epilogue:
	jr	$ra


################################################################################
# .TEXT <move_balls>
        .text
move_balls:
	# Subset:   2
	#
	# Frame:    [...]   <-- FILL THESE OUT!
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - ...
	#
	# Structure:        <-- FILL THIS OUT!
	#   move_balls
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

move_balls__prologue:

move_balls__body:

move_balls__epilogue:
	jr	$ra


################################################################################
# .TEXT <move_ball_in_axis>
        .text
move_ball_in_axis:
	# Subset:   3
	#
	# Frame:    [...]   <-- FILL THESE OUT!
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - ...
	#
	# Structure:        <-- FILL THIS OUT!
	#   move_ball_in_axis
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

move_ball_in_axis__prologue:

move_ball_in_axis__body:

move_ball_in_axis__epilogue:
	jr	$ra


################################################################################
# .TEXT <hit_brick>
        .text
hit_brick:
	# Subset:   3
	#
	# Frame:    [...]   <-- FILL THESE OUT!
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - ...
	#
	# Structure:        <-- FILL THIS OUT!
	#   hit_brick
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

hit_brick__prologue:

hit_brick__body:

hit_brick__epilogue:
	jr	$ra


################################################################################
# .TEXT <check_ball_paddle_collision>
        .text
check_ball_paddle_collision:
	# Subset:   3
	#
	# Frame:    [...]   <-- FILL THESE OUT!
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - ...
	#
	# Structure:        <-- FILL THIS OUT!
	#   check_ball_paddle_collision
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

check_ball_paddle_collision__prologue:

check_ball_paddle_collision__body:

check_ball_paddle_collision__epilogue:
	jr	$ra


################################################################################
# .TEXT <move_ball_one_cell>
        .text
move_ball_one_cell:
	# Subset:   3
	#
	# Frame:    [...]   <-- FILL THESE OUT!
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - ...
	#
	# Structure:        <-- FILL THIS OUT!
	#   move_ball_one_cell
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

move_ball_one_cell__prologue:

move_ball_one_cell__body:

move_ball_one_cell__epilogue:
	jr	$ra


################################################################################
################################################################################
###                   PROVIDED FUNCTIONS — DO NOT CHANGE                     ###
################################################################################
################################################################################

################################################################################
# .TEXT <run_command>
        .text
run_command:
	# Provided
	#
	# Frame:    [$ra]
	# Uses:     [$ra, $t0, $a0, $v0]
	# Clobbers: [$t0, $a0, $v0]
	#
	# Locals:
	#   - $t0: char command
	#
	# Structure:
	#   run_command
	#   -> [prologue]
	#     -> body
	#       -> cmd_a
	#       -> cmd_d
	#       -> cmd_A
	#       -> cmd_D
	#       -> cmd_dot
	#       -> cmd_semicolon
	#       -> cmd_comma
	#       -> cmd_question_mark
	#       -> cmd_s
	#       -> cmd_h
	#       -> cmd_p
	#       -> cmd_q
	#       -> bad_cmd
	#       -> ret_true
	#   -> [epilogue]

run_command__prologue:
	push	$ra

run_command__body:
	li	$v0, 4						# syscall 4: print_string
	li	$a0, str_run_command_prompt			# " >> "
	syscall							# printf(" >> ");

	li	$v0, 12						# syscall 4: read_character
	syscall							# scanf(" %c",
	move	$t0, $v0					#              &command);

	beq	$t0, 'a', run_command__cmd_a			# if (command == 'a') { ...
	beq	$t0, 'd', run_command__cmd_d			# } else if (command == 'd') { ...
	beq	$t0, 'A', run_command__cmd_A			# } else if (command == 'A') { ...
	beq	$t0, 'D', run_command__cmd_D			# } else if (command == 'D') { ...
	beq	$t0, '.', run_command__cmd_dot			# } else if (command == '.') { ...
	beq	$t0, ';', run_command__cmd_semicolon		# } else if (command == ';') { ...
	beq	$t0, ',', run_command__cmd_comma		# } else if (command == ',') { ...
	beq	$t0, '?', run_command__cmd_question_mark	# } else if (command == '?') { ...
	beq	$t0, 's', run_command__cmd_s			# } else if (command == 's') { ...
	beq	$t0, 'h', run_command__cmd_h			# } else if (command == 'h') { ...
	beq	$t0, 'p', run_command__cmd_p			# } else if (command == 'p') { ...
	beq	$t0, 'q', run_command__cmd_q			# } else if (command == 'q') { ...
	b	run_command__bad_cmd				# } else { ...

run_command__cmd_a:						# if (command == 'a') {
	li	$a0, -1
	jal	move_paddle					#   move_paddle(-1);
	b	run_command__ret_true

run_command__cmd_d:						# } else if (command == 'd') { ...
	li	$a0, 1
	jal	move_paddle					#   move_paddle(1);
	b	run_command__ret_true

run_command__cmd_A:						# } else if (command == 'A') { ...
	li	$a0, -1
	jal	move_paddle					#   move_paddle(-1);
	li	$a0, -1
	jal	move_paddle					#   move_paddle(-1);
	li	$a0, -1
	jal	move_paddle					#   move_paddle(-1);
	b	run_command__ret_true

run_command__cmd_D:						# } else if (command == 'D') { ...
	li	$a0, 1
	jal	move_paddle					#   move_paddle(1);
	li	$a0, 1
	jal	move_paddle					#   move_paddle(1);
	li	$a0, 1
	jal	move_paddle					#   move_paddle(1);
	b	run_command__ret_true

run_command__cmd_dot:						# } else if (command == '.') { ...
	li	$a0, BALL_SIM_STEPS
	jal	move_balls					#   move_balls(BALL_SIM_STEPS);
	b	run_command__ret_true

run_command__cmd_semicolon:					# } else if (command == ';') { ...
	li	$a0, BALL_SIM_STEPS
	mul	$a0, $a0, 3					#   BALL_SIM_STEPS * 3
	jal	move_balls					#   move_balls(BALL_SIM_STEPS * 3);
	b	run_command__ret_true

run_command__cmd_comma:						# } else if (command == ',') { ...
	li	$a0, 1
	jal	move_balls					#   move_balls(1);
	b	run_command__ret_true

run_command__cmd_question_mark:					# } else if (command == '?') { ...
	jal	print_debug_info				#   print_debug_info();
	b	run_command__ret_true

run_command__cmd_s:						# } else if (command == 's') { ...
	jal	print_screen_updates				#   print_screen_updates();
	b	run_command__ret_true

run_command__cmd_h:						# } else if (command == 'h') { ...
	jal	print_welcome					#   print_welcome();
	b	run_command__ret_true

run_command__cmd_p:						# } else if (command == 'p') { ...
	li	$a0, TRUE
	sw	$a0, no_auto_print				#   no_auto_print = 1;
	jal	print_game					#   print_game();
	b	run_command__ret_true

run_command__cmd_q:						# } else if (command == 'q') { ...
	li	$v0, 10						#   syscall 10: exit
	syscall							#   exit(0);

run_command__bad_cmd:						# } else { ...

	li	$v0, 4						#   syscall 4: print_string
	li	$a0, str_run_command_bad_cmd_1			#   "Bad command: '"
	syscall							#   printf("Bad command: '");

	li	$v0, 11						#   syscall 11: print_character
	move	$a0, $t0					#           command
	syscall							#   putchar(       );

	li	$v0, 4						#   syscall 4: print_string
	li	$a0, str_run_command_bad_cmd_2			#   "'. Run `h` for help.\n"
	syscall							#   printf("'. Run `h` for help.\n");

	li	$v0, FALSE
	b	run_command__epilogue				#   return FALSE;

run_command__ret_true:						# }
	li	$v0, TRUE					# return TRUE;

run_command__epilogue:
	pop	$ra
	jr	$ra

################################################################################
# .TEXT <print_debug_info>
        .text
print_debug_info:
	# Provided
	#
	# Frame:    []
	# Uses:     [$v0, $a0, $t0, $t1, $t2, $t3]
	# Clobbers: [$v0, $a0, $t0, $t1, $t2, $t3]
	#
	# Locals:
	#   - $t0: int i, int row
	#   - $t1: struct ball *ball, int col
	#   - $t2: temporary copy of grid_width
	#   - $t3: temporary bricks[row][col] address calculations
	#
	# Structure:
	#   print_debug_info
	#   -> [prologue]
	#     -> body
	#       -> ball_loop_init
	#       -> ball_loop_cond
	#       -> ball_loop_body
	#       -> ball_loop_step
	#       -> row_loop_init
	#       -> row_loop_cond
	#       -> row_loop_body
	#         -> row_loop_init
	#         -> row_loop_cond
	#         -> row_loop_body
	#         -> row_loop_step
	#         -> row_loop_end
	#       -> row_loop_step
	#       -> row_loop_end
	#   -> [epilogue]

print_debug_info__prologue:

print_debug_info__body:
	li	$v0, 4				# syscall 4: print_string
	li	$a0, str_print_debug_info_1	# "      grid_width = "
	syscall					# printf("      grid_width = ");

	li	$v0, 1				# sycall 1: print_int
	lw	$a0, grid_width			#              grid_width
	syscall					# printf("%d",           );

	li	$v0, 11				# syscall 11: print_character
	li	$a0, '\n'
	syscall					# putchar('\n');


	li	$v0, 4				# syscall 4: print_string
	li	$a0, str_print_debug_info_2	# "        paddle_x = "
	syscall					# printf("        paddle_x = ");

	li	$v0, 1				# sycall 1: print_int
	lw	$a0, paddle_x			#              paddle_x
	syscall					# printf("%d",         );

	li	$v0, 11				# syscall 11: print_character
	li	$a0, '\n'
	syscall					# putchar('\n');


	li	$v0, 4				# syscall 4: print_string
	li	$a0, str_print_debug_info_3	# "bricks_destroyed = "
	syscall					# printf("bricks_destroyed = ");

	li	$v0, 1				# sycall 1: print_int
	lw	$a0, bricks_destroyed		#              bricks_destroyed
	syscall					# printf("%d",                 );

	li	$v0, 11				# syscall 11: print_character
	li	$a0, '\n'
	syscall					# putchar('\n');


	li	$v0, 4				# syscall 4: print_string
	li	$a0, str_print_debug_info_4	# "    total_bricks = "
	syscall					# printf("    total_bricks = ");

	li	$v0, 1				# sycall 1: print_int
	lw	$a0, total_bricks		#              total_bricks
	syscall					# printf("%d",             );

	li	$v0, 11				# syscall 11: print_character
	li	$a0, '\n'
	syscall					# putchar('\n');


	li	$v0, 4				# syscall 4: print_string
	li	$a0, str_print_debug_info_5	# "           score = "
	syscall					# printf("           score = ");

	li	$v0, 1				# sycall 1: print_int
	lw	$a0, score			#              score
	syscall					# printf("%d",      );

	li	$v0, 11				# syscall 11: print_character
	li	$a0, '\n'
	syscall					# putchar('\n');


	li	$v0, 4				# syscall 4: print_string
	li	$a0, str_print_debug_info_6	# "     combo_bonus = "
	syscall					# printf("     combo_bonus = ");

	li	$v0, 1				# sycall 1: print_int
	lw	$a0, combo_bonus		#              combo_bonus
	syscall					# printf("%d",            );

	li	$v0, 11				# syscall 11: print_character
	li	$a0, '\n'
	syscall					# putchar('\n');
	syscall					# putchar('\n');


	li	$v0, 4				# syscall 4: print_string
	li	$a0, str_print_debug_info_7	# "        num_screen_updates = "
	syscall					# printf("        num_screen_updates = ");

	li	$v0, 1				# sycall 1: print_int
	lw	$a0, num_screen_updates		#              num_screen_updates
	syscall					# printf("%d",                   );

	li	$v0, 11				# syscall 11: print_character
	li	$a0, '\n'
	syscall					# putchar('\n');


	li	$v0, 4				# syscall 4: print_string
	li	$a0, str_print_debug_info_8	# "whole_screen_update_needed = "
	syscall					# printf("whole_screen_update_needed = ");

	li	$v0, 1				# sycall 1: print_int
	lw	$a0, whole_screen_update_needed	#              whole_screen_update_needed
	syscall					# printf("%d",                           );

	li	$v0, 11				# syscall 11: print_character
	li	$a0, '\n'
	syscall					# putchar('\n');
	syscall					# putchar('\n');

print_debug_info__ball_loop_init:
	li	$t0, 0				# int i = 0;

print_debug_info__ball_loop_cond:		# while (i < MAX_BALLS) {
	bge	$t0, MAX_BALLS, print_debug_info__ball_loop_end

print_debug_info__ball_loop_body:
	li	$v0, 4				#   syscall 4: print_string
	li	$a0, str_print_debug_info_9	#   "ball["
	syscall					#   printf("ball[");

	li	$v0, 1				#   sycall 1: print_int
	move	$a0, $t0			#                i
	syscall					#   printf("%d",  );

	li	$v0, 4				#   syscall 4: print_string
	li	$a0, str_print_debug_info_21	#   "]:\n"
	syscall					#   printf("]:\n");

	mul	$t1, $t0, SIZEOF_BALL		#   i * sizeof(struct ball)
	addi	$t1, $t1, balls			#   ball = &balls[i]

	li	$v0, 4				#   syscall 4: print_string
	li	$a0, str_print_debug_info_10	#   "  y: "
	syscall					#   printf("  y: ");

	li	$v0, 1				#   sycall 1: print_int
	lw	$a0, BALL_Y_OFFSET($t1)		#   ball->y
	syscall					#   printf("%d", ball->y);

	li	$v0, 4				#   syscall 4: print_string
	li	$a0, str_print_debug_info_11	#   "  x: "
	syscall					#   printf("  x: ");

	li	$v0, 1				#   sycall 1: print_int
	lw	$a0, BALL_X_OFFSET($t1)		#   ball->x
	syscall					#   printf("%d", ball->x);

	li	$v0, 11				#   syscall 11: print_character
	li	$a0, '\n'
	syscall					#   putchar('\n');

	li	$v0, 4				#   syscall 4: print_string
	li	$a0, str_print_debug_info_12	#   "  x_fraction: "
	syscall					#   printf("  x_fraction: ");

	li	$v0, 1				#   sycall 1: print_int
	lw	$a0, BALL_X_FRAC_OFFSET($t1)	#   ball->x_fraction
	syscall					#   printf("%d", ball->x_fraction);

	li	$v0, 11				#   syscall 11: print_character
	li	$a0, '\n'
	syscall					#   putchar('\n');

	li	$v0, 4				#   syscall 4: print_string
	li	$a0, str_print_debug_info_13	#   "  y_fraction: "
	syscall					#   printf("  y_fraction: ");

	li	$v0, 1				#   sycall 1: print_int
	lw	$a0, BALL_Y_FRAC_OFFSET($t1)	#   ball->y_fraction
	syscall					#   printf("%d", ball->y_fraction);

	li	$v0, 11				#   syscall 11: print_character
	li	$a0, '\n'
	syscall					#   putchar('\n');

	li	$v0, 4				#   syscall 4: print_string
	li	$a0, str_print_debug_info_14	#   "  dy: "
	syscall					#   printf("  dy: ");

	li	$v0, 1				#   sycall 1: print_int
	lw	$a0, BALL_DY_OFFSET($t1)	#   ball->dy
	syscall					#   printf("%d", ball->dy);

	li	$v0, 4				#   syscall 4: print_string
	li	$a0, str_print_debug_info_15	#   "  dx: "
	syscall					#   printf("  dx: ");

	li	$v0, 1				#   sycall 1: print_int
	lw	$a0, BALL_DX_OFFSET($t1)	#   ball->dx
	syscall					#   printf("%d", ball->dx);

	li	$v0, 11				#   syscall 11: print_character
	li	$a0, '\n'
	syscall					#   putchar('\n');

	li	$v0, 4				#   syscall 4: print_string
	li	$a0, str_print_debug_info_16	#   "  state: "
	syscall					#   printf("  state: ");

	li	$v0, 1				#   sycall 1: print_int
	lb	$a0, BALL_STATE_OFFSET($t1)	#   ball->state
	syscall					#   printf("%d", ball->state);

	li	$v0, 4				#   syscall 4: print_string
	li	$a0, str_print_debug_info_17	#   " ("
	syscall					#   printf(" (");

	li	$v0, 11				#   sycall 11: print_character
	lb	$a0, BALL_STATE_OFFSET($t1)	#   ball->state
	syscall					#   printf("%c", ball->state);

	li	$v0, 4				#   syscall 4: print_string
	li	$a0, str_print_debug_info_18	#   ")\n"
	syscall					#   printf(")\n");

print_debug_info__ball_loop_step:
	addi	$t0, $t0, 1			#   i++;
	b	print_debug_info__ball_loop_cond

print_debug_info__ball_loop_end:		# }


print_debug_info__row_loop_init:
	li	$t0, 0				# int row = 0;

print_debug_info__row_loop_cond:		# while (row < GRID_HEIGHT) {
	bge	$t0, GRID_HEIGHT, print_debug_info__row_loop_end

print_debug_info__row_loop_body:
	li	$v0, 4				#   syscall 4: print_string
	li	$a0, str_print_debug_info_19	#   "\nbricks["
	syscall					#   printf("\nbricks[");

	li	$v0, 1				#   sycall 1: print_int
	move	$a0, $t0			#                i
	syscall					#   printf("%d",  );

	li	$v0, 4				#   syscall 4: print_string
	li	$a0, str_print_debug_info_20	#   "]: "
	syscall					#   printf("]: ");

print_debug_info__col_loop_init:
	li	$t1, 0				#   int col = 0;

print_debug_info__col_loop_cond:		#   while (col < grid_width) {
	lw	$t2, grid_width
	bge	$t1, $t2, print_debug_info__col_loop_end

print_debug_info__col_loop_body:
	mul	$t3, $t0, MAX_GRID_WIDTH	#     row * MAX_GRID_WIDTH
	add	$t3, $t3, $t1			#     row * MAX_GRID_WIDTH + row
	addi	$t3, $t3, bricks		#     &bricks[row][col]

	li	$v0, 1				#     sycall 1: print_int
	lb	$a0, ($t3)			#     bricks[row][col]
	syscall					#     printf("%d", bricks[row][col]);

	li	$v0, 11				#     sycall 11: print_character
	li	$a0, ' '
	syscall					#     printf(" ");

print_debug_info__col_loop_step:
	addi	$t1, $t1, 1			#     row++;
	b	print_debug_info__col_loop_cond

print_debug_info__col_loop_end:			#   }

print_debug_info__row_loop_step:
	addi	$t0, $t0, 1			#   row++;
	b	print_debug_info__row_loop_cond

print_debug_info__row_loop_end:			# }
	li	$v0, 11				#   syscall 11: print_character
	li	$a0, '\n'
	syscall					#   putchar('\n');

print_debug_info__epilogue:
	jr	$ra


################################################################################
# .TEXT <print_screen_updates>
        .text
print_screen_updates:
	# Provided
	#
	# Frame:    [$ra, $s0, $s1, $s2]
	# Uses:     [$ra, $s0, $s1, $s2, $t0, $t1, $t2, $t3, $t4, $v0, $a0]
	# Clobbers: [$t0, $t1, $t2, $t3, $t4, $v0, $a0]
	#
	# Locals:
	#   - $t0: print_cell return value, temporary screen_updates address calculations
	#   - $t1: copy of num_screen_updates
	#   - $t2: copy of whole_screen_update_needed
	#   - $t3: copy of grid_width
	#   - $t4: FALSE/0
	#   - $s0: int row, int i
	#   - $s1: int col, int y
	#   - $s2: int x
	#
	# Structure:
	#   print_screen_updates
	#   -> [prologue]
	#       -> body
	#       -> whole_screen
	#         -> row_loop_init
	#         -> row_loop_cond
	#         -> row_loop_body
	#           -> col_loop_init
	#           -> col_loop_cond
	#           -> col_loop_body
	#           -> col_loop_step
	#           -> col_loop_end
	#         -> row_loop_step
	#         -> row_loop_end
	#       -> not_whole_screen
	#         -> update_loop_init
	#         -> update_loop_cond
	#         -> update_loop_body
	#         -> update_loop_step
	#         -> update_loop_end
	#       -> final_newline
	#   -> [epilogue]

print_screen_updates__prologue:
	push	$ra
	push	$s0
	push	$s1
	push	$s2

print_screen_updates__body:
	li	$v0, 11							# sycall 11: print_character
	li	$a0, '&'
	syscall								# putchar('&');

	li	$v0, 1							#   syscall 1: print_int
	lw	$a0, score						#                score
	syscall								#   printf("%d",      );

	lw	$t2, whole_screen_update_needed

	beqz	$t2, print_screen_updates__not_whole_screen		# if (whole_screen_update_needed) {

print_screen_updates__whole_screen:
print_screen_updates__row_loop_init:
	li	$s0, 0							#   int row = 0;

print_screen_updates__row_loop_cond:
	bge	$s0, GRID_HEIGHT, print_screen_updates__row_loop_end	#   while (row < GRID_HEIGHT) {

print_screen_updates__row_loop_body:
print_screen_updates__col_loop_init:
	li	$s1, 0							#     int col = 0;

print_screen_updates__col_loop_cond:
	lw	$t3, grid_width
	bge	$s1, $t3, print_screen_updates__col_loop_end		#     while (col < grid_width) {

print_screen_updates__col_loop_body:
	move	$a0, $s0						#       row
	move	$a1, $s1						#       col
	jal	print_cell						#       print_cell(row, col);
	move	$t0, $v0

	li	$v0, 11							#       sycall 11: print_character
	li	$a0, ' '
	syscall								#       printf(" ");

	li	$v0, 1							#       sycall 1: print_int
	move	$a0, $s0						#                    row
	syscall								#       printf("%d",    );

	li	$v0, 11							#       sycall 11: print_character
	li	$a0, ' '
	syscall								#       printf(" ");

	li	$v0, 1							#       sycall 1: print_int
	move	$a0, $s1						#                    col
	syscall								#       printf("%d",    );

	li	$v0, 11							#       sycall 11: print_character
	li	$a0, ' '
	syscall								#       printf(" ");

	li	$v0, 1							#       sycall 1: print_int
	move	$a0, $t0						#                    print_cell(...)
	syscall								#       printf("%d",                );

print_screen_updates__col_loop_step:

	addi	$s1, $s1, 1						#       col++;
	b	print_screen_updates__col_loop_cond			#     }

print_screen_updates__col_loop_end:
print_screen_updates__row_loop_step:
	addi	$s0, $s0, 1						#     row++;
	b	print_screen_updates__row_loop_cond			#   }


print_screen_updates__row_loop_end:
	b	print_screen_updates__final_newline			# } else {

print_screen_updates__not_whole_screen:
print_screen_updates__update_loop_init:
	li	$s0, 0							#   int i = 0;

print_screen_updates__update_loop_cond:
	lw	$t1, num_screen_updates
	bge	$s0, $t1, print_screen_updates__update_loop_end		#   while (i < num_screen_updates) {

print_screen_updates__update_loop_body:
	mul	$t0, $s0, SIZEOF_SCREEN_UPDATE				#     i * sizeof(struct screen_update)
	addi	$t0, $t0, screen_updates				#     &screen_updates[i]

	lw	$s1, SCREEN_UPDATE_Y_OFFSET($t0)			#     int y = screen_updates[i].y;
	lw	$s2, SCREEN_UPDATE_X_OFFSET($t0)			#     int x = screen_updates[i].x;

									#     if (y >= GRID_HEIGHT) continue;
	bge	$s1, GRID_HEIGHT, print_screen_updates__update_loop_step

	bltz	$s2, print_screen_updates__update_loop_step		#     if (x < 0) continue;

									#     if (x >= MAX_GRID_WIDTH) continue;
	bge	$s2, MAX_GRID_WIDTH, print_screen_updates__update_loop_step

	move	$a0, $s1						#     y
	move	$a1, $s2						#     x
	jal	print_cell						#     print_cell(y, x);
	move	$t0, $v0

	li	$v0, 11							#     sycall 11: print_character
	li	$a0, ' '
	syscall								#     printf(" ");

	li	$v0, 1							#     sycall 1: print_int
	move	$a0, $s1						#                  y
	syscall								#     printf("%d",  );

	li	$v0, 11							#     sycall 11: print_character
	li	$a0, ' '
	syscall								#     printf(" ");

	li	$v0, 1							#     sycall 1: print_int
	move	$a0, $s2						#                  x
	syscall								#     printf("%d",  );

	li	$v0, 11							#     sycall 11: print_character
	li	$a0, ' '
	syscall								#     printf(" ");

	li	$v0, 1							#     sycall 1: print_int
	move	$a0, $t0						#                  print_cell(...)
	syscall								#     printf("%d",                );

print_screen_updates__update_loop_step:
	addi	$s0, $s0, 1						#     col++;
	b	print_screen_updates__update_loop_cond			#   }

print_screen_updates__update_loop_end:
print_screen_updates__final_newline:					# }
	li	$v0, 11							# syscall 11: print_character
	li	$a0, '\n'
	syscall								# putchar('\n');

	li	$t4, FALSE
	sw	$t4, whole_screen_update_needed				# whole_screen_update_needed = FALSE;

	li	$t4, 0
	sw	$t4, num_screen_updates					# num_screen_updates = 0;

print_screen_updates__epilogue:
	pop	$s2
	pop	$s1
	pop	$s0
	pop	$ra

	jr	$ra
