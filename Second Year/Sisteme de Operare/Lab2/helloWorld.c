#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>

int main(int argc, char **argv){
	char *s = "Hello Lab2\n";
	int len= strlen(s);
	int written=0;

	while(written<len){
		written+=write(0,s + written,len);
	}

	return 0;
}
