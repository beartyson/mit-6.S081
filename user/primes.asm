
user/_primes:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <sieve>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"


void sieve(int pleft[2]){
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	f04a                	sd	s2,32(sp)
   a:	0080                	addi	s0,sp,64
   c:	84aa                	mv	s1,a0

    int i;

    if(read(pleft[0], &i, sizeof(i)) != 0 && i != -1){
   e:	4611                	li	a2,4
  10:	fdc40593          	addi	a1,s0,-36
  14:	4108                	lw	a0,0(a0)
  16:	00000097          	auipc	ra,0x0
  1a:	444080e7          	jalr	1092(ra) # 45a <read>
  1e:	cd25                	beqz	a0,96 <sieve+0x96>
  20:	fdc42583          	lw	a1,-36(s0)
  24:	57fd                	li	a5,-1
  26:	06f58863          	beq	a1,a5,96 <sieve+0x96>
        printf("prime %d\n",i);
  2a:	00001517          	auipc	a0,0x1
  2e:	93650513          	addi	a0,a0,-1738 # 960 <malloc+0xe8>
  32:	00000097          	auipc	ra,0x0
  36:	788080e7          	jalr	1928(ra) # 7ba <printf>
    }else{
        exit(0);
    }
    
    int p[2];
    pipe(p);
  3a:	fd040513          	addi	a0,s0,-48
  3e:	00000097          	auipc	ra,0x0
  42:	414080e7          	jalr	1044(ra) # 452 <pipe>
    if(fork() == 0){
  46:	00000097          	auipc	ra,0x0
  4a:	3f4080e7          	jalr	1012(ra) # 43a <fork>
  4e:	c929                	beqz	a0,a0 <sieve+0xa0>
        close(p[1]);
        sieve(p);
       
    }
    else{
        close(p[0]);
  50:	fd042503          	lw	a0,-48(s0)
  54:	00000097          	auipc	ra,0x0
  58:	416080e7          	jalr	1046(ra) # 46a <close>

        int buf;
		while(read(pleft[0], &buf, sizeof(buf)) != 0 && buf != -1) { 
  5c:	597d                	li	s2,-1
  5e:	4611                	li	a2,4
  60:	fcc40593          	addi	a1,s0,-52
  64:	4088                	lw	a0,0(s1)
  66:	00000097          	auipc	ra,0x0
  6a:	3f4080e7          	jalr	1012(ra) # 45a <read>
  6e:	c939                	beqz	a0,c4 <sieve+0xc4>
  70:	fcc42783          	lw	a5,-52(s0)
  74:	05278863          	beq	a5,s2,c4 <sieve+0xc4>
			if(buf % i != 0) { 
  78:	fdc42703          	lw	a4,-36(s0)
  7c:	02e7e7bb          	remw	a5,a5,a4
  80:	dff9                	beqz	a5,5e <sieve+0x5e>
				write(p[1], &buf, sizeof(buf)); 
  82:	4611                	li	a2,4
  84:	fcc40593          	addi	a1,s0,-52
  88:	fd442503          	lw	a0,-44(s0)
  8c:	00000097          	auipc	ra,0x0
  90:	3d6080e7          	jalr	982(ra) # 462 <write>
  94:	b7e9                	j	5e <sieve+0x5e>
        exit(0);
  96:	4501                	li	a0,0
  98:	00000097          	auipc	ra,0x0
  9c:	3aa080e7          	jalr	938(ra) # 442 <exit>
        close(pleft[0]);
  a0:	4088                	lw	a0,0(s1)
  a2:	00000097          	auipc	ra,0x0
  a6:	3c8080e7          	jalr	968(ra) # 46a <close>
        close(p[1]);
  aa:	fd442503          	lw	a0,-44(s0)
  ae:	00000097          	auipc	ra,0x0
  b2:	3bc080e7          	jalr	956(ra) # 46a <close>
        sieve(p);
  b6:	fd040513          	addi	a0,s0,-48
  ba:	00000097          	auipc	ra,0x0
  be:	f46080e7          	jalr	-186(ra) # 0 <sieve>
  c2:	a815                	j	f6 <sieve+0xf6>
			}
		}
        buf = -1;
  c4:	57fd                	li	a5,-1
  c6:	fcf42623          	sw	a5,-52(s0)
        write(p[1], &buf, sizeof(buf)); 
  ca:	4611                	li	a2,4
  cc:	fcc40593          	addi	a1,s0,-52
  d0:	fd442503          	lw	a0,-44(s0)
  d4:	00000097          	auipc	ra,0x0
  d8:	38e080e7          	jalr	910(ra) # 462 <write>
        close(pleft[0]);
  dc:	4088                	lw	a0,0(s1)
  de:	00000097          	auipc	ra,0x0
  e2:	38c080e7          	jalr	908(ra) # 46a <close>
        while(wait((int*) 0) != -1){};
  e6:	54fd                	li	s1,-1
  e8:	4501                	li	a0,0
  ea:	00000097          	auipc	ra,0x0
  ee:	360080e7          	jalr	864(ra) # 44a <wait>
  f2:	fe951be3          	bne	a0,s1,e8 <sieve+0xe8>
        
  }
    

}
  f6:	70e2                	ld	ra,56(sp)
  f8:	7442                	ld	s0,48(sp)
  fa:	74a2                	ld	s1,40(sp)
  fc:	7902                	ld	s2,32(sp)
  fe:	6121                	addi	sp,sp,64
 100:	8082                	ret

0000000000000102 <main>:

