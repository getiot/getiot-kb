---
sidebar_position: 15
authors: [luhuadong]
---

# Linux 多线程



Pthreads（即 POSIX Threads）是一套通用的线程库，由 POSIX 委员会定义，并被广泛应用于类 UNIX 系统，具有很好的可移植性。

Pthreads 规定了 API 来处理线程要求的大部分行为，包括创建和终止线程、等待线程完成、以及管理线程之间的交互。还有线程的锁定机制，以阻止多个线程同时尝试修改同一块数据，锁定机制包括互斥锁、条件变量。

因此，关于 Linux 多线程编程部分，主要学习三方面内容：线程管理（创建、分离、joinable 以及设置线程属性等）；互斥锁（创建、销毁、lock 和 unlock 等）；条件变量（conditon variable）。



## 线程管理

每个线程都有一个在进程中唯一的线程标识符，用一个数据类型 **pthread_t** 表示，该数据类型在 Linux 中是一个无符号长整型。

### 创建线程

```c showLineNumbers
int pthread_create(pthread_t *thread, const pthread_attr_t *attr, 
                   void *(*start_routine)(void *), void *arg);
```

参数和返回值说明：

| 参数          | 描述                                                         |
| ------------- | ------------------------------------------------------------ |
| thread        | 线程标识符（指向线程 ID 的指针，由该线程创建函数填入）       |
| attr          | 线程属性（包括线程调度策略、堆栈信息、join 或 detach 状态等） |
| start_routine | 线程运行函数的起始地址                                       |
| arg           | 传递给运行函数的参数                                         |
| **返回值**    |                                                              |
| 0             | 创建成功                                                     |
| 错误码        | 创建失败                                                     |

注意：大多数 pthread 函数的返回值都是成功返回 0，失败返回错误码，但并不会设置 errno 值。

关于线程属性 attr 的管理，pthreads 也提供了一系列接口，例如 `pthread_attr_init` 和 `pthread_attr_destroy` 函数分别用来创建和销毁 pthread_attr_t 对象。

```c showLineNumbers
int pthread_attr_init(pthread_attr_t *attr);
int pthread_attr_destroy(pthread_attr_t *attr);
```



### 终止线程

线程的终止可以分为两种情况 —— 主动结束和被动终止。具体来说，当发生以下情形之一时，线程就会结束：

- 线程运行的函数 return 了，也就是线程的任务已经完成；
- 线程调用了 `pthread_exit` 函数；
- 其他线程调用 `pthread_cancel` 结束这个线程；
- 进程调用 `exec()` 或 `exit()` 结束了；
- `main()` 函数先结束了，而且 `main()` 本身没有调用 `pthread_exit` 来等所有线程完成任务。

当然，一个线程结束，并不意味着它的所有信息都已经消失，后面会看到僵尸线程的问题。

下面介绍两个终止线程的函数：

```c showLineNumbers
void pthread_exit(void *retval);
```

`pthread_exit()` 将退出调用它的线程。retval 是由用户指定的参数， pthread_exit 完成之后可以通过这个参数获得线程的退出状态。

```c showLineNumbers
int pthread_cancel(pthread_t thread);
```

一个线程可以通过调用 `pthread_cancel()` 函数来请求取消同一进程中的线程，这个线程由 thread 参数指定，如果操作成功则返回 0，失败则返回对应的错误码。



### 对线程的阻塞

这里说的“阻塞”是指对线程的连接（join）和分离（detach），阻塞是线程之间同步的一种方法。

```c showLineNumbers
int pthread_join(pthread_t thread, void **retval);
```

`pthread_join` 函数会让调用它的线程等待参数 thread 指定的线程运行结束之后再运行，参数 retval 存放了其他线程的返回值。

另外，需要特别提醒，线程不能 join 自己。一个可以被 join 的线程，也仅仅可以被别的一个线程 join，如果同时有多个线程尝试 join 同一个线程时，最终结果是未知的。

上面提到过，创建一个线程时，要赋予它一定的属性，这其中就包括 joinable 或 detachable 的属性，只有被声明成 joinable 的线程，才可以被其他线程 join。POSIX 标准的最终版本指出线程应该被设置成 joinable 的。显式地设置一个线程为 joinable，需要以下四个步骤：

- 声明 `pthread_attr_t` 线程属性变量；
- 调用 `pthread_attr_init()` 函数初始化线程属性变量；
- 调用 `pthread_attr_setdetachstate()` 函数设置线程分离状态属性；
- 设置完成后调用 `pthread_attr_destroy()` 函数释放属性使用的库资源。

示例代码：

