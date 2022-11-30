main:
    li $t0, 0

my_loop:
    li $v0, 1
    move $a0, $t0
    syscall

    li $v0, 11
    li $a0, '\n'
    syscall

    addi $t0, $t0, 1
    blt $t0, 10, my_loop
    jr $ra


.data
good_morning_string:
    .asciiz "Good morning, Jayden\n"
