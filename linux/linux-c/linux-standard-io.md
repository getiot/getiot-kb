---
sidebar_position: 4
sidebar_label: Linux 标准 IO
authors: [luhuadong]
---

# Linux 标准输入输出与缓冲机制（标准 IO）

在上一节中，你学习了使用系统调用（如 `open()`、`read()`、`write()`）进行文件 IO 的方式，这种方式直接和操作系统交互，效率高但使用起来略显繁琐。本节我们将深入介绍另一个你更常用的接口 —— **标准输入输出**（Standard I/O），也就是你熟悉的 `printf()`、`scanf()`、`fopen()`、`fread()` 等函数。

你还将了解标准 IO 背后的缓冲机制，以及它和系统调用层的文件 IO 的区别与联系，帮助你在实际开发中根据场景合理选择。



## 什么是标准输入输出

标准输入输出（Standard I/O，简称“标准 IO”）是 C 标准库（`stdio.h`）提供的一组高层接口，它对系统调用进行了封装，使用更简单，适合大多数通用程序开发。

常用标准 IO 函数包括：

- 文件操作：`fopen()`、`fclose()`、`fread()`、`fwrite()`、`fprintf()`、`fscanf()`；
- 输入输出：`printf()`、`scanf()`、`putchar()`、`getchar()`；
- 文件定位：`fseek()`、`ftell()`；
- 缓冲控制：`fflush()`、`setbuf()`。

标准 IO 操作的是 **文件指针（`FILE *`）**，而不是文件描述符。



## 标准 IO 文件操作函数

### 创建/打开文件

每当你想要处理一个文件时，第一步是创建文件。文件本质上是在内存中用于存储数据的一块空间。

在 C 程序中创建文件的语法如下：

```c
FILE *fp;
fp = fopen("file_name", "mode");
```

在上述语法中，

- `FILE` 是在标准库中定义的数据结构，`fp` 是指向文件的指针。
- `fopen()` 是用于打开文件的标准函数。
  - 如果文件在系统中不存在，则创建该文件并打开。（返回 `FILE*` 类型）
  - 如果文件已存在于系统中，则直接打开该文件。（失败返回 `NULL`）
- `mode` 模式表示文件的打开方式，例如 `"r"` 表示以只读方式打开、`"w"` 表示写入并清空原文件、`"a"` 表示追加写入、`"rb"` 表示以二进制读等。

每当你打开或创建一个文件时，必须指定你打算对文件进行的操作。下表列出了 `fopen()` 函数支持的所有文件操作模式：

| 文件模式 | 描述                                                         |
| :------: | ------------------------------------------------------------ |
|   `r`    | 以读取方式打开文件。如果文件存在，打开文件并从文件开头读取内容。 |
|   `w`    | 以写入方式打开文件。如果文件不存在，创建新文件；如果文件存在，清空文件内容。 |
|   `a`    | 以追加方式打开文件。如果文件不存在，创建新文件；如果文件存在，写入的数据将被追加到文件末尾。 |
|   `r+`   | 以读写方式打开文件，文件指针指向文件开头。                   |
|   `w+`   | 以读写方式打开文件，如果文件存在，清空文件内容；如果文件不存在，创建新文件。 |
|   `a+`   | 以追加读写方式打开文件，如果文件存在，文件指针指向文件末尾；如果文件不存在，创建新文件。 |

另外，还有 `rb` / `wb` / `ab` / `r+b` / `w+b` / `a+b` 模式，它们是以**二进制模式**打开文件，而不是文本格式。模式功能与上面类似，只是操作的是二进制数据。

在给定的语法中，文件名和模式都作为字符串指定，因此必须用双引号括起来。

**示例：**

```c showLineNumbers
#include <stdio.h>

int main() {
    FILE *fp;
    fp = fopen("data.txt", "w");
    return 0;
}
```

编译执行程序，你将看到当前目录下创建了一个 data.txt 文件。

你也可以指定创建文件的路径：

```c showLineNumbers
#include <stdio.h>

int main() {
    FILE *fp;
    fp = fopen("~/data.txt", "w"); // Windows 风格路径："D://data.txt"
    return 0;
}
```



