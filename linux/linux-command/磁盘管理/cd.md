---
sidebar_label: cd 命令
sidebar_position: 4
slug: /cd
---

# cd 命令



## 介绍

**cd**（英文全拼：change directory）命令用于切换当前工作目录。

**语法**：

```bash
cd [dirName]
```

**参数**：

- `dirName` 可为绝对路径或相对路径。若目录名称省略，则变换至使用者的 home 目录（也就是刚 login 时所在的目录）。
- 另外，**`~`** 也表示为 home 目录的意思， **`.`** 则是表示目前所在的目录， **`..`** 则表示目前目录位置的上一层目录。



## 示例

进入 /etc/apache2 目录

```bash
cd /etc/apache2
```

跳到当前用户的 home 目录 

```bash
cd
```

或

```bash
cd ~
```

返回上级目录（若当前目录为“/“，则执行完后还在“/"；".."为上级目录的意思）

```bash
cd ..
```

返回上两级目录

```bash
cd ../..
```

返回进入此目录之前所在的目录

```bash
cd -
```

把上个命令的参数作为 cd 参数使用

```bash
cd !$
```

