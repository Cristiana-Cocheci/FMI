#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>
#include <pthread.h>

#define MAX_RESOURCES 5
int threadNumber=7;
int available_resources = MAX_RESOURCES;
pthread_mutex_t mtx;
struct gigei{
    int gigel,nres;
};

int decrease_count ( int count )
{
    pthread_mutex_lock(&mtx);
    if ( available_resources < count ){
        pthread_mutex_unlock(&mtx);
        return -1;
    }
    available_resources -= count ;
    printf("Gigel got %d resources; %d remaining\n",count,available_resources);
    pthread_mutex_unlock(&mtx);
    return 0;
}
int increase_count ( int count )
{
    pthread_mutex_lock(&mtx);
    available_resources += count ;
    printf("Gigel returned %d resources; %d remaining\n",count,available_resources);
    pthread_mutex_unlock(&mtx);
    return 0;
}

void * fGigel(void* rsc){
    struct gigei* date=(struct gigei*)rsc;
    while(decrease_count(date->nres)==-1){
        printf("blocat gigel %d %d, disponibil:%d\n",date->gigel,date->nres,available_resources);
    }
    increase_count(date->nres);
    return NULL;
}

int main(){
    if(pthread_mutex_init(&mtx, NULL)){
        perror(NULL);
        return errno;
    }
    pthread_t gigel[threadNumber];
    int resurse[]={1,4,5,4,2,2,3};
    struct gigei data[threadNumber];
    for(int t=0;t<threadNumber;t++){
        data[t].gigel=t;
        data[t].nres=resurse[t];
        if(pthread_create(&gigel[t], NULL, fGigel, &data[t])){
            perror(NULL);
            return errno;
        }
    }
    for(int t=0;t<threadNumber;t++){
        if(pthread_join(gigel[t], NULL)){
            perror(NULL);
            return errno;
        }
    }
    if(pthread_mutex_destroy(&mtx)){
        perror(NULL);
        return errno;
    }
}