int
main(int argc, char *argv[])
{
 102:	7179                	addi	sp,sp,-48
 104:	f406                	sd	ra,40(sp)
 106:	f022                	sd	s0,32(sp)
 108:	ec26                	sd	s1,24(sp)
 10a:	1800                	addi	s0,sp,48
  int i;
  int buf;
  int p[2];
  pipe(p);
 10c:	fd040513          	addi	a0,s0,-48
 110:	00000097          	auipc	ra,0x0
 114:	342080e7          	jalr	834(ra) # 452 <pipe>
  if(fork() == 0){
 118:	00000097          	auipc	ra,0x0
 11c:	322080e7          	jalr	802(ra) # 43a <fork>
 120:	e115                	bnez	a0,144 <main+0x42>
    close(p[1]);
 122:	fd442503          	lw	a0,-44(s0)
 126:	00000097          	auipc	ra,0x0
 12a:	344080e7          	jalr	836(ra) # 46a <close>
    sieve(p);
 12e:	fd040513          	addi	a0,s0,-48
 132:	00000097          	auipc	ra,0x0
 136:	ece080e7          	jalr	-306(ra) # 0 <sieve>
    exit(0);
 13a:	4501                	li	a0,0
 13c:	00000097          	auipc	ra,0x0
 140:	306080e7          	jalr	774(ra) # 442 <exit>
  }
    else{
        i = 2;
 144:	4789                	li	a5,2
 146:	fcf42e23          	sw	a5,-36(s0)
        buf= i;
        printf("prime %d\n",i);
 14a:	4589                	li	a1,2
 14c:	00001517          	auipc	a0,0x1
 150:	81450513          	addi	a0,a0,-2028 # 960 <malloc+0xe8>
 154:	00000097          	auipc	ra,0x0
 158:	666080e7          	jalr	1638(ra) # 7ba <printf>
        close(0);
 15c:	4501                	li	a0,0
 15e:	00000097          	auipc	ra,0x0
 162:	30c080e7          	jalr	780(ra) # 46a <close>
        close(p[0]);
 166:	fd042503          	lw	a0,-48(s0)
 16a:	00000097          	auipc	ra,0x0
 16e:	300080e7          	jalr	768(ra) # 46a <close>
        for(;i <= 35; i++){
 172:	fdc42783          	lw	a5,-36(s0)
 176:	02300713          	li	a4,35
 17a:	02f74a63          	blt	a4,a5,1ae <main+0xac>
 17e:	02300493          	li	s1,35
 182:	a811                	j	196 <main+0x94>
 184:	fdc42703          	lw	a4,-36(s0)
 188:	2705                	addiw	a4,a4,1
 18a:	0007079b          	sext.w	a5,a4
 18e:	fce42e23          	sw	a4,-36(s0)
 192:	00f4ce63          	blt	s1,a5,1ae <main+0xac>
            if(i % buf != 0){
 196:	8b85                	andi	a5,a5,1
 198:	d7f5                	beqz	a5,184 <main+0x82>
                write(p[1],&i,4);
 19a:	4611                	li	a2,4
 19c:	fdc40593          	addi	a1,s0,-36
 1a0:	fd442503          	lw	a0,-44(s0)
 1a4:	00000097          	auipc	ra,0x0
 1a8:	2be080e7          	jalr	702(ra) # 462 <write>
 1ac:	bfe1                	j	184 <main+0x82>
            }
        }
        close(p[1]);
 1ae:	fd442503          	lw	a0,-44(s0)
 1b2:	00000097          	auipc	ra,0x0
 1b6:	2b8080e7          	jalr	696(ra) # 46a <close>
        // printf("exit 2\n");
  }

  while(wait((int*) 0) != -1){};
 1ba:	54fd                	li	s1,-1
 1bc:	4501                	li	a0,0
 1be:	00000097          	auipc	ra,0x0
 1c2:	28c080e7          	jalr	652(ra) # 44a <wait>
 1c6:	fe951be3          	bne	a0,s1,1bc <main+0xba>


  exit(0);
 1ca:	4501                	li	a0,0
 1cc:	00000097          	auipc	ra,0x0
 1d0:	276080e7          	jalr	630(ra) # 442 <exit>

00000000000001d4 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 1d4:	1141                	addi	sp,sp,-16
 1d6:	e422                	sd	s0,8(sp)
 1d8:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1da:	87aa                	mv	a5,a0
 1dc:	0585                	addi	a1,a1,1
 1de:	0785                	addi	a5,a5,1
 1e0:	fff5c703          	lbu	a4,-1(a1)
 1e4:	fee78fa3          	sb	a4,-1(a5)
 1e8:	fb75                	bnez	a4,1dc <strcpy+0x8>
    ;
  return os;
}
 1ea:	6422                	ld	s0,8(sp)
 1ec:	0141                	addi	sp,sp,16
 1ee:	8082                	ret

00000000000001f0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1f0:	1141                	addi	sp,sp,-16
 1f2:	e422                	sd	s0,8(sp)
 1f4:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1f6:	00054783          	lbu	a5,0(a0)
 1fa:	cb91                	beqz	a5,20e <strcmp+0x1e>
 1fc:	0005c703          	lbu	a4,0(a1)
 200:	00f71763          	bne	a4,a5,20e <strcmp+0x1e>
    p++, q++;
 204:	0505                	addi	a0,a0,1
 206:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 208:	00054783          	lbu	a5,0(a0)
 20c:	fbe5                	bnez	a5,1fc <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 20e:	0005c503          	lbu	a0,0(a1)
}
 212:	40a7853b          	subw	a0,a5,a0
 216:	6422                	ld	s0,8(sp)
 218:	0141                	addi	sp,sp,16
 21a:	8082                	ret

000000000000021c <strlen>:

uint
strlen(const char *s)
{
 21c:	1141                	addi	sp,sp,-16
 21e:	e422                	sd	s0,8(sp)
 220:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 222:	00054783          	lbu	a5,0(a0)
 226:	cf91                	beqz	a5,242 <strlen+0x26>
 228:	0505                	addi	a0,a0,1
 22a:	87aa                	mv	a5,a0
 22c:	4685                	li	a3,1
 22e:	9e89                	subw	a3,a3,a0
 230:	00f6853b          	addw	a0,a3,a5
 234:	0785                	addi	a5,a5,1
 236:	fff7c703          	lbu	a4,-1(a5)
 23a:	fb7d                	bnez	a4,230 <strlen+0x14>
    ;
  return n;
}
 23c:	6422                	ld	s0,8(sp)
 23e:	0141                	addi	sp,sp,16
 240:	8082                	ret
  for(n = 0; s[n]; n++)
 242:	4501                	li	a0,0
 244:	bfe5                	j	23c <strlen+0x20>

0000000000000246 <memset>:

void*
memset(void *dst, int c, uint n)
{
 246:	1141                	addi	sp,sp,-16
 248:	e422                	sd	s0,8(sp)
 24a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 24c:	ca19                	beqz	a2,262 <memset+0x1c>
 24e:	87aa                	mv	a5,a0
 250:	1602                	slli	a2,a2,0x20
 252:	9201                	srli	a2,a2,0x20
 254:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 258:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 25c:	0785                	addi	a5,a5,1
 25e:	fee79de3          	bne	a5,a4,258 <memset+0x12>
  }
  return dst;
}
 262:	6422                	ld	s0,8(sp)
 264:	0141                	addi	sp,sp,16
 266:	8082                	ret

0000000000000268 <strchr>:

char*
strchr(const char *s, char c)
{
 268:	1141                	addi	sp,sp,-16
 26a:	e422                	sd	s0,8(sp)
 26c:	0800                	addi	s0,sp,16
  for(; *s; s++)
 26e:	00054783          	lbu	a5,0(a0)
 272:	cb99                	beqz	a5,288 <strchr+0x20>
    if(*s == c)
 274:	00f58763          	beq	a1,a5,282 <strchr+0x1a>
  for(; *s; s++)
 278:	0505                	addi	a0,a0,1
 27a:	00054783          	lbu	a5,0(a0)
 27e:	fbfd                	bnez	a5,274 <strchr+0xc>
      return (char*)s;
  return 0;
 280:	4501                	li	a0,0
}
 282:	6422                	ld	s0,8(sp)
 284:	0141                	addi	sp,sp,16
 286:	8082                	ret
  return 0;
 288:	4501                	li	a0,0
 28a:	bfe5                	j	282 <strchr+0x1a>

000000000000028c <gets>:

char*
gets(char *buf, int max)
{
 28c:	711d                	addi	sp,sp,-96
 28e:	ec86                	sd	ra,88(sp)
 290:	e8a2                	sd	s0,80(sp)
 292:	e4a6                	sd	s1,72(sp)
 294:	e0ca                	sd	s2,64(sp)
 296:	fc4e                	sd	s3,56(sp)
 298:	f852                	sd	s4,48(sp)
 29a:	f456                	sd	s5,40(sp)
 29c:	f05a                	sd	s6,32(sp)
 29e:	ec5e                	sd	s7,24(sp)
 2a0:	1080                	addi	s0,sp,96
 2a2:	8baa                	mv	s7,a0
 2a4:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2a6:	892a                	mv	s2,a0
 2a8:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2aa:	4aa9                	li	s5,10
 2ac:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 2ae:	89a6                	mv	s3,s1
 2b0:	2485                	addiw	s1,s1,1
 2b2:	0344d863          	bge	s1,s4,2e2 <gets+0x56>
    cc = read(0, &c, 1);
 2b6:	4605                	li	a2,1
 2b8:	faf40593          	addi	a1,s0,-81
 2bc:	4501                	li	a0,0
 2be:	00000097          	auipc	ra,0x0
 2c2:	19c080e7          	jalr	412(ra) # 45a <read>
    if(cc < 1)
 2c6:	00a05e63          	blez	a0,2e2 <gets+0x56>
    buf[i++] = c;
 2ca:	faf44783          	lbu	a5,-81(s0)
 2ce:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2d2:	01578763          	beq	a5,s5,2e0 <gets+0x54>
 2d6:	0905                	addi	s2,s2,1
 2d8:	fd679be3          	bne	a5,s6,2ae <gets+0x22>
  for(i=0; i+1 < max; ){
 2dc:	89a6                	mv	s3,s1
 2de:	a011                	j	2e2 <gets+0x56>
 2e0:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2e2:	99de                	add	s3,s3,s7
 2e4:	00098023          	sb	zero,0(s3)
  return buf;
}
 2e8:	855e                	mv	a0,s7
 2ea:	60e6                	ld	ra,88(sp)
 2ec:	6446                	ld	s0,80(sp)
 2ee:	64a6                	ld	s1,72(sp)
 2f0:	6906                	ld	s2,64(sp)
 2f2:	79e2                	ld	s3,56(sp)
 2f4:	7a42                	ld	s4,48(sp)
 2f6:	7aa2                	ld	s5,40(sp)
 2f8:	7b02                	ld	s6,32(sp)
 2fa:	6be2                	ld	s7,24(sp)
 2fc:	6125                	addi	sp,sp,96
 2fe:	8082                	ret

0000000000000300 <stat>:

int
stat(const char *n, struct stat *st)
{
 300:	1101                	addi	sp,sp,-32
 302:	ec06                	sd	ra,24(sp)
 304:	e822                	sd	s0,16(sp)
 306:	e426                	sd	s1,8(sp)
 308:	e04a                	sd	s2,0(sp)
 30a:	1000                	addi	s0,sp,32
 30c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 30e:	4581                	li	a1,0
 310:	00000097          	auipc	ra,0x0
 314:	172080e7          	jalr	370(ra) # 482 <open>
  if(fd < 0)
 318:	02054563          	bltz	a0,342 <stat+0x42>
 31c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 31e:	85ca                	mv	a1,s2
 320:	00000097          	auipc	ra,0x0
 324:	17a080e7          	jalr	378(ra) # 49a <fstat>
 328:	892a                	mv	s2,a0
  close(fd);
 32a:	8526                	mv	a0,s1
 32c:	00000097          	auipc	ra,0x0
 330:	13e080e7          	jalr	318(ra) # 46a <close>
  return r;
}
 334:	854a                	mv	a0,s2
 336:	60e2                	ld	ra,24(sp)
 338:	6442                	ld	s0,16(sp)
 33a:	64a2                	ld	s1,8(sp)
 33c:	6902                	ld	s2,0(sp)
 33e:	6105                	addi	sp,sp,32
 340:	8082                	ret
    return -1;
 342:	597d                	li	s2,-1
 344:	bfc5                	j	334 <stat+0x34>

0000000000000346 <atoi>:

int
atoi(const char *s)
{
 346:	1141                	addi	sp,sp,-16
 348:	e422                	sd	s0,8(sp)
 34a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 34c:	00054603          	lbu	a2,0(a0)
 350:	fd06079b          	addiw	a5,a2,-48
 354:	0ff7f793          	andi	a5,a5,255
 358:	4725                	li	a4,9
 35a:	02f76963          	bltu	a4,a5,38c <atoi+0x46>
 35e:	86aa                	mv	a3,a0
  n = 0;
 360:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 362:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 364:	0685                	addi	a3,a3,1
 366:	0025179b          	slliw	a5,a0,0x2
 36a:	9fa9                	addw	a5,a5,a0
 36c:	0017979b          	slliw	a5,a5,0x1
 370:	9fb1                	addw	a5,a5,a2
 372:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 376:	0006c603          	lbu	a2,0(a3)
 37a:	fd06071b          	addiw	a4,a2,-48
 37e:	0ff77713          	andi	a4,a4,255
 382:	fee5f1e3          	bgeu	a1,a4,364 <atoi+0x1e>
  return n;
}
 386:	6422                	ld	s0,8(sp)
 388:	0141                	addi	sp,sp,16
 38a:	8082                	ret
  n = 0;
 38c:	4501                	li	a0,0
 38e:	bfe5                	j	386 <atoi+0x40>

0000000000000390 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 390:	1141                	addi	sp,sp,-16
 392:	e422                	sd	s0,8(sp)
 394:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 396:	02b57463          	bgeu	a0,a1,3be <memmove+0x2e>
    while(n-- > 0)
 39a:	00c05f63          	blez	a2,3b8 <memmove+0x28>
 39e:	1602                	slli	a2,a2,0x20
 3a0:	9201                	srli	a2,a2,0x20
 3a2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 3a6:	872a                	mv	a4,a0
      *dst++ = *src++;
 3a8:	0585                	addi	a1,a1,1
 3aa:	0705                	addi	a4,a4,1
 3ac:	fff5c683          	lbu	a3,-1(a1)
 3b0:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3b4:	fee79ae3          	bne	a5,a4,3a8 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3b8:	6422                	ld	s0,8(sp)
 3ba:	0141                	addi	sp,sp,16
 3bc:	8082                	ret
    dst += n;
 3be:	00c50733          	add	a4,a0,a2
    src += n;
 3c2:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3c4:	fec05ae3          	blez	a2,3b8 <memmove+0x28>
 3c8:	fff6079b          	addiw	a5,a2,-1
 3cc:	1782                	slli	a5,a5,0x20
 3ce:	9381                	srli	a5,a5,0x20
 3d0:	fff7c793          	not	a5,a5
 3d4:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3d6:	15fd                	addi	a1,a1,-1
 3d8:	177d                	addi	a4,a4,-1
 3da:	0005c683          	lbu	a3,0(a1)
 3de:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3e2:	fee79ae3          	bne	a5,a4,3d6 <memmove+0x46>
 3e6:	bfc9                	j	3b8 <memmove+0x28>

00000000000003e8 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3e8:	1141                	addi	sp,sp,-16
 3ea:	e422                	sd	s0,8(sp)
 3ec:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3ee:	ca05                	beqz	a2,41e <memcmp+0x36>
 3f0:	fff6069b          	addiw	a3,a2,-1
 3f4:	1682                	slli	a3,a3,0x20
 3f6:	9281                	srli	a3,a3,0x20
 3f8:	0685                	addi	a3,a3,1
 3fa:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3fc:	00054783          	lbu	a5,0(a0)
 400:	0005c703          	lbu	a4,0(a1)
 404:	00e79863          	bne	a5,a4,414 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 408:	0505                	addi	a0,a0,1
    p2++;
 40a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 40c:	fed518e3          	bne	a0,a3,3fc <memcmp+0x14>
  }
  return 0;
 410:	4501                	li	a0,0
 412:	a019                	j	418 <memcmp+0x30>
      return *p1 - *p2;
 414:	40e7853b          	subw	a0,a5,a4
}
 418:	6422                	ld	s0,8(sp)
 41a:	0141                	addi	sp,sp,16
 41c:	8082                	ret
  return 0;
 41e:	4501                	li	a0,0
 420:	bfe5                	j	418 <memcmp+0x30>