```c showLineNumbers
void *thread_entry(void)
{
    ...
    pthread_exit(NULL);
}

int main(void)
{
    pthread_t tid;
    pthread_attr_t attr;

    /* For portability, explicitly create threads in a joinable state */
    pthread_attr_init(&attr);
    pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);
    pthread_create(&tid, &attr, thread_entry, NULL);
    
    ...
    pthread_attr_destroy(&attr);
    pthread_join(tid, NULL);
    pthread_exit(NULL);
}
```

值得注意的的是：僵尸线程（“zombie” thread）是一种已经退出了的 joinable 的线程，但仍在等待其他线程调用 `pthread_join()` 来 join 它，以收集它的退出信息（exit status）。如果没有其他线程 join 它的话，那么它占用的一些系统资源将不会被释放，比如堆栈。如果 `main()` 函数需要长时间运行，并且创建大量 joinable 的线程，就有可能出现进程堆栈不足的问题。因此，对于那些不需要 join 的线程，最好调用 `pthread_detach()` 将其设置为分离状态，这样它运行结束后，资源就会及时得到释放。注意，当一个线程被使用 pthread_detach 之后，它就不能再被改成 joinable 的了。

总而言之，创建的每一个线程都应该使用 `pthread_join` 或者 `pthread_detach` 其中一个，以防止僵尸线程的出现。

相关函数：

```c showLineNumbers
int pthread_detach(pthread_t thread);
int pthread_attr_setdetachstate(pthread_attr_t *attr, int detachstate);
int pthread_attr_getdetachstate(const pthread_attr_t *attr, int *detachstate);
```

示例代码：

```c showLineNumbers
void *thread_entry(void)
{
    /* Actively release resources in child thread */
    pthread_detach(pthread_self());
    ...
    pthread_exit(NULL);
}

int main(void)
{
    pthread_t tid;
    pthread_attr_t attr;
    
    /* Release child thread resources in the main thread */
    pthread_attr_init(&attr);
    pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
    pthread_create(&tid, &attr, thread_entry, NULL);
    
    ...
    pthread_attr_destroy(&attr);
    pthread_exit(NULL);
}
```

在主线程中释放子线程占用的资源，和在子线程中主动释放，两者选其一即可。



### 堆栈管理

POSIX 标准没有规定一个线程的堆栈大小。安全可移植的程序不会依赖于具体实现默认的堆栈限制，而是显式地调用 `pthread_attr_setstacksize` 来分配足够的堆栈空间。

相关函数：

```c showLineNumbers
int pthread_attr_setstacksize(pthread_attr_t *attr, size_t stacksize);
int pthread_attr_getstacksize(const pthread_attr_t *attr, size_t *stacksize);
int pthread_attr_setstackaddr(pthread_attr_t *attr, void *stackaddr);
int pthread_attr_getstackaddr(const pthread_attr_t *attr, void **stackaddr);
```



## 其他重要函数

```c showLineNumbers
pthread_t pthread_self(void);
int pthread_equal(pthread_t t1, pthread_t t2);
```

`pthread_self` 可以返回调用该函数的线程 ID，而 `pthread_equal` 用于比较两个线程的 ID，如果不相同则返回 0，否则返回一个非零值。



## 互斥锁

互斥锁（Mutex）常常被用来保护那些可以被多个线程访问的共享资源，比如可以防止多个线程同时更新同一个数据时出现混乱。使用互斥锁的一般步骤如下：

- 创建一个互斥锁，即声明一个 `pthread_mutex_t` 类型的数据，然后初始化，只有初始化之后才能使用；
- 多个线程尝试锁定这个互斥锁；
- 只有一个成功锁定互斥锁，成为互斥锁的拥有者，然后进行一些指令；
- 拥有者解锁互斥锁；
- 其他线程尝试锁定这个互斥锁，重复上面的过程；
- 最后互斥锁被显式地调用 `pthread_mutex_destroy` 来进行销毁。

有两种方式初始化一个互斥锁：

- 第一种方式是利用已经定义的常量初始化，例如

  ```c showLineNumbers
  pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
  ```

- 第二种方式是调用 `pthread_mutex_init()` 进行初始化，例如

  ```c showLineNumbers
  pthread_mutex_t mutex;
  pthread_mutex_init(&mutex, NULL);
  ```

初始化完成后，便可以在线程中使用互斥锁。当多个线程同时去锁定同一个互斥锁时，如果是用 `pthread_mutex_lock` 函数，那么失败的那些线程将会被阻塞，直到这个互斥锁被解锁，它们再继续竞争；如果是用 `pthread_mutex_trylock` 函数，那么竞争失败的线程只会返回一个错误。

