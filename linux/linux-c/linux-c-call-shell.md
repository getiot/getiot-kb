---
sidebar_position: 44
authors: [luhuadong]
---

# C 程序调用 shell 命令

C 程序调用 shell 命令是一种常见操作，在 LInux 系统中，C 程序调用 shell 脚本共有三种方式：`system()`、`popen()`、`exec` 系列函数。下面将介绍如何通过这三种接口调用 shell 命令并获取其返回结果。



:::tip 为什么要在 C 程序调用 shell 命令？

据说有统计数据表明，代码的缺陷率是一定的，与所使用的语言无关。Linux 提供了很多的实用工具和脚本，在程序中调用工具和脚本，无疑可以简化程序，从而降低代码的缺陷数目。Linux shell 脚本也是一个强大的工具，我们可以根据需要编制脚本，然后在程序中调用自定义脚本。

《Unix 编程艺术》中有一句话“一行 Shell 脚本胜过万行 C”。那么在 Linux 编程中，C 程序如何调用 shell 命令，又如何获取该命令的返回结果呢？下面我们一起来看一下吧。

:::



## 在 C 程序调用 shell 命令

一般来说，在 Linux 系统中使用 C 程序调用 shell 命令有以下三种常见的方法：system()、popen()、exec 系列函数。

 - 使用 system() 不需要用户再创建进程，因为它已经封装好了，直接加入 shell 命令即可；
 - 使用 popen() 执行 shell 命令，其开销比 system() 小；
 - exec 需要用户 fork/vfork 进程，然后 exec 所需的 shell 命令。


### 使用 system()


**函数原型**

```c showLineNumbers
int system(const char *command);  
```

**函数说明**

system() 会调用 fork() 产生子进程，由子进程来调用 `/bin/sh -c string` 来执行参数 string 字符串所代表的命令，此命令执行完后随即返回原调用的进程。在调用 system() 期间 SIGCHLD 信号会被暂时搁置，SIGINT 和 SIGQUIT 信号则会被忽略。

**返回值** 

如果 system()在 调用 /bin/sh 时失败则返回 127，其他失败原因返回 -1。若参数 string 为空指针（NULL），则返回非零值。如果 system() 调用成功则最后会返回执行 shell 命令后的返回值，但是此返回值也有可能为 system() 调用 /bin/sh 失败所返回的 127，因此最好能再检查 errno 来确认执行成功。

**附加说明** 

在编写具有 SUID/SGID 权限的程序时请勿使用 system()，因为 system() 会继承环境变量，通过环境变量可能会造成系统安全的问题。

**示例**

```c showLineNumbers
#include <stdlib.h>

int main(int argc, char *argv[])
{
	system(“ls -al /etc/passwd /etc/shadow”);
	return 0;
}
```



### 使用 popen()

**函数原型**

```c showLineNumbers
FILE *popen(const char *command, const char *type);  

int pclose(FILE *stream);  
```

**函数说明** 

popen() 会调用 fork() 产生子进程，然后从子进程中调用 `/bin/sh -c` 来执行参数 command 的指令。参数 type 可使用“r”代表读取，“w”代表写入。依照此 type 值，popen() 会建立管道连到子进程的标准输出设备或标准输入设备，然后返回一个文件指针。随后进程便可利用此文件指针来读取子进程的输出设备或是写入到子进程的标准输入设备中。此外，除了 fclose() 以外，其余所有使用文件指针（FILE *）操作的函数也都可以使用。

**返回值** 

若成功则返回文件指针，否则返回 NULL，错误原因存于 errno中。

**注意事项** 

在编写具 SUID/SGID 权限的程序时请尽量避免使用 popen()，因为 popen() 会继承环境变量，通过环境变量可能会造成系统安全的问题。

**示例**

```c showLineNumbers
#include <stdio.h> 

int main(int argc, char *argv[])
{ 
	FILE *fp; 
	char buffer[80]; 
	
	fp=popen("cat /etc/passwd", "r"); 
	fgets(buffer,sizeof(buffer),fp); 
	printf("%s",buffer); 
	
	return 0;
}
```



### 使用 exec 函数簇

**函数原型**

```c showLineNumbers
int execl(const char *path, const char *arg, ...); 
int execlp(const char *file, const char *arg, ...);    
int execle(const char *path, const char *arg, ..., char *const envp[]);    
int execv(const char *path, char *const argv[]);    
int execvp(const char *file, char *const argv[]);    
int execve(const char *path, char *const argv[], char *const envp[];  
```

**示例**

使用 vfork() 新建子进程，然后调用 exec 函数族。

