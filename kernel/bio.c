// Buffer cache.
//
// The buffer cache is a linked list of buf structures holding
// cached copies of disk block contents.  Caching disk blocks
// in memory reduces the number of disk reads and also provides
// a synchronization point for disk blocks used by multiple processes.
//
// Interface:
// * To get a buffer for a particular disk block, call bread.
// * After changing buffer data, call bwrite to write it to disk.
// * When done with the buffer, call brelse.
// * Do not use the buffer after calling brelse.
// * Only one process at a time can use a buffer,
//     so do not keep them longer than necessary.


#include "types.h"
#include "param.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "riscv.h"
#include "defs.h"
#include "fs.h"
#include "buf.h"

#define BUCKET 13
struct {
  struct spinlock lock;
  struct buf buf[NBUF];

  // Linked list of all buffers, through prev/next.
  // Sorted by how recently the buffer was used.
  // head.next is most recent, head.prev is least.
  // struct buf head;
  struct spinlock bucket_lock[BUCKET];
  struct buf bucket[BUCKET];
} bcache;



void
binit(void)
{
  struct buf *b;

  for (int i = 0; i < BUCKET; i++)
  {
    /* code */
    initlock(&bcache.bucket_lock[i],"bucket_lock");
    bcache.bucket[i].next = 0;
  }

  

  initlock(&bcache.lock, "bcache");
  int bucket_num = 0;
  int count = 0;
  // Create linked list of buffers
  // bcache.head.prev = &bcache.head;
  // bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    // b->next = bcache.head.next;
    // b->prev = &bcache.head;
    bucket_num = count++ % BUCKET;
    b->refcnt = 0;
    b->lastuse = 0;
    b->next = bcache.bucket[bucket_num].next;
    bcache.bucket[bucket_num].next = b;
    initsleeplock(&b->lock, "buffer");
    // bcache.head.next->prev = b;
    // bcache.head.next = b;
  }

}

// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint blockno)
{
  struct buf *b;

  printf("start bget...\n");
  int bucket_num = blockno%BUCKET;
  acquire(&bcache.bucket_lock[bucket_num]);

  // Is the block already cached?
  for(b = bcache.bucket[bucket_num].next; b; b = b->next){
    if(b->dev == dev && b->blockno == blockno){
      b->refcnt++;
      release(&bcache.bucket_lock[bucket_num]);
      acquiresleep(&b->lock);
      return b;
    }
  }
  release(&bcache.bucket_lock[bucket_num]);

  acquire(&bcache.lock);

  for(b = bcache.bucket[bucket_num].next; b; b = b->next){
    if(b->dev == dev && b->blockno == blockno){
      acquire(&bcache.bucket_lock[bucket_num]);
      b->refcnt++;
      release(&bcache.bucket_lock[bucket_num]);
      release(&bcache.lock);
      acquiresleep(&b->lock);
      return b;
    }
  }
  // Not cached.
  // Recycle the least recently used (LRU) unused buffer.
  // for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
  //   if(b->refcnt == 0) {
  //     b->dev = dev;
  //     b->blockno = blockno;
  //     b->valid = 0;
  //     b->refcnt = 1;
  //     release(&bcache.lock);
  //     acquiresleep(&b->lock);
  //     return b;
  //   }
  // }
  // panic("bget: no buffers");

  // use bache_lock, double check if block cache is not reffered between lock release
  // when holding a lock and acquire another lock, may cause deadlock,especially when acquire them in a loop
  // either they don't compete for the same lock, or hold a coarse-lock so only one can get it. make it serial
  // serial means a coarse lock
  // when modifying a buffer proteced by lock, use the lock;
 
  struct buf *used_least = 0; 
  uint holding_bucket = -1;
  for (int i = 0; i < BUCKET; i++)
  {
    /* code */
    int found = 0;
    acquire(&bcache.bucket_lock[i]);
    for(b = &bcache.bucket[i]; b->next; b = b->next){
      if(b->next->refcnt == 0 && (!used_least || b->next->lastuse < used_least->next->lastuse)){
        used_least = b;
        found = 1;
      }
    }
    if(!found){
      release(&bcache.bucket_lock[i]);
    }else{
      if(holding_bucket != -1) release(&bcache.bucket_lock[holding_bucket]);
      holding_bucket = i;
    }
  }
  if(!used_least){
    panic("bget: no buffers");
  }
  b = used_least->next;
  if(holding_bucket != bucket_num){
    used_least->next = b->next;
    release(&bcache.bucket_lock[holding_bucket]);
    acquire(&bcache.bucket_lock[bucket_num]);
    b->next = bcache.bucket[bucket_num].next;
    bcache.bucket[bucket_num].next = b;
    
  }
 
  b->dev = dev;
  b->blockno = blockno;
  b->refcnt = 1;
  b->valid = 0;
  release(&bcache.bucket_lock[bucket_num]);
  release(&bcache.lock);
  acquiresleep(&b->lock);

  return b;
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
  virtio_disk_rw(b, 1);
}

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");

  releasesleep(&b->lock);
  int buck_num = b->blockno % BUCKET;
  acquire(&bcache.bucket_lock[buck_num]);
  b->refcnt--;
  if (b->refcnt == 0) {
    // no one is waiting for it.
    // b->next->prev = b->prev;
    // b->prev->next = b->next;
    // b->next = bcache.head.next;
    // b->prev = &bcache.head;
    // bcache.head.next->prev = b;
    // bcache.head.next = b;
    b->lastuse = ticks;

  }
  
  release(&bcache.bucket_lock[buck_num]);
}

void
bpin(struct buf *b) {
  int buck_num = b->blockno % BUCKET;
  acquire(&bcache.bucket_lock[buck_num]);
  b->refcnt++;
  release(&bcache.bucket_lock[buck_num]);
}

void
bunpin(struct buf *b) {
  int buck_num = b->blockno % BUCKET;
  acquire(&bcache.bucket_lock[buck_num]);
  b->refcnt--;
  release(&bcache.bucket_lock[buck_num]);
}


