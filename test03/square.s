main:
	li	$v0, 5		# scanf("%d", &x);
	syscall			#
	move	$t0, $v0
	
i_loop_init:
	li	$t1, 0

i_loop_cond:
	bge $t1, $t0, i_loop_end
	b i_loop_body

i_loop_body:
	li	$t2, 0
	b j_loop_cond

j_loop_cond:
	bge	$t2, $t0, i_loop_increment
	b j_loop_body

j_loop_body:
	li	$a0, '*'
	li	$v0, 11
	syscall

	addi $t2, $t2, 1
	b j_loop_cond


i_loop_increment:
	addi $t1, $t1, 1
	li	$a0, '\n'	# printf("%c", '\n');
	li	$v0, 11
	syscall	
	b i_loop_cond

i_loop_end:
	b end

end:
	li	$v0, 0		# return 0
	jr	$ra
