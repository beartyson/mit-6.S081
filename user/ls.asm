
user/_ls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "user/user.h"
#include "kernel/fs.h"

char*
fmtname(char *path)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	84aa                	mv	s1,a0
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  10:	00000097          	auipc	ra,0x0
  14:	302080e7          	jalr	770(ra) # 312 <strlen>
  18:	02051793          	slli	a5,a0,0x20
  1c:	9381                	srli	a5,a5,0x20
  1e:	97a6                	add	a5,a5,s1
  20:	02f00693          	li	a3,47
  24:	0097e963          	bltu	a5,s1,36 <fmtname+0x36>
  28:	0007c703          	lbu	a4,0(a5)
  2c:	00d70563          	beq	a4,a3,36 <fmtname+0x36>
  30:	17fd                	addi	a5,a5,-1
  32:	fe97fbe3          	bgeu	a5,s1,28 <fmtname+0x28>
    ;
  p++;
  36:	00178493          	addi	s1,a5,1

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  3a:	8526                	mv	a0,s1
  3c:	00000097          	auipc	ra,0x0
  40:	2d6080e7          	jalr	726(ra) # 312 <strlen>
  44:	2501                	sext.w	a0,a0
  46:	47b5                	li	a5,13
  48:	00a7fa63          	bgeu	a5,a0,5c <fmtname+0x5c>
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}
  4c:	8526                	mv	a0,s1
  4e:	70a2                	ld	ra,40(sp)
  50:	7402                	ld	s0,32(sp)
  52:	64e2                	ld	s1,24(sp)
  54:	6942                	ld	s2,16(sp)
  56:	69a2                	ld	s3,8(sp)
  58:	6145                	addi	sp,sp,48
  5a:	8082                	ret
  memmove(buf, p, strlen(p));
  5c:	8526                	mv	a0,s1
  5e:	00000097          	auipc	ra,0x0
  62:	2b4080e7          	jalr	692(ra) # 312 <strlen>
  66:	00001997          	auipc	s3,0x1
  6a:	a8a98993          	addi	s3,s3,-1398 # af0 <buf.0>
  6e:	0005061b          	sext.w	a2,a0
  72:	85a6                	mv	a1,s1
  74:	854e                	mv	a0,s3
  76:	00000097          	auipc	ra,0x0
  7a:	410080e7          	jalr	1040(ra) # 486 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  7e:	8526                	mv	a0,s1
  80:	00000097          	auipc	ra,0x0
  84:	292080e7          	jalr	658(ra) # 312 <strlen>
  88:	0005091b          	sext.w	s2,a0
  8c:	8526                	mv	a0,s1
  8e:	00000097          	auipc	ra,0x0
  92:	284080e7          	jalr	644(ra) # 312 <strlen>
  96:	1902                	slli	s2,s2,0x20
  98:	02095913          	srli	s2,s2,0x20
  9c:	4639                	li	a2,14
  9e:	9e09                	subw	a2,a2,a0
  a0:	02000593          	li	a1,32
  a4:	01298533          	add	a0,s3,s2
  a8:	00000097          	auipc	ra,0x0
  ac:	294080e7          	jalr	660(ra) # 33c <memset>
  return buf;
  b0:	84ce                	mv	s1,s3
  b2:	bf69                	j	4c <fmtname+0x4c>

00000000000000b4 <ls>:

