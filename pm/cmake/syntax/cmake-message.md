---
sidebar_position: 4
slug: /cmake-message
authors: [luhuadong]
---

# CMake 消息打印

如果你想在 CMake 配置/构建过程中打印一些提示信息或调试信息，可以使用 CMake 提供的 **message()** 命令。下面将介绍 message() 函数的语法、消息类型，并通过一些示例演示如何使用它来打印消息。

## 语法

CMake 中 message() 函数的语法如下：

```cmake showLineNumbers
message([<mode>] "message to display" ...)
```

可选 `mode` 决定消息类型与行为：

| 消息类型 | 描述 |
|:---------|:-----|
| 无 | 重要信息 |
| `STATUS` | 一般信息，常用于配置阶段提示 |
| `WARNING` | CMake 警告，继续执行 |
| `AUTHOR_WARNING` | 面向开发者的警告，继续执行 |
| `FATAL_ERROR` | CMake 错误，终止配置/生成 |
| `SEND_ERROR` | CMake 错误，继续执行但跳过生成步骤 |
| `DEPRECATION` | 弃用提示（若打开了相关策略） |

CMake 的命令行工具会在 stdout 上显示 `STATUS` 消息，在 stderr 上显示其他所有消息。CMake 的 GUI 会在它的 log 区域显示所有消息。交互式的对话框（ccmake 和 CMakeSetup）将会在状态行上一次显示一条 `STATUS` 消息，而其他格式的消息会出现在交互式的弹出式对话框中。

CMake 警告和错误消息的文本显示使用的是一种简单的标记语言。文本没有缩进，超过长度的行会回卷，段落之间以新行做为分隔符。

## 示例

**1. 输出错误并终止（FATAL_ERROR）**

```cmake showLineNumbers
message(FATAL_ERROR "FATAL: In-source builds are not allowed. "
                    "You should create a separate directory for build files.")
```

**2. 输出警告（WARNING）**

```cmake showLineNumbers
message(WARNING "OpenCV requires Android SDK tools revision 14 or newer.")
```

**3. 输出一般信息（STATUS）**

```cmake showLineNumbers
message(STATUS "Can't detect runtime and/or arch")
```

**4. 输出变量值**

```cmake showLineNumbers
set(USER_NAME "GetIot.tech")
message(STATUS "The user name = ${USER_NAME}.")
```

:::tip

`set(USER_NAME "GetIot.tech")` 中变量名与值之间用空格分隔即可，不要写逗号。

:::

## 小结

CMake 提供了 `message()` 函数用于打印消息，它的作用相当于 C 语言中的 `printf`、C++ 中的 `std::cout` 和 Qt 中的 `qDebug()`，用于在配置/构建时输出变量或提示信息，便于排查问题和了解构建过程。
