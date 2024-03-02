#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <sys/wait.h>

int main(int argc, char **argv) {
    int i=1, v[argc-1];
    while(i < argc){
        int l=strlen(argv[i]),x=0;
        int p=1;
        for(int j=l-1;j>=0;j--){ //sau cu atoi
            x+=p*(argv[i][j]-'0');
            p*=10;
        }
        v[i-1]=x;
        i++;
    }
    
    pid_t child_pid=9; //ca sa nu fie 0
    int n=argc-1,children=0;
    while(n>0 && child_pid!=0){ //verificam ca suntem in parinte (/inapoi in parinte) si ca mai avem nevoie de copii
        n--; 
        if((child_pid=fork()) >0){
            children++; //am mai facut un copil
        }
    }
    if(child_pid<0){
         perror("Eroare la fork");
         return errno;
    }
    else if(child_pid==0){
        // Suntem în procesul copil
        int n=v[children]; //alegem urmatorul numar  
        printf("%d: ",n);
        while(n!=1){
            if(n%2==0){
                n/=2;
            }
            else{
                n=3*n+1;
            }
            printf("%d ",n);
        }
        printf("\n");
        printf("Parent: %d || Child %d\n",getppid(),getpid());
    }
    else{
        //suntem in parinte
        while(children>0){
            children--; //asteptam sa termine toti copii procesele
            wait(NULL);
        }
        printf("Done || Parent: %d || Child %d\n",getppid(),getpid());
    }
    

    return 0;
}
        
    
    