void
ls(char *path)
{
  b4:	d9010113          	addi	sp,sp,-624
  b8:	26113423          	sd	ra,616(sp)
  bc:	26813023          	sd	s0,608(sp)
  c0:	24913c23          	sd	s1,600(sp)
  c4:	25213823          	sd	s2,592(sp)
  c8:	25313423          	sd	s3,584(sp)
  cc:	25413023          	sd	s4,576(sp)
  d0:	23513c23          	sd	s5,568(sp)
  d4:	1c80                	addi	s0,sp,624
  d6:	892a                	mv	s2,a0
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
  d8:	4581                	li	a1,0
  da:	00000097          	auipc	ra,0x0
  de:	49e080e7          	jalr	1182(ra) # 578 <open>
  e2:	04054a63          	bltz	a0,136 <ls+0x82>
  e6:	84aa                	mv	s1,a0
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  e8:	d9840593          	addi	a1,s0,-616
  ec:	00000097          	auipc	ra,0x0
  f0:	4a4080e7          	jalr	1188(ra) # 590 <fstat>
  f4:	06054c63          	bltz	a0,16c <ls+0xb8>
    fprintf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
  f8:	da041783          	lh	a5,-608(s0)
  fc:	0007869b          	sext.w	a3,a5
 100:	4705                	li	a4,1
 102:	08e68563          	beq	a3,a4,18c <ls+0xd8>
 106:	4709                	li	a4,2
 108:	04e69163          	bne	a3,a4,14a <ls+0x96>
  case T_FILE:
    printf("%s %d %d %l\n", fmtname(path), st.type, st.ino, st.size);
 10c:	854a                	mv	a0,s2
 10e:	00000097          	auipc	ra,0x0
 112:	ef2080e7          	jalr	-270(ra) # 0 <fmtname>
 116:	85aa                	mv	a1,a0
 118:	da843703          	ld	a4,-600(s0)
 11c:	d9c42683          	lw	a3,-612(s0)
 120:	da041603          	lh	a2,-608(s0)
 124:	00001517          	auipc	a0,0x1
 128:	96450513          	addi	a0,a0,-1692 # a88 <malloc+0x11a>
 12c:	00000097          	auipc	ra,0x0
 130:	784080e7          	jalr	1924(ra) # 8b0 <printf>
    break;
 134:	a819                	j	14a <ls+0x96>
    fprintf(2, "ls: cannot open %s\n", path);
 136:	864a                	mv	a2,s2
 138:	00001597          	auipc	a1,0x1
 13c:	92058593          	addi	a1,a1,-1760 # a58 <malloc+0xea>
 140:	4509                	li	a0,2
 142:	00000097          	auipc	ra,0x0
 146:	740080e7          	jalr	1856(ra) # 882 <fprintf>
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  
}
 14a:	26813083          	ld	ra,616(sp)
 14e:	26013403          	ld	s0,608(sp)
 152:	25813483          	ld	s1,600(sp)
 156:	25013903          	ld	s2,592(sp)
 15a:	24813983          	ld	s3,584(sp)
 15e:	24013a03          	ld	s4,576(sp)
 162:	23813a83          	ld	s5,568(sp)
 166:	27010113          	addi	sp,sp,624
 16a:	8082                	ret
    fprintf(2, "ls: cannot stat %s\n", path);
 16c:	864a                	mv	a2,s2
 16e:	00001597          	auipc	a1,0x1
 172:	90258593          	addi	a1,a1,-1790 # a70 <malloc+0x102>
 176:	4509                	li	a0,2
 178:	00000097          	auipc	ra,0x0
 17c:	70a080e7          	jalr	1802(ra) # 882 <fprintf>
    close(fd);
 180:	8526                	mv	a0,s1
 182:	00000097          	auipc	ra,0x0
 186:	3de080e7          	jalr	990(ra) # 560 <close>
    return;
 18a:	b7c1                	j	14a <ls+0x96>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 18c:	854a                	mv	a0,s2
 18e:	00000097          	auipc	ra,0x0
 192:	184080e7          	jalr	388(ra) # 312 <strlen>
 196:	2541                	addiw	a0,a0,16
 198:	20000793          	li	a5,512
 19c:	00a7fb63          	bgeu	a5,a0,1b2 <ls+0xfe>
      printf("ls: path too long\n");
 1a0:	00001517          	auipc	a0,0x1
 1a4:	8f850513          	addi	a0,a0,-1800 # a98 <malloc+0x12a>
 1a8:	00000097          	auipc	ra,0x0
 1ac:	708080e7          	jalr	1800(ra) # 8b0 <printf>
      break;
 1b0:	bf69                	j	14a <ls+0x96>
    strcpy(buf, path);
 1b2:	85ca                	mv	a1,s2
 1b4:	dc040513          	addi	a0,s0,-576
 1b8:	00000097          	auipc	ra,0x0
 1bc:	112080e7          	jalr	274(ra) # 2ca <strcpy>
    p = buf+strlen(buf);
 1c0:	dc040513          	addi	a0,s0,-576
 1c4:	00000097          	auipc	ra,0x0
 1c8:	14e080e7          	jalr	334(ra) # 312 <strlen>
 1cc:	02051913          	slli	s2,a0,0x20
 1d0:	02095913          	srli	s2,s2,0x20
 1d4:	dc040793          	addi	a5,s0,-576
 1d8:	993e                	add	s2,s2,a5
    *p++ = '/';
 1da:	00190993          	addi	s3,s2,1
 1de:	02f00793          	li	a5,47
 1e2:	00f90023          	sb	a5,0(s2)
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 1e6:	00001a17          	auipc	s4,0x1
 1ea:	8caa0a13          	addi	s4,s4,-1846 # ab0 <malloc+0x142>
        printf("ls: cannot stat %s\n", buf);
 1ee:	00001a97          	auipc	s5,0x1
 1f2:	882a8a93          	addi	s5,s5,-1918 # a70 <malloc+0x102>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1f6:	a801                	j	206 <ls+0x152>
        printf("ls: cannot stat %s\n", buf);
 1f8:	dc040593          	addi	a1,s0,-576
 1fc:	8556                	mv	a0,s5
 1fe:	00000097          	auipc	ra,0x0
 202:	6b2080e7          	jalr	1714(ra) # 8b0 <printf>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 206:	4641                	li	a2,16
 208:	db040593          	addi	a1,s0,-592
 20c:	8526                	mv	a0,s1
 20e:	00000097          	auipc	ra,0x0
 212:	342080e7          	jalr	834(ra) # 550 <read>
 216:	47c1                	li	a5,16
 218:	f2f519e3          	bne	a0,a5,14a <ls+0x96>
      if(de.inum == 0)
 21c:	db045783          	lhu	a5,-592(s0)
 220:	d3fd                	beqz	a5,206 <ls+0x152>
      memmove(p, de.name, DIRSIZ);
 222:	4639                	li	a2,14
 224:	db240593          	addi	a1,s0,-590
 228:	854e                	mv	a0,s3
 22a:	00000097          	auipc	ra,0x0
 22e:	25c080e7          	jalr	604(ra) # 486 <memmove>
      p[DIRSIZ] = 0;
 232:	000907a3          	sb	zero,15(s2)
      if(stat(buf, &st) < 0){
 236:	d9840593          	addi	a1,s0,-616
 23a:	dc040513          	addi	a0,s0,-576
 23e:	00000097          	auipc	ra,0x0
 242:	1b8080e7          	jalr	440(ra) # 3f6 <stat>
 246:	fa0549e3          	bltz	a0,1f8 <ls+0x144>
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 24a:	dc040513          	addi	a0,s0,-576
 24e:	00000097          	auipc	ra,0x0
 252:	db2080e7          	jalr	-590(ra) # 0 <fmtname>
 256:	85aa                	mv	a1,a0
 258:	da843703          	ld	a4,-600(s0)
 25c:	d9c42683          	lw	a3,-612(s0)
 260:	da041603          	lh	a2,-608(s0)
 264:	8552                	mv	a0,s4
 266:	00000097          	auipc	ra,0x0
 26a:	64a080e7          	jalr	1610(ra) # 8b0 <printf>
 26e:	bf61                	j	206 <ls+0x152>

0000000000000270 <main>:

int
main(int argc, char *argv[])
{
 270:	1101                	addi	sp,sp,-32
 272:	ec06                	sd	ra,24(sp)
 274:	e822                	sd	s0,16(sp)
 276:	e426                	sd	s1,8(sp)
 278:	e04a                	sd	s2,0(sp)
 27a:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
 27c:	4785                	li	a5,1
 27e:	02a7d963          	bge	a5,a0,2b0 <main+0x40>
 282:	00858493          	addi	s1,a1,8
 286:	ffe5091b          	addiw	s2,a0,-2
 28a:	1902                	slli	s2,s2,0x20
 28c:	02095913          	srli	s2,s2,0x20
 290:	090e                	slli	s2,s2,0x3
 292:	05c1                	addi	a1,a1,16
 294:	992e                	add	s2,s2,a1
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
 296:	6088                	ld	a0,0(s1)
 298:	00000097          	auipc	ra,0x0
 29c:	e1c080e7          	jalr	-484(ra) # b4 <ls>
  for(i=1; i<argc; i++)
 2a0:	04a1                	addi	s1,s1,8
 2a2:	ff249ae3          	bne	s1,s2,296 <main+0x26>
  exit(0);
 2a6:	4501                	li	a0,0
 2a8:	00000097          	auipc	ra,0x0
 2ac:	290080e7          	jalr	656(ra) # 538 <exit>
    ls(".");
 2b0:	00001517          	auipc	a0,0x1
 2b4:	81050513          	addi	a0,a0,-2032 # ac0 <malloc+0x152>
 2b8:	00000097          	auipc	ra,0x0
 2bc:	dfc080e7          	jalr	-516(ra) # b4 <ls>
    exit(0);
 2c0:	4501                	li	a0,0
 2c2:	00000097          	auipc	ra,0x0
 2c6:	276080e7          	jalr	630(ra) # 538 <exit>

00000000000002ca <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 2ca:	1141                	addi	sp,sp,-16
 2cc:	e422                	sd	s0,8(sp)
 2ce:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2d0:	87aa                	mv	a5,a0
 2d2:	0585                	addi	a1,a1,1
 2d4:	0785                	addi	a5,a5,1
 2d6:	fff5c703          	lbu	a4,-1(a1)
 2da:	fee78fa3          	sb	a4,-1(a5)
 2de:	fb75                	bnez	a4,2d2 <strcpy+0x8>
    ;
  return os;
}
 2e0:	6422                	ld	s0,8(sp)
 2e2:	0141                	addi	sp,sp,16
 2e4:	8082                	ret

00000000000002e6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2e6:	1141                	addi	sp,sp,-16
 2e8:	e422                	sd	s0,8(sp)
 2ea:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2ec:	00054783          	lbu	a5,0(a0)
 2f0:	cb91                	beqz	a5,304 <strcmp+0x1e>
 2f2:	0005c703          	lbu	a4,0(a1)
 2f6:	00f71763          	bne	a4,a5,304 <strcmp+0x1e>
    p++, q++;
 2fa:	0505                	addi	a0,a0,1
 2fc:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2fe:	00054783          	lbu	a5,0(a0)
 302:	fbe5                	bnez	a5,2f2 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 304:	0005c503          	lbu	a0,0(a1)
}
 308:	40a7853b          	subw	a0,a5,a0
 30c:	6422                	ld	s0,8(sp)
 30e:	0141                	addi	sp,sp,16
 310:	8082                	ret

