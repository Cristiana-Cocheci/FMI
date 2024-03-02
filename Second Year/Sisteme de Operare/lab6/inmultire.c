#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>
#include <pthread.h>
#include <stdlib.h>
int m,p,n;

void *inmultire(void *vect){
    int* data=(int*)vect;
    int i=data[p+p];
    int j=data[p+p+1];
    int suma=0;
    for(int k=0;k<p;k++){
        suma+= data[k] * data [p+k];
    }
    int* rez = (int *)malloc(sizeof(int));
    rez[0]=suma;
    return rez;
}

int main(){
    scanf("%d%d%d",&m,&p,&n);
    int A[m][p], B[p][n],C[m][n];
    for(int i=0;i<m;i++){
        for(int j=0;j<p;j++){
            scanf("%d",&A[i][j]);
        }
    }
    for(int i=0;i<p;i++){
        for(int j=0;j<n;j++){
            scanf("%d",&B[i][j]);
        }
    }
    pthread_t thread[m][n]; 
    int data[m*n][p+p+2]; //daca as fi lasat numai data[p+p+2]
    for(int i=0;i<m;i++){
        for(int j=0;j<n;j++){
            for(int k=0;k<p;k++){
                data[i*n+j][k]=A[i][k]; //de la 0 la p-1 avem elemente de pe o linie a lui A
                data[i*n+j][p+k]=B[k][j]; // de la p la 2*p-1 avem elemente de pe o coloana a lui B
            }
            data[i*n+j][p+p]=i;
            data[i*n+j][p+p+1]=j;
           
            if(pthread_create(&thread[i][j], NULL, inmultire, &data[i*n+j])){
                perror(NULL);
                return errno;
            }
        }
    }
    void* result;
    for(int i=0;i<m;i++)
        for(int j=0;j<n;j++){
           if(pthread_join(thread[i][j], &result)){
                perror(NULL);
                return errno;
            }
            int* rez=(int*)result;
            C[i][j]=rez[0];
            free(rez);
        }
            
    for(int i=0;i<m;i++){
        for(int j=0;j<n;j++){
            //printf("%d %d |",i,j);
            printf("%d ",C[i][j]);
        }
        printf("\n");
    }

}

/*
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>
#include <pthread.h>
#include <stdlib.h>
int m,p,n;

void *inmultire(void *vect){
    int* data=(int*)vect;
    int i=data[p+p];
    int j=data[p+p+1];
    int suma=0;
    for(int k=0;k<p;k++){
        suma+= data[k] * data [p+k];
    }
    int rez[1]={suma};
    memcpy(vect,rez,sizeof(int));
    return vect;
}

int main(){
    scanf("%d%d%d",&m,&p,&n);
    int A[m][p], B[p][n],C[m][n];
    for(int i=0;i<m;i++){
        for(int j=0;j<p;j++){
            scanf("%d",&A[i][j]);
        }
    }
    for(int i=0;i<p;i++){
        for(int j=0;j<n;j++){
            scanf("%d",&B[i][j]);
        }
    }
    pthread_t thread[m][n]; 
    int data[m*n][p+p+2]; //daca as fi lasat numai data[p+p+2]
    for(int i=0;i<m;i++){
        for(int j=0;j<n;j++){
            for(int k=0;k<p;k++){
                data[i*n+j][k]=A[i][k]; //de la 0 la p-1 avem elemente de pe o linie a lui A
                data[i*n+j][p+k]=B[k][j]; // de la p la 2*p-1 avem elemente de pe o coloana a lui B
            }
            data[i*n+j][p+p]=i;
            data[i*n+j][p+p+1]=j;
           
            if(pthread_create(&thread[i][j], NULL, inmultire, data[i*n+j])){
                perror(NULL);
                return errno;
            }
        }
    }
    void* result;
    for(int i=0;i<m;i++)
        for(int j=0;j<n;j++){
           if(pthread_join(thread[i][j], &result)){
                perror(NULL);
                return errno;
            }
            int* rez=(int*)result;
            C[i][j]=*rez;
        }
            
    for(int i=0;i<m;i++){
        for(int j=0;j<n;j++){
            //printf("%d %d |",i,j);
            printf("%d ",C[i][j]);
        }
        printf("\n");
    }

}*/
/*#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>
#include <pthread.h>
int C[10000][10000];
int m,p,n;

void *inmultire(void *vect){
    int* data=(int*)vect;
    int i=data[p+p];
    int j=data[p+p+1];
    int suma=0;
    for(int k=0;k<p;k++){
        suma+= data[k] * data [p+k];
    }
    
    C[i][j]=suma;
    return NULL;
}

int main(){
    scanf("%d%d%d",&m,&p,&n);
    int A[m][p], B[p][n];
    for(int i=0;i<m;i++){
        for(int j=0;j<p;j++){
            scanf("%d",&A[i][j]);
        }
    }
    for(int i=0;i<p;i++){
        for(int j=0;j<n;j++){
            scanf("%d",&B[i][j]);
        }
    }
    pthread_t thread[m][n]; 
    int data[m*n][p+p+2]; //daca as fi lasat numai data[p+p+2]
    for(int i=0;i<m;i++){
        for(int j=0;j<n;j++){
            for(int k=0;k<p;k++){
                data[i*m+j][k]=A[i][k]; //de la 0 la p-1 avem elemente de pe o linie a lui A
                data[i*m+j][p+k]=B[k][j]; // de la p la 2*p-1 avem elemente de pe o coloana a lui B
            }
            data[i*m+j][p+p]=i;
            data[i*m+j][p+p+1]=j;
            
            if(pthread_create(&thread[i][j], NULL, inmultire, data[i*m+j])){
                perror(NULL);
                return errno;
            }
        }
    }
    void* result;
    for(int i=0;i<m;i++)
        for(int j=0;j<n;j++)
            if(pthread_join(thread[i][j], &result)){
                perror(NULL);
                return errno;
            }
            
    for(int i=0;i<m;i++){
        for(int j=0;j<n;j++){
            printf("%d ",C[i][j]);
        }
        printf("\n");
    }

}*/