### 关闭文件

在完成对文件的操作后，应该始终关闭文件。这意味着终止对文件的内容和链接，从而防止文件的意外损坏。

C 语言提供了 `fclose` 函数来关闭文件。

```c
fclose(fp);
```

关闭文件后，文件指针 `fp` 不再指向任何文件。

```c
FILE *fp;
fp  = fopen ("data.txt", "r");
fclose (fp);
```

`fclose()` 函数接受一个文件指针作为参数。然后，它会关闭与该文件指针关联的文件。如果关闭成功，则返回 0；如果关闭文件时发生错误，则返回 `EOF`（文件结束）。

关闭文件后，相同的文件指针还可以用于其他文件。

:::tip

在 C 语言编程中，虽然程序终止时文件会自动关闭。但使用 `fclose()` 函数手动关闭文件是一种很好的编程习惯。

:::



### 写入文件

Linux 标准 IO 库提供了几个写入文件所需的函数，包括：

- **`fwrite(buffer, size, nmemb, file_pointer)`**：将 `buffer` 缓冲区中的内容按指定大小写入 `file_pointer` 指向的文件，支持写入文本和二进制格式数据。
- **`fputc(char, file_pointer)`**：将一个字符写入 `file_pointer` 指向的文件。
- **`fputs(str, file_pointer)`**：将字符串写入 `file_pointer` 指向的文件。
- **`fprintf(file_pointer, str, variable_lists)`**：将字符串打印到 `file_pointer` 指向的文件中。该字符串可以包含格式说明符和变量列表（`variable_lists`），因此可以很好地控制写入的文本格式。

后面三个函数操作的是字符或字符串，尤其是 `fputs` 和 `fprintf` 函数，当你写入文件时，必须明确添加换行符（`\n`），否则数据可能不会及时写入。

下面通过代码演示这四个文件写入函数的使用。

#### 示例 1：fwrite() 函数

```c showLineNumbers
#include <stdio.h>
#include <string.h>

int main() {
    FILE *fptr = fopen("data.bin", "wb");
    char buffer[] = "Hello, Linux! From GetIoT.tech.\n";
    fwrite(buffer, sizeof(char), strlen(buffer), fptr);
    fclose(fptr);
    return 0;
}
```

说明：

1. 在上面的程序中，我们以 `wb` 二进制写入模式创建并打开了一个名为 data.txt 的文件。
2. 调用 `fwrite()` 函数执行写入操作，将 buffer 中的数据写入文件。

#### 示例 2：fputc() 函数

```c showLineNumbers
#include <stdio.h>
int main() 
{
    int i;
    FILE * fptr;
    char fn[50];
    char str[] = "Hello, Linux! From GetIoT.tech.\n";
    fptr = fopen("data.txt", "w"); // "w" defines "writing mode"
    for (i = 0; str[i] != '\n'; i++) {
        /* write to file using fputc() function */
        fputc(str[i], fptr);
    }
    
    fclose(fptr);
    return 0;
}
```

上述程序将单个字符写入 **data.txt** 文件，直到遇到下一行符号 `\n`，表示该句子已成功写入。该过程是取出数组中的每个字符并将其写入文件。

1. 首先以 `w` 写入模式创建并打开了一个名为 data.txt 的文件，并声明将写入文件的字符串。
2. 由于 `fputc` 每次只写入一个字符，因此你需要使用 `for` 循环遍历整个字符串。

#### 示例 3：fputs() 函数

```c showLineNumbers
#include <stdio.h>
int main() 
{
    FILE * fp;
    fp = fopen("data.txt", "w+");
    fputs("Hello, Linux! ", fp);
    fputs("From GetIoT.tech.\n", fp);
    fclose(fp);
    return (0);
}
```

说明：

1. 在上面的程序中，我们以写入模式创建并打开了一个名为 data.txt 的文件。
2. 调用 `fputs()` 函数执行写入操作，写入两个不同的字符串。

#### 示例 4：fprintf() 函数

