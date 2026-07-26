---
sidebar_position: 4
---

# Shell 变量



## 变量类型

运行 shell 时，会同时存在三种变量：

- **局部变量**。局部变量在脚本或命令中定义，仅在当前 shell 实例中有效，其他 shell 启动的程序不能访问局部变量。

- **环境变量**。所有的程序，包括 shell 启动的程序，都能访问环境变量，有些程序需要环境变量来保证其正常运行。必要的时候 shell 脚本也可以定义环境变量。

- **Shell 变量**。shell 变量是由 shell 程序设置的特殊变量。shell 变量中有一部分是环境变量，有一部分是局部变量，这些变量保证了 shell 的正常运行。



## 局部变量

### 定义变量

Shell 支持自定义变量。定义变量时，变量名不加美元符号（$），如：

```bash
variableName="value"
```

Shell 使用赋值符号（=）来表示赋值，需要注意的是，变量名和等号之间不能有空格，这可能和你熟悉的所有编程语言都不一样。同时，变量名的命名须遵循如下规则：

- Shell 变量区分大小写；
- 首个字符必须为字母（a-z，A-Z）；
- 中间不能有空格，可以使用下划线（`_`）；
- 不能使用标点符号；
- 不能使用 bash 里的关键字（可用 help 命令查看保留关键字）。

变量定义示例：

```bash showLineNumbers
myUrl="https://getiot.tech/linux-shell/shell-script-variables.html"
myNum=100
```




### 使用变量

对于已经定义过的变量，我们可以通过变量名来引用变量中的保存的数据，引用的方式是在该变量名前面加上美元符号（$）。例如：

```bash showLineNumbers
yourName="GetIoT"
echo $yourName
echo ${yourName}
```

变量名外面的花括号是可选的，加不加都行，加花括号是为了帮助解释器识别变量的边界，比如下面这种情况：

```bash showLineNumbers
for skill in Ada Coffe Action Java 
do
    echo "I am good at ${skill}Script"
done
```

如果不给 skill 变量加花括号，写成 `echo "I am good at $skillScript"`，解释器就会把 `$skillScript` 当成一个变量（其值为空），代码执行结果就不是我们期望的样子了。

建议给所有变量加上花括号，这是个好的编程习惯。



### 重新定义变量

已定义的变量，可以被重新定义，如：

```bash showLineNumbers
myUrl="http://getiot.tech"
echo ${myUrl}
myUrl="https://getiot.tech"
echo ${myUrl}
```

这样写是合法的，但注意，第二次赋值的时候不能写 `$myUrl="https://getiot.tech"`，只有在使用变量的时候才加美元符号（$）。

由于 shell 是动态类型语言，因此也可以将之前定义的字符串变量重新定义为数值型变量。

```bash showLineNumbers
myUrl=100
echo ${myUrl}
```



### `$()` 与 `${}`

在 shell 编程中，圆括号 `()` 和花括号 `{}` 的使用很容易混淆，但它们的使用是不同的：

- 花括号包裹变量名，如 `${a}`，表示使用变量 a 的值，在不引起歧义的情况下可以省略花括号；
- 圆括号可用于包裹 shell 命令，如 `$(CMD)` 命令替换，和 `` `CMD` `` 效果相同，结果为该命令的输出。

例如：

```bash showLineNumbers
kernel=$(uname -r)
echo $kernel       # 例如输出：5.8.0-55-generic
linux=`uname -r`
echo $linux        # 同样输出：5.8.0-55-generic
```



### 只读变量

使用 **readonly** 命令可以将变量定义为只读变量，只读变量的值不能被改变。

下面的例子尝试更改只读变量，结果报错：

```bash showLineNumbers
#!/bin/bash

myUrl="http://getiot.tech"
readonly myUrl
myUrl="https://getiot.tech"
```

运行脚本，结果如下：

```bash
bash: myUrl：只读变量
```



### 删除变量

使用 **unset** 命令可以删除变量。语法：

```bash
unset variableName
```

变量被删除后不能再次使用；unset 命令不能删除只读变量。

举个例子：

```bash showLineNumbers
#!/bin/sh

myUrl="http://getiot.tech"
unset myUrl
echo $myUrl
```

