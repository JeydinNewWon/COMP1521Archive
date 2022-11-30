#include <pthread.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>


struct thread_data {
    pthread_barrier_t *barrier;
    int payload;
};

void *my_thread(void *data) {
    struct thread_data *thread_data = data;
    int number = thread_data->payload;

    pthread_barrier_wait(thread_data->barrier);

    sleep(1);

    printf("Number is: %d\n", number);


    return NULL;
}


pthread_t create_thread(void) {
    pthread_barrier_t barrier;
    pthread_barrier_init(&barrier, NULL, 2);


    struct thread_data data = {
        .barrier = &barrier, 
        .payload = 0x69
    };

    pthread_t pthread_id;

    pthread_create(&pthread_id, NULL, my_thread, &data);

    pthread_barrier_wait(&barrier);

    return pthread_id;
}


void do_something(void) {
    printf("doing something!\n");
}

int main(void) {
    pthread_t thread_id = create_thread();

    do_something();

    pthread_join(thread_id, NULL);

    return 0;
}