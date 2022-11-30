# Reads a 4-byte value and reverses the byte order, then prints it

########################################################################
# .TEXT <main>

BYTE_MASK = 0xFF

main:
	# Locals:
	#	- $t0: int network_bytes
	#	- $t1: int computer_bytes
	#	- Add your registers here!


	li		$v0, 5		# scanf("%d", &x);
	syscall
	move	$t0, $v0

	li		$t1, 0
	li		$t2, BYTE_MASK

	and		$t3, $t0, $t2
	sll		$t3, $t3, 24

	or		$t1, $t1, $t3

	sll		$t2, $t2, 8
	and		$t3, $t2, $t0
	sll 	$t3, $t3, 8

	or		$t1, $t1, $t3

	sll		$t2, $t2, 8
	and		$t3, $t2, $t0
	sra		$t3, $t3, 8

	or		$t1, $t1, $t3

	sll		$t2, $t2, 8
	and		$t3, $t2, $t0
	sra		$t3, $t3, 24

	or		$t1, $t1, $t3

	move	$v0, $t1

	#
	# Your code here!
	#

	move	$a0, $v0	# printf("%d\n", x);
	li	$v0, 1
	syscall

	li	$a0, '\n'	# printf("%c", '\n');
	li	$v0, 11
	syscall

main__end:
	li	$v0, 0		# return 0;
	jr	$ra
