#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>
#include <pthread.h>


void * reverse(void *sir){
    char* s=(char *)sir;
    int l=strlen(s);
    char rev[l];
    int i;
    for(i=0;i<l;i++){
        rev[i]=s[l-i-1];
    }
    rev[i]='\0';
    memcpy(sir,rev,l);
    return sir;
}

int main (int argc, char **argv){
    char* sir=argv[1];
    pthread_t gigel;
    if(pthread_create(&gigel, NULL, reverse, sir)){
        perror(NULL);
        return errno;
    }
    void* result;
    if(pthread_join(gigel, &result)){
        perror(NULL);
        return errno;
    }
    printf("%s\n",(char*)result);
    return 0;
}



/*#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>
#include <pthread.h>

char rev[100]; //trb sa aloc memorie ptr rev, altfel iau seg fault

void * reverse(void *sir){
    char* s=(char *)sir;
    int l=strlen(s);
    int i;
    for(i=0;i<l;i++){
        rev[i]=s[l-i-1];
    }
    rev[i]='\0';
    return NULL;
}

int main (int argc, char **argv){
    char* sir=argv[1];
    pthread_t thread;
    if(pthread_create(&thread, NULL, reverse, sir)){
        perror(NULL);
        return errno;
    }
    void* result;
    if(pthread_join(thread, &result)){
        perror(NULL);
        return errno;
    }
    printf("%s\n",rev);
    return 0;
}*/