上面的脚本没有任何输出。



## 内部变量

### 特殊变量

自定义的变量名只能包含数字、字母和下划线，但 shell 中还设置了使用其他符号定义的特殊变量，这些变量有其特殊含义，灵活运用它们，会使 shell 程序变得更健壮、更简洁。

下表列出 shell 内部常用的特殊变量：

| **变量** | **含义**                                                     |
| :------: | :----------------------------------------------------------- |
|   `$0`   | 当前脚本的文件名。                                           |
|   `$n`   | 传递给脚本或函数的参数。n 是一个数字，表示第几个参数。       |
|   `$#`   | 传递给脚本或函数的参数个数。                                 |
|   `$-`   | 传递给脚本的执行标志。                                       |
|   `$*`   | 传递给脚本或函数的所有参数。                                 |
|   `$@`   | 传递给脚本或函数的所有参数。被双引号（" "）包含时，与 `$*` 稍有不同。 |
|   `$?`   | 上个命令的退出状态，或 shell 函数的返回值。0 表示没有错误，其他值表示有错误。 |
|   `$$`   | 当前 Shell 进程 ID。对于 Shell 脚本，就是这些脚本所在的进程 ID。 |
|   `$!`   | 最近运行的一个后台进程的 PID。                               |

下面的例子可以加深理解：

```bash showLineNumbers
#!/bin/bash

echo "Script: $0"
echo "PID   : $$"
echo "ArgCnt: $#"
echo "Arg1  : $1"
echo "Arg2  : $2"
echo "Flag  : $-"
echo "ALL*  : $*"
echo "ALL@  : $@"
echo "Exit  : $?"
```

运行脚本（输入两个参数 hello 和 world）：

```bash
$ ./special_variables.sh hello world
Script: ./special_variables.sh
PID   : 12902
ArgCnt: 2
Arg1  : hello
Arg2  : world
Flag  : hB
ALL*  : hello world
ALL@  : hello world
Exit  : 0
```

运行脚本时传递给脚本的参数称为命令行参数。命令行参数用 `$n` 表示，例如，`$1` 表示第一个参数，`$2` 表示第二个参数，依次类推。使用命令行参数，可以使 shell 脚本的运行更加灵活。



### `$*` 和 `$@` 的区别

`$*` 和 `$@` 都表示传递给函数或脚本的所有参数，不被双引号（" "）包裹时，都以 `$1`、`$2` ... `$n` 的形式输出所有参数。但是当它们被双引号包裹时，`"$*"` 会将所有的参数作为一个整体，以 `"$1 $2 ... $n"` 的形式输出所有参数；`"$@"` 会将各个参数分开，以 `"$1"`、`"$2"` ... `"$n"` 的形式输出所有参数。

下面的例子可以清楚的看到 `$*` 和 `$@` 的区别：

```bash showLineNumbers
#!/bin/bash
echo "\$*=" $*
echo "\"\$*\"=" "$*"

echo "\$@=" $@
echo "\"\$@\"=" "$@"

echo "print each param from \$*"
for var in $*
do
    echo "$var"
done

echo "print each param from \$@"
for var in $@
do
    echo "$var"
done

echo "print each param from \"\$*\""
for var in "$*"
do
    echo "$var"
done

echo "print each param from \"\$@\""
for var in "$@"
do
    echo "$var"
done
```

运行脚本（输入 a b c d 四个参数），看到如下结果：

```bash
$ ./star_vs_at_variable.sh a b c d
$*= a b c d
"$*"= a b c d
$@= a b c d
"$@"= a b c d
print each param from $*
a
b
c
d
print each param from $@
a
b
c
d
print each param from "$*"
a b c d
print each param from "$@"
a
b
c
d
```



### 退出状态

`$?` 可以获取上一个命令的退出状态。所谓退出状态，就是上一个命令执行后的返回结果。退出状态是一个数字，一般情况下，大部分命令执行成功会返回 0，失败返回 1。不过，也有一些命令返回其他值，表示不同类型的错误。

下面例子中，先创建一个文件，再执行两次删除操作：

```bash showLineNumbers
#!/bin/bash

FILE=test.txt
touch ${FILE}
echo $?
rm ${FILE}
echo $?
rm ${FILE}
echo $?
```

