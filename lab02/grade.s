# read a mark and print the corresponding UNSW grade
#
# Before starting work on this task, make sure you set your tab-width to 8!
# It is also suggested to indent with tabs only.
#
# YOUR-NAME-HERE, DD/MM/YYYY

#![tabsize(8)]

main:
	la	$a0, prompt	# printf("Enter a mark: ");
	li	$v0, 4
	syscall

	li	$v0, 5		# scanf("%d", mark);
	move $t0, $v0   # store the scanned res
	syscall

	blt $v0, 50, FAIL
	blt $v0, 65, PASS
	blt $v0, 75, CREDIT
	blt $v0, 85, DISTINCTION

	b HIGHDISTINCTION

FAIL:
	la	$a0, fl		# printf("FL\n");
	li	$v0, 4
	syscall
	b END
PASS:
	la	$a0, ps
	li	$v0, 4
	syscall
	b END
CREDIT:
	la	$a0, cr
	li	$v0, 4
	syscall
	b END

DISTINCTION:
	la	$a0, dn
	li	$v0, 4
	syscall
	b END

HIGHDISTINCTION:
	la	$a0, hd
	li	$v0, 4
	syscall

END:
	li	$v0, 0
	jr	$ra		# return 0

.data
prompt:
	.asciiz "Enter a mark: "
fl:
	.asciiz "FL\n"
ps:
	.asciiz "PS\n"
cr:
	.asciiz "CR\n"
dn:
	.asciiz "DN\n"
hd:
	.asciiz "HD\n"