```c showLineNumbers
#include <stdio.h>
int main() 
{
    FILE *fptr;
    fptr = fopen("data.txt", "w"); // "w" defines "writing mode"
    char str[] = "GetIoT.tech";
    /* write to file */
    fprintf(fptr, "Hello, Linux! From %s.\n", str);
    fclose(fptr);
    return 0;
}
```

说明：

1. 在上面的程序中，我们以写入模式创建并打开了一个名为 data.txt 的文件。
2. 使用 `fprintf()` 函数将格式化字符串写入文件。



### 读取文件

与写入文件函数相对应，标准 IO 中也有与之对应的文件读取函数，包括：

- **`fread(buffer, size, nmemb, file_pointer)`**：指定大小从 `file_pointer` 指向的文件中读取数据，并保存到 `buffer` 缓冲区，支持读取文本和二进制格式数据。
- **`fgetc(file_pointer)`**：返回文件指针指向的文件中下一个字符。到达文件末尾时，返回 EOF。
- **`fgets(buffer, n, file_pointer)`**：从文件中读取 `n-1` 个字符，并将字符串存储在缓冲区中，其中附加空字符 `\0` 作为最后一个字符。
- **`fscanf(file_pointer, conversion_specifiers, variable_adresses)`**：用于解析和分析数据。它从文件中读取字符，并使用转换说明符将输入赋值给变量指针列表 `variable_adresses`。注意，与 `scanf` 函数一样，当遇到空格或换行符时，`fscanf` 会停止读取字符串。

以下程序演示分别使用 `fread()`、`fgets()`、`fscanf()` 和 `fgetc()` 函数读取 data.txt 文件。data.txt 测试文件的内容如下：

```txt
Hello world again
This is a test
123 456 789
```

文件读取测试代码：

```c showLineNumbers
#include <stdio.h>
#include <string.h>

int main() {
    FILE *file_pointer;
    char buffer[100], c;

    // 使用 fgets() 读取一行
    printf("---- 使用 fgets() 读取一行 ----\n");
    file_pointer = fopen("data.txt", "r");
    fgets(buffer, sizeof(buffer), file_pointer);
    printf("%s\n", buffer);
    fclose(file_pointer);

    // 使用 fscanf() 按格式读取
    printf("---- 使用 fscanf() 按格式解析 ----\n");
    file_pointer = fopen("data.txt", "r");
    char word1[20], word2[20], word3[20];
    fscanf(file_pointer, "%s %s %s", word1, word2, word3);
    printf("Word1: %s\n", word1);
    printf("Word2: %s\n", word2);
    printf("Word3: %s\n", word3);
    fclose(file_pointer);

    // 使用 fgetc() 逐字符读取
    printf("---- 使用 fgetc() 逐字符读取 ----\n");
    file_pointer = fopen("data.txt", "r");
    while ((c = fgetc(file_pointer)) != EOF) {
        putchar(c);
    }
    fclose(file_pointer);

    // 使用 fread() 读取整个文件内容
    printf("\n---- 使用 fread() 读取二进制内容 ----\n");
    file_pointer = fopen("data.txt", "rb");
    char bin_buffer[100];
    size_t n = fread(bin_buffer, sizeof(char), sizeof(bin_buffer) - 1, file_pointer);
    bin_buffer[n] = '\0';
    printf("%s\n", bin_buffer);
    fclose(file_pointer);

    return 0;
}
```

编译并执行程序，输出结果如下：

```bash showLineNumbers
---- 使用 fgets() 读取一行 ----
Hello world again

---- 使用 fscanf() 按格式解析 ----
Word1: Hello
Word2: world
Word3: again

---- 使用 fgetc() 逐字符读取 ----
Hello world again
This is a test
123 456 789

---- 使用 fread() 读取二进制内容 ----
Hello world again
This is a test
123 456 789
```



## 标准 IO 的缓冲机制

标准 IO 的重要特性之一就是**缓冲机制**。这意味着你写入的数据并不会立即写入磁盘，而是先放入内存缓冲区，等到一定条件满足时才真正写入磁盘。

Linux 系统提供了三种缓冲模式，你可以通过 `setvbuf()` 自定义缓冲策略。

