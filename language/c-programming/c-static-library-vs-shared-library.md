---
sidebar_position: 47
draft: true
---

# C 语言 - 静态库和共享库



通常情况下，对函数库的链接是放在编译时期（compile time）完成的，所有相关的对象文件（object file）与牵涉到的函数库（library）被链接合成一个可执行文件（executable file）。程序在运行时，与函数库再无瓜葛，因为所有需要的函数已拷贝到自己门下。所以这些函数库被成为静态库（static libaray），通常文件名为“libxxx.a”的形式。
其实，我们也可以把对一些库函数的链接载入推迟到程序运行的时期（runtime），这就是如雷贯耳的动态链接库（dynamic link library）技术。

## 静态库概念

1. 库是预编译的目标文件（object files）的集合，它们可以被链接进程序。静态库以后缀为“.a”的特殊的存档（archive file）存储。
2. 标准系统库可在目录 `/usr/lib` 与 `/lib` 中找到。比如，在类 Unix 系统中 C 语言的数学库一般存储为文件 `/usr/lib/libm.a`。该库中函数的原型声明在头文件 `/usr/include/math.h` 中。
3. C 标准库本身存储为 `/usr/lib/libc.a`，它包含 ANSI/ISO 标准指定的函数，比如 `printf`。对每一个 C 程序来说，`libc.a` 都默认被链接。
4. 静态库的优点是可以在不用重新**编译**程序**库**代码的情况下，进行程序的**重新链接**，这种方法节省了编译过程的时间（在编译大型程序的时候，需要花费很长的时间）。静态库的另一个优点是开发者可以提供库文件给使用的人员，不用开放源代码，这是库函数提供者经常采用的手段。

### 实例

在程序中调用数学库 `libm.a` 中 `sin` 函数，保存为 `main.c` 文件。

```c showLineNumbers
#include <stdio.h>
#include <math.h>
int main(void)
{
    double x = 2.0;
    double y = sin(x);
    printf("the result:%f\n", y);
    return 0;
}
```

如果直接使用 `gcc main.c -o main`，则会出现错误：undefined reference to ‘sin’。解释：

1. 函数 `sin()`，未在本程序中定义，也不在默认库 libc.a 中，除非被指定，编译器不会自主链接 libm.a。

2. 为使编译器能将 `sin()` 链接进主程序 main.c，需要提供数学库 libm.a。

