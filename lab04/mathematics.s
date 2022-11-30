# YOUR-NAME-HERE, DD/MM/YYYY

########################################################################
# .DATA
# Here are some handy strings for use in your code.

	.data
prompt_str:
	.asciiz "Enter a random seed: "
result_str:
	.asciiz "The random result is: "

########################################################################
# .TEXT <main>
	.text
main:

	# Args: void
	# Returns: int
	#
	# Frame:	[...]
	# Uses: 	[...]
	# Clobbers:	[...]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   - main
	#     -> [prologue]
	#     -> [body]
	#     -> [epilogue]

main__prologue:
	begin
	push	$ra
	push	$s0

	# TODO: add code to set up your stack frame here 

main__body:
	la 	$a0, prompt_str
	li	$v0, 4
	syscall

	li	$v0, 5
	syscall
	move $a0, $v0

	jal seed_rand

	li $a0, 100

	jal rand
	move $s0, $v0
	move $a0, $v0

	jal add_rand

	move $a0, $v0

	jal sub_rand

	move $a0, $v0

	jal seq_rand

	move $t0, $v0

	la	$a0, result_str
	li	$v0, 4
	syscall

	move $a0, $t0
	li	$v0, 1
	syscall

	li	$a0, '\n'
	li	$v0, 11
	syscall


main__epilogue:
	# TODO: add code to clean up stack frame here
	pop		$s0
	pop		$ra
	end

	li	$v0, 0
	jr	$ra				# return 0;

########################################################################
# .TEXT <add_rand>
	.text
add_rand:
	# Args:
	#   - $a0: int value
	# Returns: int
	#    
	# Frame:	[...]
	# Uses: 	[...]
	# Clobbers:	[...]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   - add_rand
	#     -> [prologue]
	#     -> [body]
	#     -> [epilogue]

add_rand__prologue:
	begin

	push $ra
	push $a0

	# TODO: add code to set up your stack frame here

add_rand__body:

	li $a0, 0xFFFF

	jal rand

	pop $a0

	add $v0, $v0, $a0
add_rand__epilogue:
	
	pop $ra

	end

	jr	$ra


########################################################################
# .TEXT <sub_rand>
	.text
sub_rand:
	# Args:
	#   - $a0: int value
	# Returns: int
	#
	# Frame:	[...]
	# Uses: 	[...]
	# Clobbers:	[...]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   - sub_rand
	#     -> [prologue]
	#     -> [body]
	#     -> [epilogue]

sub_rand__prologue:
	begin

	push $ra
	push $a0

	# TODO: add code to set up your stack frame here

sub_rand__body:

	jal rand

sub_rand__epilogue:
	pop $a0

	sub $v0, $a0, $v0

	pop $ra
	# TODO: add code to clean up stack frame here

	end

	jr	$ra

########################################################################
# .TEXT <seq_rand>
	.text
seq_rand:
	# Args:
	#   - $a0: int value
	# Returns: int
	#
	# Frame:	[...]
	# Uses: 	[...]
	# Clobbers:	[...]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   - seq_rand
	#     -> [prologue]
	#     -> [body]
	#     -> [epilogue]

seq_rand__prologue:
	begin

	push $ra
	push $a0

seq_rand__body:

	li	$a0, 100
	jal rand
	move	$t1, $v0

	pop $a0
	li	$t0, 0

loop_cond: 
	bge $t0, $t1, loop_end

loop_body:
	push $t0
	jal add_rand
	move $a0, $v0
	b loop_increment

loop_increment:
	pop $t0 
	addi $t0, $t0, 1
	b loop_cond

loop_end:
	move $v0, $a0
	b seq_rand__epilogue

seq_rand__epilogue:

	pop	$ra
	# TODO: add code to clean up stack frame here

	end
	
	jr	$ra



##
## The following are two utility functions, provided for you.
##
## You don't need to modify any of the following,
## but you may find it useful to read through.
## You'll be calling these functions from your code.
##

OFFLINE_SEED = 0x7F10FB5B

########################################################################
# .DATA
	.data
	
# int random_seed;
	.align 2
random_seed:
	.space 4


########################################################################
# .TEXT <seed_rand>
	.text
seed_rand:
# DO NOT CHANGE THIS FUNCTION

	# Args:
	#   - $a0: unsigned int seed
	# Returns: void
	#
	# Frame:	[]
	# Uses:		[$a0, $t0]
	# Clobbers:	[$t0]
	#
	# Locals:
	#   - $t0: offline_seed
	#
	# Structure:
	#   - seed_rand

	li	$t0, OFFLINE_SEED		# const unsigned int offline_seed = OFFLINE_SEED;
	xor	$t0, $a0			# random_seed = seed ^ offline_seed;
	sw	$t0, random_seed

	jr	$ra				# return;

########################################################################
# .TEXT <rand>
	.text
rand:
# DO NOT CHANGE THIS FUNCTION

	# Args:
	#   - $a0: unsigned int n
	# Returns:
	#   - $v0: int
	#
	# Frame:    []
	# Uses:     [$a0, $v0, $t0]
	# Clobbers: [$v0, $t0]
	#
	# Locals:
	#   - $t0: int rand
	#
	# Structure:
	#   - rand

	lw	$t0, random_seed 		# unsigned int rand = random_seed;
	multu	$t0, 0x5bd1e995  		# rand *= 0x5bd1e995;
	mflo	$t0
	addiu	$t0, 12345       		# rand += 12345;
	sw	$t0, random_seed 		# random_seed = rand;

	remu	$v0, $t0, $a0    
	jr	$ra              		# return rand % n;
