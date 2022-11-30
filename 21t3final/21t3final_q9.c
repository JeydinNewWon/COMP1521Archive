#include <stdio.h>

// read a line of input and checks whether it consists only of balanced brackets
// if the line contains characters other than ()[]{} -1 is printed
// if brackets are not balance,  -1 is printed
// if the line contains only balanced brackets, length of the line is printed

int match(int index);
int check(int index, int what);

char line[1024];

int main(int argc, char *argv[]) {
    fgets(line, 1024, stdin);
    int r = check(0, '\n');
    printf("%d\n", r);
    return 0;
}

int check(int index, int what) {
    if (line[index] == what) {
        index = index + 1;
    } else {
        index = match(index);
        if (index > 0) {
            index = check(index, what);
        }
    }
    return index;
}

int match(int index) {
    int r = -1;
    int c = line[index];
    int w = 0;
    if (c == '[') {
        w = ']';
    } else if (c == '(') {
        w = ')';
    } else if (c == '{') {
        w = '}';
    }

    if (w != 0) {
        r = check(index + 1, w);
    }
    return r;
}