0000000000000422 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 422:	1141                	addi	sp,sp,-16
 424:	e406                	sd	ra,8(sp)
 426:	e022                	sd	s0,0(sp)
 428:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 42a:	00000097          	auipc	ra,0x0
 42e:	f66080e7          	jalr	-154(ra) # 390 <memmove>
}
 432:	60a2                	ld	ra,8(sp)
 434:	6402                	ld	s0,0(sp)
 436:	0141                	addi	sp,sp,16
 438:	8082                	ret

000000000000043a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 43a:	4885                	li	a7,1
 ecall
 43c:	00000073          	ecall
 ret
 440:	8082                	ret

0000000000000442 <exit>:
.global exit
exit:
 li a7, SYS_exit
 442:	4889                	li	a7,2
 ecall
 444:	00000073          	ecall
 ret
 448:	8082                	ret

000000000000044a <wait>:
.global wait
wait:
 li a7, SYS_wait
 44a:	488d                	li	a7,3
 ecall
 44c:	00000073          	ecall
 ret
 450:	8082                	ret

0000000000000452 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 452:	4891                	li	a7,4
 ecall
 454:	00000073          	ecall
 ret
 458:	8082                	ret

000000000000045a <read>:
.global read
read:
 li a7, SYS_read
 45a:	4895                	li	a7,5
 ecall
 45c:	00000073          	ecall
 ret
 460:	8082                	ret

0000000000000462 <write>:
.global write
write:
 li a7, SYS_write
 462:	48c1                	li	a7,16
 ecall
 464:	00000073          	ecall
 ret
 468:	8082                	ret

000000000000046a <close>:
.global close
close:
 li a7, SYS_close
 46a:	48d5                	li	a7,21
 ecall
 46c:	00000073          	ecall
 ret
 470:	8082                	ret

0000000000000472 <kill>:
.global kill
kill:
 li a7, SYS_kill
 472:	4899                	li	a7,6
 ecall
 474:	00000073          	ecall
 ret
 478:	8082                	ret

