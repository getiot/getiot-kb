---
sidebar_label: nm 命令
sidebar_position: 7
slug: /nm
---

# nm 命令 - 列出目标文件的符号表



## 介绍

**nm**（英文全拼：names）命令是 [GNU Binutils](https://www.gnu.org/software/binutils/) 二进制工具集的一员，用于显示二进制文件（例如库文件和可执行文件等）中的符号。如果没有为 nm 命令指明目标文件，则 nm 假定目标文件是 a.out。

**语法**：

```bash
nm [选项] [文件]
```

**选项**：

- `-A`, `-o`, `--print-file-name` ：在找到的各个符号的名字前加上文件名，而不是在此文件的所有符号前只出现文件名一次。
- `-a`, `--debug-syms` ：显示调试符号。
- `-B`, `--format=bsd` ：用来兼容 MIPS 的 nm。
- `-C`, `--demangle[=STYLE]` ：将低级符号名解码（demangle）成用户级名字，比如去除编译时添加的前置下划线，这样可以使得 C++ 函数名具有可读性。不同的编译器符号修饰风格不同，可以使用 =STYLE 参数来选择合适的解码风格。
- `-D`, `--dynamic` ：显示动态符号。该任选项仅对于动态目标(例如特定类型的共享库)有意义。
- `-f`, `--format=FORMAT` ：FORMAT 可取值 bsd、sysv 或 posix，该选项在 GNU nm 中有用，默认为 bsd。
- `-g`, `--extern-only` ：仅显示外部符号。
- `-h`, `--help` ：显示帮助信息。
- `-l`, `--line-numbers` ：对每个符号，使用调试信息来试图找到文件名和行号。对于已定义的符号，查找符号地址的行号。对于未定义符号，查找指向符号重定位入口的行号。如果可以找到行号信息，显示在符号信息之后。
- `-n`, `-v`, `--numeric-sort` ：按符号对应地址的顺序排序，而非按符号名的字符顺序。
- `-P`, `--portability` ：使用 POSIX.2 标准输出格式代替默认的输出格式。等同于 -f posix。
- `-p`, `--no-sort` ：按目标文件中遇到的符号顺序显示，不排序。
- `-r`, `--reverse-sort` ：逆序排序。例如，升序变为降序。
- `-S`, `--print-size` ：以 BSD 输出样式输出已定义符号的值和大小。对于不记录符号大小的目标文件格式，此选项不起作用，除非使用了--size sort，在这种情况下，将显示计算的大小。
- `-s`, `--print-armap` ：当列出库中成员的符号时，同时列出索引。索引的内容包含：模块与其包含的名字的定义之间的映射。
- `-t`, `--radix=RADIX` ：使用基数 radix 进制显示符号值。radix 只能为 d（十进制）、o（八进制）或 x（十六进制）。
- `-u`, `--undefined-only` ：仅显示没有定义的符号。
- `-V`, `--version` ：显示版本信息并退出。
- `-X` ：为了与 AIX 版本的 nm 兼容，选项 -X 将被忽略。它可接受一个参数，该参数必须是字符串 32_64。AIX nm 的默认模式对应于 -X 32，GNU nm 不支持模式 -X 32。
- `--defined-only` ：仅显示有定义的符号。
- `--no-demangle` ：不解码低级符号名，这是默认选项。
- `--plugin NAME` ：加载名为 name 的插件以添加对额外目标类型的支持。只有在启用插件支持的情况下构建了工具链时，此选项才可用。
- `--size-sort` ：按符号大小排列。
- `--special-syms` ：显示目标相关的具体特殊含义的符号。这些符号通常被特定目标文件用于某些特殊处理，当包含在正常符号列表中时通常不起作用。例如，对于 ARM 目标，此选项将跳过用于标记 ARM 代码、Thumb 代码和数据之间转换的映射符号。
- `--synthetic` ：输出合成符号。合成符号是链接器为各种目的创建的特殊符号，默认情况下不会显示它们，因为它们不是二进制文件源代码的一部分。
- `--target=BFDNAME` ：指定系统默认格式以外的目标文件格式。



## 示例

假设 hello.c 代码如下：

```c
#include <stdio.h>

static int g_test;
int baud_table[5] = {9600, 19200, 38400, 57600, 115200};

int main(void)
{
    int l_test;
    printf("Hello, GetIoT\n");
    return 0;
}
```

执行 `gcc hello.c` 编译后，查看 a.out 文件中所有的符号

```bash
$ nm a.out 
0000000000004010 D baud_table
0000000000004024 B __bss_start
0000000000004024 b completed.8060
                 w __cxa_finalize@@GLIBC_2.2.5
0000000000004000 D __data_start
0000000000004000 W data_start
0000000000001090 t deregister_tm_clones
0000000000001100 t __do_global_dtors_aux
0000000000003dc0 d __do_global_dtors_aux_fini_array_entry
0000000000004008 D __dso_handle
0000000000003dc8 d _DYNAMIC
0000000000004024 D _edata
0000000000004030 B _end
00000000000011e8 T _fini
0000000000001140 t frame_dummy
0000000000003db8 d __frame_dummy_init_array_entry
000000000000215c r __FRAME_END__
0000000000003fb8 d _GLOBAL_OFFSET_TABLE_
                 w __gmon_start__
0000000000002014 r __GNU_EH_FRAME_HDR
0000000000004028 b g_test
0000000000001000 t _init
0000000000003dc0 d __init_array_end
0000000000003db8 d __init_array_start
0000000000002000 R _IO_stdin_used
                 w _ITM_deregisterTMCloneTable
                 w _ITM_registerTMCloneTable
00000000000011e0 T __libc_csu_fini
0000000000001170 T __libc_csu_init
                 U __libc_start_main@@GLIBC_2.2.5
0000000000001149 T main
                 U puts@@GLIBC_2.2.5
00000000000010c0 t register_tm_clones
0000000000001060 T _start
0000000000004028 D __TMC_END__
```



## 符号说明

对于每一个符号来说，其类型如果是小写的，则表明该符号是 local 的；大写则表明该符号是 global（external）的。

- A 该符号的值是绝对的，在以后的链接过程中，不允许进行改变。这样的符号值，常常出现在中断向量表中，例如用符号来表示各个中断向量函数在中断向量表中的位置。

- B 该符号的值出现在非初始化数据段（bss）中。例如，在一个文件中定义全局 static int test。则该符号 test 的类型为 b，位于 bss section 中。其值表示该符号在 bss 段中的偏移。一般而言，bss 段分配于 RAM 中。

- C 该符号为 common。common symbol 是未初始话数据段。该符号没有包含于一个普通 section 中。只有在链接过程中才进行分配。符号的值表示该符号需要的字节数。例如在一个 c 文件中，定义 int test，并且该符号在别的地方会被引用，则该符号类型即为 C。否则其类型为 B。

- D 该符号位于初始化数据段中。一般来说，分配到 data section 中。

  例如：定义全局 `int baud_table[5] = {9600, 19200, 38400, 57600, 115200};`，会分配到初始化数据段中。

- G 该符号也位于初始化数据段中。主要用于 small object 提高访问 small data object 的一种方式。

- I 该符号是对另一个符号的间接引用。

- N 该符号是一个 debugging 符号。

- R 该符号位于只读数据区。

  例如：定义全局 `const int test[] = {123, 123};`，则 test 就是一个只读数据区的符号。

- S 符号位于非初始化数据区，用于 small object。

- T 该符号位于代码区 text section。

- U 该符号在当前文件中是未定义的，即该符号的定义在别的文件中。

  例如：当前文件调用另一个文件中定义的函数，在这个被调用的函数在当前就是未定义的；但是在定义它的文件中类型是T。但是对于全局变量来说，在定义它的文件中，其符号类型为 C，在使用它的文件中，其类型为 U。

- V 该符号是一个 weak object。

- W 该符号是一个弱符号，没有被专门标记为 weak object 符号。

- ? 该符号类型没有定义



