# Reads 10 numbers into an array
# printing 0 if they are in non-decreasing order
# or 1 otherwise.
# YOUR-NAME-HERE, DD/MM/YYYY

# Constants
ARRAY_LEN = 10

main:
	# Registers:
	#  - $t0: int i
	#  - $t1: temporary result
	#  - $t2: temporary result
	#	- $t3: swapped result
	#  TODO: add your registers here

scan_loop__init:
	li	$t0, 0				# i = 0;
scan_loop__cond:
	bge	$t0, ARRAY_LEN, scan_loop__end	# while (i < ARRAY_LEN) {

scan_loop__body:
	li	$v0, 5				#   syscall 5: read_int
	syscall					#   
						#
	mul	$t1, $t0, 4			#   calculate &numbers[i] == numbers + 4 * i
	la	$t2, numbers			#
	add	$t2, $t2, $t1			#
	sw	$v0, ($t2)			#   scanf("%d", &numbers[i]);

	addi	$t0, $t0, 1			#   i++;
	j	scan_loop__cond			# }
scan_loop__end:

sort_loop_init:
	li	$t3, 0
	li	$t0, 1

sort_loop__cond:
	bge $t0, ARRAY_LEN, sort_loop__end

sort_loop__body:
	mul	$t1, $t0, 4			#   calculate &numbers[i] == numbers + 4 * i
	la	$t2, numbers			#
	add	$t2, $t2, $t1

	lw	$t4, ($t2)
	
	addi $t2, $t2, -4
	lw	$t5, ($t2)
	bgt $t5, $t4, swap_flag
	b sort_loop__increment

swap_flag:
	li $t3, 1

sort_loop__increment:
	addi $t0, $t0, 1
	b sort_loop__cond


sort_loop__end:
	li	$v0, 1				# syscall 1: print_int
	move	$a0, $t3 			#
	syscall					# printf("%d", 42)

	li	$v0, 11				# syscall 11: print_char
	li	$a0, '\n'			#
	syscall					# printf("%c", '\n');

	li	$v0, 0
	jr	$ra				# return 0;

	.data
numbers:
	.word	0:ARRAY_LEN			# int numbers[ARRAY_LEN] = {0};
