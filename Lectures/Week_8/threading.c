#include <pthread.h>
#include <stdio.h>
#include <stdatomic.h>

atomic_int bank_account = 0;

pthread_mutex_t bank_account_lock = PTHREAD_MUTEX_INITIALIZER;

void *add_10000(void *argument) {
    for (long i = 0; i < 10000; i++) {
        bank_account++;
    }

    return NULL;
}

int main(void) {
    pthread_t thread_id_1;

    pthread_create(&thread_id_1, NULL, add_10000, NULL);

    pthread_t thread_id_2;
    
    pthread_create(&thread_id_2, NULL, add_10000, NULL);

    pthread_join(thread_id_1, NULL);
    pthread_join(thread_id_2, NULL);

    printf("bank account: %ld\n", bank_account);
    
    return 0;
    
}