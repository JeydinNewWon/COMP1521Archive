main:
	li	$t6, 300
	li	$t7, 24
	li	$t8, 25
	li	$t9, 26

	li	$v0, 1
	div	$t6, $t7
	mfhi	$a0
	syscall

	li	$v0, 11
	li	$a0, '\n'
	syscall

	li	$v0, 1
	div	$t6, $t8
	mfhi	$a0
	syscall

	li	$v0, 11
	li	$a0, '\n'
	syscall

	li	$v0, 1
	div	$t6, $t9
	mflo	$a0
	syscall

	li	$v0, 11
	li	$a0, '\n'
	syscall

	jr	$ra
