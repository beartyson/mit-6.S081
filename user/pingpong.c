#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
    int p[2];
    pipe(p);
 
    if(fork() == 0) {
        close(0);
        dup(p[0]);
        printf("%d: received ping\n",getpid());
        close(p[0]);
        write(p[1], "h", 1);
        close(p[1]);
    
    } else {
        
        write(p[1], "h", 1);
        close(p[1]);
        wait((int *) 0);
        dup(p[0]);
        printf("%d: received pong\n",getpid());
        close(p[0]);
    }

    exit(0);
}
