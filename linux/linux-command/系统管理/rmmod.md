---
sidebar_position: 26
slug: /rmmod
---

# rmmod 命令



## 介绍

**rmmod**（英文全拼：remove module）命令用于移除已载入内核的模块。

**语法**：

```shell
rmmod [options] modulename
```

**选项**：

- `-f`, `--force` ：强制移除模块，使用此选项比较危险。
- `-s`, `--syslog` ：将错误信息输出至 syslog 服务，而标准输出。
- `-v`, `--verbose` ：显示指令执行的详细信息。

**参数**：模块名



## 示例

卸载 getiot.ko 模块（模块名不需要带后缀）

```shell
rmmod getiot
```

卸载 getiot 模块并显示执行信息

```shell
rmmod -v getiot
```

卸载 getiot 模块并将错误信息写入 syslog

```shell
rmmod -s getiot
```

删除正在使用的 getiot 模块（谨慎使用）

```shell
rmmod -f getiot
```

