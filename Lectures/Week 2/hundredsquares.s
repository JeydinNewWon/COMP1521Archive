# $t0 contains sum
# $t1 contains i
# $t2 contains square

main:
    li $t0, 0
    li $t1, 0

loop_start:
    bgt $t1, 100, loop_end
    mul $t2, $t1, $t1
    add $t0, $t0, $t2
    addi $t1, $t1, 1
    j loop_start

loop_end:
    li $v0, 1
    move $a0, $t0
    syscall

    li $v0, 11
    li $a0, '\n'

    syscall 
    jr $ra