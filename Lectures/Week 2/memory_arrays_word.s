main:
    li  $t0, 3
    mul $t0, $t0, 4
    la  $t1, x
    add $t2, $t1, $t0
    li  $t3, 17
    lw  $t3, ($t2)

    li  $v0, 1
    move    $a0, $t3
    syscall

    li  $v0, 11
    li  $a0, '\n'
    syscall


    jr  $ra

.data
x: .word 3, 9, 27, 81, 243