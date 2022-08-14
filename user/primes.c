#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"


void sieve(int pleft[2]){

    int i;

    if(read(pleft[0], &i, sizeof(i)) != 0 && i != -1){
        printf("prime %d\n",i);
    }else{
        exit(0);
    }
    
    int p[2];
    pipe(p);
    if(fork() == 0){
        close(pleft[0]);
        close(p[1]);
        sieve(p);
       
    }
    else{
        close(p[0]);

        int buf;
		while(read(pleft[0], &buf, sizeof(buf)) != 0 && buf != -1) { 
			if(buf % i != 0) { 
				write(p[1], &buf, sizeof(buf)); 
			}
		}
        buf = -1;
        write(p[1], &buf, sizeof(buf)); 
        close(pleft[0]);
        while(wait((int*) 0) != -1){};
        
  }
    

}

int
main(int argc, char *argv[])
{
  int i;
  int buf;
  int p[2];
  pipe(p);
  if(fork() == 0){
    close(p[1]);
    sieve(p);
    exit(0);
  }
    else{
        i = 2;
        buf= i;
        printf("prime %d\n",i);
        close(0);
        close(p[0]);
        for(;i <= 35; i++){
            if(i % buf != 0){
                write(p[1],&i,4);
            }
        }
        close(p[1]);
        // printf("exit 2\n");
  }

  while(wait((int*) 0) != -1){};


  exit(0);
}