0000000000000312 <strlen>:

uint
strlen(const char *s)
{
 312:	1141                	addi	sp,sp,-16
 314:	e422                	sd	s0,8(sp)
 316:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 318:	00054783          	lbu	a5,0(a0)
 31c:	cf91                	beqz	a5,338 <strlen+0x26>
 31e:	0505                	addi	a0,a0,1
 320:	87aa                	mv	a5,a0
 322:	4685                	li	a3,1
 324:	9e89                	subw	a3,a3,a0
 326:	00f6853b          	addw	a0,a3,a5
 32a:	0785                	addi	a5,a5,1
 32c:	fff7c703          	lbu	a4,-1(a5)
 330:	fb7d                	bnez	a4,326 <strlen+0x14>
    ;
  return n;
}
 332:	6422                	ld	s0,8(sp)
 334:	0141                	addi	sp,sp,16
 336:	8082                	ret
  for(n = 0; s[n]; n++)
 338:	4501                	li	a0,0
 33a:	bfe5                	j	332 <strlen+0x20>

000000000000033c <memset>:

void*
memset(void *dst, int c, uint n)
{
 33c:	1141                	addi	sp,sp,-16
 33e:	e422                	sd	s0,8(sp)
 340:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 342:	ca19                	beqz	a2,358 <memset+0x1c>
 344:	87aa                	mv	a5,a0
 346:	1602                	slli	a2,a2,0x20
 348:	9201                	srli	a2,a2,0x20
 34a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 34e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 352:	0785                	addi	a5,a5,1
 354:	fee79de3          	bne	a5,a4,34e <memset+0x12>
  }
  return dst;
}
 358:	6422                	ld	s0,8(sp)
 35a:	0141                	addi	sp,sp,16
 35c:	8082                	ret

000000000000035e <strchr>:

char*
strchr(const char *s, char c)
{
 35e:	1141                	addi	sp,sp,-16
 360:	e422                	sd	s0,8(sp)
 362:	0800                	addi	s0,sp,16
  for(; *s; s++)
 364:	00054783          	lbu	a5,0(a0)
 368:	cb99                	beqz	a5,37e <strchr+0x20>
    if(*s == c)
 36a:	00f58763          	beq	a1,a5,378 <strchr+0x1a>
  for(; *s; s++)
 36e:	0505                	addi	a0,a0,1
 370:	00054783          	lbu	a5,0(a0)
 374:	fbfd                	bnez	a5,36a <strchr+0xc>
      return (char*)s;
  return 0;
 376:	4501                	li	a0,0
}
 378:	6422                	ld	s0,8(sp)
 37a:	0141                	addi	sp,sp,16
 37c:	8082                	ret
  return 0;
 37e:	4501                	li	a0,0
 380:	bfe5                	j	378 <strchr+0x1a>

0000000000000382 <gets>:

char*
gets(char *buf, int max)
{
 382:	711d                	addi	sp,sp,-96
 384:	ec86                	sd	ra,88(sp)
 386:	e8a2                	sd	s0,80(sp)
 388:	e4a6                	sd	s1,72(sp)
 38a:	e0ca                	sd	s2,64(sp)
 38c:	fc4e                	sd	s3,56(sp)
 38e:	f852                	sd	s4,48(sp)
 390:	f456                	sd	s5,40(sp)
 392:	f05a                	sd	s6,32(sp)
 394:	ec5e                	sd	s7,24(sp)
 396:	1080                	addi	s0,sp,96
 398:	8baa                	mv	s7,a0
 39a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 39c:	892a                	mv	s2,a0
 39e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3a0:	4aa9                	li	s5,10
 3a2:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 3a4:	89a6                	mv	s3,s1
 3a6:	2485                	addiw	s1,s1,1
 3a8:	0344d863          	bge	s1,s4,3d8 <gets+0x56>
    cc = read(0, &c, 1);
 3ac:	4605                	li	a2,1
 3ae:	faf40593          	addi	a1,s0,-81
 3b2:	4501                	li	a0,0
 3b4:	00000097          	auipc	ra,0x0
 3b8:	19c080e7          	jalr	412(ra) # 550 <read>
    if(cc < 1)
 3bc:	00a05e63          	blez	a0,3d8 <gets+0x56>
    buf[i++] = c;
 3c0:	faf44783          	lbu	a5,-81(s0)
 3c4:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3c8:	01578763          	beq	a5,s5,3d6 <gets+0x54>
 3cc:	0905                	addi	s2,s2,1
 3ce:	fd679be3          	bne	a5,s6,3a4 <gets+0x22>
  for(i=0; i+1 < max; ){
 3d2:	89a6                	mv	s3,s1
 3d4:	a011                	j	3d8 <gets+0x56>
 3d6:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 3d8:	99de                	add	s3,s3,s7
 3da:	00098023          	sb	zero,0(s3)
  return buf;
}
 3de:	855e                	mv	a0,s7
 3e0:	60e6                	ld	ra,88(sp)
 3e2:	6446                	ld	s0,80(sp)
 3e4:	64a6                	ld	s1,72(sp)
 3e6:	6906                	ld	s2,64(sp)
 3e8:	79e2                	ld	s3,56(sp)
 3ea:	7a42                	ld	s4,48(sp)
 3ec:	7aa2                	ld	s5,40(sp)
 3ee:	7b02                	ld	s6,32(sp)
 3f0:	6be2                	ld	s7,24(sp)
 3f2:	6125                	addi	sp,sp,96
 3f4:	8082                	ret

00000000000003f6 <stat>:

int
stat(const char *n, struct stat *st)
{
 3f6:	1101                	addi	sp,sp,-32
 3f8:	ec06                	sd	ra,24(sp)
 3fa:	e822                	sd	s0,16(sp)
 3fc:	e426                	sd	s1,8(sp)
 3fe:	e04a                	sd	s2,0(sp)
 400:	1000                	addi	s0,sp,32
 402:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 404:	4581                	li	a1,0
 406:	00000097          	auipc	ra,0x0
 40a:	172080e7          	jalr	370(ra) # 578 <open>
  if(fd < 0)
 40e:	02054563          	bltz	a0,438 <stat+0x42>
 412:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 414:	85ca                	mv	a1,s2
 416:	00000097          	auipc	ra,0x0
 41a:	17a080e7          	jalr	378(ra) # 590 <fstat>
 41e:	892a                	mv	s2,a0
  close(fd);
 420:	8526                	mv	a0,s1
 422:	00000097          	auipc	ra,0x0
 426:	13e080e7          	jalr	318(ra) # 560 <close>
  return r;
}
 42a:	854a                	mv	a0,s2
 42c:	60e2                	ld	ra,24(sp)
 42e:	6442                	ld	s0,16(sp)
 430:	64a2                	ld	s1,8(sp)
 432:	6902                	ld	s2,0(sp)
 434:	6105                	addi	sp,sp,32
 436:	8082                	ret
    return -1;
 438:	597d                	li	s2,-1
 43a:	bfc5                	j	42a <stat+0x34>

000000000000043c <atoi>:

int
atoi(const char *s)
{
 43c:	1141                	addi	sp,sp,-16
 43e:	e422                	sd	s0,8(sp)
 440:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 442:	00054603          	lbu	a2,0(a0)
 446:	fd06079b          	addiw	a5,a2,-48
 44a:	0ff7f793          	andi	a5,a5,255
 44e:	4725                	li	a4,9
 450:	02f76963          	bltu	a4,a5,482 <atoi+0x46>
 454:	86aa                	mv	a3,a0
  n = 0;
 456:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 458:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 45a:	0685                	addi	a3,a3,1
 45c:	0025179b          	slliw	a5,a0,0x2
 460:	9fa9                	addw	a5,a5,a0
 462:	0017979b          	slliw	a5,a5,0x1
 466:	9fb1                	addw	a5,a5,a2
 468:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 46c:	0006c603          	lbu	a2,0(a3)
 470:	fd06071b          	addiw	a4,a2,-48
 474:	0ff77713          	andi	a4,a4,255
 478:	fee5f1e3          	bgeu	a1,a4,45a <atoi+0x1e>
  return n;
}
 47c:	6422                	ld	s0,8(sp)
 47e:	0141                	addi	sp,sp,16
 480:	8082                	ret
  n = 0;
 482:	4501                	li	a0,0
 484:	bfe5                	j	47c <atoi+0x40>

0000000000000486 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 486:	1141                	addi	sp,sp,-16
 488:	e422                	sd	s0,8(sp)
 48a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 48c:	02b57463          	bgeu	a0,a1,4b4 <memmove+0x2e>
    while(n-- > 0)
 490:	00c05f63          	blez	a2,4ae <memmove+0x28>
 494:	1602                	slli	a2,a2,0x20
 496:	9201                	srli	a2,a2,0x20
 498:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 49c:	872a                	mv	a4,a0
      *dst++ = *src++;
 49e:	0585                	addi	a1,a1,1
 4a0:	0705                	addi	a4,a4,1
 4a2:	fff5c683          	lbu	a3,-1(a1)
 4a6:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 4aa:	fee79ae3          	bne	a5,a4,49e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 4ae:	6422                	ld	s0,8(sp)
 4b0:	0141                	addi	sp,sp,16
 4b2:	8082                	ret
    dst += n;
 4b4:	00c50733          	add	a4,a0,a2
    src += n;
 4b8:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 4ba:	fec05ae3          	blez	a2,4ae <memmove+0x28>
 4be:	fff6079b          	addiw	a5,a2,-1
 4c2:	1782                	slli	a5,a5,0x20
 4c4:	9381                	srli	a5,a5,0x20
 4c6:	fff7c793          	not	a5,a5
 4ca:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4cc:	15fd                	addi	a1,a1,-1
 4ce:	177d                	addi	a4,a4,-1
 4d0:	0005c683          	lbu	a3,0(a1)
 4d4:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 4d8:	fee79ae3          	bne	a5,a4,4cc <memmove+0x46>
 4dc:	bfc9                	j	4ae <memmove+0x28>

00000000000004de <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4de:	1141                	addi	sp,sp,-16
 4e0:	e422                	sd	s0,8(sp)
 4e2:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4e4:	ca05                	beqz	a2,514 <memcmp+0x36>
 4e6:	fff6069b          	addiw	a3,a2,-1
 4ea:	1682                	slli	a3,a3,0x20
 4ec:	9281                	srli	a3,a3,0x20
 4ee:	0685                	addi	a3,a3,1
 4f0:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 4f2:	00054783          	lbu	a5,0(a0)
 4f6:	0005c703          	lbu	a4,0(a1)
 4fa:	00e79863          	bne	a5,a4,50a <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 4fe:	0505                	addi	a0,a0,1
    p2++;
 500:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 502:	fed518e3          	bne	a0,a3,4f2 <memcmp+0x14>
  }
  return 0;
 506:	4501                	li	a0,0
 508:	a019                	j	50e <memcmp+0x30>
      return *p1 - *p2;
 50a:	40e7853b          	subw	a0,a5,a4
}
 50e:	6422                	ld	s0,8(sp)
 510:	0141                	addi	sp,sp,16
 512:	8082                	ret
  return 0;
 514:	4501                	li	a0,0
 516:	bfe5                	j	50e <memcmp+0x30>