| 类型                     |  模式宏  | 描述                       | 示例                           |
| ------------------------ | :------: | -------------------------- | ------------------------------ |
| 全缓冲（Fully Buffered） | `_IOFBF` | 满一块缓冲区时才刷新       | 文件输出                       |
| 行缓冲（Line Buffered）  | `_IOLBF` | 输入或输出遇到换行符时刷新 | 终端输出                       |
| 无缓冲（Unbuffered）     | `_IONBF` | 每次调用立即生效           | 错误输出 stderr 默认是无缓冲的 |

你可以使用 `fflush()` 强制刷新缓冲区：

```c
fflush(fp); // 将缓冲区中的内容写入文件
```

:::warning

写文件后没有调用 `fclose()` 前，如果不调用 `fflush()`，那么有可能数据还在缓冲区未写入文件。

:::

请看下面示例：

```c showLineNumbers
#include <stdio.h>
#include <unistd.h> // for sleep()

int main() {
    printf("这是一条未刷新就停顿的输出...");
    // 输出不会立即显示，除非缓冲区满或遇到换行或关闭
    sleep(3);

    printf("这是一条立即刷新就停顿的输出...");
    fflush(stdout); // 手动刷新缓冲区，立即显示内容
    sleep(3);
    
    // 设置标准输出为无缓冲模式
    setvbuf(stdout, NULL, _IONBF, 0);  // 设置 stdout 为无缓冲

    printf("[无缓冲] 马上输出这条消息\n");
    sleep(2);  // 暂停 2 秒，输出已发生

    // 设置标准输出为默认全缓冲模式
    char buffer[100];
    setvbuf(stdout, buffer, _IOFBF, sizeof(buffer)); // 设置 stdout 为完全缓冲

    printf("[全缓冲] 这条消息暂时不会显示（未 fflush）");
    sleep(2);  // 暂停 2 秒，此时不会显示

    fflush(stdout);  // 手动刷新缓冲区
    printf("\n[全缓冲] 刷新后显示\n");

    return 0;
}
```

**说明**：

- 第一条 `printf` 会因 stdout 是 **行缓冲**（连接终端）而等待换行或缓冲区满后才显示。
- 第二条使用 `fflush(stdout)`，即使没有换行，也会立即将缓冲区内容输出到屏幕。
- 第三条 `printf` 由于 stdout 被设置为 **无缓冲**，因此调用 `printf` 后会立即输出内容。
- 第三条 `printf` 由于 stdout 被设置为 **全缓冲**，因此需要调用 `fflush` 后缓冲区内容才真正写入终端。



## 标准 IO 函数列表

|   函数名    | 作用                           | 特点说明                                        |
| :---------: | ------------------------------ | ----------------------------------------------- |
|  `fopen()`  | 打开文件，返回 `FILE*` 指针    | 支持多种模式（如 `"r"`, `"w"`, `"a"`, `"rb+"`） |
| `fclose()`  | 关闭文件，释放资源             | 使用完文件后必须调用                            |
| `fprintf()` | 向文件中写入格式化数据         | 类似 `printf()`，可写字符串、整数、浮点数等     |
| `fscanf()`  | 从文件中按格式读取数据         | 类似 `scanf()`，读取指定格式的值                |
|  `fgetc()`  | 从文件中读取一个字符           | 返回 `int` 类型字符，遇到 EOF 停止              |
|  `fputc()`  | 向文件写入一个字符             | 单字符输出，适合循环写入                        |
|  `fgets()`  | 从文件中读取一行               | 可读取含空格的整行字符串                        |
|  `fputs()`  | 向文件写入一行字符串           | 写入字符串，自动添加 `\0` 结束符                |
|  `getc()`   | 等价于 `fgetc()`               | 宏定义版本，语义相同                            |
|  `putc()`   | 等价于 `fputc()`               | 宏定义版本，语义相同                            |
|  `getw()`   | 从文件中读取一个整数（`int`）  | 非标准，移植性差，建议用 `fread()` 代替         |
|  `putw()`   | 向文件中写入一个整数（`int`）  | 同上，不推荐新项目使用                          |
|  `fread()`  | 从文件中读取二进制块           | 可一次读取结构体或大量字节，效率高              |
| `fwrite()`  | 向文件写入二进制块             | 搭配结构体常用于二进制文件存取                  |
|  `fseek()`  | 移动文件指针到指定位置         | 支持 `SEEK_SET`、`SEEK_CUR`、`SEEK_END`         |
|  `ftell()`  | 获取当前文件指针的位置         | 常与 `fseek()` 搭配使用                         |
| `rewind()`  | 将文件指针移回文件开头         | 类似 `fseek(fp, 0, SEEK_SET)`                   |
| `fflush()`  | 刷新缓冲区，将缓冲内容写入文件 | 对于写模式文件非常重要，确保数据真正写入磁盘    |

