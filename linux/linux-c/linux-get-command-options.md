---
sidebar_position: 51
authors: [luhuadong]
---

# Linux 选项参数

为了增强应用程序的通用性和灵活性，软件设计师通常会把程序中可变的部分抽离出来，让程序本身只处理业务逻辑，实现配置参数与功能代码的解耦合。在 Linux 系统编程中，通常有两种做法：

- 通过配置文件与程序进行交互（ini、xml、json...）
- 通过命令行选项参数进行交互（getopt）

配置文件的格式可以是常见的 ini、xml、json 或 yaml，也可以是自定义的文件格式，对于配置项较多的程序，这种方式会更方便、更直观。而命令行选项参数在 Linux 更加常见，几乎所有 Linux 命令行工具都支持（例如 ls、cd、mount 等）。

不用多说，我们都知道命令行对于 Linux 来说有多么重要，而大部分的命令行程序都是带参数的。如果是我们自己开发的命令行程序，该怎么灵活方便地为其添加选项参数呢？下面我们来看看在 Linux C 编程中如何支持参数以及对参数进行识别！



## 命令行参数

### 命令行参数的管理

Linux 应用程序是从 main 函数开始执行的，如果需要带选项参数，通常会这么定义 main 函数：

```c showLineNumbers
int main(int argc, char *argv[])
{
	// do something
	return 0;
}
```

- 第1个参数 argc 表示参数的数目，包含命令本身，也就是说如果命令后面不带参数的话，argc 就等于 1。
- 第2个参数 argv 是字符指针数组，其成员依次指向各个参数，argv[0] 指向命令本身，argv[1] 指向后面带的第1个参数，指针数组最后一个成员为 NULL，表示参数结束。

比如 `ls -w 80` 命令，其进程启动之后拿到的 argc 和 argv 参数内容如下：

