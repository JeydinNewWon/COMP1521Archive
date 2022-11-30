#  print the minimum of two integers
main:
	li	$v0, 5		# scanf("%d", &x);
	syscall			#
	move	$t0, $v0

	li	$v0, 5		# scanf("%d", &y);
	syscall			#
	move	$t1, $v0

	bgt $t1, $t0, x_bigger_than

	b y_bigger_than

x_bigger_than:
	move $a0, $t0
	li $v0, 1
	syscall

	li	$a0, '\n'	# printf("%c", '\n');
	li	$v0, 11
	syscall

	b end


y_bigger_than:
	move $a0, $t1
	li $v0, 1
	syscall

	li	$a0, '\n'	# printf("%c", '\n');
	li	$v0, 11
	syscall

	b end

end:
	li	$v0, 0		# return 0
	jr	$ra
