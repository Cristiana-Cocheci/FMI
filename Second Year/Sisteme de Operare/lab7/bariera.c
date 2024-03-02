#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>
#include <pthread.h>
#include <stdlib.h>
#include<semaphore.h>

int N, reachedBarrier;
pthread_mutex_t mtx;
sem_t semafor;

int barrier_point(){
    pthread_mutex_lock(&mtx);
    reachedBarrier++;

    if(reachedBarrier==N){
        printf("aici\n");
        if ( sem_post (& semafor )) { //semaforul devine 1
            perror ( NULL );
            return errno ;
        }
    }
    pthread_mutex_unlock(&mtx);
    if ( sem_wait (& semafor )) { //asteptam
        perror ( NULL );
        return errno ;
    }
    if ( sem_post (& semafor )) { //cand prinde un loc liber, trece bariera si adauga iar 1
            perror ( NULL );
            return errno ;
    }
}

/*
int barrier_point(){
    pthread_mutex_lock(&mtx);
    reachedBarrier++;
    pthread_mutex_unlock(&mtx);

    if(reachedBarrier==N){
        printf("aici\n");
        for(int i=0;i<N;i++)
            if ( sem_post (& semafor )) {
                perror ( NULL );
                return errno ;
            }
    }
    else if ( sem_wait (& semafor )) {
        perror ( NULL );
        return errno ;
    }
}
*/

void *fdorei(void* tid){
    int dorelid = * (int *) tid;
    printf ("%d reached the barrier \n" , dorelid );
    barrier_point ();
    printf ("%d passed the barrier \n" , dorelid );
    return NULL ;
}

int init(){
    reachedBarrier=0;

    if(sem_init(&semafor,0,0)){ //pleaca de la 0, deci niciun dorel nu poate sa treaca bariera
        perror(NULL);
        return errno;
    }

    pthread_t dorel[N];
    int dorei[N];
    for(int t=0;t<N;t++){
        dorei[t]=t;
        if(pthread_create(&dorel[t], NULL, fdorei, &dorei[t])){
            perror(NULL);
            return errno;
        }
        
    }
    for(int t=0;t<N;t++){
        if(pthread_join(dorel[t], NULL)){
            perror(NULL);
            return errno;
        }
    }
    return 0;
}


int main(int argc, char** argv){
    N=atoi(argv[1]);
    if(pthread_mutex_init(&mtx, NULL)){
        perror(NULL);
        return errno;
    }
    if(init(N)){
        return errno;
    }
    if(pthread_mutex_destroy(&mtx)){
        perror(NULL);
        return errno;
    }
    if(sem_destroy(&semafor)){
        perror(NULL);
        return errno;
    }
}