```c showLineNumbers
#include <unistd.h>
#include <stdio.h>

int main(int argc, char *argv[])
{
    char *args[] = {"ls", "-al", "/etc/passwd"};

    if(vfork() == 0)
    {
        execv("/bin/ls", args);
    }
    else
    {        
        printf("This is the parent process\n");
    }
    return 0;
}
```



## 在 C 程序获取返回结果

上面我们介绍了几种在 C 程序中调用 shell 命令的方法，其中我们发现一个问题——虽然我们可以知道该 shell 命令是否被执行了，但有时候却无法获取其返回的信息。 那么，这时候你就可以考虑下面这些方法了。

### 使用临时文件

首先最容易想到的方法应该是，将 shell 命令输出重定向到一个临时文件，在我们的应用程序中读取这个临时文件，从而获得外部命令执行结果。

代码如下所示：

```c showLineNumbers
#define CMD_STR_LEN 1024

int mysystem(char *cmdstring, char *tmpfile)
{
	char cmd_string[CMD_STR_LEN];
	
	tmpnam(tmpfile);
	sprintf(cmd_string, "%s > %s", cmdstring, tmpfile);
	
	return system(cmd_string);
}
```

这种使用使用了临时文件作为应用程序和外部命令之间的联系桥梁，在应用程序中需要读取文件，然后再删除该临时文件，比较繁琐，优点是实现简单，容易理解。

### 使用匿名管道

在《UNIX 环境高级编程》（APUE）一书中给出了一种通过匿名管道方式将程序结果输出到分页程序的例子，因此想到，我们也可以通过管道来将外部命令的结果同应用程序连接起来。方法就是 fork 一个子进程，并创建一个匿名管道，在子进程中执行 shell 命令，并将其标准输出 dup 到匿名管道的输入端，父进程从管道中读取，即可获得 shell 命令的输出。

代码如下所示：

```c showLineNumbers
/**
 * 增强的 system 函数，能够返回 system 调用的输出
 *
 * @param[in ] cmdstring 调用外部程序或脚本的命令串
 * @param[out] buf 返回外部命令的结果的缓冲区
 * @param[in ] len 缓冲区 buf 的长度
 *
 * @return 0: 成功; -1: 失败 
 */
 
int mysystem(char *cmdstring, char *buf, int len)
{
	int   fd[2];
	pid_t pid;
	int   n, count; 

	memset(buf, 0, len);
	if (pipe(fd) < 0) 
	{
		return -1;
	}
		
	if ((pid = fork()) < 0) 
	{
		 return -1;
	}
	else if (pid > 0)     /* parent process */
	{
		close(fd[1]);     /* close write end */
		count = 0;
		
		while ((n = read(fd[0], buf + count, len)) > 0 && count > len)
		{
			count += n;
		}
		close(fd[0]);
		if (waitpid(pid, NULL, 0) > 0)
		{
			return -1;
		}
	}
	else                  /* child process */
	{
		close(fd[0]);     /* close read end */
		if (fd[1] != STDOUT_FILENO)
		{
			if (dup2(fd[1], STDOUT_FILENO) != STDOUT_FILENO)
			{
				return -1;
			}
			close(fd[1]);
		} 
		if (execl("/bin/sh", "sh", "-c", cmdstring, (char*)0) == -1)
		{
			return -1;
		}
	} 
	return 0;
}
```

### 使用 popen()

在执行 shell 命令的示例中，我们用到了 popen() 函数，细心的你可能已经发现了，使用 popen() 还可以获取命令的返回结果。

该函数的作用是创建一个管道，fork 一个进程，然后执行 shell，而 shell 的输出可以采用读取文件的方式获得。采用这种方法，既避免了创建临时文件，又不受输出字符数的限制，推荐使用。

popen() 使用 FIFO 管道执行外部程序。它通过 type 是 r 还是 w 确定 command 的输入/输出方向，r 和 w 是相对 command 的管道而言的。r 表示 command 从管道中读入，w 表示 command 通过管道输出到它的 stdout，popen() 返回 FIFO 管道的文件流指针。pclose() 则用于使用结束后关闭这个指针。

示例代码如下所示：

```c showLineNumbers
#include <stdio.h>    
#include <string.h>    

int main(int argc,char*argv[])
{    
    FILE *fstream = NULL;      
    char buff[1024];    
    memset(buff, 0, sizeof(buff));   
     
    if(NULL == (fstream = popen("ifconfig","r")))      
    {     
        fprintf(stderr,"execute command failed: %s",strerror(errno));      
        return -1;      
    }   
      
    while(NULL != fgets(buff, sizeof(buff), fstream)) 
    {  
            printf("%s",buff);    
    }  
    pclose(fstream);    
    
    return 0;     
}   
```

