# COMP1521 22T2 ... final exam, question 2

# $t0 - MASK
# $t1 - zero_count
# $t2 - increment
# $t3 - x

MASK = 1

main:
	li		$v0, 5		# syscall 5: read_int
	syscall
	move	$t3, $v0	# read integer into $t0


	# THESE LINES JUST PRINT 42\n
	# REPLACE THE LINES BELOW WITH YOUR CODE

	li		$t0, MASK

for_loop__init:
	li		$t1, 0
	li		$t2, 0

for_loop__cond:
	bge 	$t2, 32, for_loop__end

for_loop__body:
	and 	$t4, $t0, $t3

	beq 	$t4, 0, for_loop__zero_inc

	b		for_loop__increment

for_loop__zero_inc:
	addi	$t1, $t1, 1

for_loop__increment:
	addi	$t2, $t2, 1
	sll		$t0, $t0, 1
	b		for_loop__cond


for_loop__end:
	li		$v0, 1
	move	$a0, $t1
	syscall 

	li	$v0, 11		# syscall 11: print_char
	li	$a0, '\n'
	syscall			# printf("\n");
	# REPLACE THE LINES ABOVE WITH YOUR CODE

main__end:
	li	$v0, 0		# return 0;
	jr	$ra