000000000000047a <exec>:
.global exec
exec:
 li a7, SYS_exec
 47a:	489d                	li	a7,7
 ecall
 47c:	00000073          	ecall
 ret
 480:	8082                	ret

0000000000000482 <open>:
.global open
open:
 li a7, SYS_open
 482:	48bd                	li	a7,15
 ecall
 484:	00000073          	ecall
 ret
 488:	8082                	ret

000000000000048a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 48a:	48c5                	li	a7,17
 ecall
 48c:	00000073          	ecall
 ret
 490:	8082                	ret

0000000000000492 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 492:	48c9                	li	a7,18
 ecall
 494:	00000073          	ecall
 ret
 498:	8082                	ret

000000000000049a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 49a:	48a1                	li	a7,8
 ecall
 49c:	00000073          	ecall
 ret
 4a0:	8082                	ret

00000000000004a2 <link>:
.global link
link:
 li a7, SYS_link
 4a2:	48cd                	li	a7,19
 ecall
 4a4:	00000073          	ecall
 ret
 4a8:	8082                	ret

00000000000004aa <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4aa:	48d1                	li	a7,20
 ecall
 4ac:	00000073          	ecall
 ret
 4b0:	8082                	ret

00000000000004b2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4b2:	48a5                	li	a7,9
 ecall
 4b4:	00000073          	ecall
 ret
 4b8:	8082                	ret

00000000000004ba <dup>:
.global dup
dup:
 li a7, SYS_dup
 4ba:	48a9                	li	a7,10
 ecall
 4bc:	00000073          	ecall
 ret
 4c0:	8082                	ret

00000000000004c2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4c2:	48ad                	li	a7,11
 ecall
 4c4:	00000073          	ecall
 ret
 4c8:	8082                	ret

00000000000004ca <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4ca:	48b1                	li	a7,12
 ecall
 4cc:	00000073          	ecall
 ret
 4d0:	8082                	ret

00000000000004d2 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4d2:	48b5                	li	a7,13
 ecall
 4d4:	00000073          	ecall
 ret
 4d8:	8082                	ret

00000000000004da <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4da:	48b9                	li	a7,14
 ecall
 4dc:	00000073          	ecall
 ret
 4e0:	8082                	ret

00000000000004e2 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4e2:	1101                	addi	sp,sp,-32
 4e4:	ec06                	sd	ra,24(sp)
 4e6:	e822                	sd	s0,16(sp)
 4e8:	1000                	addi	s0,sp,32
 4ea:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4ee:	4605                	li	a2,1
 4f0:	fef40593          	addi	a1,s0,-17
 4f4:	00000097          	auipc	ra,0x0
 4f8:	f6e080e7          	jalr	-146(ra) # 462 <write>
}
 4fc:	60e2                	ld	ra,24(sp)
 4fe:	6442                	ld	s0,16(sp)
 500:	6105                	addi	sp,sp,32
 502:	8082                	ret

0000000000000504 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 504:	7139                	addi	sp,sp,-64
 506:	fc06                	sd	ra,56(sp)
 508:	f822                	sd	s0,48(sp)
 50a:	f426                	sd	s1,40(sp)
 50c:	f04a                	sd	s2,32(sp)
 50e:	ec4e                	sd	s3,24(sp)
 510:	0080                	addi	s0,sp,64
 512:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 514:	c299                	beqz	a3,51a <printint+0x16>
 516:	0805c863          	bltz	a1,5a6 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 51a:	2581                	sext.w	a1,a1
  neg = 0;
 51c:	4881                	li	a7,0
 51e:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 522:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 524:	2601                	sext.w	a2,a2
 526:	00000517          	auipc	a0,0x0
 52a:	45250513          	addi	a0,a0,1106 # 978 <digits>
 52e:	883a                	mv	a6,a4
 530:	2705                	addiw	a4,a4,1
 532:	02c5f7bb          	remuw	a5,a1,a2
 536:	1782                	slli	a5,a5,0x20
 538:	9381                	srli	a5,a5,0x20
 53a:	97aa                	add	a5,a5,a0
 53c:	0007c783          	lbu	a5,0(a5)
 540:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 544:	0005879b          	sext.w	a5,a1
 548:	02c5d5bb          	divuw	a1,a1,a2
 54c:	0685                	addi	a3,a3,1
 54e:	fec7f0e3          	bgeu	a5,a2,52e <printint+0x2a>
  if(neg)
 552:	00088b63          	beqz	a7,568 <printint+0x64>
    buf[i++] = '-';
 556:	fd040793          	addi	a5,s0,-48
 55a:	973e                	add	a4,a4,a5
 55c:	02d00793          	li	a5,45
 560:	fef70823          	sb	a5,-16(a4)
 564:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 568:	02e05863          	blez	a4,598 <printint+0x94>
 56c:	fc040793          	addi	a5,s0,-64
 570:	00e78933          	add	s2,a5,a4
 574:	fff78993          	addi	s3,a5,-1
 578:	99ba                	add	s3,s3,a4
 57a:	377d                	addiw	a4,a4,-1
 57c:	1702                	slli	a4,a4,0x20
 57e:	9301                	srli	a4,a4,0x20
 580:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 584:	fff94583          	lbu	a1,-1(s2)
 588:	8526                	mv	a0,s1
 58a:	00000097          	auipc	ra,0x0
 58e:	f58080e7          	jalr	-168(ra) # 4e2 <putc>
  while(--i >= 0)
 592:	197d                	addi	s2,s2,-1
 594:	ff3918e3          	bne	s2,s3,584 <printint+0x80>
}
 598:	70e2                	ld	ra,56(sp)
 59a:	7442                	ld	s0,48(sp)
 59c:	74a2                	ld	s1,40(sp)
 59e:	7902                	ld	s2,32(sp)
 5a0:	69e2                	ld	s3,24(sp)
 5a2:	6121                	addi	sp,sp,64
 5a4:	8082                	ret
    x = -xx;
 5a6:	40b005bb          	negw	a1,a1
    neg = 1;
 5aa:	4885                	li	a7,1
    x = -xx;
 5ac:	bf8d                	j	51e <printint+0x1a>

