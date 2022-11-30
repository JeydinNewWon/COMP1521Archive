//! fix the data race in the below program!


/// You are permitted to add standard headers (useful for atomics)
#include <pthread.h>
#include <stdio.h>

/// You are permitted to modify the type of
/// this global variable (useful for atomics)
int global_counter = 0;

/// You are permitted to create another global
/// variable (useful for mutex)
pthread_mutex_t bank_account_lock = PTHREAD_MUTEX_INITIALIZER;

/// You are permitted to modify this function
/// (will be necessary for both mutex and atomics)
void perform_increment(void) {
    pthread_mutex_lock(&bank_account_lock);
    global_counter = global_counter + 1;
    pthread_mutex_unlock(&bank_account_lock);
}


///
/// DO NOT CHANGE ANY CODE BELOW THIS POINT
///

void *thread_run(void *data) {
    int n_increments = * (int *) data;

    for (int i = 0; i < n_increments; i++) {
        perform_increment();
    }

    return NULL;
}


int get_global_counter(void) {
    return global_counter;
}
