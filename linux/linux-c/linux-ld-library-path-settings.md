---
sidebar_position: 46
authors: [luhuadong]
---

# Linux 共享库路径配置

在 Linux 编程中，有时候明明编译链接都没问题，但运行时却出现 “cannot open shared object file :No such file or directory” 错误。

原因是 Linux 下的共享库路径配置不正确。默认情况下，Linux 共享库搜索路径为 /lib 和 /usr/lib 两个目录（不包含子目录），若共享库不在这两个路径，不能自动连接到（最典型的就是 /usr/local/lib）。那怎么样呢？

## 解决办法

解决方法有五种：

1. 链接时使用静态库（.a 文件）。在 gcc 或 g++ 编译命令上写入该 .a 文件的完整路径。

2. 使用 `LD_LIBRARY_PATH` 环境变量（临时有效）。把需要添加的路径加入到 `LD＿LIBRARY＿PATH` 中，注意如果多于一个要用冒号隔开。例如：

   ```bash
   export LD_LIBRARY_PATH=/usr/local/lib/minigui
   export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib
   ```

3. 将动态库文件复制到可以搜索到的路径（一般是系统默认的路径，如 /lib、/usr/lib）里面，这种做法比较直接，可能导致一些问题，比如多个不同版本的库的兼容问题。

4. 编译的时候添加共享库搜索路径设定。在编译源码的时候使用参数 -Wl， -rpath 指定动态搜索的路径即可。

5. 修改系统文件 /etc/ld.so.conf，添加路径，运行 [ldconfig](/linux-command/ldconfig/) 命令。





