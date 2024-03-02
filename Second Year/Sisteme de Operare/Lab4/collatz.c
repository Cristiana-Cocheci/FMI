
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <sys/wait.h>

int main(int argc, char *argv[]) {
    pid_t child_pid;
    child_pid=fork();
    int n=atoi(argv[1]);
    

    if (child_pid < 0) {
        perror("Eroare la fork");
        return errno;
    } else if (child_pid == 0) {
        printf("%d: ",n);
        // Suntem în procesul copil
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
    }
    else{
        wait(NULL);
        printf("Child %d finished\n",child_pid);
    }
    
    return 0;
}
