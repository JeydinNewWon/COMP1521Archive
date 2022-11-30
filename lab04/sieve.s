# Sieve of Eratosthenes
# https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
# YOUR-NAME-HERE, DD/MM/YYYY

# Constants
ARRAY_LEN = 1000

main:

	li	$v0, 0
	li	$t0, 2

outer_loop_cond:
	bge	$t0, ARRAY_LEN, outer_loop_end
	b outer_loop_body

outer_loop_body:
	lb	$t3, prime($t0)
	beq	$t3, 0, outer_loop_increment

	move $a0, $t0
	li	$v0, 1
	syscall

	li	$a0, '\n'
	li	$v0, 11
	syscall

inner_loop_init:
	li	$t1, 2
	mul	$t1, $t1, $t0
	b inner_loop_cond

inner_loop_cond:
	bge	$t1, ARRAY_LEN, inner_loop_end
	b inner_loop_body

inner_loop_body:
	li	$t2, 0
	sb	$t2, prime($t1)
	b inner_loop_increment

inner_loop_increment:
	add $t1, $t1, $t0
	b inner_loop_cond

inner_loop_end:
	b outer_loop_increment

outer_loop_increment:
	addi $t0, $t0, 1
	b outer_loop_cond

outer_loop_end:
	b end


end:
	jr	$ra			# return 0;

	.data
prime:
	.byte	1:ARRAY_LEN		# uint8_t prime[ARRAY_LEN] = {1, 1, ...};
