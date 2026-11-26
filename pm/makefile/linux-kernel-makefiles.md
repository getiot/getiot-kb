---
sidebar_position: 4
draft: true
---

# Linux 内核 Makefile 概览

linux的内核makefile主要用于编译整个内核源码，按照用户的需求生成各种目标文件，对于用户来说，编译内核时非常简单的，只需要几个指令就可以做到，但是对于一个驱动开发者而言，了解内核源码的编译机制是非常必要的。

## make 和 makefile

需要了解的是：make是linux下的一个程序软件，makefile相当于针对make程序的配置文件，当我们执行make命令时，make将会在当前目录寻找Makefile文件，然后根据Makefile的配置对源文件进行编译。

linux内核源代码的编译也是使用make工具和makefile，但是它在普通的C程序编译的基础上对配置和编译选项进行了扩展，这就是kbuild系统，专门针对linux的内核编译，使得linux内核的编译更加简洁而高效。

## linux的内核镜像文件

首先我们需要认识一下linux内核镜像的各种形式，毕竟编译内核最主要的目的就是生成内核镜像，它有几种形式：vmlinux、vmlinux.bin、vmlinuz、zImage、bzImage。

- vmlinux：这是编译linux内核直接生成的原始镜像文件，它是由静态链接之后生成的可执行文件，但是它一般不作为最终的镜像使用，不能直接boot启动，用于生成vmlinuz，可以debug的时候使用。
- vmlinux.bin：与vmlinux相同，但采用可启动的原始二进制文件格式。丢弃所有符号和重定位信息。通过objcopy -O binary vmlinux vmlinux.bin从vmlinux生成。
- vmlinuz：由vmlinux经过gzip(也可以是bzip)压缩而来，同时在vmlinux的基础上进一步添加了启动和解压缩代码,是可以引导boot启动内核的最终镜像。vmlinuz通常被放置在/boot目录，/boot目录下存放的是系统引导需要的文件，同时vmlinuz文件解压出的vmlinux不带符号表的目标文件，所以一般/boot目录下会带一个符号表System.map文件。
- zImage：这是小内核的旧格式，有指令make zImage生成，仅适用于只有640K以下内存的linux kernel文件。
- bzImage: big zImage,需要注意的是这个bz与bzip没有任何关系，适用于更大的linux kernel文件。现代处理器的linux镜像都是生成bzImage文件，同时，vmlinuz和bzImage是同一类型的文件，一般情况下这个和vmlinuz是同一个东西。

