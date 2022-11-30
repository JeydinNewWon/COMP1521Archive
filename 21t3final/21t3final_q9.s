# this code reads a line of input and prints 42
# change it to check the string for brackets

# read a line of input and checks whether it consists only of balanced brackets
# if the line contains characters other than ()[]{} -1 is printed
# if brackets are not balance,  -1 is printed
# if the line contains only balanced brackets, length of the line is printed

main:
    la   $a0, line
    la   $a1, 1024
    li   $v0, 8          # fgets(line, 1024, stdin);
    syscall


    # THESE LINES JUST PRINT 42
    # REPLACE THE LINES BELOW WITH YOUR CODE
    li $a0, 42
    li $v0, 1
    syscall
    li   $a0, '\n'
    li   $v0, 11
    syscall
    # REPLACE THE LINES ABOVE WITH YOUR CODE


    li   $v0, 0          # return 0
    jr   $31


# PUT YOU FUNCTION DEFINITIONS HERE


.data
line:
    .byte 0:1024
