main:
    li  $t0, 3
    mul  $t0, $t0, 4
    la  $t1, x
    add $t2, $t1, $t0 # add 12 to store x at the third index in the array x.
    li  $t3, 17
    sw  $t3, ($t2)

.data 
x:  .space 40