对于这一系列的生成文件可以参考[官方文档](http://www.linfo.org/vmlinuz.html)

## kbuild系统

### 各种各样的makeifle文件

在linux中，由于内核代码的分层模型，以及兼容很多平台的特性，makefile文件分布在各个目录中，对每个模块进行分离编译，降低耦合性，使编译方式更加灵活。
makefile主要是以下五个部分：

- 顶层makefile : 在源代码的根目录有个顶层makefile，顶层makefile的作用就是负责生成两个最重要的部分：编译生成vmlinux和各种模块。
- .config文件 : 这个config文件主要是产生自用户对内核模块的配置，有三种配置方式：
  - 编译进内核
  - 编译成可加载模块
  - 不进行编译。
- arch/$(ARCH)/Makefile : 从目录可以看出，这个makefile主要是根据指定的平台对内核镜像进行相应的配置,提供平台信息给顶层makefile。
- scirpts/makefile. : *这些makefile配置文件包含了构建内核的规则。
- kbuild makefiles : 每一个模块都是单独被编译然后再链接的，所以这一种kbiuld makefile几乎在每个模块中都存在.在这些模块文件(子目录)中，也可以使用Kbuild文件代替Makefile，当两者同时存在时，优先选择Kbuild文件进行编译工作，只是用户习惯性地使用Makefile来命名。

## kbuild makefile

### 编译进内核的模块

如果需要将一个模块配置进内核，需要在makefile中进行配置：

```
obj-y += foo.o
```

将foo.o编译进内核，根据make的自动推导原则，make将会自动将foo.c编译成foo.o。

上述方式基本上用于开发时的模块单独编译，当需要一次编译整个内核时，通常是在top makefile中这样写：

```
obj-$(CONFIG_FOO) += foo.o
```

在.config文件中将CONFIG_FOO变量配置成y，当需要修改模块的编译行为时，就可以统一在配置文件中修改，而不用到makefile中去找。

kbuild编译所有的obj-y的文件，然后调用$(AR) rcSTP将所有被编译的目标文件进行打包，打包成build-in.o文件，需要注意的是这仅仅是一份压缩版的存档，这个目标文件里面并不包含符号表，既然没有符号表，它就不能被链接。

紧接着调用scripts/link-vmlinux.sh，将上面产生的不带符号表的目标文件添加符号表和索引，作为生成vmlinux镜像的输入文件，链接生成vmlinux。

对于这些被编译进内核的模块，模块排列的顺序是有意义的，允许一个模块被重复配置，系统将会取用第一个出现的配置项，而忽略随后出现的配置项，并不会出现后项覆盖前项的现象。

链接的顺序同时也是有意义的，因为编译进内核的模块通常由xxx_initcall()来描述，内核对这些模块分了相应的初始化优先级，相同优先级的模块初始化函数将会被依次放置在同一个段中，而这些模块执行的顺序就取决于放置的先后顺序，由链接顺序所决定。

***linux的initcall机制可以参考另一篇博客：[linux的initcall机制](https://www.cnblogs.com/downey-blog/p/10486653.html)***

### 编译可加载的模块

所有在配置文件中标记为-m的模块将被编译成可加载模块.ko文件。

如果需要将一个模块配置为可加载模块，需要在makefile中进行配置：

```
obj-m += foo.o
```

同样的，通常可以写成这样的形式：

```
obj-$(CONFIG_FOO) += foo.o 
```

在.config文件中将CONFIG_FOO变量配置成m,在配置文件中统一控制，编译完成时将会在当前文件夹中生成foo.ko文件，在内核运行时使用insmod或者是modprobe指令加载到内核。

### 模块编译依赖多个文件

通常的，驱动开发者也会将单独编译自己开发的驱动模块，当一个驱动模块依赖多个源文件时，需要通过以下方式来指定依赖的文件：

```
obj-m += foo.o
foo-y := a.o b.o c.o   
```

foo.o 由a.o,b.o,c.o生成，然后调用$(LD) -r 将a.o,b.o,c.o链接成foo.o文件。

同样地，makefile支持以变量的形式来指定是否生成foo.o,我们可以这样:

```
obj-$(CONFIG_FOO) += foo.o
foo-$(CONFIG_FOO_XATTR) += a.o b.o c.o  
```

根据CONFIG_FOO_XATTR的配置属性来决定是否生成foo.o,然后根据CONFIG_FOO属性来决定将foo.o模块编入内核还是作为模块。

### makefile目录层次关系的处理

需要理解的一个原则就是：一个makefile只负责处理本目录中的编译关系，自然地，其他目录中的文件编译由其他目录的makefile负责，整个linux内核的makefile组成一个树状结构，对于上层makefile的子目录而言，只需要让kbuild知道它应该怎样进行递归地进入目录即可。

kbuild利用目录指定的方式来进行目录指定操作，举个例子：

```
obj-$(CONFIG_FOO) += foo/  
```

当CONFIG_FOO被配置成y或者m时，kbuild就会进入到foo/目录中，但是需要注意的是，这个信息仅仅是告诉kbuild应该进入到哪个目录，而不对其目录中的编译做任何指导。

### 编译选项

*** 需要注意的是，在之前的版本中，编译的选项由EXTRA_CFLAGS, EXTRA_AFLAGS和 EXTRA_LDFLAGS修改成了ccflags-y asflags-y和ldflags-y. ***

#### ccflags-y asflags-y和ldflags-y

ccflags-y asflags-y和ldflags-y这三个变量的值分别对应编译、汇编、链接时的参数。

同时，所有的ccflags-y asflags-y和ldflags-y这三个变量只对有定义的makefile中使用，简而言之，这些flag在makefile树中不会有继承效果，makefile之间相互独立。

#### subdir-ccflags-y, subdir-asflags-y

这两个编译选项与ccflags-y和asflags-y效果是一致的，只是添加了subdir-前缀，意味着这两个编译选项对本目录和所有的子目录都有效。

#### CFLAGS_$@, AFLAGS_$@

使用CFLAGS_或者AFLAGS_前缀描述的模块可以为模块的编译单独提供参数，举个例子:

```
CFLAGS_foo.o = -DAUTOCONF
```

在编译foo.o时，添加了-DAUTOCONF编译选项。

### kbuild中的变量

顶层makefile中定义了以下变量：

#### KERNELRELEASE

这是一个字符串，用于构建安装目录的名字(一般使用版本号来区分)或者显示当前的版本号。

#### ARCH

定义当前的目标架构平台，比如:"X86"，"ARM",默认情况下，ARCH的值为当前编译的主机架构,但是在交叉编译环境中，需要在顶层makefile或者是命令行中指定架构：

```
make ARCH=arm ...
```

#### INSTALL_PATH

指定安装目录，安装目录主要是为了放置需要安装的镜像和map(符号表)文件，系统的启动需要这些文件的参与。

#### INSTALL_MOD_PATH, MODLIB

INSTALL_MOD_PATH：为模块指定安装的前缀目录，这个变量在顶层makefile中并没有被定义，用户可以使用，MODLIB为模块指定安装目录.

默认情况下，模块会被安装到 `$(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)` 中，默认 `INSTALL_MOD_PATH` 不会被指定，所以会被安装到 `/lib/modules/$(KERNELRELEASE)` 中。

#### INSTALL_MOD_STRIP

如果这个变量被指定，模块就会将一些额外的、运行时非必要的信息剥离出来以缩减模块的大小，当INSTALL_MOD_STRIP为1时，--strip-debug选项就会被使用，模块的调试信息将被删除，否则就执行默认的参数，模块编译时会添加一些辅助信息。

这些全局变量一旦在顶层makefile中被定义就全局有效，但是有一点需要注意，在驱动开发时，一般编译单一的模块，执行make调用的是当前目录下的Makefile.

在这种情况下这些变量是没有被定义的，只有先调用了顶层makefile之后，这些变量在子目录中的makefile才被赋值。

### 生成header文件

vmlinux中打包了所有模块编译生成的目标文件，在驱动开发者眼中，在内核启动完成之后，它的作用相当于一个动态库，既然是一个库，如果其他开发者需要使用里面的接口，就需要相应的头文件。

自然地，build也会生成相应的header文件供开发者使用，一个最简单的方式就是用下面这个指令：

```
make headers_install ARCH=arm INSTALL_HDR_PATH=/DIR
```

ARCH：指定CPU的体系架构，默认是当前主机的架构，可以使用以下命令查看当前源码支持哪些架构：

```
 ls -d include/asm-* | sed 's/.*-//'	
```

INSTALL_HDR_PATH：指定头文件的放置目录，默认是./usr。

至此，build工具将在指定的DIR目录生成基于arm架构的头文件，开发者在开发时就可以引用这些头文件。

## 小结

为了清晰地了解kbuild的执行，有必要对kbuild的执行过程做一下梳理：

- 根据用户(内核)的配置生成相应的.config文件
- 将内核的版本号存入include/linux/version.h
- 建立指向 include/asm-$(ARCH) 的符号链接，选定平台
- 更新所有编译所需的文件。
- 从顶层makefile开始，递归地访问各个子目录，对相应的模块编译生成目标文件
- 链接过程，在源代码的顶层目录链接生成vmlinux
- 根据具体架构提供的信息添加相应符号，生成最终的启动镜像，往往不同架构之间的启动方式不一致。
  - 这一部分包含启动指令
  - 准备initrd镜像等平台相关的部分。



