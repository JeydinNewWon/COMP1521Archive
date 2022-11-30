	.data
numbers:
	.word 0:10	# int numbers[10] = { 0 };

	.text
main:
	li	$t0, 0		# i = 0;

main__input_loop:
	bge	$t0, 10, main__input_finished	# while (i < 10) {

	li	$v0, 5			# syscall 5: read_int
	syscall
	mul	$t1, $t0, 4
	sw	$v0, numbers($t1)	#	scanf("%d", &numbers[i]);
	
	addi	$t0, 1			#	i++;
	b	main__input_loop	# }

main__input_finished:
	li	$t1, 1			# max_run
	li	$t2, 1			# current_run

while__loop_init:
	li	$t0, 1

while__loop_cond:
	bge		$t0, 10, while__loop_end

while__loop_body:
	mul		$t7, $t0, 4
	lw		$t3, numbers($t7)

	addi	$t7, $t7, -4

	lw		$t4, numbers($t7)

	bgt		$t3, $t4, while__loop_body_curr_inc

	li		$t2, 1

	b		while__loop_body_curr_run_gt_max_run

while__loop_body_curr_inc:
	addi	$t2, $t2, 1

while__loop_body_curr_run_gt_max_run:
	bgt		$t2, $t1, while__loop_body_set_max_run
	b		while__loop_inc

while__loop_body_set_max_run:
	move	$t1, $t2

while__loop_inc:
	addi	$t0, $t0, 1
	b		while__loop_cond

while__loop_end:


main__print_42:
	li		$v0, 1		# syscall 1: print_int
	move	$a0, $t1
	syscall			# printf("42");

	li	$v0, 11		# syscall 11: print_char
	li	$a0, '\n'
	syscall			# printf("\n");

	li	$v0, 0
	jr	$ra		# return 0;