00000000000005ae <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5ae:	7119                	addi	sp,sp,-128
 5b0:	fc86                	sd	ra,120(sp)
 5b2:	f8a2                	sd	s0,112(sp)
 5b4:	f4a6                	sd	s1,104(sp)
 5b6:	f0ca                	sd	s2,96(sp)
 5b8:	ecce                	sd	s3,88(sp)
 5ba:	e8d2                	sd	s4,80(sp)
 5bc:	e4d6                	sd	s5,72(sp)
 5be:	e0da                	sd	s6,64(sp)
 5c0:	fc5e                	sd	s7,56(sp)
 5c2:	f862                	sd	s8,48(sp)
 5c4:	f466                	sd	s9,40(sp)
 5c6:	f06a                	sd	s10,32(sp)
 5c8:	ec6e                	sd	s11,24(sp)
 5ca:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5cc:	0005c903          	lbu	s2,0(a1)
 5d0:	18090f63          	beqz	s2,76e <vprintf+0x1c0>
 5d4:	8aaa                	mv	s5,a0
 5d6:	8b32                	mv	s6,a2
 5d8:	00158493          	addi	s1,a1,1
  state = 0;
 5dc:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5de:	02500a13          	li	s4,37
      if(c == 'd'){
 5e2:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 5e6:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 5ea:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 5ee:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5f2:	00000b97          	auipc	s7,0x0
 5f6:	386b8b93          	addi	s7,s7,902 # 978 <digits>
 5fa:	a839                	j	618 <vprintf+0x6a>
        putc(fd, c);
 5fc:	85ca                	mv	a1,s2
 5fe:	8556                	mv	a0,s5
 600:	00000097          	auipc	ra,0x0
 604:	ee2080e7          	jalr	-286(ra) # 4e2 <putc>
 608:	a019                	j	60e <vprintf+0x60>
    } else if(state == '%'){
 60a:	01498f63          	beq	s3,s4,628 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 60e:	0485                	addi	s1,s1,1
 610:	fff4c903          	lbu	s2,-1(s1)
 614:	14090d63          	beqz	s2,76e <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 618:	0009079b          	sext.w	a5,s2
    if(state == 0){
 61c:	fe0997e3          	bnez	s3,60a <vprintf+0x5c>
      if(c == '%'){
 620:	fd479ee3          	bne	a5,s4,5fc <vprintf+0x4e>
        state = '%';
 624:	89be                	mv	s3,a5
 626:	b7e5                	j	60e <vprintf+0x60>
      if(c == 'd'){
 628:	05878063          	beq	a5,s8,668 <vprintf+0xba>
      } else if(c == 'l') {
 62c:	05978c63          	beq	a5,s9,684 <vprintf+0xd6>
      } else if(c == 'x') {
 630:	07a78863          	beq	a5,s10,6a0 <vprintf+0xf2>
      } else if(c == 'p') {
 634:	09b78463          	beq	a5,s11,6bc <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 638:	07300713          	li	a4,115
 63c:	0ce78663          	beq	a5,a4,708 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 640:	06300713          	li	a4,99
 644:	0ee78e63          	beq	a5,a4,740 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 648:	11478863          	beq	a5,s4,758 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 64c:	85d2                	mv	a1,s4
 64e:	8556                	mv	a0,s5
 650:	00000097          	auipc	ra,0x0
 654:	e92080e7          	jalr	-366(ra) # 4e2 <putc>
        putc(fd, c);
 658:	85ca                	mv	a1,s2
 65a:	8556                	mv	a0,s5
 65c:	00000097          	auipc	ra,0x0
 660:	e86080e7          	jalr	-378(ra) # 4e2 <putc>
      }
      state = 0;
 664:	4981                	li	s3,0
 666:	b765                	j	60e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 668:	008b0913          	addi	s2,s6,8
 66c:	4685                	li	a3,1
 66e:	4629                	li	a2,10
 670:	000b2583          	lw	a1,0(s6)
 674:	8556                	mv	a0,s5
 676:	00000097          	auipc	ra,0x0
 67a:	e8e080e7          	jalr	-370(ra) # 504 <printint>
 67e:	8b4a                	mv	s6,s2
      state = 0;
 680:	4981                	li	s3,0
 682:	b771                	j	60e <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 684:	008b0913          	addi	s2,s6,8
 688:	4681                	li	a3,0
 68a:	4629                	li	a2,10
 68c:	000b2583          	lw	a1,0(s6)
 690:	8556                	mv	a0,s5
 692:	00000097          	auipc	ra,0x0
 696:	e72080e7          	jalr	-398(ra) # 504 <printint>
 69a:	8b4a                	mv	s6,s2
      state = 0;
 69c:	4981                	li	s3,0
 69e:	bf85                	j	60e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 6a0:	008b0913          	addi	s2,s6,8
 6a4:	4681                	li	a3,0
 6a6:	4641                	li	a2,16
 6a8:	000b2583          	lw	a1,0(s6)
 6ac:	8556                	mv	a0,s5
 6ae:	00000097          	auipc	ra,0x0
 6b2:	e56080e7          	jalr	-426(ra) # 504 <printint>
 6b6:	8b4a                	mv	s6,s2
      state = 0;
 6b8:	4981                	li	s3,0
 6ba:	bf91                	j	60e <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 6bc:	008b0793          	addi	a5,s6,8
 6c0:	f8f43423          	sd	a5,-120(s0)
 6c4:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 6c8:	03000593          	li	a1,48
 6cc:	8556                	mv	a0,s5
 6ce:	00000097          	auipc	ra,0x0
 6d2:	e14080e7          	jalr	-492(ra) # 4e2 <putc>
  putc(fd, 'x');
 6d6:	85ea                	mv	a1,s10
 6d8:	8556                	mv	a0,s5
 6da:	00000097          	auipc	ra,0x0
 6de:	e08080e7          	jalr	-504(ra) # 4e2 <putc>
 6e2:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6e4:	03c9d793          	srli	a5,s3,0x3c
 6e8:	97de                	add	a5,a5,s7
 6ea:	0007c583          	lbu	a1,0(a5)
 6ee:	8556                	mv	a0,s5
 6f0:	00000097          	auipc	ra,0x0
 6f4:	df2080e7          	jalr	-526(ra) # 4e2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6f8:	0992                	slli	s3,s3,0x4
 6fa:	397d                	addiw	s2,s2,-1
 6fc:	fe0914e3          	bnez	s2,6e4 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 700:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 704:	4981                	li	s3,0
 706:	b721                	j	60e <vprintf+0x60>
        s = va_arg(ap, char*);
 708:	008b0993          	addi	s3,s6,8
 70c:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 710:	02090163          	beqz	s2,732 <vprintf+0x184>
        while(*s != 0){
 714:	00094583          	lbu	a1,0(s2)
 718:	c9a1                	beqz	a1,768 <vprintf+0x1ba>
          putc(fd, *s);
 71a:	8556                	mv	a0,s5
 71c:	00000097          	auipc	ra,0x0
 720:	dc6080e7          	jalr	-570(ra) # 4e2 <putc>
          s++;
 724:	0905                	addi	s2,s2,1
        while(*s != 0){
 726:	00094583          	lbu	a1,0(s2)
 72a:	f9e5                	bnez	a1,71a <vprintf+0x16c>
        s = va_arg(ap, char*);
 72c:	8b4e                	mv	s6,s3
      state = 0;
 72e:	4981                	li	s3,0
 730:	bdf9                	j	60e <vprintf+0x60>
          s = "(null)";
 732:	00000917          	auipc	s2,0x0
 736:	23e90913          	addi	s2,s2,574 # 970 <malloc+0xf8>
        while(*s != 0){
 73a:	02800593          	li	a1,40
 73e:	bff1                	j	71a <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 740:	008b0913          	addi	s2,s6,8
 744:	000b4583          	lbu	a1,0(s6)
 748:	8556                	mv	a0,s5
 74a:	00000097          	auipc	ra,0x0
 74e:	d98080e7          	jalr	-616(ra) # 4e2 <putc>
 752:	8b4a                	mv	s6,s2
      state = 0;
 754:	4981                	li	s3,0
 756:	bd65                	j	60e <vprintf+0x60>
        putc(fd, c);
 758:	85d2                	mv	a1,s4
 75a:	8556                	mv	a0,s5
 75c:	00000097          	auipc	ra,0x0
 760:	d86080e7          	jalr	-634(ra) # 4e2 <putc>
      state = 0;
 764:	4981                	li	s3,0
 766:	b565                	j	60e <vprintf+0x60>
        s = va_arg(ap, char*);
 768:	8b4e                	mv	s6,s3
      state = 0;
 76a:	4981                	li	s3,0
 76c:	b54d                	j	60e <vprintf+0x60>
    }
  }
}
 76e:	70e6                	ld	ra,120(sp)
 770:	7446                	ld	s0,112(sp)
 772:	74a6                	ld	s1,104(sp)
 774:	7906                	ld	s2,96(sp)
 776:	69e6                	ld	s3,88(sp)
 778:	6a46                	ld	s4,80(sp)
 77a:	6aa6                	ld	s5,72(sp)
 77c:	6b06                	ld	s6,64(sp)
 77e:	7be2                	ld	s7,56(sp)
 780:	7c42                	ld	s8,48(sp)
 782:	7ca2                	ld	s9,40(sp)
 784:	7d02                	ld	s10,32(sp)
 786:	6de2                	ld	s11,24(sp)
 788:	6109                	addi	sp,sp,128
 78a:	8082                	ret

000000000000078c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 78c:	715d                	addi	sp,sp,-80
 78e:	ec06                	sd	ra,24(sp)
 790:	e822                	sd	s0,16(sp)
 792:	1000                	addi	s0,sp,32
 794:	e010                	sd	a2,0(s0)
 796:	e414                	sd	a3,8(s0)
 798:	e818                	sd	a4,16(s0)
 79a:	ec1c                	sd	a5,24(s0)
 79c:	03043023          	sd	a6,32(s0)
 7a0:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7a4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7a8:	8622                	mv	a2,s0
 7aa:	00000097          	auipc	ra,0x0
 7ae:	e04080e7          	jalr	-508(ra) # 5ae <vprintf>
}
 7b2:	60e2                	ld	ra,24(sp)
 7b4:	6442                	ld	s0,16(sp)
 7b6:	6161                	addi	sp,sp,80
 7b8:	8082                	ret

00000000000007ba <printf>:

void
printf(const char *fmt, ...)
{
 7ba:	711d                	addi	sp,sp,-96
 7bc:	ec06                	sd	ra,24(sp)
 7be:	e822                	sd	s0,16(sp)
 7c0:	1000                	addi	s0,sp,32
 7c2:	e40c                	sd	a1,8(s0)
 7c4:	e810                	sd	a2,16(s0)
 7c6:	ec14                	sd	a3,24(s0)
 7c8:	f018                	sd	a4,32(s0)
 7ca:	f41c                	sd	a5,40(s0)
 7cc:	03043823          	sd	a6,48(s0)
 7d0:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7d4:	00840613          	addi	a2,s0,8
 7d8:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7dc:	85aa                	mv	a1,a0
 7de:	4505                	li	a0,1
 7e0:	00000097          	auipc	ra,0x0
 7e4:	dce080e7          	jalr	-562(ra) # 5ae <vprintf>
}
 7e8:	60e2                	ld	ra,24(sp)
 7ea:	6442                	ld	s0,16(sp)
 7ec:	6125                	addi	sp,sp,96
 7ee:	8082                	ret

00000000000007f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7f0:	1141                	addi	sp,sp,-16
 7f2:	e422                	sd	s0,8(sp)
 7f4:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7f6:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7fa:	00000797          	auipc	a5,0x0
 7fe:	1967b783          	ld	a5,406(a5) # 990 <freep>
 802:	a805                	j	832 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 804:	4618                	lw	a4,8(a2)
 806:	9db9                	addw	a1,a1,a4
 808:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 80c:	6398                	ld	a4,0(a5)
 80e:	6318                	ld	a4,0(a4)
 810:	fee53823          	sd	a4,-16(a0)
 814:	a091                	j	858 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 816:	ff852703          	lw	a4,-8(a0)
 81a:	9e39                	addw	a2,a2,a4
 81c:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 81e:	ff053703          	ld	a4,-16(a0)
 822:	e398                	sd	a4,0(a5)
 824:	a099                	j	86a <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 826:	6398                	ld	a4,0(a5)
 828:	00e7e463          	bltu	a5,a4,830 <free+0x40>
 82c:	00e6ea63          	bltu	a3,a4,840 <free+0x50>
{
 830:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 832:	fed7fae3          	bgeu	a5,a3,826 <free+0x36>
 836:	6398                	ld	a4,0(a5)
 838:	00e6e463          	bltu	a3,a4,840 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 83c:	fee7eae3          	bltu	a5,a4,830 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 840:	ff852583          	lw	a1,-8(a0)
 844:	6390                	ld	a2,0(a5)
 846:	02059713          	slli	a4,a1,0x20
 84a:	9301                	srli	a4,a4,0x20
 84c:	0712                	slli	a4,a4,0x4
 84e:	9736                	add	a4,a4,a3
 850:	fae60ae3          	beq	a2,a4,804 <free+0x14>
    bp->s.ptr = p->s.ptr;
 854:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 858:	4790                	lw	a2,8(a5)
 85a:	02061713          	slli	a4,a2,0x20
 85e:	9301                	srli	a4,a4,0x20
 860:	0712                	slli	a4,a4,0x4
 862:	973e                	add	a4,a4,a5
 864:	fae689e3          	beq	a3,a4,816 <free+0x26>
  } else
    p->s.ptr = bp;
 868:	e394                	sd	a3,0(a5)
  freep = p;
 86a:	00000717          	auipc	a4,0x0
 86e:	12f73323          	sd	a5,294(a4) # 990 <freep>
}
 872:	6422                	ld	s0,8(sp)
 874:	0141                	addi	sp,sp,16
 876:	8082                	ret

0000000000000878 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 878:	7139                	addi	sp,sp,-64
 87a:	fc06                	sd	ra,56(sp)
 87c:	f822                	sd	s0,48(sp)
 87e:	f426                	sd	s1,40(sp)
 880:	f04a                	sd	s2,32(sp)
 882:	ec4e                	sd	s3,24(sp)
 884:	e852                	sd	s4,16(sp)
 886:	e456                	sd	s5,8(sp)
 888:	e05a                	sd	s6,0(sp)
 88a:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 88c:	02051493          	slli	s1,a0,0x20
 890:	9081                	srli	s1,s1,0x20
 892:	04bd                	addi	s1,s1,15
 894:	8091                	srli	s1,s1,0x4
 896:	0014899b          	addiw	s3,s1,1
 89a:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 89c:	00000517          	auipc	a0,0x0
 8a0:	0f453503          	ld	a0,244(a0) # 990 <freep>
 8a4:	c515                	beqz	a0,8d0 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8a6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8a8:	4798                	lw	a4,8(a5)
 8aa:	02977f63          	bgeu	a4,s1,8e8 <malloc+0x70>
 8ae:	8a4e                	mv	s4,s3
 8b0:	0009871b          	sext.w	a4,s3
 8b4:	6685                	lui	a3,0x1
 8b6:	00d77363          	bgeu	a4,a3,8bc <malloc+0x44>
 8ba:	6a05                	lui	s4,0x1
 8bc:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8c0:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8c4:	00000917          	auipc	s2,0x0
 8c8:	0cc90913          	addi	s2,s2,204 # 990 <freep>
  if(p == (char*)-1)
 8cc:	5afd                	li	s5,-1
 8ce:	a88d                	j	940 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 8d0:	00000797          	auipc	a5,0x0
 8d4:	0c878793          	addi	a5,a5,200 # 998 <base>
 8d8:	00000717          	auipc	a4,0x0
 8dc:	0af73c23          	sd	a5,184(a4) # 990 <freep>
 8e0:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8e2:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8e6:	b7e1                	j	8ae <malloc+0x36>
      if(p->s.size == nunits)
 8e8:	02e48b63          	beq	s1,a4,91e <malloc+0xa6>
        p->s.size -= nunits;
 8ec:	4137073b          	subw	a4,a4,s3
 8f0:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8f2:	1702                	slli	a4,a4,0x20
 8f4:	9301                	srli	a4,a4,0x20
 8f6:	0712                	slli	a4,a4,0x4
 8f8:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8fa:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8fe:	00000717          	auipc	a4,0x0
 902:	08a73923          	sd	a0,146(a4) # 990 <freep>
      return (void*)(p + 1);
 906:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 90a:	70e2                	ld	ra,56(sp)
 90c:	7442                	ld	s0,48(sp)
 90e:	74a2                	ld	s1,40(sp)
 910:	7902                	ld	s2,32(sp)
 912:	69e2                	ld	s3,24(sp)
 914:	6a42                	ld	s4,16(sp)
 916:	6aa2                	ld	s5,8(sp)
 918:	6b02                	ld	s6,0(sp)
 91a:	6121                	addi	sp,sp,64
 91c:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 91e:	6398                	ld	a4,0(a5)
 920:	e118                	sd	a4,0(a0)
 922:	bff1                	j	8fe <malloc+0x86>
  hp->s.size = nu;
 924:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 928:	0541                	addi	a0,a0,16
 92a:	00000097          	auipc	ra,0x0
 92e:	ec6080e7          	jalr	-314(ra) # 7f0 <free>
  return freep;
 932:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 936:	d971                	beqz	a0,90a <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 938:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 93a:	4798                	lw	a4,8(a5)
 93c:	fa9776e3          	bgeu	a4,s1,8e8 <malloc+0x70>
    if(p == freep)
 940:	00093703          	ld	a4,0(s2)
 944:	853e                	mv	a0,a5
 946:	fef719e3          	bne	a4,a5,938 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 94a:	8552                	mv	a0,s4
 94c:	00000097          	auipc	ra,0x0
 950:	b7e080e7          	jalr	-1154(ra) # 4ca <sbrk>
  if(p == (char*)-1)
 954:	fd5518e3          	bne	a0,s5,924 <malloc+0xac>
        return 0;
 958:	4501                	li	a0,0
 95a:	bf45                	j	90a <malloc+0x92>
