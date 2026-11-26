---
sidebar_position: 5
sidebar_label: Linux 检查文件
authors: [luhuadong]
---

# Linux 检查文件是否存在

在操作文件之前，通常需要先检查文件是否存在，以及是否有相应的操作权限。因此本文介绍在 Linux 中如何使用 C 接口（系统调用或库函数）来检查文件，包括 `fopen()`、`stat()` 和 `access()` 三个函数。这些函数各有优缺点和适用场景，了解它们的差异有助于你根据需求选择最合适的方法。



##  使用 `fopen()` 函数

`fopen()` 是最常用的文件操作函数，它不仅可以用来检查文件是否存在，还可以用来打开文件进行读写操作。当文件不存在时，`fopen()` 会返回 `NULL`，并设置一个错误码。

**函数原型：**

```c
FILE *fopen(const char *pathname, const char *mode);
```

**示例：**

```c showLineNumbers
#include <stdio.h>

int main() {
    FILE *file = fopen("example.txt", "r");
    if (file) {
        printf("file exists\n");
        fclose(file);
    } else {
        printf("file doesn't exist\n");
    }
    return 0;
}
```

**说明：**

- 如果文件存在并且可以打开，`fopen()` 返回文件指针。
- 如果文件不存在，返回 `NULL`。

:::info 注意

`fopen("example.txt", "r")` 使用的是相对路径，如果 C 程序位置和文件位置不同，你可以指定文件的绝对路径（完整路径），从而避免找不到文件。

:::

基于 `fopen()` 函数，你可以创建一个自定义函数 `checkIfFileExists()` 来检查文件是否存在，方便以后复用代码。

**示例：**

```c showLineNumbers
#include <stdio.h>

int checkIfFileExists(const char * filename)
{
    FILE *file;
    if (file = fopen(filename, "r")) {
        fclose(file);
        return 1;
    }

    return 0;
}

int main(void)
{
    if(checkIfFileExists("example.txt")) {
        printf("file exists");
    } else {
        printf("file does not exists");
    }
}
```



## 使用 `stat()` 函数

`stat()` 函数用于获取文件的状态信息，由头文件 `sys/stat.h` 声明。如果文件存在，它会填充 `stat` 结构体中的相关字段。如果文件不存在，它会返回一个错误。

**函数原型：**

```c
int stat(const char *pathname, struct stat *statbuf);
```

`stat()` 函数读取文件的属性，而不是从文件中读取数据。如果操作成功，该函数将返回 `0`；否则如果文件不存在，将返回 `-1`。

**示例：**

下面示例基于 `stat()` 函数改写 `checkIfFileExists()` 自定义函数，实现文件检查功能。

```c showLineNumbers
#include <stdio.h>
#include <sys/stat.h>

int checkIfFileExists(const char* filename){
    struct stat buffer;
    if (stat(filename, &buffer) == 0) {
        return 1;  // 文件存在
    } else {
        return 0;  // 文件不存在
    }
}

int main(void)
{
    if(checkIfFileExists("example.txt")) {
        printf("file exists");
    } else {
        printf("file does not exists");
    }
}
```

**说明：**

- `stat()` 不仅可以用来检查文件是否存在，还可以获取文件的权限、大小和最后修改时间等信息。
- `stat()` 适用于需要获取文件的更多信息的场景。



## 使用 `access()` 函数

检查文件是否存在的另一种方法是使用 `access()` 函数。它由头文件 `unistd.h` 声明。它可以检查文件的读取、写入或执行权限，返回 `0` 表示文件存在并可访问，返回 `-1` 表示文件不存在或不可访问。

**函数原型：**

```c
int access(const char *pathname, int mode);
```

`access()` 函数需要一个权限参数，可以用 `R_OK` 表示读权限，`W_OK` 表示写权限，`X_OK` 表示执行权限。你也可以将它们组合起来使用，例如 `R_OK|W_OK` 表示读取和写入权限。

**示例：**

```c showLineNumbers
#include <stdio.h>
#include <unistd.h>
int main(void)
{
    if( access( "example.txt", F_OK ) == 0) {
        printf("file is not found");
    } else {
    	printf("file is found");
    }
    return 0;
}
```

**说明：**

- `F_OK` 参数检查文件是否存在。还可以使用 `R_OK`、`W_OK`、`X_OK` 分别检查读、写、执行权限。
- `access()` 适用于需要检查文件权限的场景。



## 小结

本文介绍了三种常见的检查文件是否存在的方法：`fopen()`、`stat()` 和 `access()`。

- `fopen()` 适合用于简单的文件存在性检查，并尝试打开文件。
- `stat()` 提供了详细的文件信息，适合需要更多文件元数据的情况。
- `access()` 适合检查文件的权限和存在性。

在实际开发过程中，你可以根据你的需求，选择最合适的函数来处理文件检查。
