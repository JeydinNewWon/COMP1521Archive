main:
        li      $t0, -1
        li      $t1, -255
        li      $t2, 2147483647
        li      $t3, 1

        mult    $t0, $t0
        mult    $t1, $t1
	mult	$t1, $t2
	mult	$t1, $t3
	mult	$t2, $t2
	mult	$t0, $t1

	jr	$ra
