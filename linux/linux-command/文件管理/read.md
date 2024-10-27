---
sidebar_label: read 命令
sidebar_position: 12
slug: /read
---

# read 命令



## 介绍

**read** 命令用于从标准输入读取当行数据。

read 是一个 bash 的内建命令，这个命令可以用来读取键盘输入，当使用重定向的时候，可以读取文件中的一行数据。

### 语法

```bash
read [选项] [参数]
```

**参数说明:**

- `-a` ：后跟一个变量，该变量会被认为是个数组，然后给其赋值，默认是以空格为分割符。
- `-d` ：后面跟一个标志符，其实只有其后的第一个字符有用，作为结束的标志。
- `-p` ：后面跟提示信息，即在输入前打印提示信息。
- `-e` ：在输入的时候可以使用命令补全功能。
- `-n` ：后跟一个数字，定义输入文本的长度，很实用。
- `-r` ：屏蔽 `\`，如果没有该选项，则 `\` 作为一个转义字符，有的话 `\` 就是个正常的字符了。
- `-s` ：安静模式，在输入字符时不再屏幕上显示，例如login时输入密码。
- `-t` ：后面跟秒数，定义输入字符的等待时间。
- `-u` ：后面跟 fd，从文件描述符中读入，该文件描述符可以是 exec 新开启的。



## 示例

简单读取键盘输入：

```bash
#!/bin/bash
echo "输入网站名: "
read file
echo "你输入的网站名是 $file"
exit 0
```

允许在 read 命令行中直接指定一个提示：

```bash
#!/bin/bash 
read -p "输入网站名:" file 
echo "你输入的网站名是 $file"  
exit 0
```

指定 read 命令等待输入的秒数。当计时满时，read 命令返回一个非零退出状态：

```bash
#!/bin/bash 
if read -t 5 -p "输入网站名:" file 
then
	echo "你输入的网站名是 $file" 
else     
	echo "\n抱歉，你输入超时了。" 
fi 
exit 0
```

设置 read 命令计数输入的字符。当输入的字符数目达到预定数目时，自动退出，并将输入的数据赋值给变量：

```bash
#!/bin/bash 
read -n1 -p "Do you want to continue [Y/N]?" answer
echo ""
case $answer in 
Y | y)       
	echo "fine ,continue";; 
N | n)       
	echo "ok,good bye";; 
*)      
	echo "error choice";;  
esac 
exit 0
```

使 read 命令中输入的数据不显示在命令终端上：

```bash
#!/bin/bash 
read -s -p "请输入您的密码:" pass 
echo -e "\n您输入的密码是 $pass" 
exit 0
```

