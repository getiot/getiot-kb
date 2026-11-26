---
sidebar_position: 7
authors: [luhuadong]
---

# Linux 进程间通信



## 共享文件

两个进程可以通过**共享文件**的方式进行通信，即一个进程在文件中写入消息，另外一个进程从文件中读出信息。这两个进程有无血缘关系均可以。但是通过共享同一个文件进行进程间通信的缺点是，两个进程的读写同步问题，即一个进程写的慢另外一个进程读的快的时候会读不到内容。示例代码如下：

```c showLineNumbers
int main(int argc, const char* argv[])
{
       int fd = open("My_file", O_CREAT | O_RDWR,0664);
       if(-1 == fd){
              perror("open My_file error!");
              exit(1);
       }
       pid_t pid = fork();//创建子进程
       if(-1 == pid){
              perror("fork error!");
              exit(1);
       }
       if(pid > 0){ //父进程写
              char *temp = "The first test IPC msg by file is successfuly!\n";
              write(fd, temp, strlen(temp)+1);
              close(fd);
       }else if(0 == pid){ //子进程读
              sleep(1); //睡眠1秒的原因是为了保证此时父进程完成写操作。
              char read_buf[1024];
              lseek(fd, 0, SEEK_SET); //保证文件指针在文件头部
              int len = read(fd, read_buf, sizeof(read_buf));
              printf("%s\n",read_buf);
              close(fd);
       }
       return 0;
}
```



## 匿名管道pipe

匿名管道pipe的实质是内核的缓冲区，它不占用磁盘空间。 一个pipe分为读写两部分，有读和写两个文件描述符，pipe是半双工的一个进程写的时候要把它的读端文件描述符关掉，读的时候要把他的写端文件描述符关掉。pipe默认是阻塞的，写端进程没有写入数据的时候读端进程不用再刻意sleep去等待，而是一直阻塞在那里等待直到写端进程写入。pipe实现是以环形队列形式实现的，所以数据只能读一次（两个进程只有一个进程能从pipe中读消息，读完后队列中这条消息就没有了。pipe在进程结束时有系统回收。匿名管道特点是只能进行有血缘关系的进程间通信，没有血缘关系的进程间无法使用pipe进行通信。示例代码如下：

```c showLineNumbers
int main(int argc, const char* argv[])
{
       int fd[2]={0};
       int ret = pipe (fd);//fd[0]为读端，fd[1]为写端
       if(-1 == ret){
              perror("pipe error!");
              exit(1);   
       }
       pid_t pid = fork();//创建子进程
       if(-1 == pid){
              perror("fork error!");
              exit(1);
       }
       if(pid > 0){ //父进程写,关闭读端
              close(fd[0]);
              char *temp = "The first test IPC msg by pipe is successfuly!\n";
              write(fd[1], temp, strlen(temp)+1);
              close(fd[1]);
       }else if(0 == pid){ //子进程读,关闭写端   
              close(fd[1]);
              char read_buf[1024];           
              int len = read(fd[0], read_buf, sizeof(read_buf));
              printf("%s\n",read_buf);
              close(fd[0]);
       }
       return 0;
}
```



## 有名管道fifo

有名管道fifo的实质是磁盘一个大小为0的文件映射一个内核缓冲区，它不占用磁盘空间，所以fifo在磁盘上空间永远为0。fifo默认是阻塞的，写端没有写入数据的时候读端不用可以sleep去等待，而是一直阻塞在那里等待写端写入。fifo是伪文件，它可以使用open、close、read、write等文件IO操作但是不能使用lseek操作。fifo特点是能进行无血缘关系的进程间通信。示例代码如下：

写端代码：

