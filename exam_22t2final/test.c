#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(void) {
    char *emoji = "😀";
    char *hello = "hello";
    char *emoji_train = "h🍇🍈🍍🍐";

    char construct_emoji[5];

    char line_test[3] = {0x68, 0x69, '\0'};

    for (int i = 0; i < 4; i++) {
        printf("%x\n", emoji[i]);
    }

    
    for (int i = 0; i < 2; i++) {
        printf("%x\n", line_test[i]);
    }


    printf("%d\n", strlen(emoji));
    printf("%d\n", strlen(hello));
    printf("%d\n", strlen(emoji_train));
    printf("%s\n", line_test);

    construct_emoji[0] = 0xF0;
    construct_emoji[1] = 0x9F;
    construct_emoji[2] = 0x98;
    construct_emoji[3] = 0x80;
    construct_emoji[4] = 0;

    printf("construct: %s\n", construct_emoji);
}