运行脚本，可以看到前两次命令执行的结果都是 0，第二次删除由于没有 test.txt 文件，因此返回 1 表示执行失败。

```bash
$ ./exit_variable.sh
0
0
rm: 无法删除 'test.txt': 没有那个文件或目录
1
```

`$?` 也可以表示函数的返回值，例如：

```bash showLineNumbers
#!/bin/bash

fun_test() {
    if [ $1 == 0 ]; then
        return 0
    else
        return 1
    fi
}

fun_test $1
echo $?
```

运行脚本，输入不同的参数会得到不同的输出结果：

```bash
$ ./exit_variable.sh 0
0
$ ./exit_variable.sh 1
1
$ ./exit_variable.sh 2
1
```



### 其他内部变量

除了以 `$` 符开头的特殊变量，下面这些内部变量在 shell 编程中也较为常用。

|   变量    | 含义                                                         |
| :-------: | ------------------------------------------------------------ |
| `LINENO`  | 用于显示脚本中当前执行的命令的行号。                         |
| `OLDPWD`  | 利用 cd 命令改换到新目录之前所在的工作目录。                 |
| `OPTARG`  | getopts 命令已经处理的前一个选项参数。                       |
| `OPTIND`  | 选项索引。                                                   |
|  `PPID`   | 是当前进程的父进程的 PID                                     |
|   `PWD`   | 当前工作目录。变量值等同于命令 pwd 的输出。                  |
| `RANDOM`  | 随机数变量。每次引用这个变量会得到一个 0~32767 的随机数。    |
|  `REPLY`  | read 命令，如果没有被指定变量。即通过read读入的数据，如果没有对应的变量进行赋值，则可以把REPLY变量用作read命令的默认变量，接收read命令读入的参数。 |
| `SECONDS` | 脚本已经运行的时间（以秒为单位）。                           |

下面的例子可以加深理解：

```bash showLineNumbers
#!/bin/bash

read
echo "    PPID : $PPID"
echo "     PWD : $PWD"
echo "    LINE : $LINENO"
echo "  RANDOM : $RANDOM"
echo "   REPLY : $REPLY"
echo "$OPTARG, $OPTIND"
echo "RUN TIME : $SECONDS"
```

运行脚本，首先等待用户输入，比如输入 "GetIoT"：

```bash
$ ./shell_variables.sh
GetIoT
    PPID : 7971
     PWD : /home/rudy/workspace
    LINE : 6
  RANDOM : 12180
   REPLY : GetIoT
RUN TIME : 3
```

关于 getopts 命令和 `OPTARG`、`OPTIND` 变量处理脚本参数的示例，将在 [shell 脚本示例](/linux-shell/shell-script-templates/) 中详细介绍。



## 环境变量

环境变量是在操作系统中一个具有特定名字的对象，它包含了一个或多个应用程序将使用到的信息。Linux 是一个多用户的操作系统，每个用户登录系统时都会有一个专用的运行环境，每个用户都可以通过修改环境变量的方式对自己的运行环境进行配置。

使用 env 命令可以查看所有环境变量（都为大写）：

```bash showLineNumbers
$ env
SHELL=/bin/sh
EDITOR=vi
PWD=/home/rudy
LOGNAME=rudy
XDG_SESSION_TYPE=tty
HOME=/home/rudy
LANG=C
QT_QPA_PLATFORM=wayland
...
```

除了系统默认配置的环境变量，我们也可以手动添加环境变量，添加的方法是通过 export 命令。

例如在嵌入式开发中常常需要设置 `ARCH` 和 `CROSS_COMPILE` 环境变量：

```bash
export ARCH=arm64
export CROSS_COMPILE=aarch64-poky-linux-
```

或者修改当前的环境变量，例如将当前用户主目录下的 .local/bin 目录添加到 `PATH` 环境变量：

```bash
export PATH="/home/$(whoami)/.local/bin:$PATH"
```

如果在 shell 终端执行上述 export 命令，则该环境变量只会对当前 shell 及其子 shell 有效；如果想要环境变量对所有用户生效，则可以将 export 命令保存到 /etc/profile 文件；如果只想对特定用户生效，则可以保存到 ~/.bashrc 文件。



