# Recursive implementation of a factorial calculator.
# You will need to complete the factorial function at the bottom of this file.
# Your program should yield n! = 1 for any n < 1.
# YOUR-NAME-HERE, DD/MM/YYYY

########################################################################
# .DATA
	.data
prompt_str:	.asciiz	"Enter n: "
result_str:	.asciiz	"! = "

########################################################################
# .TEXT <main>
	.text
main:
	# DO NOT MODIFY THIS FUNCTION.

	# Args: void
	# Returns: int
	#
	# Frame:	[$ra, $s0]
	# Uses: 	[$v0, $a0, $s0, $t0]
	# Clobbers:	[$v0, $a0, $t0]
	#
	# Locals:
	#   - $s0: int n
	#   - $t0: int f
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

main__body:
	li	$v0, 4				# syscall 4: print_string
	la	$a0, prompt_str			#
	syscall					# printf("%s", "Enter n: ");

	li	$v0, 5				# syscall 5: read_int
	syscall					#
	move	$s0, $v0			# scanf("%d", &n);

	move	$a0, $s0			
	jal	factorial			
	move	$t0, $v0			# int f = factorial(n);

	li	$v0, 1				# syscall 1: print_int
	move	$a0, $s0			#
	syscall					# printf("%d", n);

	li	$v0, 4				# syscall 4: print_string
	la	$a0, result_str			#
	syscall					# printf("%s", "! = ")

	li	$v0, 1				# syscall 1: print_int
	move	$a0, $t0			#
	syscall					# printf("%d", f)

	li	$v0, 11				# syscall 11: print_char
	li	$a0, '\n'			#
	syscall					# printf("%c", '\n');

main__epilogue:
	pop	$s0
	pop	$ra
	end

	li	$v0, 0
	jr	$ra				# return 0;

	# DO NOT MODIFY THE ABOVE CODE.

########################################################################
# .TEXT <factorial>
	.text
factorial:

	# Args:
	#   - $a0: int n
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
	#   - factorial
	#     -> [prologue]
	#     -> [body]
	#     -> [epilogue]

factorial__prologue:
	
	begin
	push $ra

factorial__body:
	ble $a0, 1, factorial_else_if
	push $a0
	add $a0, $a0, -1
	jal factorial__prologue
	pop $a0

	mul $v0, $a0, $v0

	b factorial__epilogue

factorial_else_if:
	li	$v0, 1

factorial__epilogue:
	pop $ra
	end

	jr	$ra
