# read 10 numbers into an array

main:

    li   $t0, 0          # i = 0
loop0:
    bge  $t0, 10, end0   # while (i < 10) {

    li   $v0, 5          #   scanf("%d", &numbers[i]);
    syscall              #

    mul  $t1, $t0, 4     #   calculate &numbers[i]
    la   $t2, numbers    #
    add  $t3, $t1, $t2   #
    sw   $v0, ($t3)      #   store entered number in array

    add  $t0, $t0, 1     #   i++;
    b    loop0           # }
end0:

loop1_init:
    li      $t0, 0

loop1_cond:
    bge     $t0, 10, loop1_end

loop1_body:
    mul     $t1, $t0, 4
    lw      $t2, numbers($t1)

    bgt     $t2, 0, loop1_print

    b       loop1_inc

loop1_print:
    move	$a0, $t2
    li      $v0, 1
    syscall

    li      $a0, ' '
    li      $v0, 11
    syscall


loop1_inc:
    addi    $t0, $t0, 1
    b       loop1_cond

loop1_end:
    li      $a0, '\n'
    li      $v0, 11
    syscall

loop2_init:
    li      $t0, 0

loop2_cond:
    bge     $t0, 10, loop2_end

loop2_body:
    mul     $t1, $t0, 4
    lw      $t2, numbers($t1)

    blt     $t2, 0, loop2_print

    b       loop2_inc

loop2_print:
    move	$a0, $t2
    li      $v0, 1
    syscall

    li      $a0, ' '
    li      $v0, 11
    syscall

loop2_inc:
    addi    $t0, $t0, 1
    b       loop2_cond

loop2_end:


end:
    li      $a0, '\n'
    li      $v0, 11
    syscall

    li   $v0, 0
    jr   $31             # return

.data

numbers:
    .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0  # int numbers[10] = {0};
