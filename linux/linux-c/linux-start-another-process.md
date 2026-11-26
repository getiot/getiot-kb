---
sidebar_position: 57
sidebar_label: Linux 启动另一个进程
authors: [luhuadong]
---

# Linux 进程中启动另一个进程

在 Linux 编程中，你经常会遇到这样的需求：从当前进程中启动另一个进程，比如运行一个外部命令、调用另一个程序，或者构建一个父子进程模型来完成特定任务。
 本文将带你了解三种常用方式：`system`、`fork` + `exec`、`popen`，并通过示例帮助你理解它们的区别和使用场景。



## 使用 `system` 函数

`system()` 是 C 标准库提供的函数，它最简单，适合执行短小的 shell 命令。

**示例：**

```c showLineNumbers
#include <stdlib.h>

int main() {
    system("ls -l /");  // 执行 shell 命令
    return 0;
}
```

- 它会调用默认的 shell（通常是 `/bin/sh`）来执行你传入的字符串。
- 函数返回执行结果的**退出状态码**，你可以用 `WEXITSTATUS()` 宏提取它。

**优点：**

- 简单易用；
- 不需要 `fork` 和 `exec` 的繁琐细节。

**缺点：**

- 依赖 shell；
- 无法获取进程的输出内容；
- 存在安全隐患（尤其是当命令中含有用户输入时）；



## 使用 `fork` 和 `exec` 系列函数

如果你想精细控制子进程行为，可以使用经典的 `fork` + `exec` 组合。

**工作原理：**

1. `fork()` 创建一个**子进程**，此时父子进程几乎完全一样；
2. 子进程中调用 `exec()` 系列函数**替换当前进程映像**为另一个程序；
3. 父进程可以使用 `wait()` 或 `waitpid()` 等函数等待子进程退出。

**示例：**

```c showLineNumbers
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main() {
    pid_t pid = fork();

    if (pid == 0) {
        // 子进程
        execlp("ls", "ls", "-l", "/", NULL);
        perror("exec failed");  // exec 失败才会执行这句
        exit(EXIT_FAILURE);
    } else if (pid > 0) {
        // 父进程
        int status;
        waitpid(pid, &status, 0);
        printf("Child exited with status %d\n", WEXITSTATUS(status));
    } else {
        // fork 出错
        perror("fork failed");
    }

    return 0;
}
```

**exec 常用函数：**

|  函数名  | 特点说明                       |
| :------: | ------------------------------ |
| `execl`  | 参数列出命令和参数             |
| `execv`  | 参数用数组表示                 |
| `execlp` | 自动查找 `PATH` 环境变量       |
| `execvp` | `execv` + PATH 查找            |
| `execve` | 最底层的版本，可以传递环境变量 |

**优点：**

- 更安全、更灵活；
- 不依赖 shell；
- 适合构建复杂的父子进程模型。

**缺点：**

- 代码稍复杂；
- 如果你不熟悉多进程，容易出错。



## 使用 `popen` 执行命令并获取输出

`popen()` 也是 C 标准库提供的接口，它可以让你**启动另一个进程并读取其输出**（或向其写入输入）。

**示例：**

```c showLineNumbers
#include <stdio.h>

int main() {
    FILE *fp = popen("ls /", "r");
    char buf[128];

    while (fgets(buf, sizeof(buf), fp)) {
        printf("%s", buf);
    }

    pclose(fp);
    return 0;
}
```

- `popen` 第二个参数 `"r"` 表示读取子进程输出；`"w"` 表示写入子进程输入。
- 它返回一个 `FILE*`，你可以用 `fgets()` 等函数读取输出内容。

**优点：**

- 简单；
- 能读取子进程输出（`system()` 做不到）；
- 类似于 `shell` 的“管道”用法。

**缺点：**

- 仍然依赖 shell；
- 不适合高并发或复杂交互。



## 小结

在 Linux 编程中，启动另一个进程的方法不止一种：

|     方法      |    适合场景    | 是否依赖 shell | 是否能获取输出 | 控制粒度 |
| :-----------: | :------------: | :------------: | :------------: | :------: |
|  `system()`   |  简单执行命令  |      ✅ 是      |      ❌ 否      |    低    |
| `fork`+`exec` | 精确控制子进程 |      ❌ 否      |    ✅ 可扩展    |    高    |
|   `popen()`   |  读取命令输出  |      ✅ 是      |      ✅ 是      |    中    |

你可以根据项目需求选择不同方法：

- 如果你只是想简单地执行一条命令，`system()` 足够了；
- 如果你需要更强的控制，比如守护进程、守护服务等，建议使用 `fork` + `exec`；
- 如果你想像 Shell 脚本那样“管道读取结果”，用 `popen()` 更方便。


