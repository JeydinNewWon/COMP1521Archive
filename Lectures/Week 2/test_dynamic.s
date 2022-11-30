main:
    li $t1, 0x00400028
    
loop0:
    li $v0, 5
    syscall
    move $t0, $v0
    beq $t0, -1, end
    addi $t1, $t1, 4
    sw  $t0, ($t1)
    b loop0

end:


