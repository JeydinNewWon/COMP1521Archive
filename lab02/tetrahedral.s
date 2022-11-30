# Read a number n and print the first n tetrahedral numbers
# https://en.wikipedia.org/wiki/Tetrahedral_number
#
# Before starting work on this task, make sure you set your tab-width to 8!
# It is also suggested to indent with tabs only.
#
# YOUR-NAME-HERE, DD/MM/YYYY

#![tabsize(8)]

main:				# int main(void) {

	la	$a0, prompt	# printf("Enter how many: ");
	li	$v0, 4
	syscall


	li	$v0, 5		# scanf("%d", number);
					# $t0 holds how_many
	syscall
	move $t0, $v0

	li	$t1, 1		# t1 holds n 
					# t2 holds j
					# t3 holds i
					# t4 holds total

loop_n:
	bgt  $t1, $t0, end
	li  $t4, 0
	li  $t2, 1

	b  loop_j

	b  loop_n

loop_j:
	li  $t3, 1
	bgt  $t2, $t1, print_total

	b loop_i

loop_i:
	bgt $t3, $t2, increment_j
	add $t4, $t4, $t3
	addi $t3, $t3, 1
	b loop_i

print_total:
	addi $t1, $t1, 1

	move $a0, $t4
	li $v0, 1
	syscall 

	li	$a0, '\n'	# printf("%c", '\n');
	li	$v0, 11
	syscall

	b loop_n

increment_j:
	addi $t2, $t2, 1
	b loop_j

end:

	li	$v0, 0
	jr	$ra		# return 0

	.data
prompt:
	.asciiz "Enter how many: "