最后需要指出的是，**保护共享数据是程序员的责任**。程序员要负责所有可以访问该数据的线程都使用 mutex 这种机制，否则，不使用 mutex 的线程还是有可能对数据造成破坏。

相关函数：

```c showLineNumbers
int pthread_mutex_init (pthread_mutex_t *mutex, const pthread_mutexattr_t *mutexattr);
int pthread_mutex_destroy (pthread_mutex_t *mutex);
int pthread_mutex_lock (pthread_mutex_t *mutex);
int pthread_mutex_trylock (pthread_mutex_t *mutex);
int pthread_mutex_timedlock (pthread_mutex_t *mutex,const struct timespec *abstime);
int pthread_mutex_unlock (pthread_mutex_t *mutex);
int pthread_mutexattr_init (pthread_mutexattr_t *attr);
int pthread_mutexattr_destroy (pthread_mutexattr_t *attr);
```

示例代码：

```c showLineNumbers
int global_value;
pthread_mutex_t mutex;

void *thread_entry(void)
{
    pthread_mutex_lock(&mutex);
    global_value += 1;
    pthread_mutex_unlock(&mutex);
    pthread_exit(NULL);
}

int main(void)
{
    pthread_t tid;
    pthread_attr_t attr;
    
    /* Initialize mutex object */
    pthread_mutex_init(&mutex, NULL);

    /* For portability, explicitly create threads in a joinable state */
    pthread_attr_init(&attr);
    pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);
    pthread_create(&tid, &attr, thread_entry, NULL);
    pthread_attr_destroy(&attr);
    
    ...
    pthread_join(tid, NULL);
    pthread_mutex_destroy(&mutex);
    pthread_exit(NULL);
}
```



## 条件变量

由于互斥锁只有两种状态，这限制了它的用途，因此 POSIX 又提出了条件变量（Condition Variable）机制。条件变量允许线程在阻塞的时候等待另一个线程发送的信号，当收到信号后，阻塞的线程就被唤醒并试图锁定与之相关的互斥锁。可以看到，条件变量是需要结合互斥锁一起使用的。

和互斥锁一样，使用条件变量之前需要先声明和初始化。通过声明 `pthread_cond_t` 类型的数据，并且必须先初始化才能使用。初始化的方法也有两种：

- 第一种，利用内部定义的常量，例如

  ```c showLineNumbers
  pthread_cond_t convar = PTHREAD_COND_INITIALIZER;
  ```

- 第二种，利用 `pthread_cond_init()` 函数，例如

  ```c showLineNumbers
  pthread_cond_t convar;
  pthread_cond_init(&convar, NULL);
  ```

  其中，`pthread_cond_init` 的第二个参数 attr 由 `pthread_condattr_init()` 和 `pthread_condattr_destroy()` 创建和销毁。

当使用完毕后，可以通过 `pthread_cond_destroy()` 销毁一个条件变量。

相关函数：

```c showLineNumbers
int pthread_cond_init (pthread_cond_t *cond, const pthread_condattr_t *cond_attr);
int pthread_cond_destroy (pthread_cond_t *cond);
int pthread_cond_signal (pthread_cond_t *cond);
int pthread_cond_broadcast (pthread_cond_t *cond);
int pthread_cond_wait (pthread_cond_t *cond, pthread_mutex_t *mutex);
int pthread_cond_timedwait (pthread_cond_t *cond, pthread_mutex_t *mutex, 
                            const struct timespec *abstime);
```

`pthread_cond_wait()` 会阻塞调用它的线程，直到收到某一信号。这个函数需要在 mutex 已经被锁之后进行调用，并且当线程被阻塞时，会自动解锁 mutex。信号收到后，线程被唤醒，这时 mutex 又会被这个线程锁定。

`pthread_cond_signal()` 函数结束时，必须解锁 mutex，以供 `pthread_cond_wait()` 锁定 mutex。当不止一个线程在等待信号时，要用 `pthread_cond_broadcast()` 代替 `pthread_cond_signal()` 来告诉所有被该条件变量阻塞的线程结束阻塞状态。

示例代码：

