N_SIZE = 10

main:
    li  $t0, 0
main__while_start:
    bge $t0, N_SIZE, main__while_end

    mul $t1, $t0, 4
    lw  $a0, numbers($t1)

    li  $v0, 1
    syscall

    addi $t0, $t0, 1

    li  $v0, 11
    li  $a0, '\n'
    syscall
    b main__while_start


main__while_end:
    jr $ra

.data
    numbers: 
        .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9