main:
    li $a0, string0
    li $v0, 4

    syscall
    
    li $v0, 0
    jr $ra

    .data

string0:
    .asciiz "Well, this was a MIPStake!\n"