#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>
#include <pthread.h>

struct argumente{
    int i,j,p,rez;
    int* linie,coloana;
};

int main(int argc, char** argv){
    char* file_name=argv[1];
    freopen(file_name,"r",stdin);
    int m,p,n;
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
    struct argumente args[n*m];
}