```c showLineNumbers
int main(int argc, const char* argv[])
{
       if(argc < 2){
              printf("The right step is: ./a.out fifoname\n");
              exit(1);
       }
       //判断文件是否存在
       int ret = access(argv[1], F_OK);

       if(-1 == ret){
              ret = mkfifo(argv[1], 0664);        
              if(-1 == ret){
                     printf("mkfifo error!\n");
                     exit(1);
              }
              printf("Create %s fifo sucess!\n",argv[1]);
       }
       int fd = open(argv[1], O_WRONLY);
       if(-1 == fd){
              printf("open error!\n");
              exit(1);
       }
       while(1){
              sleep(1);
              char* Msg;
              time_t now_time;
              time(&now_time);
              Msg = ctime(&now_time);
              strcat(Msg, "The first test IPC msg by pipe is successfuly.\n");         
              write(fd, Msg, strlen(Msg)); 

       }
       close (fd);
       return 0;
}
```

读端代码

```c showLineNumbers
int main(int argc, const char* argv[])
{
       if(argc < 2){
              printf("The right step is: ./a.out fifoname\n");
              exit(1);
       }
       printf("argv[1] %s\n", argv[1]);
       //判断文件是否存在
       //int ret = access(argv[1], F_OK);
       //if(-1 == ret){
              int result = mkfifo(argv[1], 0664);             
              if(-1 == result){
                     printf("mkfifo error!\n");
                     exit(1);
              }
              printf("Create %s fifo sucess!\n",argv[1]);
       //}
       int fd = open(argv[1], O_RDONLY);

       if(-1 == fd){
              printf("open error!\n");
              exit(1);
       }
       while(1){
              char read_buf[1024];                  
              int read_len = read(fd, read_buf, sizeof(read_buf));
              printf("%s\n",read_buf);             
       }
       close (fd);      
       return 0;
}
```



## 消息队列

消息队列是消息的链接表 ,消息队列存放在内核中并由消息队列标识符标识。消息队列的特点是把数据放在某个内存之后就会马上返回，无需等待其他进程来取就返回。消息队列有两套标准。POSIX标准和System V 标准，两者 对信号量、共享内存、消息队列等进程之间共享方式提供了自己的解决方案具体区别稍后会再写一篇文章。这里以System V 标准说明。

消息队列、信号量以及共享内存之间有很多相似之处。每个内核中的 I P C结构（消息队列、信号量或共享存储段）都用一个非负整数的标识符( i d e n t i f i e r )加以引用。 

无论何时创建I P C结构,都应指定一个关键字（k e y），通过 ftok函数可以产生一个key值。函数类型key_t ftok(const char *path, int id); //“/home/linux” , 'a' 参数path必须引用一个现有的文件，参数id只使用期低8位即0~255的字符。

创建或取得一个消息队列对象使用msgget函数，函数类型int msgget(key_t key, int flag);参数key:创建消息队列的关键字。参数flag:可以是0或者IPC_CREAT(不存在就创建) 。返回值：消息队列的id ,若出错则返回-1。

消息发送msgsnd函数，函数类型int msgsnd(int msqid, const void *msgp, size_t msgsz, int msgflg);函数功能：将msgp消息写入标识为msgid的消息队列，消息长度为msgsz。参数msgflg可以指定为IPC_NOWAIT，类似于文件IO的非阻塞标志。

消息接收msgrcv函数，函数类型ssize_t msgrcv(int msqid, void *msgp, size_t msgsz, long msgtype, int msgflg);功能：从标识符为msgid的消息队列里接收一个指定类型的消息 并 存储于msgp中 读取后 把消息从消息队列中删除msgtype：为 0 表示无论什么类型 都可以接收，大于0返回队列中第一个消息类型为msgtype的消息，小于0返回队列中消息类型消息msgtype绝对值的消息。msgflg：如果是0 标识如果没有指定类型的消息 就一直等待，如果是IPC_NOWAIT 则表示不等待。

发送端代码

```c showLineNumbers
typedef struct{
    long type;
    char name[20];
    int age;
}Msg;

int main(int argc, const char* argv[])
{
       key_t key = ftok("~/",'a');
    printf("A key:%x\n",key);
    int msgid = msgget(key,IPC_CREAT|O_WRONLY|0777);
    if(msgid<0)
    {  
        perror("msgget error!");
        exit(-1);
    }  
    Msg m;
       while(1){
              printf("\nplease input your type name age:");
           scanf("%ld%s%d",&m.type,m.name,&m.age);
            msgsnd(msgid,&m,sizeof(m)-sizeof(m.type),0);
              sleep(1);
       }
    return 0;

}
```

