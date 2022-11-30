# Read a number and print positive multiples of 7 or 11 < n
#
# Before starting work on this task, make sure you set your tab-width to 8!
# It is also suggested to indent with tabs only.
#
# YOUR-NAME-HERE, DD/MM/YYYY

#![tabsize(8)]

main:				# int main(void) {

	la	$a0, prompt	# printf("Enter a number: ");
	li	$v0, 4
	syscall

	li	$v0, 5		# scanf("%d", number);
	syscall

	move $t1, $v0	# We will use $t1 for number

	li	$t0, 1		# We use $t0 for i.
	li	$t2, 7
	li	$t3, 11

loop0:
	rem $t4, $t0, $t2
	rem $t5, $t0, $t3
	
	beq $t4, 0, printnum
	beq $t5, 0, printnum

	addi $t0, $t0, 1

	blt $t0, $t1, loop0

end:
	li	$v0, 0
	jr	$ra		# return 0

printnum:
	move	$a0, $t0
	li	$v0, 1
	syscall

	li	$a0, '\n'	# printf("%c", '\n');
	li	$v0, 11
	syscall

	addi $t0, $t0, 1

	blt $t0, $t1, loop0
	b end
	
.data
prompt:
	.asciiz "Enter a number: "
