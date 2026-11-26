---
sidebar_position: 14
authors: [luhuadong]
---

# Linux 信号量



信号量、同步这些名词在进程间通信时就已经说过，在这里它们的意思是相同的，只不过是同步的对象不同而已。但是下面介绍的信号量的接口是用于线程的信号量， 注意不要跟用于进程间通信的信号量混淆，关于用于进程间通信的信号量的详细介绍可以参阅我的另一篇博文： Linux进程间通信——使用信号量。相似地， 线程同步是控制线程执行和访问临界区域的方法。

## 什么是信号量

线程的信号量与进程间通信中使用的信号量的概念是一样，它是一种特殊的变量，它可以被增加或减少，但对其的关键访问被保证是原子操作。如果一个程序中有多个线程试图改变一个信号量的值，系统将保证所有的操作都将依次进行。

而只有0和1两种取值的信号量叫做二进制信号量，在这里将重点介绍。而信号量一般常用于保护一段代码，使其每次只被一个执行线程运行。我们可以使用二进制信号量来完成这个工作。

## 信号量的接口和使用

信号量的函数都以sem_开头，线程中使用的基本信号量函数有4个，它们都声明在头文件 semaphore.h中。

### 1、sem_init函数

该函数用于创建信号量，其原型如下：

```c showLineNumbers
int sem_init(sem_t *sem, int pshared， unsigned int value);
```

该函数初始化由sem指向的信号对象，设置它的共享选项，并给它一个初始的整数值。pshared控制信号量的类型，如果其值为0，就表示这个信号量是当前进程的局部信号量，否则信号量就可以在多个进程之间共享，value为sem的初始值。调用成功时返回0，失败返回-1.

### 2、sem_wait函数

该函数用于以原子操作的方式将信号量的值减1。原子操作就是，如果两个线程企图同时给一个信号量加1或减1，它们之间不会互相干扰。它的原型如下：

```c showLineNumbers
int sem_wait(sem_t *sem);
```

sem指向的对象是由sem_init调用初始化的信号量。调用成功时返回0，失败返回-1.

### 3、sem_post函数

该函数用于以原子操作的方式将信号量的值加1。它的原型如下：

```c showLineNumbers
int sem_post(sem_t *sem);
```

与sem_wait一样，sem指向的对象是由sem_init调用初始化的信号量。调用成功时返回0，失败返回-1.

### 4、sem_destroy函数

该函数用于对用完的信号量的清理。它的原型如下：

```c showLineNumbers
int sem_destroy(sem_t *sem);
```

成功时返回 0，失败时返回 -1.

## 使用信号量同步线程

下面以一个简单的多线程程序来说明如何使用信号量进行线程同步。在主线程中，我们创建子线程，并把数组msg作为参数传递给子线程，然后主线程等待直到有文本输入，然后调用sem_post来增加信号量的值，这样就会立刻使子线程从sem_wait的等待中返回并开始执行。线程函数在把字符串的小写字母变成大写并统计输入的字符数量之后，它再次调用sem_wait并再次被阻塞，直到主线程再次调用sem_post增加信号量的值。

```c showLineNumbers
#include <unistd.h>
#include <pthread.h>
#include <semaphore.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
 
//线程函数
void *thread_func(void *msg);
sem_t sem;//信号量
 
#define MSG_SIZE 512
 
int main()
{
	int res = -1;
	pthread_t thread;
	void *thread_result = NULL;
	char msg[MSG_SIZE];
	//初始化信号量，其初值为0
	res = sem_init(&sem, 0, 0);
	if(res == -1)
	{
		perror("semaphore intitialization failed\n");
		exit(EXIT_FAILURE);
	}
	//创建线程，并把msg作为线程函数的参数
	res = pthread_create(&thread, NULL, thread_func, msg);
	if(res != 0)
	{
		perror("pthread_create failed\n");
		exit(EXIT_FAILURE);
	}
	//输入信息，以输入end结束，由于fgets会把回车（\n）也读入，所以判断时就变成了“end\n”
	printf("Input some text. Enter 'end'to finish...\n");
	while(strcmp("end\n", msg) != 0)
	{
		fgets(msg, MSG_SIZE, stdin);
		//把信号量加1
		sem_post(&sem);
	}
 
	printf("Waiting for thread to finish...\n");
	//等待子线程结束
	res = pthread_join(thread, &thread_result);
	if(res != 0)
	{
		perror("pthread_join failed\n");
		exit(EXIT_FAILURE);
	}
	printf("Thread joined\n");
	//清理信号量
	sem_destroy(&sem);
	exit(EXIT_SUCCESS);
}
 
void* thread_func(void *msg)
{
	//把信号量减1
	sem_wait(&sem);
	char *ptr = msg;
	while(strcmp("end\n", msg) != 0)
	{
		int i = 0;
		//把小写字母变成大写
		for(; ptr[i] != '\0'; ++i)
		{
			if(ptr[i] >= 'a' && ptr[i] <= 'z')
			{
				ptr[i] -= 'a' - 'A';
			}
		}
		printf("You input %d characters\n", i-1);
		printf("To Uppercase: %s\n", ptr);
		//把信号量减1
		sem_wait(&sem);
	}
	//退出线程
	pthread_exit(NULL);
}
```





