# read two integers and print all the integers which have their bottom 2 bits set.

# t0 : x
# t1 : y
# t2: i
# t3: i & MASK res

MASK = 3

main:
    li $v0, 5
    syscall
    move $t0, $v0

    li $v0, 5
    syscall
    move $t1, $v0


for_loop_init:
    move    $t2, $t0
    addi	$t2, $t2, 1

for_loop_cond:
    bge     $t2, $t1, for_loop_end

for_loop_body:
    and     $t3, $t2, MASK 

    beq     $t3, MASK, for_loop_print
    b       for_loop_inc

for_loop_print:
    move    $a0, $t2
    li      $v0, 1
    syscall

    li      $a0, '\n'
    li      $v0, 11
    syscall

for_loop_inc:
    addi    $t2, $t2, 1
    b       for_loop_cond

for_loop_end:


end:
    li $v0, 0
    jr $31
