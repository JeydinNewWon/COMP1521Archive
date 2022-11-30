#include <pthread.h>
#include "thread_chain.h"
#include <stdio.h>

void *my_thread(void *data) {
    int *n = data;

    thread_hello();

    if (*n == 49) {
        return NULL;
    }

    *n += 1;
    pthread_t thread_id;
    pthread_create(&thread_id, NULL, my_thread, data);

    pthread_join(thread_id, NULL);
    
    return NULL;
}

void my_main(void) {
    int n = 0;
    pthread_t thread_handle;
    pthread_create(&thread_handle, NULL, my_thread, &n);

    pthread_join(thread_handle, NULL);
}