**建议：**

- 文本读写推荐用 `fscanf()` / `fprintf()` / `fgets()` / `fputs()`。
- 二进制读写推荐用 `fread()` / `fwrite()`。
- 文件位置操作用 `fseek()` / `ftell()` / `rewind()`。



## 标准 IO vs 文件 IO

下表列出了文件 IO 与标准 IO 的主要区别。总结一句话就是：标准 IO 更“聪明”，文件 IO 更“直接”。

|   特性   |     文件 IO（系统调用）      |     标准 IO（C 标准库）      |
| :------: | :--------------------------: | :--------------------------: |
| 函数示例 |  `open` / `read` / `write`   | `fopen` / `fread` / `fwrite` |
| 操作对象 |     文件描述符（`int`）      |     文件指针（`FILE*`）      |
| 缓冲机制 |            无缓冲            |            有缓冲            |
|  灵活性  |      更底层、更精细控制      |     更友好、适合文本处理     |
|   性能   |      适合大规模高频 IO       |       适合小量文本操作       |
| 典型用途 | 系统服务、后台进程、驱动开发 |    用户应用、文本处理工具    |

下面是文件 IO 和标准 IO 的实际对比示例：

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

<Tabs>
  <TabItem value="file-io" label="文件 IO 示例" default>

```c showLineNumbers
#include <fcntl.h>
#include <unistd.h>

int main() {
    int fd = open("file_io.txt", O_WRONLY | O_CREAT | O_TRUNC, 0644);
    write(fd, "File IO example\n", 16);
    close(fd);
    return 0;
}
```

  </TabItem>
  <TabItem value="std-io" label="标准 IO 示例">

```c showLineNumbers
#include <stdio.h>

int main() {
    FILE *fp = fopen("stdio.txt", "w");
    fprintf(fp, "Standard IO example\n");
    fclose(fp);
    return 0;
}
```

  </TabItem>
</Tabs>



⚠️ 需要注意，标准 IO 和文件 IO 虽然都能访问同一个文件，但**不能混用同一个文件的两种接口**，否则可能会引发数据错乱、读写顺序不一致等问题。举个例子：

```c showLineNumbers
FILE *fp = fopen("data.txt", "w+");
int fd = fileno(fp); // 获取文件描述符

write(fd, "Hello", 5);  // 文件 IO 写入
fseek(fp, 0, SEEK_SET); // 想通过标准 IO 读取
fgets(buf, sizeof(buf), fp); // 读取失败或数据异常
```

:::warning 记住！

要么用文件 IO 接口处理整个流程，要么全程使用标准 IO。不要混合使用！

:::



## 小结

在本节中，你学习了 Linux 中两种常见的文件处理方式：

- **标准 IO（C 标准库）**：使用 `fopen()`、`fread()`、`fprintf()` 等接口，操作 `FILE*` 文件指针，具有缓冲机制，适合日常文本处理。
- **文件 IO（系统调用）**：使用 `open()`、`read()`、`write()` 等接口，操作文件描述符，无缓冲，更接近操作系统底层。

你也掌握了标准 IO 的三种缓冲模式，并了解了不能混用文件 IO 与标准 IO的原因。实际开发中，如果你追求性能、稳定性或需要精细控制，建议用文件 IO；如果你更重视开发效率、代码简洁，可以选择标准 IO。
