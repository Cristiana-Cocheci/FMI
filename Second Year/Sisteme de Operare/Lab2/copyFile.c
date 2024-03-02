#include <unistd.h>
#include <errno.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <stdio.h>

int main(int argc, char **argv){
	size_t BUFSIZE=4096;
	char buf[BUFSIZE];
	char *source = argv[1];
	char *destination = argv[2];

	int src_file_descriptor = open(source, O_RDONLY); //fd==  numar  prin care programul gaseste fisierul sursa;
	if(src_file_descriptor < 0) {
		// eroare
		perror("Source file does not exist?\n");
		return errno;
	}

	int  dest_file_descriptor = open(destination, O_CREAT | O_RDWR, S_IRWXU); // flags  : create or rw, drepturi de editare cu RWX for owner
	if (dest_file_descriptor < 0){
		close(src_file_descriptor); //inchidem sursa
		perror("Something wrong with destination file\n");
		return errno;
	}

	struct stat src_stat, dest_stat; //structura de tip stat in care se afla datele despre fisiere
	if(stat(source, &src_stat)){ //se apeleaza cu referinta!
		perror("Source file info problems\n");
		close(src_file_descriptor);
		close(dest_file_descriptor);
		return errno;

	}

	if(stat(destination, &dest_stat)){
		close(src_file_descriptor);
		close(dest_file_descriptor);
		perror("Destination file info problem\n");
		return errno;
	}

	//verificam ca nu e acelasi fisier
	if(dest_stat.st_dev == src_stat.st_dev && dest_stat.st_ino== src_stat.st_ino){
		close(src_file_descriptor);
		close(dest_file_descriptor);
		perror("Same file\n");
		return errno;
	}

	size_t file_length=src_stat.st_size, already_read =0;
	while(already_read < file_length){ 
		//scriem in timp ce citim
		size_t read_now = read(src_file_descriptor, buf, BUFSIZE);
		if(read_now<0){
			close(src_file_descriptor);
			close(dest_file_descriptor);
			perror("We didn't read right?\n");
			return errno;
		}
		already_read+=read_now;
		
		size_t written=0;
		while(written<read_now){
			size_t written_now = write(dest_file_descriptor, buf+ written, read_now - written);
			if(written_now < 0){
				close(src_file_descriptor);
				close(dest_file_descriptor);
				perror("We didn't write right?\n");
				return errno;
			}
			written+=written_now;

		}
	}
	
	if(close(src_file_descriptor) <0){
		perror("We didn't close source\n");
		return errno;
	}
	if(close(dest_file_descriptor)<0){
		perror("We didn't close destination\n");
		return errno;
	}
	printf("Copy complete\n");
	return 0;
}