3. 使用方法：`gcc main.c -o main /usr/lib/libm.a` 或 `gcc main.c -o main /usr/lib64/libm.a`（具体视操作系统而定）。

   以上可以编译通过。为了避免在命令行中指定长的路径（其实有更深、更充分的原因，稍后讲解），编译器为链接函数库提供了快捷的选项 `-l`。因此可以使用下面的方法：`gcc main.c -lm –o main`。略作说明：

   - 选项 `-lNAME` 使用连接器尝试链接系统库目录中的函数库文件 libNAME.a；

   - 此实例使用 gcc 编译，如果使用 g++ 编译、链接，会成功生成可执行文件。

     ![img](https://raw.githubusercontent.com/nielon/MarkdownPhotos/master/diff-g++-gcc-link.png#center)

## 动态库概念

1. 动态链接库是程序运行时加载的库，当动态链接库正确安装后，所有的程序都可以使用动态库来运行程序。动态链接库是目标文件的集合，目标文件在动态链接库中的组织方式是按照特殊方式形成的。库中函数和变量的地址是相对地址，不是绝对地址，其真实地址在调用动态库的程序加载时形成。
2. 动态链接库的名称有别名（soname）、真名（realname）和链接名（linker name）。别名由一个前缀 lib，然后是库的名字，再加上一个后缀“.so”构成。真名是动态链接库真实名称，一般总是在别名的基础加上一个小版本号，发布版本等构成。除此之外，还有一个链接名，即程序链接时使用的库的名字。（更详细的内容在第 6 章讲述共享库的版本时展开）
3. 在动态链接库安装的时候，总是复制文件到某个目录下，然后用一个软连接生成别名，在库文件进行更新的时候，仅仅更新软链接即可。
4. 把库函数推迟到程序运行时期载入的好处：
   - 可以实现进程之间的资源共享；
   - 将一些程序升级变得简单；
   - 甚至可以真正做到链接载入完全由程序员在程序代码中控制；

## 生成链接库

在具体讲解链接库的生成和使用之前，先创建以下程序文件。在 test 文件夹下创建 main.c \ add.c \ sub.c \ test.h

```
/* main.c */
#include <stdio.h>
#include "test.h"
int  main()
{
    printf("add=:%d\n",add(5,3));
    printf("sub=:%d\n",sub(5,3));
    return 0;
}
/* add.c */
int add(int a, int b)
{
    return (a+b);
}
/* sub.c */
int sub(int a, int b)
{
    return (a-b);
}
/* test.h */
#ifndef __TESTMATH__
#define __TESTMATH__
 
int add(int a, int b);
int sub(int a, int b);
 
#enddif //__TESTMATH__
```

代码上两者没有区别，主要在于编译命令的不同。

### 静态库

将目标文件用 `ar` 命令打包就可以：`ar` 是 archive 的缩写，也就是归档的意思，平时我们用得更多的是另一条归档命令 `tar`。`ar`和 `tar` 的功能其实比较类似，但 `ar` 命令做了一些额外的处理，它会为被归档的目标文件中的符号建立索引，当和应用程序链接时，建立的这些索引将回收链接过程。

```
gcc -c add.c -o add.o
gcc -c sub.c -o sub.o
ar -rcs libtest.a add.o sub.o
```

### 共享库/动态库

也是使用目标文件。但生成目标文件时要加编译器选项 `-fpic`；生成动态库时使用链接器选项 `-shared`。在编译的时候（即生成目标文件的时候），我们需要告诉编译器，这些对象文件是用来做动态链接库的，所以要用地址不相关代码（Position Independent Code （PIC））； -shared：生成共享目标文件，通常用于建立共享库时使用。

```
gcc -fPIC -c add.c -o add.o
gcc -fPIC -c sub.c -o sub.o
gcc -shared –o libtest.so  add.o sub.o
# 以上两步也可以合成一步搞定：
gcc  add.c sub.c -fPIC -shared -o libtest.so
```

## 使用链接库

静态库的名字形式为”libxxx.a”，后缀名为”.a”；共享库/动态库的名字形式为 “libxxx.so”，后缀名为 “.so”。

静态库和动态库的使用基本一样，用的是 `-Lpath` 和 `-lxxx` 标签。编译器会先在 path 文件夹下搜索 libxxx.so 文件，如果没有找到，继续搜索 libxxx.a（静态库）。当指定 `-static` 标签时，表示禁止使用共享库，则不会搜索 libxxx.so 文件，直接搜索 libxxx.a（静态库）。

动态库

```
gcc main.c -o main -ltest -L.
```

静态链接库

```
gcc main.c -o main -ltest -L. -static    # -static：禁止使用共享库。
```

也可以这样使用链接库（不推荐，但适用于非规则命名的链接库 eg 无 lib 前缀的）

```
gcc main.c -o main libadd.a    #使用gcc命令带上库文件就OK了
gcc main.c -o main libadd.so
```

### 动态链接库 vs. 静态链接库

![img](https://raw.githubusercontent.com/nielon/MarkdownPhotos/master/shared-first-1.png#center)

通过上图的对比可以验证，链接程序在链接时是优先链接的动态库。如果打算使用静态库：情况一，指定目录下同时存在动态库、静态库，需用 `-static` 参数指定链接静态库；情况二，指定目录只有静态库，则可以不用 `-static`。

![img](https://raw.githubusercontent.com/nielon/MarkdownPhotos/master/shared-first-2.png#center)

## 运行程序

静态库的使用到这里已经结束了。这一节是要说使用动态库的主程序运行的问题。

看到这里，不知是否有注意到使用动态链接库生成可执行文件，执行 `./main` 时报错。这是因为程序运行时没有找到动态库造成的。程序编译时链接动态库和运行时使用动态库的概念是不同的，在运行时，程序链接的动态库需要在系统目录下才行。

我们可以通过 `ldd` 命令查看某程序当前对动态链接库的依赖情况：

![img](https://raw.githubusercontent.com/nielon/MarkdownPhotos/master/ldd.png#center)

`ldd` 的结果表明了我们生成的 libtest.so 找不到。因为动态库是一个可以共享的文件，因此往往存放在一个公共的位置，在 Linux 系统中程序查找动态链接库的规则如下：

1. 首先在环境变量 LD_LIBRARY_PATH 所记录的路径中查找。
2. 然后从缓存文件 /etc/ld.so.cache 中查找。
3. 如果上述步骤都找不到，则到默认的系统路径（具体呢？）中查找，先是 /lib 然后是 /usr/lib。

很明显，这几个路径都不包含当前路径。相应的，使用以下方法可以解决此问题：

- 在 linux 下最方便的解决方案是拷贝 libtest.so 到绝对目录 /lib 下（需要 root 用户权限）；

- 将动态库的目录放到程序搜索路径中，可以通过定义名为 LD_LIBRARY_PATH 的环境变量来实现：

  ```
  rmq@baba-db01:~/cts2/nielong/test> export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/cts2/nielong/test/
  rmq@baba-db01:~/cts2/nielong/test> echo $LD_LIBRARY_PATH
  :/data/rmq/cts2/nielong/test
  ```

  # 动态库的版本问题

前面章节介绍动态库时好些地方都做了简化，包括动态库的命名和生成、动态库的查找目录及查找顺序，动态库在编译环境和运行环境中的区别。

### 版本及命名

[参考链接](http://linux-wiki.cn/wiki/zh-hans/动态库(.so))

动态库的版本总是个问题，如果编译时链接的库和执行时提供的不一样，难免会导致程序的执行发生诡异的错误。为解决此问题，Linux系列的做法是这样的：

首先，每个so文件有一个文件名，如libABC.so.x.y.z，这里ABC是库名称，x.y.z是文件的版本号，一般来说：

- 第一位x表示了兼容性，x不一样的so文件是不能兼容的。
- 第二位y的变化表示可能引入了新的特性（Feature），但总的来讲还是兼容的。
- 第三位z的变化一般表示仅是修正了Bug。
- 并非所有.so文件都遵循此规则，但其应用确实很普遍。

在系统中，会存在一些符号链接， 如

```
libpam.so -> libpam.so.0.83.0
libpam.so.0 -> libpam.so.0.83.0
```

其中第一个（linker name）主要在使用该库**开发**其它程序时使用，比如gcc想连接PAM库，直接连libpam.so就行了，不必在链接时给出它的具体版本。第二个（soname）则主要用在**运行**时，因为前面说了第一位版本一样的库是互相兼容的，所以程序运行时只要试图连接libpam.so.0就够了，不必在意其具体的版本（在前面章节针对这两者是没有区分的）。ldconfig(8) 可以自动生成这些链接。

ldconfig 检查存在的 real name 文件，并且创建指向它的符号链接 soname 文件。ldconfig 还做一件事情就是建立 cache 文件 /etc/ld.so.cache。

那么编译程序时gcc在链接一个so文件（如libpam.so）时，如何知道该程序运行时链接哪个文件呢（上例中是libpam.so.0）？原来产生so文件时，可以指定一个soname，一般形如libABC.so.x。人们编译可执行文件时，如果链接了某个so，存在可执行文件里的.so文件名并不是其全名，而是这个soname。比如上例中，这个soname就是libpam.so.0。

### 生成动态库

[参考链接](http://littlewhite.us/archives/301)

更细致的生成动态库的操作为：

```
gcc hello.c -fPIC -shared -Wl,-soname,libhello.so.0 -o libhello.so.0.0.1
```

需要注意的参数是 `-Wl,-soname`（中间没有空格），`-Wl` 选项告诉编译器将后面的参数传递给链接器，`-soname` 则指定了动态库的 soname（简单共享名，Short for shared object name）。

现在我们生成了 libhello.so.0.0.1，当我们运行 `ldconfig -n .` 命令时，当前目录会多一个软连接（普通用户执行 `ldconfig` 时可能提示找不到命令，环境变量的问题，指明路径就可以了 `/sbin/ldconfig -n .`）。这个软链接是如何生成的呢，并不是截取 libhello.so.0.0.1 名字的前面部分，而是根据 libhello.so.0.0.1 编译时指定的 `-soname` 生成的。也就是说我们在编译动态库时通过 `-soname` 指定的名字，已经记载到了动态库的二进制数据里面。不管程序是否按 libxxx.so.a.b.c 格式命名，但 Linux 上几乎所有动态库在编译时都指定了 `-soname`，我们可以通过 `readelf` 工具查看 soname。

关键就是这个soname，它相当于一个中间者，当我们的动态库只是升级一个小版本时，我们可以让它的soname相同，而可执行程序只认soname指定的动态库，这样依赖这个动态库的可执行程序不需重新编译就能使用新版动态库的特性。

#### 库的放置

[参考链接](http://blog.csdn.net/ldong2007/article/details/3194187)

动态库必须放置在文件系统的指定位置。

1. 多数开源软件遵守GNU 标准：当分发源代码的时候，库默认安装在 /usr/local/lib，命令安装在 /usr/local/bin。该标准还定义了如何重写这些默认标准以及如何调用安装程序。
2. Filesystem Hierarchy Standard(FHS) 规定：多数库应安装在 /usr/lib，启动时需要的库安装在 /lib，非系统库应安装在 /usr/local/lib

GNU 标准是针对开发人员的，FHS 是针对发行者的。

### 使用动态库：可执行程序的编译

在Linux下，编译时指定-lhello，链接器会去寻找 libhello.so 这样的文件，当前目录下没有这个文件，所以报错。一般通过建立这样一个软链接解决此问题。

生成可执行文件之后，使用 ldd 查看其依赖的动态库。发现main程序依赖的动态库名字是 libhello.so.0，既不是 libhello.so 也不是 libhello.so.0.0.1。其实在生成 main 程序的过程有如下几步：

1. 链接器通过编译命令 `-L. -lhello` 在当前目录查找 libhello.so 文件
2. 读取 libhello.so 链接指向的实际文件，这里是 libhello.so.0.0.1
3. 读取 libhello.so.0.0.1 中的 SONAME，这里是 libhello.so.0
4. 将 libhello.so.0 记录到 main 程序的二进制数据里

也就是说 libhello.so.0 是已经存储到 main 程序的二进制数据里的，不管这个程序在哪里，通过 ldd 查看它依赖的动态库都是 libhello.so.0

### 使用动态库：可执行程序的运行

至此，我们知道了**程序运行时需要寻找的动态库文件名其实是动态库编译时指定的SONAME**，即 libhello.so.0，但它会去哪里找这个文件呢？

~~参考另一篇笔记《build.md》（还在整理中，未发布），其中详细介绍了程序执行时动态库的查找路径及查找顺序。~~尴了个尬，那篇笔记里只描述了预处理阶段查找头文件的路径及其查找顺序。

需要强调的是，当出现共享库找不到时，并 [不推荐设置 LD_LIBRARY_PATH 变量](http://xahlee.info/UnixResource_dir/_/ldpath.html)。而应该在生成可执行文件时做出修改，不单单使用 `-L` 指定编译时链接路径，也要使用 `-R`（`-rpath`） 指定运行时查找路径。`-Wl,-rpath` 举例：

```
# 当指定多个动态库搜索路径时，路径之间用冒号"："分隔
gcc -Wl,-rpath,libPath -L libPath -ltest hello.c
```

将搜索路径信息写入可执行文件（rpath 代表 runtime path）。这样就不需要设置环境变量。坏处是，如果库文件移动位置，我们需要重新编译test。

#### -Wl,-rpath

[参考链接](http://stackoverflow.com/questions/6562403/i-dont-understand-wl-rpath-wl)

man gcc:

> -Wl,option
>
> Pass option as an option to the linker. If option contains commas, it is split into multiple options at the commas. You can use this syntax to pass an argument to the option. For example, `-Wl,-Map,output.map` passes `-Map output.map` to the linker. When using the GNU linker, you can also get the same effect with `-Wl,-Map=output.map’.

man ld:

> -rpath=dir
>
> Add a directory to the runtime library search path. This is used when linking an ELF executable with shared objects. All -rpath arguments are concatenated and passed to the runtime linker, which uses them to locate shared objects at runtime. The -rpath option is also used when locating shared objects which are needed by shared objects explicitly included in the link;

`-Wl` 是 gcc 的参数，用来将后续的内容传给连接器；
`-rpath` 是 ld 的参数，用来指定运行时库的查找路径；其**并非 gcc** 的参数。

指定多个动态库搜索路径的写法：（严格控制空格的存在）

```
g++ $^ -o $@ ${LDFLAGS} ${LDLIBS} -Wl,-rpath -Wl,${LD_RUN_PATH1} -Wl,-rpath -Wl,${LD_RUN_PATH2}
# or
g++ $^ -o $@ ${LDFLAGS} ${LDLIBS} -Wl,-rpath -Wl,${LD_RUN_PATH1}:${LD_RUN_PATH2}
```

#### 库是如何被使用的

[参考链接](http://blog.csdn.net/ldong2007/article/details/3194187)

在基于 GNU glibc 的系统上，包括所有 linux 系统，ELF 可执行二进制文件的运行自动导致程序加载器被加载并且运行。在 linux 下，加载器是 /lib/ld-linux.so.X（X是版本号）。然后加载器搜索、加载程序所要使用的动态链接库。

被搜索的文件夹列表保存在文件 /etc/ld.so.conf 里。

在程序启动的时候搜索这些文件夹是很没有效率的，所以实际上使用缓存。ldconfig(8) 默认读取 /etc/ld.so.conf 文件，在 DLL 文件夹里创建合适的符号链接，在 /etc/ld.so.cache 里写入一个缓存。缓存大大加速了库的读取。所以，当一个 DLL 被添加、删除时，或DLL文件夹被改变时都需要运行 ldconfig 程序，当安装了一个新的 DLL 时，由软件包管理器自动运行 ldconfig。当程序启动时，装载器实际使用的是缓存。

### 动态库版本更新

看懂了以上内容，动态库怎么进行版本更新就只是上述原理的应用而已。如果还有疑惑，见 [参考链接](http://littlewhite.us/archives/301)

## 动态库的显示调用

以上使用动态链接库的方式可以称为隐式调用，相对应的显式调用是使用 linux 提供 `dlopen`、`dlsym`、`dlerror` 和 `dlcolose` 函数获取动态链接库。

关于显式调用，可以参考：[Linux下动态链接库的使用](http://www.cnblogs.com/Xiao_bird/archive/2010/03/01/1675821.html)





## 参考

- [https://tnie.github.io/2016/12/09/library-static-dynamic/](https://tnie.github.io/2016/12/09/library-static-dynamic/)
- [https://www.cnblogs.com/ifantastic/p/3526237.html](https://www.cnblogs.com/ifantastic/p/3526237.html)