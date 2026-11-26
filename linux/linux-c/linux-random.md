---
sidebar_position: 48
authors: [luhuadong]
---

# Linux 随机数

在 Linux 系统编程中，你经常会遇到需要生成随机数的场景，比如加密通信、数据模拟、游戏开发、验证码生成等等。Linux 提供了多种方式来生成随机数，不同的方法适用于不同的应用场景。

本文将带你系统学习：

- `rand()` 和 `srand()` 的用法；
- `/dev/random` 和 `/dev/urandom` 的区别；
- `getrandom()` 系统调用；
- 使用 OpenSSL 和其他加密安全库获取高质量随机数。



## 使用 rand() 生成伪随机数

`rand()` 是最常用的伪随机数函数，来自 `<stdlib.h>`。

```c showLineNumbers
#include <stdio.h>
#include <stdlib.h>

int main() {
    // 每次运行程序输出都是一样的
    printf("随机数：%d\n", rand());
    return 0;
}
```

如果你想让每次运行程序都输出不同的结果，可以使用 `srand()` 设置种子（seed）：

```c showLineNumbers
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main() {
    srand(time(NULL));  // 用当前时间初始化种子
    for (int i = 0; i < 5; i++) {
        printf("随机数：%d\n", rand() % 100);  // 取模控制范围：0~99
    }
    return 0;
}
```

:::danger 注意

⚠️ `rand()` 的随机性较弱，不适用于安全场景，比如密码、加密密钥等。

:::



## 读取 /dev/random 和 /dev/urandom

Linux 提供了两个特殊的设备文件：

- `/dev/random`：阻塞式，熵池不足时会等待；
- `/dev/urandom`：非阻塞式，用伪随机扩展。

你可以直接从这些文件中读取高质量的随机数据：

```c showLineNumbers
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

int main() {
    int fd = open("/dev/urandom", O_RDONLY);
    if (fd < 0) {
        perror("打开 /dev/urandom 失败");
        return 1;
    }

    unsigned char buffer[16];
    read(fd, buffer, sizeof(buffer));
    close(fd);

    printf("生成的 16 字节随机数：\n");
    for (int i = 0; i < 16; i++) {
        printf("%02x ", buffer[i]);
    }
    printf("\n");
    return 0;
}
```

:::tip 

✅ `/dev/urandom` 适用于大多数用途，包括安全相关的需求。

:::



## 使用 getrandom() 系统调用（推荐）

从 Linux 3.17 开始，你可以使用 `getrandom()` 系统调用直接获取高质量随机数据，而无需依赖 `/dev/urandom` 文件。

```c showLineNumbers
#include <stdio.h>
#include <unistd.h>
#include <sys/random.h>

int main() {
    unsigned char buffer[16];

    ssize_t ret = getrandom(buffer, sizeof(buffer), 0);
    if (ret < 0) {
        perror("getrandom 失败");
        return 1;
    }

    printf("getrandom 生成的 16 字节随机数：\n");
    for (int i = 0; i < 16; i++) {
        printf("%02x ", buffer[i]);
    }
    printf("\n");

    return 0;
}
```

相比 `/dev/urandom`，`getrandom()` 更高效，不依赖文件描述符，而且能在沙箱环境中更好地工作。



## 生成浮点随机数

你可以将 `rand()` 生成的整数转换成浮点数（例如 0 到 1 的小数）：

```c
double r = (double)rand() / RAND_MAX;
```

然后根据需要缩放区间：

```c
// 生成 [min, max) 范围内的随机数
double rand_range(double min, double max) {
    return min + (max - min) * ((double)rand() / RAND_MAX);
}
```



## 加密级别的随机数（OpenSSL）

如果你在写密码学或网络安全相关的程序，推荐使用 OpenSSL 提供的安全随机数生成器：

```c showLineNumbers
#include <stdio.h>
#include <openssl/rand.h>

int main() {
    unsigned char buf[16];
    if (RAND_bytes(buf, sizeof(buf)) != 1) {
        fprintf(stderr, "生成随机数失败！\n");
        return 1;
    }

    printf("OpenSSL 生成的随机数：\n");
    for (int i = 0; i < 16; i++) {
        printf("%02x ", buf[i]);
    }
    printf("\n");
    return 0;
}
```

`RAND_bytes()` 会自动使用系统熵源，是安全可用的方式。



## 小结

在本教程中，你学习了 Linux 下常见的随机数生成方法：

- 使用 `rand()` 和 `srand()` 生成伪随机数；
- 使用 `/dev/urandom` 读取高质量随机字节；
- 使用 `getrandom()` 系统调用获取安全随机数；
- 使用 OpenSSL 的 `RAND_bytes()` 提供加密强度的随机源；
- 如何生成浮点范围的随机数；

你在实际开发中可以根据需求选择适合的方式。如果只是写普通的程序测试数据，`rand()` 配合 `srand()` 就够用了；但如果涉及密码、密钥、身份认证等安全领域，一定要用 `/dev/urandom`、`getrandom()` 或 OpenSSL。



