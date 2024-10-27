---
sidebar_label: ldd 命令
sidebar_position: 2
slug: /ldd
---

# ldd 命令



## 介绍

**ldd**（英文全拼：list dynamic dependencies）命令列出程序或库文件的动态依赖关系（所依赖的共享库列表）。

**语法**：

```bash
ldd [option]... file...
```

**选项**：

- `--version`：打印指令版本号
- `-v`：详细信息模式，打印所有相关信息
- `-u`：打印未使用的直接依赖
- `-d`：执行重定位和报告任何丢失的对象
- `-r`：执行数据对象和函数的重定位，并且报告任何丢失的对象和函数
- `--help`：显示帮助信息

**参数**：指定可执行程序或者库文件

**原理**： ldd 不是个可执行程式，而只是个 shell 脚本；ldd 显示可执行模块的 dependency 的工作原理，其实质是通过 ld-linux.so（elf 动态库的装载器）来实现的。



## 示例

示例：查看 ls 程序运行所依赖的库

```bash
$ ldd /bin/ls
        linux-vdso.so.1 (0x00007ffcc3563000)
        libselinux.so.1 => /lib64/libselinux.so.1 (0x00007f87e5459000)
        libcap.so.2 => /lib64/libcap.so.2 (0x00007f87e5254000)
        libc.so.6 => /lib64/libc.so.6 (0x00007f87e4e92000)
        libpcre.so.1 => /lib64/libpcre.so.1 (0x00007f87e4c22000)
        libdl.so.2 => /lib64/libdl.so.2 (0x00007f87e4a1e000)
        /lib64/ld-linux-x86-64.so.2 (0x00005574bf12e000)
        libattr.so.1 => /lib64/libattr.so.1 (0x00007f87e4817000)
        libpthread.so.0 => /lib64/libpthread.so.0 (0x00007f87e45fa000)
```

每一行会有两列或三列，含义如下：


- 第1列：程序需要依赖什么库
- 第2列：系统提供的与程序需要的库所对应的库
- 第3列：库加载的开始地址

通过上面的信息，我们可以得到以下几个信息：

1. 通过对比第1列和第2列，我们可以分析程序需要依赖的库和系统实际提供的，是否相匹配
2. 通过观察第3列，我们可以知道在当前的库中的符号在对应的进程的地址空间中的开始位置

如果依赖的某个库找不到，通过这个命令可以迅速定位问题所在。