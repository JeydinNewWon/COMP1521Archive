main:
	li	$v0, 5		# scanf("%d", &x);
	syscall			#
	move	$t0, $v0

	li	$v0, 5		# scanf("%d", &y);
	syscall			#
	move	$t1, $v0

loop_init:
	li $t2, 0
	addi $t2, $t0, 1

loop_cond:
	bge $t2, $t1, loop_end
	b loop_body

loop_body:
	beq $t2, 13, loop_increment

	move $a0, $t2
	li $v0, 1
	syscall

	li	$a0, '\n'	# printf("%c", '\n');
	li	$v0, 11
	syscall	

	b loop_increment

loop_increment:
	addi $t2, $t2, 1
	b loop_cond

loop_end:
	b end

end:
	li	$v0, 0         # return 0
	jr	$ra
