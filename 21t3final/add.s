main:
    li $t0, 1
    li $t1, 1

    add $a0, $t0, $t1
    li $v0, 1
    syscall

    li $a0, '\n'
    li $v0, 11
    syscall

    li $v0, 0
    jr $ra


