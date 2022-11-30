########################################################################
# .DATA
# Here are some handy strings for use in your code.
	.data
prompt_m_str:	.asciiz	"Enter m: "
prompt_n_str:	.asciiz	"Enter n: "
result_str_1:	.asciiz	"Ackermann("
result_str_2:	.asciiz	", "
result_str_3:	.asciiz	") = "

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
	push $ra
	push $s0
	push $s1
	push $s2

main__body:

	la	$a0, prompt_m_str
	li	$v0, 4
	syscall

	li	$v0, 5
	syscall

	move	$s0, $v0

	la	$a0, prompt_n_str
	li	$v0, 4
	syscall

	li	$v0, 5
	syscall

	move	$s1, $v0

	move	$a0, $s0
	move	$a1, $s1

	jal ackermann

	move	$s2, $v0

	la		$a0, result_str_1
	li		$v0, 4
	syscall

	move	$a0, $s0
	li		$v0, 1
	syscall

	la		$a0, result_str_2
	li		$v0, 4
	syscall

	move 	$a0, $s1
	li		$v0, 1
	syscall

	la		$a0, result_str_3
	li		$v0, 4
	syscall


	move	$a0, $s2
	li		$v0, 1
	syscall

	li		$a0, '\n'
	li		$v0, 11
	syscall


main__epilogue:
	pop $s2
	pop $s1
	pop $s0
	pop $ra
	end
	# TODO: clean up your stack frame

	li	$v0, 0
	jr	$ra			# return 0;

########################################################################
# .TEXT <ackermann>
	.text
ackermann:

	# Args:
	#   - $a0: int m
	#   - $a1: int n
	# Returns: int
	#
	# Frame:	[]
	# Uses: 	[]
	# Clobbers:	[]
	#
	# Locals:
	#   - .
	#
	# Structure:
	#   - ackermann
	#     -> [prologue]
	#     -> [body]
	#     -> [epilogue]

ackermann__prologue:

	# TODO: set up your stack frame
	begin
	push	$ra
	push	$a0
	push	$a1

ackermann__body:
	beq		$a0, 0, ackermann__m_equals
	beq		$a1, 0, ackermann__n_equals

	addi	$a1, $a1, -1
	jal		ackermann

	move	$a1, $v0
	addi	$a0, $a0, -1

	jal		ackermann
	b		ackermann__epilogue

ackermann__m_equals:
	add		$v0, $a1, 1
	b		ackermann__epilogue

ackermann__n_equals:
	addi	$a0, $a0, -1
	li		$a1, 1
	jal		ackermann
	b		ackermann__epilogue


ackermann__epilogue:

	# TODO: clean up your stack frame
	pop 	$a1
	pop		$a0
	pop 	$ra

	end

	jr	$ra