接收端代码

```c showLineNumbers
typedef struct{
    long type;
    char name[20];
    int age;
}Msg;

 
int main()
{
    key_t key = ftok("~/",'a');
    printf("B key:%x\n",key);
    int msgid = msgget(key,O_RDONLY);

    if(msgid<0)
    {  
        perror("msgget error!");
        exit(-1);
    }  
    Msg rcv;
    long type;
       printf("waitting recv");
       while(1){
              msgrcv(msgid,&rcv,sizeof(rcv)-sizeof(type),0,0);
           printf("rcv--name:%s age:%d\n",rcv.name,rcv.age);                 
       }
       msgctl(msgid,IPC_RMID,NULL);
    return 0;
}
```



## 共享内存

共享内存用于进程间通信的时候由于是直接操作内存所以效率高，但是没有阻塞属性，所以就要考虑两个进程写入和读出的先后性问题了。mmap可以通过将一个已存在的一个文件映射到内存让两个进程读写来进行进程间通信。当然mmap也可以可以直接在内存映射一个匿名映射区进行进程间通信。但是mmap用于无血缘关系的进程间通信时，必须借助一个已存在的文件的内存映射区进行。共享内存示例代码如下：

```c showLineNumbers
int main(int argc, const char* argv[])
{
       int fd = open("My_file", O_CREAT | O_RDWR,0664);

       if(-1 == fd){
              perror("open My_file error!");
              exit(1);
       }
       ftruncate(fd, 4096);
       int len = lseek(fd, 0, SEEK_END);
       lseek(fd, 0, SEEK_SET);
    printf("len = %d\n", len);
       void* ptr = mmap(NULL, len, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);

       if(MAP_FAILED == ptr){
              perror("mmap error!");
              exit(1);
       }
       close(fd);
       printf("%s\n", (char *)ptr);
       pid_t pid = fork();//创建子进程

       if(-1 == pid){
              perror("fork error!");
              exit(1);
       }
       if(pid > 0){ //父进程写       
              char* Msg;
              time_t now_time;
              time(&now_time);
              Msg = ctime(&now_time);
              strcat(Msg, "The first test IPC msg by file is successfuly!\n");
              strcpy(ptr, Msg); //写数据
              wait(NULL); //回收

       }else if(0 == pid){ //子进程读           
              printf("recv :%s\n",ptr); //读数据       
       }
       int ret = munmap(ptr, len); //释放内存映射区

       if(-1 == ret){
              perror("munmap error!");
              exit(1);
       }
       return 0;
}
```



## 信号量

共享内存用于进程间的通信可能存在多个进程竞争内存您的问题，为避免这个问题而我们可以使用信号量进行进程间通信。信号量是一种用于实现计算机资源共享的IPC机制之一，其本质是一个计数器。信号量是在多进程环境下实现资源互斥访问或共享资源访问的方法，可以用来保证两个或多个关键代码段不被并发调用。在进入一个关键代码段之前，进程/线程必须获取一个信号量；一旦该关键代码段完成了，那么该进程必须释放信号量。其它想进入该关键代码段的线程必须等待直到第一个进程释放信号量。

信号量有两种应用形式：一种用于临界资源的互斥访问，临界资源在同一时刻只允许一个进程使用，此时的信号量是一个二元信号量，它只控制一个资源；另一种应用于处理多个共享资源（例如多台打印机的分配），信号量在其中起到记录空闲资源数目的作用。

- 内核信号量
- POSIX 信号量
- System V 信号量

 

## 套接字socket

前边的几种进程间的通信方式只适合同一台主机的不同进程间的通信，对于相隔千里之外的不同主机间的进程我们可以使用套接字socket编程实现。这个比较复杂。我们改天单独写一篇。





