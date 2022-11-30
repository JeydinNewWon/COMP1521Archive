main:
    li   $t0, 0
loop1_cond:
    beq  $t0, 11,  loop1_end
loop2_init:
    li   $t1, 0
loop2_cond:
    beq  $t1, 11,  loop1_step
loop2_body:
    addi $t2, $t0, -5
    addi $t3, $t1, -5
    mul  $t2, $t2, $t2
    mul  $t3, $t3, $t3
    add  $t4, $t2, $t3
    li   $t5, 17
    slt  $t2, $t4, $t5
    bne  $t2, $0,  draw
    li   $a0, ' '
    li   $v0, 11
    syscall
    b    loop2_step
draw:
    li   $a0, '#'
    li   $v0, 11
    syscall
loop2_step:
    addi $t1, $t1, 1
    b    loop2_cond
loop1_step:
    li   $a0, '\n'
    li   $v0, 11
    syscall
    addi $t0, $t0, 1
    b    loop1_cond
loop1_end:
    li   $v0, 10
    syscall
end:
    jr   $ra
