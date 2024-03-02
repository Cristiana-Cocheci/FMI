
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <sys/wait.h>

int main() {
    pid_t child_pid;

    child_pid = fork();

    if (child_pid < 0) {
        perror("Eroare la fork");
        return errno;
    } else if (child_pid == 0) {
        // Suntem în procesul copil

        // Afișăm fișierele din directorul curent folosind execve(2)
        char *argv[] = {"ls", NULL};
        if (execve("/bin/ls", argv, NULL) == -1) {
            perror("Eroare la execve");
            exit(EXIT_FAILURE);
        }
    } else {
        // Suntem în procesul părinte
        printf("My PID = %d, Child PID = %d\n", getpid(), child_pid);
        wait(NULL);  // Așteptăm procesul copil să se încheie     
    }

    return 0;
}
