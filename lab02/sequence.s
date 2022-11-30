# Read three numbers `start`, `stop`, `step`
# Print the integers bwtween `start` and `stop` moving in increments of size `step`
#
# Before starting work on this task, make sure you set your tab-width to 8!
# It is also suggested to indent with tabs only.
#
# YOUR-NAME-HERE, DD/MM/YYYY

#![tabsize(8)]

main:				# int main(void)
	la	$a0, prompt1	# printf("Enter the starting number: ");
	li	$v0, 4
	syscall

	li	$v0, 5		# scanf("%d", number);
	syscall

	move  $t0, $v0	# we will use $t0 for the start.

	la	$a0, prompt2	# printf("Enter the stopping number: ");
	li	$v0, 4
	syscall

	li	$v0, 5		# scanf("%d", number);
	syscall

	move	$t1, $v0 # we will use $t1 for the stop

	la	$a0, prompt3	# printf("Enter the step size: ")
	li	$v0, 4
	syscall

	li	$v0, 5		# scanf("%d", number);
	syscall

	move	$t2, $v0

	blt $t1, $t0, stopless
	bgt $t1, $t0, stopgreater

	b end


stopless:
	bge $t2, 0, end
	b stoplessloop

stoplessloop:
	blt $t0, $t1, end

	move	$a0, $t0
	li	$v0, 1
	syscall

	li	$a0, '\n'	# printf("%c", '\n');
	li	$v0, 11
	syscall

	add $t0, $t0, $t2

	b stoplessloop


stopgreater:
	ble $t2, 0, end
	b stopgreaterloop

stopgreaterloop:
	bgt $t0, $t1, end

	move	$a0, $t0
	li	$v0, 1
	syscall

	li	$a0, '\n'	# printf("%c", '\n');
	li	$v0, 11
	syscall

	add $t0, $t0, $t2

	b stopgreaterloop

end:
	li	$v0, 0
	jr	$ra		# return 0

	.data
prompt1:
	.asciiz "Enter the starting number: "
prompt2:
	.asciiz "Enter the stopping number: "
prompt3:
	.asciiz "Enter the step size: "