0000000000000518 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 518:	1141                	addi	sp,sp,-16
 51a:	e406                	sd	ra,8(sp)
 51c:	e022                	sd	s0,0(sp)
 51e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 520:	00000097          	auipc	ra,0x0
 524:	f66080e7          	jalr	-154(ra) # 486 <memmove>
}
 528:	60a2                	ld	ra,8(sp)
 52a:	6402                	ld	s0,0(sp)
 52c:	0141                	addi	sp,sp,16
 52e:	8082                	ret

0000000000000530 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 530:	4885                	li	a7,1
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <exit>:
.global exit
exit:
 li a7, SYS_exit
 538:	4889                	li	a7,2
 ecall
 53a:	00000073          	ecall
 ret
 53e:	8082                	ret

0000000000000540 <wait>:
.global wait
wait:
 li a7, SYS_wait
 540:	488d                	li	a7,3
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 548:	4891                	li	a7,4
 ecall
 54a:	00000073          	ecall
 ret
 54e:	8082                	ret

0000000000000550 <read>:
.global read
read:
 li a7, SYS_read
 550:	4895                	li	a7,5
 ecall
 552:	00000073          	ecall
 ret
 556:	8082                	ret

0000000000000558 <write>:
.global write
write:
 li a7, SYS_write
 558:	48c1                	li	a7,16
 ecall
 55a:	00000073          	ecall
 ret
 55e:	8082                	ret

0000000000000560 <close>:
.global close
close:
 li a7, SYS_close
 560:	48d5                	li	a7,21
 ecall
 562:	00000073          	ecall
 ret
 566:	8082                	ret

0000000000000568 <kill>:
.global kill
kill:
 li a7, SYS_kill
 568:	4899                	li	a7,6
 ecall
 56a:	00000073          	ecall
 ret
 56e:	8082                	ret

0000000000000570 <exec>:
.global exec
exec:
 li a7, SYS_exec
 570:	489d                	li	a7,7
 ecall
 572:	00000073          	ecall
 ret
 576:	8082                	ret

0000000000000578 <open>:
.global open
open:
 li a7, SYS_open
 578:	48bd                	li	a7,15
 ecall
 57a:	00000073          	ecall
 ret
 57e:	8082                	ret

0000000000000580 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 580:	48c5                	li	a7,17
 ecall
 582:	00000073          	ecall
 ret
 586:	8082                	ret

0000000000000588 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 588:	48c9                	li	a7,18
 ecall
 58a:	00000073          	ecall
 ret
 58e:	8082                	ret

0000000000000590 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 590:	48a1                	li	a7,8
 ecall
 592:	00000073          	ecall
 ret
 596:	8082                	ret

0000000000000598 <link>:
.global link
link:
 li a7, SYS_link
 598:	48cd                	li	a7,19
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5a0:	48d1                	li	a7,20
 ecall
 5a2:	00000073          	ecall
 ret
 5a6:	8082                	ret

00000000000005a8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5a8:	48a5                	li	a7,9
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5b0:	48a9                	li	a7,10
 ecall
 5b2:	00000073          	ecall
 ret
 5b6:	8082                	ret

00000000000005b8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5b8:	48ad                	li	a7,11
 ecall
 5ba:	00000073          	ecall
 ret
 5be:	8082                	ret

00000000000005c0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5c0:	48b1                	li	a7,12
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5c8:	48b5                	li	a7,13
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5d0:	48b9                	li	a7,14
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5d8:	1101                	addi	sp,sp,-32
 5da:	ec06                	sd	ra,24(sp)
 5dc:	e822                	sd	s0,16(sp)
 5de:	1000                	addi	s0,sp,32
 5e0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5e4:	4605                	li	a2,1
 5e6:	fef40593          	addi	a1,s0,-17
 5ea:	00000097          	auipc	ra,0x0
 5ee:	f6e080e7          	jalr	-146(ra) # 558 <write>
}
 5f2:	60e2                	ld	ra,24(sp)
 5f4:	6442                	ld	s0,16(sp)
 5f6:	6105                	addi	sp,sp,32
 5f8:	8082                	ret

00000000000005fa <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5fa:	7139                	addi	sp,sp,-64
 5fc:	fc06                	sd	ra,56(sp)
 5fe:	f822                	sd	s0,48(sp)
 600:	f426                	sd	s1,40(sp)
 602:	f04a                	sd	s2,32(sp)
 604:	ec4e                	sd	s3,24(sp)
 606:	0080                	addi	s0,sp,64
 608:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 60a:	c299                	beqz	a3,610 <printint+0x16>
 60c:	0805c863          	bltz	a1,69c <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 610:	2581                	sext.w	a1,a1
  neg = 0;
 612:	4881                	li	a7,0
 614:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 618:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 61a:	2601                	sext.w	a2,a2
 61c:	00000517          	auipc	a0,0x0
 620:	4b450513          	addi	a0,a0,1204 # ad0 <digits>
 624:	883a                	mv	a6,a4
 626:	2705                	addiw	a4,a4,1
 628:	02c5f7bb          	remuw	a5,a1,a2
 62c:	1782                	slli	a5,a5,0x20
 62e:	9381                	srli	a5,a5,0x20
 630:	97aa                	add	a5,a5,a0
 632:	0007c783          	lbu	a5,0(a5)
 636:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 63a:	0005879b          	sext.w	a5,a1
 63e:	02c5d5bb          	divuw	a1,a1,a2
 642:	0685                	addi	a3,a3,1
 644:	fec7f0e3          	bgeu	a5,a2,624 <printint+0x2a>
  if(neg)
 648:	00088b63          	beqz	a7,65e <printint+0x64>
    buf[i++] = '-';
 64c:	fd040793          	addi	a5,s0,-48
 650:	973e                	add	a4,a4,a5
 652:	02d00793          	li	a5,45
 656:	fef70823          	sb	a5,-16(a4)
 65a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 65e:	02e05863          	blez	a4,68e <printint+0x94>
 662:	fc040793          	addi	a5,s0,-64
 666:	00e78933          	add	s2,a5,a4
 66a:	fff78993          	addi	s3,a5,-1
 66e:	99ba                	add	s3,s3,a4
 670:	377d                	addiw	a4,a4,-1
 672:	1702                	slli	a4,a4,0x20
 674:	9301                	srli	a4,a4,0x20
 676:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 67a:	fff94583          	lbu	a1,-1(s2)
 67e:	8526                	mv	a0,s1
 680:	00000097          	auipc	ra,0x0
 684:	f58080e7          	jalr	-168(ra) # 5d8 <putc>
  while(--i >= 0)
 688:	197d                	addi	s2,s2,-1
 68a:	ff3918e3          	bne	s2,s3,67a <printint+0x80>
}
 68e:	70e2                	ld	ra,56(sp)
 690:	7442                	ld	s0,48(sp)
 692:	74a2                	ld	s1,40(sp)
 694:	7902                	ld	s2,32(sp)
 696:	69e2                	ld	s3,24(sp)
 698:	6121                	addi	sp,sp,64
 69a:	8082                	ret
    x = -xx;
 69c:	40b005bb          	negw	a1,a1
    neg = 1;
 6a0:	4885                	li	a7,1
    x = -xx;
 6a2:	bf8d                	j	614 <printint+0x1a>

