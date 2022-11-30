# read an integer
# print 1 iff  the least significant bit is equal to the most significant bit
# print 0 otherwise

main:
    li   $v0, 5
    syscall


    andi    $t0, $v0, 1
    srl     $t1, $v0, 31

    beq     $t0, $t1, bits_equal

    b       bits_unequal

bits_equal:
    li      $a0, 1
    li      $v0, 1
    syscall
    b       new_line

bits_unequal:
    li      $a0, 0
    li      $v0, 1
    syscall

new_line:
    li   $a0, '\n'
    li   $v0, 11
    syscall
    # REPLACE THE LINES ABOVE WITH YOUR CODE


end:
    li $v0, 0
    jr $31
