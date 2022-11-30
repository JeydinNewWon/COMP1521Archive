#include <unistd.h>

int main(void) {
    char bytes[13] = "Hello, Zac!\n";

    // argument 1 to syscall is the system call number, 1 is write
    // remaining arguments are specific to each system call

    // write system call takes 3 arguments:
    //   1) file descriptor, 1 == stdout
    //   2) memory address of first byte to write
    //   3) number of bytes to write

    syscall(1, 1, bytes, 12); // prints Hello, Zac! on stdout

    return 0;
}