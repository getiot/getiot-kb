---
sidebar_position: 5
draft: true
---

# Linux 内核模块 Makefile 编写



在开发 Linux 内核驱动时，免不了要接触到 Makefile 的编写和修改，尽管网上的makefile模板一大堆，做一些简单的修改就能用到自己的项目上，但是，对于这些基础的东西，更应该做到知其然并知其所以然。
***本篇文章中只讨论linux内核模块编译的makefile，linux内核makefile总览可以参考另一篇博客：[linux内核makefile概览](https://www.cnblogs.com/downey-blog/p/10486863.html)***

本篇博客参考[官方文档](https://www.kernel.org/doc/html/latest/kbuild/modules.html)。

linux内核使用的是kbuild编译系统，在编译可加载模块时，其makefile的风格和常用的编译C程序的makefile有所不同，尽管如此，makefile的作用总归是给编译器提供编译信息。

## 最简单的makefile

我们先来看看一个最简单的makefile是怎样的：

```
    obj-m+=hello.o
    all:
            make -C /lib/modules/$(shell uname -r)/build/ M=$(PWD) modules
    clean:
            make -C /lib/modules/$(shell uname -r)/build/ M=$(PWD) clean
```

这个makefile的作用就是编译hello.c文件，最终生成hello.ko文件。

#### obj-m+=hello.o

obj-m表示编译生成可加载模块。

相对应的，obj-y表示直接将模块编译进内核。

可以看到，这里并没有输入hello.c源文件，熟悉makefile的人应该知道，这得益于makefile的自动推导功能，需要编译生成filename.o文件而没有显示地指定filename.c文件位置时，make查找filename.c是否存在，如果存在就正常编译，如果不存在，则报错。

obj-m+=hello.o，这条语句就是显式地将hello.o编译成hello.ko,而hello.o则由make的自动推导功能编译hello.c文件生成。

#### all，clean

all，clean这一类的是makefile中的伪目标，伪目标并不是一个真正的编译目标，它代表着一系列你想要执行的命令集合，通常一个makefile会对应多个操作，例如编译，清除编译结果，安装，就可以使用这些伪目标来进行标记。在执行时就可以键入：

```
    make clean
    make install
```

等指令来完成相应的指令操作，当make后不带参数时，默认执行第一个伪目标的操作。

#### make -C /lib/modules/$(shell uname -r)/build/ M=$(PWD) modules

标准的make指令是这样的：make -C $KDIR M=$PWD [target]，下面分别介绍每个字段的含义。

-C选项：此选项指定内核源码的位置，make在编译时将会进入内核源码目录，执行编译，编译完成时返回。

$KDIR：/lib/modules/$(shell uname -r)/build/，指定内核源码的位置。

直接在目标板上编译时，内核头文件默认存放在/lib/modules/$(shell uname -r)/build/中，这个build/目录是一个软连接，链接到源码头文件的安装位置。而内核真正的源码库则直接引用正在运行的内核镜像。

当跨平台编译时，就需要指定相应的内核源码目录，而不是系统中的源码目录，但是交叉编译时，需不需要指定架构平台和交叉编译工具链呢？我们接着往下看;

M=$(PWD)：需要编译的模块源文件地址

------

[target]：modules，事实上，这是个可选选项。默认行为是将源文件编译并生成内核模块，即module(s)，但是它还支持一下选项：

- modules_install:安装这个外部模块，默认安装地址是/lib/modules/$(uname -r)/extra/，同时可以由内建变量INSTALL_MOD_PATH指定安装目录
- clean:卸载源文件目录下编译过程生成的文件，在上文的makefile最后一行可以看到。
- help：帮助信息

## 更多选项

### 编译多个源文件

hello_world总是简单的，但是在实际开发中，就会出现更复杂的情况，这时候就需要了解更多的makefile选项：

首先，当一个.o目标文件的生成依赖多个源文件时，显然make的自动推导规则就力不从心了(它只能根据同名推导，比如编译filename.o，只会去查找filename.c)，我们可以这样指定：

```
    obj-m  += hello.o
    hello-y := a.o b.o hello_world.o
```

hello.o目标文件依赖于a.o,b.o,hello_world.o,那么这里的a.o和b.o如果没有指定源文件，根据推导规则就是依赖源文件a.c,b.c,hello_world.c.
除了hello-y，同时也可以用hello-objs,实现效果是一样的。

### 同时编译多个可加载模块

kbuild支持同时编译多个可加载模块，也就是生成多个.ko文件，它的格式是这样的：

```
    obj-m := foo.o bar.o
    foo-y := <foo_srcs>
    bar-y := <bar_srcs>
```

就是这么简单。

### ifneq ($(KERNELRELEASE),)

通常，标准的makefile会写成这样：

```
    ifneq ($(KERNELRELEASE),)
    obj-m  := hello.o

    else
    KDIR ?= /lib/modules/`uname -r`/build

    all:
            $(MAKE) -C $(KDIR) M=$(PWD) modules
    clean:
            $(MAKE) -C $(KDIR) M=$(PWD) clean
    endif
```

为什么要添加一个ifneq，else，all条件判断。

这得从linux内核模块make执行的过程说起：当键入make时，make在当前目录下寻找makefile并执行，KERNELRELEASE在顶层的makefile中被定义，所以在执行当前makefile时KERNELRELEASE并没有被定义，走else分支，直接执行

```
    $(MAKE) -C $(KDIR) M=$(PWD) modules
```

而这条指令会进入到$(KDIR)目录，调用顶层的makefile，在顶层makefile中定义了KERNELRELEASE变量.

在顶层makefile中会递归地再次调用到当前目录下的makefile文件，这时KERNELRELEASE变量已经非空，所以执行if分支，在可加载模块编译列表添加hello模块，由此将模块编译成可加载模块放在当前目录下。

归根结底，各级子目录中的makefile文件的作用就是先切换到顶层makefile，然后通过obj-m在可加载模块编译列表中添加当前模块，kbuild就会将其编译成可加载模块。

如果是直接编译整个内核源码，就省去了else分支中进入顶层makefile的步骤。

需要注意的一个基本概念是：每一次编译，顶层makefile都试图递归地进入每个子目录调用子目录的makefile，只是当目标子目录中没有任何修改时，默认不再进行重复编译以节省编译时间。

这里同时解决了上面的一个疑问：既然是从顶层目录开始编译，那么只要顶层目录中指定了架构(ARCH)和交叉编译工具链地址(CROSS_COMPILE)，各子目录中就不再需要指定这两个参数。

## 头文件的放置

当编译的目标模块依赖多个头文件时，kbuild对头文件的放置有这样的规定：

- 直接放置在makefile同在的目录下，在编译时当前目录会被添加到头文件搜索目录。

- 放置在系统目录，这个系统目录是源代码目录中的include/linux/。

- 与通用的makefile一样，使用-I$(DIR)来指定，不同的是，代表编译选项的变量是固定的，为ccflag.

  ```
    一般的用法是这样的：
  
            ccflags-y := -I$(DIR)/include   
    kbuild就会将$(DIR)/includ目录添加到编译时的头文件搜索目录中。  
  ```



