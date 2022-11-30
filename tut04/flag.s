FLAG_ROWS = 6
FLAG_COLS = 12

main:
    li  $t0, 0
    
for_loop_one_cond:
    bge $t0, FLAG_ROWS, for_loop_one_end

for_loop_one_body:
    li	$t1, 0			# $t1 = 0
    b for_loop_two_cond

for_loop_two_cond:
    bge $t1, FLAG_COLS, for_loop_two_end
    b for_loop_two_body

for_loop_two_body:
    la  $t2, flag
    mul $t3, $t0, FLAG_COLS

    add $t3, $t3, $t1

    lb  $a0, flag($t3)
    li  $v0, 11
    syscall


for_loop_two_increment:
    addi $t1, $t1, 1
    b for_loop_two_cond


for_loop_two_end:
    b for_loop_one_increment

for_loop_one_increment:
    li  $a0, '\n'
    li  $v0, 11
    syscall

    addi $t0, $t0, 1

    b for_loop_one_cond

for_loop_one_end:
    b end

end:
    jr  $ra

.data
    flag: .byte   '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
    .byte   '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
    .byte   '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'
    .byte   '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'
    .byte   '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
    .byte   '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'