# Reads a line and prints whether it is a palindrome or not

LINE_LEN = 256

########################################################################
# .TEXT <main>
main:
	# Locals:
	#   - ...

	li	$v0, 4				# syscall 4: print_string
	la	$a0, line_prompt_str		#
	syscall					# printf("Enter a line of input: ");

	li	$v0, 8				# syscall 8: read_string
	la	$a0, line			#
	la	$a1, LINE_LEN			#
	syscall					# fgets(buffer, LINE_LEN, stdin)



count_loop__init:
	li	$t0, 0

count_loop__cond:
	lb	$t1, line($t0)
	beq	$t1, 0, count_loop__end

count_loop__step:
	addi	$t0, $t0, 1
	b		count_loop__cond

count_loop__end:

pali_loop__init:
	li 	$t2, 0
	addi	$t3, $t0, -2
pali_loop__cond:
	bge $t2, $t3, pali_loop__end

pali_loop__step:
	lb		$t4, line($t2)
	lb		$t5, line($t3)

	bne		$t4, $t5, not_palindrome

	addi	$t2, $t2, 1
	addi	$t3, $t3, -1
	b		pali_loop__cond

pali_loop__end:
					
is_palindrome:
	li	$v0, 4				# syscall 4: print_string
	la	$a0, result_palindrome_str	#
	syscall					# printf("palindrome\n");
	b	return_zero

not_palindrome:
	li	$v0, 4				# syscall 4: print_string
	la	$a0, result_not_palindrome_str	#
	syscall
	b	return_zero

return_zero:
	li	$v0, 0
	jr	$ra				# return 0;


########################################################################
# .DATA
	.data
# String literals
line_prompt_str:
	.asciiz	"Enter a line of input: "
result_not_palindrome_str:
	.asciiz	"not palindrome\n"
result_palindrome_str:
	.asciiz	"palindrome\n"

# Line of input stored here
line:
	.space	LINE_LEN

