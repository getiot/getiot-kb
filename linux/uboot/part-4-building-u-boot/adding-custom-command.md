---
sidebar_position: 8
sidebar_label: 添加一个自定义命令
slug: /adding-custom-command
---

# 为 U-Boot 添加一个自定义命令

添加自定义命令是理解 U-Boot 命令系统的好练习。本章我们添加一个最小命令 `hello_getiot`，让它在 U-Boot 命令行中输出一行文字。

:::note
这个实验适合放在课程实验源码中单独做补丁。不要直接在产品 U-Boot 中保留无意义测试命令。
:::

## 1. 实验目标

完成本章后，你应该能做到：

- 在 `cmd/` 中新增一个命令实现文件。
- 把新文件接入 `cmd/Makefile`。
- 重新编译并在 QEMU 中运行。
- 使用 `help` 和命令返回值验证命令。
- 理解 `U_BOOT_CMD()` 的基本参数。

建议你先确认前面章节的 QEMU ARM64 编译流程已经成功，再做本实验。

## 2. 新增命令文件

在 U-Boot 源码中创建 `cmd/hello_getiot.c`：

```bash
# [Host]
cd /home/rudy/workspace/Projects/GetIoT/uboot-courses/u-boot-v2026.07
```

文件内容示例：

```c
// SPDX-License-Identifier: GPL-2.0+

#include <command.h>
#include <stdio.h>

static int do_hello_getiot(struct cmd_tbl *cmdtp, int flag, int argc,
                           char *const argv[])
{
        puts("Hello, GetIoT U-Boot course!\n");
        return 0;
}

U_BOOT_CMD(
        hello_getiot, 1, 0, do_hello_getiot,
        "print a greeting for the GetIoT U-Boot course",
        ""
);
```

这段代码有几个点：

- `do_hello_getiot()` 是命令处理函数。
- `puts()` 输出字符串到 U-Boot console。
- 返回 `0` 表示命令执行成功。
- `U_BOOT_CMD()` 把函数注册成命令。

## 3. 接入 Makefile

编辑 `cmd/Makefile`，增加一行：

```makefile
obj-y += hello_getiot.o
```

这表示只要进入 `cmd/` 构建，就编译这个命令。更规范的产品写法是增加 Kconfig 选项，再使用 `obj-$(CONFIG_CMD_HELLO_GETIOT)` 控制是否编译。本章先用最小方式理解机制。

你可以先确认 Makefile 中已有很多类似写法：

```bash
# [Host]
rg "obj-.*cmd|obj-y" cmd/Makefile
```

## 4. 重新编译并运行

```bash
# [Host]
make qemu_arm64_defconfig
make CROSS_COMPILE=aarch64-linux-gnu- -j$(nproc)
qemu-system-aarch64 -machine virt -cpu cortex-a57 -m 1024 -nographic -bios u-boot.bin
```

进入 U-Boot 后：

```bash
# [U-Boot]
help hello_getiot
hello_getiot
```

预期输出：

```bash
Hello, GetIoT U-Boot course!
```

如果使用 out-of-tree 构建，请记得所有 `make` 命令都带上相同的 `O=` 参数。

## 5. 验证命令是否编进去了

除了在 U-Boot 命令行中运行，还可以从构建产物侧验证。

查看 map 文件：

```bash
# [Host]
grep hello_getiot u-boot.map
```

查看符号：

```bash
# [Host]
aarch64-linux-gnu-nm u-boot | grep hello_getiot
```

如果这些地方都找不到，说明文件可能没有参与编译，优先检查 `cmd/Makefile`。

## 6. 命令注册机制

`U_BOOT_CMD()` 宏把命令名称、最大参数个数、是否可重复执行、处理函数和帮助信息注册到 U-Boot 命令表中。你输入命令时，U-Boot 会在命令表中查找名称，然后调用对应函数。

处理函数返回 `0` 表示成功，非零表示失败。脚本中的 `&&`、`||` 会受到返回值影响。

`U_BOOT_CMD()` 的常见形式可以这样理解：

```c
U_BOOT_CMD(
        name, maxargs, repeatable, command_function,
        short_help,
        long_help
);
```

其中：

- `name`：命令名称。
- `maxargs`：最大参数个数，包含命令本身。
- `repeatable`：是否允许回车重复执行。
- `command_function`：处理函数。
- `short_help`：`help` 列表中的简短说明。
- `long_help`：`help <command>` 时显示的详细说明。

## 7. 增加参数处理

你可以把命令稍微扩展一下，让它接收一个名字：

```c
static int do_hello_getiot(struct cmd_tbl *cmdtp, int flag, int argc,
                           char *const argv[])
{
        const char *name = "GetIoT";

        if (argc > 1)
                name = argv[1];

        printf("Hello, %s!\n", name);
        return 0;
}

U_BOOT_CMD(
        hello_getiot, 2, 0, do_hello_getiot,
        "print a greeting for the GetIoT U-Boot course",
        "[name]"
);
```

重新编译后：

```bash
# [U-Boot]
hello_getiot
hello_getiot U-Boot
```

这能帮助你理解 `argc` 和 `argv` 与普通 C 程序命令行参数的相似之处。

## 8. 可选：使用 Kconfig 控制

更规范的做法是给命令增加配置选项。思路是：

1. 在 `cmd/Kconfig` 中增加 `config CMD_HELLO_GETIOT`。
2. 在 `cmd/Makefile` 中使用 `obj-$(CONFIG_CMD_HELLO_GETIOT) += hello_getiot.o`。
3. 通过 `menuconfig` 或 defconfig 启用。

示意 Makefile：

```makefile
obj-$(CONFIG_CMD_HELLO_GETIOT) += hello_getiot.o
```

本教程不强制你完成这一步，因为 Kconfig 细节会引入更多内容。但你应该知道：产品级功能通常不建议永远 `obj-y`，而应由配置项控制。

## 9. 常见问题

#### `Unknown command 'hello_getiot'`

优先检查：

- `cmd/hello_getiot.c` 文件名是否正确。
- `cmd/Makefile` 是否加入了对象文件。
- 是否重新编译了 U-Boot。
- QEMU 运行的是否是新生成的 `u-boot.bin`。

#### 编译报函数签名错误

检查处理函数参数是否与示例一致：

```c
static int do_xxx(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
```

不同 U-Boot 版本可能有细节变化。本教程以 v2026.07 为准。

### 修改代码后运行结果没变

你可能运行了旧镜像。先确认 `u-boot.bin` 的修改时间，再确认 QEMU `-bios` 指向的是同一个文件。

## 10. 下一步改进

真正的命令通常还需要：

- 检查参数个数。
- 解析数值和地址。
- 返回明确错误码。
- 增加 Kconfig 选项。
- 增加帮助文本。
- 避免访问未初始化设备。

## 本章小结

一个 U-Boot 命令并不神秘：它本质上是一个 C 函数，加上一段注册信息。通过这个实验，你已经摸到了 U-Boot 命令行背后的代码入口。

## 思考与练习

1. 修改命令，让它接收一个参数并输出。
2. 使用 `grep hello_getiot u-boot.map` 验证命令是否进入最终镜像。
3. 解释 `U_BOOT_CMD()` 中 `maxargs` 的含义。
