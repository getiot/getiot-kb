---
sidebar_position: 3
sidebar_label: Linux 文件 IO
authors: [luhuadong]
---

# Linux 文件与目录操作（文件 IO）

在 Linux 系统编程中，文件和目录是你最常接触的资源之一。你需要打开文件、读取内容、写入日志、创建目录、删除文件……所有这些操作，都可以通过 Linux 提供的一组系统调用来实现。

本节将带你掌握 **文件描述符** 和一组核心系统调用，包括 `open()`、`read()`、`write()`、`close()`、`lseek()` 等，帮你打好文件 IO 的基础。同时，你还会学习如何创建、删除目录，以及获取文件的元信息。



## 文件描述符

在 Linux 中，每当你打开一个文件，系统就会返回一个整数，这就是**文件描述符**（file descriptor，通常简写为 fd）。它是一个用于标识打开文件的句柄，后续的读写操作都需要用这个描述符来指定目标文件。简单来说，文件描述符就是你和文件之间的桥梁。

默认情况下，Linux 会自动为每个进程打开三个文件描述符：

| 文件描述符 |        名称         |      说明      |
| :--------: | :-----------------: | :------------: |
|    `0`     | 标准输入 (`stdin`)  | 通常是键盘输入 |
|    `1`     | 标准输出 (`stdout`) | 通常是终端输出 |
|    `2`     | 标准错误 (`stderr`) |  用于错误输出  |

当你使用 `open()` 打开一个文件时，系统会返回一个新的文件描述符，例如 3、4、5 等。



## 打开和关闭文件

### 使用 `open()` 打开文件

头文件：

```c
#include <fcntl.h>
#include <unistd.h>
```

函数原型：

```c
int open(const char *pathname, int flags, mode_t mode);
```

常用参数：

- `pathname`：文件路径；
- `flags`：打开方式，如只读 `O_RDONLY`，只写 `O_WRONLY`，读写 `O_RDWR`；
- `mode`：当创建新文件时指定权限（通常配合 `O_CREAT` 使用）。

示例代码：

```c
int fd = open("test.txt", O_WRONLY | O_CREAT, 0644);
if (fd == -1) {
    perror("open");
}
```

### 使用 `close()` 关闭文件

释放文件资源：

```c
close(fd);
```



## 读取和写入文件

### 使用 `read()` 读取文件内容

```c
ssize_t read(int fd, void *buf, size_t count);
```

- `fd`：文件描述符；
- `buf`：接收数据的缓冲区；
- `count`：希望读取的字节数；
- 返回值是实际读取的字节数。

示例：

```c
char buffer[100];
ssize_t n = read(fd, buffer, sizeof(buffer));
```

### 使用 `write()` 向文件写入数据

```c
ssize_t write(int fd, const void *buf, size_t count);
```

和 `read()` 类似，返回值是实际写入的字节数。

示例：

```c
const char *msg = "Hello, Linux IO!\n";
write(fd, msg, strlen(msg));
```



## 移动文件指针：`lseek()`

如果你需要跳过文件开头的一部分、或者定位到文件结尾，可以使用 `lseek()`。

```c
off_t lseek(int fd, off_t offset, int whence);
```

- `offset`：偏移量；
- `whence`：
  - `SEEK_SET`：从文件开头开始偏移；
  - `SEEK_CUR`：从当前位置偏移；
  - `SEEK_END`：从文件末尾开始偏移。

示例：获取文件大小

```c
off_t size = lseek(fd, 0, SEEK_END);
```



## 获取文件信息：`stat()` 和 `fstat()`

你可以用这两个函数查看文件的元数据，例如大小、权限、创建时间等。

```c
#include <sys/stat.h>
#include <unistd.h>

struct stat st;
stat("test.txt", &st);
printf("文件大小: %ld 字节\n", st.st_size);
```

`fstat()` 和 `stat()` 类似，只是接受的是文件描述符而不是路径。



## 创建和删除目录

### 创建目录：`mkdir()`

```c
#include <sys/stat.h>
#include <sys/types.h>

mkdir("mydir", 0755);
```

- `0755` 表示目录权限：所有者可读写执行，其他用户可读执行。

### 删除目录：`rmdir()`

```c
rmdir("mydir");
```

注意：目录必须是空的才能删除。



## 删除文件：`unlink()`

```c
#include <unistd.h>

unlink("test.txt");
```

这将永久删除文件，类似于 rm 命令。



## 综合示例：创建并写入文件

```c showLineNumbers
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>

int main() {
    int fd = open("hello.txt", O_WRONLY | O_CREAT | O_TRUNC, 0644);
    if (fd == -1) {
        perror("open");
        return 1;
    }

    const char *msg = "Hello, system file IO!\n";
    write(fd, msg, strlen(msg));

    close(fd);
    return 0;
}
```

编译运行：

```bash
gcc file_write.c -o file_write
./file_write
cat hello.txt
```

你应该能看到文件中成功写入了内容。



## 小结

在本节中，你学习了 Linux 中常见的 **文件和目录操作 API**，包括：

- 使用 `open()` / `read()` / `write()` / `close()` 操作文件；
- 使用 `lseek()` 移动文件指针；
- 使用 `stat()` 获取文件信息；
- 使用 `mkdir()` / `rmdir()` 创建和删除目录；
- 使用 `unlink()` 删除文件。

这些系统调用是 Linux 系统编程中最基础也是最常用的部分。掌握它们，你就拥有了与文件系统打交道的“钥匙”。