![](https://static.getiot.tech/linux-getopt-argv-sample.png#center)

这里要区分一下命令、选项、参数的概念。它们以空格隔开，第一个就是命令（如果使用管道，一个命令行中可以包含多个命令）；选项和参数通常都是可选的，选项分为短选项和长选项，比如这里的 `-w` 是短选项，它对应的长选项是 `--width`；参数 80 是对前面的选项 `-w` 的描述，并非所有选项都有参数，具体由程序本身决定。参数可以紧跟选项，也可以用空格隔开，对于长选项参数还可以使用等号，所以下面几种写法是等效的：

```bash
ls -w 80
ls -w80
ls --width 80
ls --width=80
```



### 命令行参数的识别

理解了上面这点，显然我们要解析命令行的选项参数，只需要根据 main 函数传入的参数 argc 和 argv 就可以获取并处理通过命令行传入的参数了。但这样会增加程序员的工作量，并且命令行的选项参数通常是随意的，不会刻意让某个参数处于第 1 或者第 2 的位置。如果参数较多，自己解析的话很容易使代码变得臃肿，而且也不利于代码重用。那该怎么办呢？

答案就是 **getopt** 系列函数！通过 getopt 将参数解析部分解耦出来，数据驱动的方式看起来也很美观，我们 man 一下看看：

```c showLineNumbers
#include<unistd.h>  

int getopt(intargc, char * const argv[], const char *optstring); 

extern char *optarg;
extern int optind, opterr, optopt;

#include<getopt.h>  
 
int getopt_long(int argc, char * const argv[], 
		const char *optstring,  
		const struct option *longopts, int*longindex); 

int getopt_long_only(int argc, char * const argv[],
		const char *optstring, 
		const struct option *longopts, int*longindex);  
```

从函数名字可以看出来，getopt_long 和 getopt_long_only 应该是 getopt 的增强版，我们先来看看最简单的 getopt 函数吧。



## getopt 函数

**定义**：

```c showLineNumbers
int getopt(int argc, char * const argv[], const char *optstring);
```

**描述**：getopt 是用来解析命令行选项参数的，但是只能解析短选项（如 -d 100），不能解析长选项（如 --prefix）

**参数**：

 - `argc`：main() 函数传递过来的参数的个数
 - `argv`：main() 函数传递过来的参数的字符串指针数组
 - `optstring`：选项字符串，告知 getopt() 可以处理哪个选项以及哪个选项需要参数

**返回**：如果选项成功找到，返回选项字母；如果所有命令行选项都解析完毕，返回 -1；如果遇到选项字符不在 optstring 中，返回字符 `'?'`；如果遇到丢失参数，那么返回值依赖于 optstring 中第一个字符，如果第一个字符是 `':'` 则返回 `':'`，否则返回 `'?'` 并提示出错误信息。

下面说明 optstring 的格式意义：

```
char*optstring = “ab:c::”;
```

- 单个字符 **a**　　表示选项 a 没有参数；格式：-a 即可，不加参数。
- 单字符加冒号 **b:**　表示选项 b 有且必须加参数；格式：-b 100 或 -b100，但 -b=100 是错误的。
- 单字符加两冒号 **c::**　表示选项 c 的参数可以有，也可以没有；格式：-c200，其它格式错误。

上面这个 optstring 在传入之后，getopt 函数将依次检查命令行是否指定了 -a，-b，-c（这需要多次调用 getopt 函数，直到其返回 -1），当检查到上面某一个参数被指定时，函数会返回被指定的参数名称（即该字母）。

此外，还有几个重要的全局变量：

 - `optarg` —— 指向当前选项参数（如果有）的指针。 
 - `optind` —— 再次调用 getopt() 时的下一个 argv 指针的索引。
 - `optopt` —— 最后一个未知选项。 
 - `opterr` ­——如果不希望 getopt() 打印出错信息，则只要将全局变量 opterr 设为 0 即可。



## getopt_long 函数

下面再说说 getopt_long 函数，getopt_long 函数包含了 getopt 函数的功能，另外允许指定“长参数”（或者说长选项），与 getopt 函数对比，getopt_long 比其多了两个参数。

**定义**：

```c showLineNumbers
int getopt_long(int argc, char * const argv[], const char *optstring, const struct option *longopts,int *longindex);
```

**描述**：包含 getopt 功能，增加了解析长选项的功能（如：--prefix --help）
**参数**：

 - `longopts`：指明了长参数的名称和属性
 - `longindex`：如果 longindex 非空，它指向的变量将记录当前找到参数符 longopts 里的第几个元素的描述，即是 longopts 的下标值

**返回**：对于短选项，返回值同 getopt 函数；对于长选项，如果 flag 是NULL，返回 val，否则返回 0；对于错误情况返回值同 getopt 函数。

**结构体**

```c showLineNumbers
struct option {
	const char  *name;       /* 参数名称 */  
	int          has_arg;    /* 指明是否带有参数 */  
	int          *flag;      /* flag=NULL时,返回value;不为空时,*flag=val,返回0 */  
	int          val;        /* 用于指定函数找到选项的返回值或flag非空时指定*flag的值 */  
};  
```

has_arg  指明是否带参数值，其数值可选：

 - `no_argument`：表明长选项不带参数，如：`--name`、`--help`；
 - `required_argument`：表明长选项必须带参数，如：`--prefix /root` 或 `--prefix=/root`；
 - `optional_argument`：表明长选项的参数是可选的，如：`--help` 或 `–prefix=/root`，其它都是错误。



## getopt_long_only 函数

getopt_long_only() 函数与 getopt_long() 函数使用相同的参数表，在功能上基本一致，只是 getopt_long() 只将 `--name` 当作长参数，但 getopt_long_only() 会将 `--name` 和 `-name` 两种选项都当作长参数来匹配。getopt_long_only() 如果选项 `-name` 不能在 longopts 中匹配，但能匹配一个短选项，它就会解析为短选项。



## 示例代码

我们设计一个场景，该示例程序用于输出某人说的某句话，默认输出“Hello, World!”。一共有四个选项，如下：

| 短选项 | 长选项      | 是否带参数 | 说明     |
| ------ | ----------- | ---------- | -------- |
| `-h`   | `--help`    | 否         | 查看帮助 |
| `-v`   | `--version` | 否         | 查看版本 |
| `-w`   | `--who`     | 是         | 设置名字 |
| `-s`   | `--say`     | 是         | 设置内容 |

首先引入必要的头文件：

```c showLineNumbers
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <getopt.h>
#include <string.h>
```

许多命令行程序都支持查看帮助和版本信息，所以我们先实现好这两个函数：

```c showLineNumbers
#define VER_MAJOR          0
#define VER_MINOR          1
#define VER_PATCH          1

static void show_usage(const char *cmd)
{
    printf("Usage: %s [options] ... \n", cmd);
    printf("This is a demo for how to use options\n\n");
    printf("  -h, --help           display this help and exit\n");
    printf("  -v, --version        output version information and exit\n");
    printf("  -w, --who=NAME       tell me what is your NAME\n");
    printf("  -s, --say=CONTENT    what CONTENT do you want to say\n\n");

    exit(0);
}

static void show_version(void)
{
    printf("version %d.%d.%d\n", VER_MAJOR, VER_MINOR, VER_PATCH);
    exit(0);
}
```

接下来就是要构建 option 结构体，并调用 `getopt_long()` 进行选项参数的识别：

```c showLineNumbers
int main(int argc, char *argv[])
{
    int option;
    char *name = NULL;
    char *content = "Hello, World!";

    const char * const short_options = "hvw:s:";
    const struct option long_options[] = {

        { "help",    0, NULL, 'h' },
        { "version", 0, NULL, 'v' },
        { "who",     1, NULL, 'w' },
        { "say",     1, NULL, 's' },
        { NULL,      0, NULL,  0  }
    };

    while ((option = getopt_long(argc, argv, short_options, long_options, NULL)) != -1) 
    {
        switch (option)
        {
        case 'h':
            show_usage(argv[0]);
            break;
        case 'v':
            show_version();
            break;
        case 'w':
            name = strdup(optarg);
            break;
        case 's':
            content = strdup(optarg);
            break;
        case '?':
        default :
            printf("Error: option invalid\n");
            exit(EXIT_FAILURE);
            break;
        }
    }

    if (name)
        printf("%s: ", name);

    printf("%s\n", content);

    return 0;
}
```

好啦，程序非常简单，编译运行看看效果吧！

编译：

```bash
$ gcc getopt_example.c -o getopt_example
```

查看版本：

```bash
$ ./getopt_example -v
version 0.1.1
```

查看帮助：

```bash
$ ./getopt_example -h
Usage: ./getopt_example [options] ... 
This is a demo for how to use options

  -h, --help           display this help and exit
  -v, --version        output version information and exit
  -w, --who=NAME       tell me what is your NAME
  -s, --say=CONTENT    what CONTENT do you want to say

```

带选项参数运行：

```bash
$ ./getopt_example --who Rudy --say "该起床学习啦！"
Rudy: 该起床学习啦！
```