00000000000006a4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6a4:	7119                	addi	sp,sp,-128
 6a6:	fc86                	sd	ra,120(sp)
 6a8:	f8a2                	sd	s0,112(sp)
 6aa:	f4a6                	sd	s1,104(sp)
 6ac:	f0ca                	sd	s2,96(sp)
 6ae:	ecce                	sd	s3,88(sp)
 6b0:	e8d2                	sd	s4,80(sp)
 6b2:	e4d6                	sd	s5,72(sp)
 6b4:	e0da                	sd	s6,64(sp)
 6b6:	fc5e                	sd	s7,56(sp)
 6b8:	f862                	sd	s8,48(sp)
 6ba:	f466                	sd	s9,40(sp)
 6bc:	f06a                	sd	s10,32(sp)
 6be:	ec6e                	sd	s11,24(sp)
 6c0:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6c2:	0005c903          	lbu	s2,0(a1)
 6c6:	18090f63          	beqz	s2,864 <vprintf+0x1c0>
 6ca:	8aaa                	mv	s5,a0
 6cc:	8b32                	mv	s6,a2
 6ce:	00158493          	addi	s1,a1,1
  state = 0;
 6d2:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6d4:	02500a13          	li	s4,37
      if(c == 'd'){
 6d8:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 6dc:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 6e0:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 6e4:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6e8:	00000b97          	auipc	s7,0x0
 6ec:	3e8b8b93          	addi	s7,s7,1000 # ad0 <digits>
 6f0:	a839                	j	70e <vprintf+0x6a>
        putc(fd, c);
 6f2:	85ca                	mv	a1,s2
 6f4:	8556                	mv	a0,s5
 6f6:	00000097          	auipc	ra,0x0
 6fa:	ee2080e7          	jalr	-286(ra) # 5d8 <putc>
 6fe:	a019                	j	704 <vprintf+0x60>
    } else if(state == '%'){
 700:	01498f63          	beq	s3,s4,71e <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 704:	0485                	addi	s1,s1,1
 706:	fff4c903          	lbu	s2,-1(s1)
 70a:	14090d63          	beqz	s2,864 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 70e:	0009079b          	sext.w	a5,s2
    if(state == 0){
 712:	fe0997e3          	bnez	s3,700 <vprintf+0x5c>
      if(c == '%'){
 716:	fd479ee3          	bne	a5,s4,6f2 <vprintf+0x4e>
        state = '%';
 71a:	89be                	mv	s3,a5
 71c:	b7e5                	j	704 <vprintf+0x60>
      if(c == 'd'){
 71e:	05878063          	beq	a5,s8,75e <vprintf+0xba>
      } else if(c == 'l') {
 722:	05978c63          	beq	a5,s9,77a <vprintf+0xd6>
      } else if(c == 'x') {
 726:	07a78863          	beq	a5,s10,796 <vprintf+0xf2>
      } else if(c == 'p') {
 72a:	09b78463          	beq	a5,s11,7b2 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 72e:	07300713          	li	a4,115
 732:	0ce78663          	beq	a5,a4,7fe <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 736:	06300713          	li	a4,99
 73a:	0ee78e63          	beq	a5,a4,836 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 73e:	11478863          	beq	a5,s4,84e <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 742:	85d2                	mv	a1,s4
 744:	8556                	mv	a0,s5
 746:	00000097          	auipc	ra,0x0
 74a:	e92080e7          	jalr	-366(ra) # 5d8 <putc>
        putc(fd, c);
 74e:	85ca                	mv	a1,s2
 750:	8556                	mv	a0,s5
 752:	00000097          	auipc	ra,0x0
 756:	e86080e7          	jalr	-378(ra) # 5d8 <putc>
      }
      state = 0;
 75a:	4981                	li	s3,0
 75c:	b765                	j	704 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 75e:	008b0913          	addi	s2,s6,8
 762:	4685                	li	a3,1
 764:	4629                	li	a2,10
 766:	000b2583          	lw	a1,0(s6)
 76a:	8556                	mv	a0,s5
 76c:	00000097          	auipc	ra,0x0
 770:	e8e080e7          	jalr	-370(ra) # 5fa <printint>
 774:	8b4a                	mv	s6,s2
      state = 0;
 776:	4981                	li	s3,0
 778:	b771                	j	704 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 77a:	008b0913          	addi	s2,s6,8
 77e:	4681                	li	a3,0
 780:	4629                	li	a2,10
 782:	000b2583          	lw	a1,0(s6)
 786:	8556                	mv	a0,s5
 788:	00000097          	auipc	ra,0x0
 78c:	e72080e7          	jalr	-398(ra) # 5fa <printint>
 790:	8b4a                	mv	s6,s2
      state = 0;
 792:	4981                	li	s3,0
 794:	bf85                	j	704 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 796:	008b0913          	addi	s2,s6,8
 79a:	4681                	li	a3,0
 79c:	4641                	li	a2,16
 79e:	000b2583          	lw	a1,0(s6)
 7a2:	8556                	mv	a0,s5
 7a4:	00000097          	auipc	ra,0x0
 7a8:	e56080e7          	jalr	-426(ra) # 5fa <printint>
 7ac:	8b4a                	mv	s6,s2
      state = 0;
 7ae:	4981                	li	s3,0
 7b0:	bf91                	j	704 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 7b2:	008b0793          	addi	a5,s6,8
 7b6:	f8f43423          	sd	a5,-120(s0)
 7ba:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 7be:	03000593          	li	a1,48
 7c2:	8556                	mv	a0,s5
 7c4:	00000097          	auipc	ra,0x0
 7c8:	e14080e7          	jalr	-492(ra) # 5d8 <putc>
  putc(fd, 'x');
 7cc:	85ea                	mv	a1,s10
 7ce:	8556                	mv	a0,s5
 7d0:	00000097          	auipc	ra,0x0
 7d4:	e08080e7          	jalr	-504(ra) # 5d8 <putc>
 7d8:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7da:	03c9d793          	srli	a5,s3,0x3c
 7de:	97de                	add	a5,a5,s7
 7e0:	0007c583          	lbu	a1,0(a5)
 7e4:	8556                	mv	a0,s5
 7e6:	00000097          	auipc	ra,0x0
 7ea:	df2080e7          	jalr	-526(ra) # 5d8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7ee:	0992                	slli	s3,s3,0x4
 7f0:	397d                	addiw	s2,s2,-1
 7f2:	fe0914e3          	bnez	s2,7da <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 7f6:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 7fa:	4981                	li	s3,0
 7fc:	b721                	j	704 <vprintf+0x60>
        s = va_arg(ap, char*);
 7fe:	008b0993          	addi	s3,s6,8
 802:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 806:	02090163          	beqz	s2,828 <vprintf+0x184>
        while(*s != 0){
 80a:	00094583          	lbu	a1,0(s2)
 80e:	c9a1                	beqz	a1,85e <vprintf+0x1ba>
          putc(fd, *s);
 810:	8556                	mv	a0,s5
 812:	00000097          	auipc	ra,0x0
 816:	dc6080e7          	jalr	-570(ra) # 5d8 <putc>
          s++;
 81a:	0905                	addi	s2,s2,1
        while(*s != 0){
 81c:	00094583          	lbu	a1,0(s2)
 820:	f9e5                	bnez	a1,810 <vprintf+0x16c>
        s = va_arg(ap, char*);
 822:	8b4e                	mv	s6,s3
      state = 0;
 824:	4981                	li	s3,0
 826:	bdf9                	j	704 <vprintf+0x60>
          s = "(null)";
 828:	00000917          	auipc	s2,0x0
 82c:	2a090913          	addi	s2,s2,672 # ac8 <malloc+0x15a>
        while(*s != 0){
 830:	02800593          	li	a1,40
 834:	bff1                	j	810 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 836:	008b0913          	addi	s2,s6,8
 83a:	000b4583          	lbu	a1,0(s6)
 83e:	8556                	mv	a0,s5
 840:	00000097          	auipc	ra,0x0
 844:	d98080e7          	jalr	-616(ra) # 5d8 <putc>
 848:	8b4a                	mv	s6,s2
      state = 0;
 84a:	4981                	li	s3,0
 84c:	bd65                	j	704 <vprintf+0x60>
        putc(fd, c);
 84e:	85d2                	mv	a1,s4
 850:	8556                	mv	a0,s5
 852:	00000097          	auipc	ra,0x0
 856:	d86080e7          	jalr	-634(ra) # 5d8 <putc>
      state = 0;
 85a:	4981                	li	s3,0
 85c:	b565                	j	704 <vprintf+0x60>
        s = va_arg(ap, char*);
 85e:	8b4e                	mv	s6,s3
      state = 0;
 860:	4981                	li	s3,0
 862:	b54d                	j	704 <vprintf+0x60>
    }
  }
}
 864:	70e6                	ld	ra,120(sp)
 866:	7446                	ld	s0,112(sp)
 868:	74a6                	ld	s1,104(sp)
 86a:	7906                	ld	s2,96(sp)
 86c:	69e6                	ld	s3,88(sp)
 86e:	6a46                	ld	s4,80(sp)
 870:	6aa6                	ld	s5,72(sp)
 872:	6b06                	ld	s6,64(sp)
 874:	7be2                	ld	s7,56(sp)
 876:	7c42                	ld	s8,48(sp)
 878:	7ca2                	ld	s9,40(sp)
 87a:	7d02                	ld	s10,32(sp)
 87c:	6de2                	ld	s11,24(sp)
 87e:	6109                	addi	sp,sp,128
 880:	8082                	ret

0000000000000882 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 882:	715d                	addi	sp,sp,-80
 884:	ec06                	sd	ra,24(sp)
 886:	e822                	sd	s0,16(sp)
 888:	1000                	addi	s0,sp,32
 88a:	e010                	sd	a2,0(s0)
 88c:	e414                	sd	a3,8(s0)
 88e:	e818                	sd	a4,16(s0)
 890:	ec1c                	sd	a5,24(s0)
 892:	03043023          	sd	a6,32(s0)
 896:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 89a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 89e:	8622                	mv	a2,s0
 8a0:	00000097          	auipc	ra,0x0
 8a4:	e04080e7          	jalr	-508(ra) # 6a4 <vprintf>
}
 8a8:	60e2                	ld	ra,24(sp)
 8aa:	6442                	ld	s0,16(sp)
 8ac:	6161                	addi	sp,sp,80
 8ae:	8082                	ret

00000000000008b0 <printf>:

void
printf(const char *fmt, ...)
{
 8b0:	711d                	addi	sp,sp,-96
 8b2:	ec06                	sd	ra,24(sp)
 8b4:	e822                	sd	s0,16(sp)
 8b6:	1000                	addi	s0,sp,32
 8b8:	e40c                	sd	a1,8(s0)
 8ba:	e810                	sd	a2,16(s0)
 8bc:	ec14                	sd	a3,24(s0)
 8be:	f018                	sd	a4,32(s0)
 8c0:	f41c                	sd	a5,40(s0)
 8c2:	03043823          	sd	a6,48(s0)
 8c6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8ca:	00840613          	addi	a2,s0,8
 8ce:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8d2:	85aa                	mv	a1,a0
 8d4:	4505                	li	a0,1
 8d6:	00000097          	auipc	ra,0x0
 8da:	dce080e7          	jalr	-562(ra) # 6a4 <vprintf>
}
 8de:	60e2                	ld	ra,24(sp)
 8e0:	6442                	ld	s0,16(sp)
 8e2:	6125                	addi	sp,sp,96
 8e4:	8082                	ret

00000000000008e6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8e6:	1141                	addi	sp,sp,-16
 8e8:	e422                	sd	s0,8(sp)
 8ea:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8ec:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8f0:	00000797          	auipc	a5,0x0
 8f4:	1f87b783          	ld	a5,504(a5) # ae8 <freep>
 8f8:	a805                	j	928 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8fa:	4618                	lw	a4,8(a2)
 8fc:	9db9                	addw	a1,a1,a4
 8fe:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 902:	6398                	ld	a4,0(a5)
 904:	6318                	ld	a4,0(a4)
 906:	fee53823          	sd	a4,-16(a0)
 90a:	a091                	j	94e <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 90c:	ff852703          	lw	a4,-8(a0)
 910:	9e39                	addw	a2,a2,a4
 912:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 914:	ff053703          	ld	a4,-16(a0)
 918:	e398                	sd	a4,0(a5)
 91a:	a099                	j	960 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 91c:	6398                	ld	a4,0(a5)
 91e:	00e7e463          	bltu	a5,a4,926 <free+0x40>
 922:	00e6ea63          	bltu	a3,a4,936 <free+0x50>
{
 926:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 928:	fed7fae3          	bgeu	a5,a3,91c <free+0x36>
 92c:	6398                	ld	a4,0(a5)
 92e:	00e6e463          	bltu	a3,a4,936 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 932:	fee7eae3          	bltu	a5,a4,926 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 936:	ff852583          	lw	a1,-8(a0)
 93a:	6390                	ld	a2,0(a5)
 93c:	02059713          	slli	a4,a1,0x20
 940:	9301                	srli	a4,a4,0x20
 942:	0712                	slli	a4,a4,0x4
 944:	9736                	add	a4,a4,a3
 946:	fae60ae3          	beq	a2,a4,8fa <free+0x14>
    bp->s.ptr = p->s.ptr;
 94a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 94e:	4790                	lw	a2,8(a5)
 950:	02061713          	slli	a4,a2,0x20
 954:	9301                	srli	a4,a4,0x20
 956:	0712                	slli	a4,a4,0x4
 958:	973e                	add	a4,a4,a5
 95a:	fae689e3          	beq	a3,a4,90c <free+0x26>
  } else
    p->s.ptr = bp;
 95e:	e394                	sd	a3,0(a5)
  freep = p;
 960:	00000717          	auipc	a4,0x0
 964:	18f73423          	sd	a5,392(a4) # ae8 <freep>
}
 968:	6422                	ld	s0,8(sp)
 96a:	0141                	addi	sp,sp,16
 96c:	8082                	ret

000000000000096e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 96e:	7139                	addi	sp,sp,-64
 970:	fc06                	sd	ra,56(sp)
 972:	f822                	sd	s0,48(sp)
 974:	f426                	sd	s1,40(sp)
 976:	f04a                	sd	s2,32(sp)
 978:	ec4e                	sd	s3,24(sp)
 97a:	e852                	sd	s4,16(sp)
 97c:	e456                	sd	s5,8(sp)
 97e:	e05a                	sd	s6,0(sp)
 980:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 982:	02051493          	slli	s1,a0,0x20
 986:	9081                	srli	s1,s1,0x20
 988:	04bd                	addi	s1,s1,15
 98a:	8091                	srli	s1,s1,0x4
 98c:	0014899b          	addiw	s3,s1,1
 990:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 992:	00000517          	auipc	a0,0x0
 996:	15653503          	ld	a0,342(a0) # ae8 <freep>
 99a:	c515                	beqz	a0,9c6 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 99c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 99e:	4798                	lw	a4,8(a5)
 9a0:	02977f63          	bgeu	a4,s1,9de <malloc+0x70>
 9a4:	8a4e                	mv	s4,s3
 9a6:	0009871b          	sext.w	a4,s3
 9aa:	6685                	lui	a3,0x1
 9ac:	00d77363          	bgeu	a4,a3,9b2 <malloc+0x44>
 9b0:	6a05                	lui	s4,0x1
 9b2:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9b6:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9ba:	00000917          	auipc	s2,0x0
 9be:	12e90913          	addi	s2,s2,302 # ae8 <freep>
  if(p == (char*)-1)
 9c2:	5afd                	li	s5,-1
 9c4:	a88d                	j	a36 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 9c6:	00000797          	auipc	a5,0x0
 9ca:	13a78793          	addi	a5,a5,314 # b00 <base>
 9ce:	00000717          	auipc	a4,0x0
 9d2:	10f73d23          	sd	a5,282(a4) # ae8 <freep>
 9d6:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9d8:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9dc:	b7e1                	j	9a4 <malloc+0x36>
      if(p->s.size == nunits)
 9de:	02e48b63          	beq	s1,a4,a14 <malloc+0xa6>
        p->s.size -= nunits;
 9e2:	4137073b          	subw	a4,a4,s3
 9e6:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9e8:	1702                	slli	a4,a4,0x20
 9ea:	9301                	srli	a4,a4,0x20
 9ec:	0712                	slli	a4,a4,0x4
 9ee:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9f0:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9f4:	00000717          	auipc	a4,0x0
 9f8:	0ea73a23          	sd	a0,244(a4) # ae8 <freep>
      return (void*)(p + 1);
 9fc:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a00:	70e2                	ld	ra,56(sp)
 a02:	7442                	ld	s0,48(sp)
 a04:	74a2                	ld	s1,40(sp)
 a06:	7902                	ld	s2,32(sp)
 a08:	69e2                	ld	s3,24(sp)
 a0a:	6a42                	ld	s4,16(sp)
 a0c:	6aa2                	ld	s5,8(sp)
 a0e:	6b02                	ld	s6,0(sp)
 a10:	6121                	addi	sp,sp,64
 a12:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a14:	6398                	ld	a4,0(a5)
 a16:	e118                	sd	a4,0(a0)
 a18:	bff1                	j	9f4 <malloc+0x86>
  hp->s.size = nu;
 a1a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a1e:	0541                	addi	a0,a0,16
 a20:	00000097          	auipc	ra,0x0
 a24:	ec6080e7          	jalr	-314(ra) # 8e6 <free>
  return freep;
 a28:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a2c:	d971                	beqz	a0,a00 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a2e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a30:	4798                	lw	a4,8(a5)
 a32:	fa9776e3          	bgeu	a4,s1,9de <malloc+0x70>
    if(p == freep)
 a36:	00093703          	ld	a4,0(s2)
 a3a:	853e                	mv	a0,a5
 a3c:	fef719e3          	bne	a4,a5,a2e <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 a40:	8552                	mv	a0,s4
 a42:	00000097          	auipc	ra,0x0
 a46:	b7e080e7          	jalr	-1154(ra) # 5c0 <sbrk>
  if(p == (char*)-1)
 a4a:	fd5518e3          	bne	a0,s5,a1a <malloc+0xac>
        return 0;
 a4e:	4501                	li	a0,0
 a50:	bf45                	j	a00 <malloc+0x92>
