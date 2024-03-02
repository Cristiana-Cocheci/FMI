#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/mman.h>

int main(int argc, char **argv) {
    char shm_name[]= "myshm";
    int shm_fd;
    shm_fd = shm_open(shm_name, O_CREAT | O_RDWR, S_IRUSR|S_IWUSR); //file descriptor ptr memorie
    if(shm_fd<0){
        perror("shm_fd");
        return errno;
    }
    int lpag=getpagesize();
    size_t shm_size = lpag * (argc-1);
    if(ftruncate(shm_fd, shm_size)==-1){ //dam dimensiunea memoriei
        perror("ftruncate");
        shm_unlink(shm_name);
        return errno;
    }
    
    //salvarea numerelor
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
    
    //incepem forkurile
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
        // ne ducem la memoria noastra
        void *shm_ptr = mmap(0, lpag, PROT_WRITE, MAP_SHARED, shm_fd, lpag*children); //alocam memorie pentru copil
        if(shm_ptr == MAP_FAILED){
            perror(NULL);
            shm_unlink(shm_name);
            return errno;
        }
        
        int n=v[children]; //alegem urmatorul numar  
        
        int index=0;
        index+= sprintf(shm_ptr + index, "%d: ",n);

        while(n!=1){
            if(n%2==0){
                n/=2;
            }
            else{
                n=3*n+1;
            }
            index+= sprintf(shm_ptr + index, "%d ", n);
        }
        
        index+= sprintf(shm_ptr + index, "\nDONE || Parent: %d || CHILD(ME) : %d\n", getppid(), getpid());
        index+= sprintf(shm_ptr + index, "\n\0");
        if(index>lpag){
            perror("dimensiune raspuns prea mare");
            shm_unlink(shm_name);
            return errno;
        }
        
    }
    else{
        //suntem in parinte
        while(children>0){
            children--; //asteptam sa termine toti copii procesele
            wait(NULL);
        }
        //citim rezultatele
        void *shm_ptr = mmap(0, shm_size, PROT_READ, MAP_SHARED, shm_fd, 0);
        void *copy=shm_ptr;
        if(shm_ptr == MAP_FAILED){
            perror(NULL);
            shm_unlink(shm_name);
            return errno;
        }
        //afisam datele
        int len_curent;
        
        for (int i = 0; i < argc-1; i++) {
            
            printf("%s", shm_ptr);
            shm_ptr +=lpag;
        }

        printf("Done || Parent: %d || Child %d\n",getppid(),getpid());
        munmap(copy,shm_size);
    }
    
   shm_unlink(shm_name);
    return 0;
}
        
    
    