```c showLineNumbers
#define COUNT_LIMIT    10

int count = 0;
pthread_mutex_t mutex;
pthread_cond_t convar;

void *thread1_entry(void)
{
    while (1) {
        pthread_mutex_lock(&mutex);
        count++;
        if (count == COUNT_LIMIT) {
            pthread_cond_signal(&convar);
        }
        pthread_mutex_unlock(&mutex);

        /* Do some work so threads can alternate on mutex lock */
        sleep(1);
    }
    pthread_exit(NULL);
}

void *thread2_entry(void)
{
    pthread_mutex_lock(&mutex);
    while (count < COUNT_LIMIT) {
        pthread_cond_wait(&convar, &mutex);
        count = 0;
    }
    pthread_mutex_unlock(&mutex);
    pthread_exit(NULL);
}

int main(int argc, char *argv[])
{
    int i, rc;
    pthread_t tid1, tid2;
    pthread_attr_t attr;

    /* Initialize mutex and condition variable objects */
    pthread_mutex_init(&mutex, NULL);
    pthread_cond_init(&convar, NULL);

    /* For portability, explicitly create threads in a joinable state */
    pthread_attr_init(&attr);
    pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);
    pthread_create(&tid1, &attr, thread1_entry, NULL);
    pthread_create(&tid2, &attr, thread2_entry, NULL);

    /* Wait for all threads to complete */
    pthread_join(tid1, NULL);
    pthread_join(tid2, NULL);

    /* Clean up and exit */
    pthread_attr_destroy(&attr);
    pthread_mutex_destroy(&mutex);
    pthread_cond_destroy(&convar);
    pthread_exit(NULL);
}
```



## 读写锁

读写锁（Read-Write Lock）与互斥量类似，不过读写锁允许更高的并行性。互斥量要么是锁住状态，要么是不加锁状态，而且一次只有一个线程对其加锁。读写锁可以有三种状态：读模式下加锁状态，写模式下加锁状态，不加锁状态。一次只有一个线程可以占有写模式的读写锁，但是多个线程可用同时占有读模式的读写锁。读写锁也叫做“共享-独占锁”，当读写锁以读模式锁住时，它是以共享模式锁住的，当它以写模式锁住时，它是以独占模式锁住的。

使用读写锁之前同样需要先声明和初始化。读写锁的数据类型为 `pthread_rwlock_t`，初始化的方法也有两种：

- 第一种方式是利用已经定义的常量初始化，例如

  ```c showLineNumbers
  pthread_rwlock_t rwlock = PTHREAD_RWLOCK_INITIALIZER;
  ```

- 第二种方式是调用 `pthread_rwlock_init()` 进行初始化，例如

  ```c showLineNumbers
  pthread_rwlock_t rwlock;
  pthread_rwlock_init(&rwlock, NULL);
  ```

相关函数：

```c showLineNumbers
/* 初始化读写锁 */
int pthread_rwlock_init(pthread_rwlock_t *rwlock, const pthread_rwlockattr_t *attr);
/* 销毁读写锁 */
int pthread_rwlock_destroy(pthread_rwlock_t *rwlock);
/* 获取读写锁中的读锁 */
int pthread_rwlock_rdlock(pthread_rwlock_t *rwlock);
int pthread_rwlock_tryrdlock(pthread_rwlock_t *rwlock);
int pthread_rwlock_timedrdlock (pthread_rwlock_t *rwlock, 
                                const struct timespec *abstime);
/* 获取读写锁中的写锁 */
int pthread_rwlock_wrlock(pthread_rwlock_t *rwlock);
int pthread_rwlock_trywrlock(pthread_rwlock_t *rwlock);
int pthread_rwlock_timedwrlock (pthread_rwlock_t *rwlock, 
                                const struct timespec *abstime);
/* 解除锁定读写锁 */
int pthread_rwlock_unlock(pthread_rwlock_t *rwlock);
/* 读写锁属性 */
int pthread_rwlockattr_init(pthread_rwlockattr_t *attr);
int pthread_rwlockattr_destroy(pthread_rwlockattr_t *attr);
int pthread_rwlockattr_getpshared(const pthread_rwlockattr_t *attr, int *pshared);
int pthread_rwlockattr_setpshared(pthread_rwlockattr_t *attr, int pshared);
```

读写锁中包含了两把锁 —— 读锁（R）和写锁（W）。如果一个共享资源只有读取而没有写入操作，那么多个任务可以同时读取，而不用担心竟态条件的发生。一旦有一个线程开始写入，那么其他想要读取或者写入的线程统统都必须等待该线程完成写入，才能继续操作。

应用程序应该用 R 锁来控制读取操作，如果一个线程获得 R 锁，读写锁允许其他线程继续获得 R 锁，而不必等待该线程释放 R 锁。也就是说，多个进程可以同时读取同一资源。W 锁用来控制写入操作，同一时间只能有一个线程获得 W 锁。不过，在获得 W 锁之前，线程必须等到所有持有共享读取锁的线程释放掉各自的 R 锁，以免自己的写入操作干扰到其他线程的读取。

本文的所有示例代码，可以在 [GitHub](https://github.com/getiot/linux-c/tree/main/pthreads) 找到。提醒一下，在编译使用 pthread 多线程的程序时，可别忘了添加 `-pthread` 选项！





