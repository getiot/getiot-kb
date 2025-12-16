---
sidebar_position: 7
sidebar_label: zlog
slug: /zlog
---

# zlog 纯 C 语言日志库

**zlog** 是一款高性能、线程安全、灵活配置的纯 C 语言日志库，专为 Linux 和类 Unix 系统设计。它支持多种日志输出目的地（如文件、控制台等），并提供了丰富的配置选项，允许开发者根据需要调整日志的级别、格式和输出方式。

zlog 的设计目标是解决传统 C 语言日志解决方案（如 `printf` 和 `syslog`）的不足，提供更高效、更安全、更强大的日志记录功能。可以为 C 语言应用程序提供类似于 Java 中的 logback 或 C++ 中的 log4cxx 的日志功能。



## 主要特点

- **高性能**：在作者的笔记本上，Zlog 的性能可达每秒 25 万条日志，比使用 `rsyslogd` 的 `syslog(3)` 快约 1000 倍。
- **线程安全和进程安全**：支持多线程和多进程环境下的日志记录。
- **灵活的配置**：通过配置文件可以灵活设置日志的输出格式、输出目标、日志级别等。
- **多种输出目标**：支持将日志输出到标准输出、标准错误、静态文件路径、动态文件路径、syslog 以及用户自定义的输出。
- **日志文件轮转**：支持线程安全和进程安全的日志文件轮转。
- **微秒级精度**：日志时间戳支持微秒级精度。
- **无外部依赖**：仅依赖于 POSIX 系统和 C99 标准的 `vsnprintf`。
- **自定义日志级别**：用户可以根据需要定义自己的日志级别。
- **运行时刷新配置**：支持手动或自动刷新配置文件，且不会丢失日志信息。
- **默认类别日志 API**：提供 `dzlog`，一个默认类别的日志 API，便于快速使用。
- **日志上下文（MDC）**：支持类似 log4j 的键值对映射，用于记录上下文信息。
- **自调试功能**：可以在运行时输出 Zlog 自身的调试和错误日志。



## 核心概念

zlog 的架构基于三个核心模块：

- **Category（分类）**：用于区分不同的日志记录器。每个分类可以有独立的配置，便于模块化管理。
- **Format（格式）**：定义日志的输出格式，如时间戳、日志级别、线程 ID、文件名等。
- **Rule（规则）**：将分类、格式和输出目标结合起来，决定日志的输出行为。

这种设计使得 zlog 在保持高性能的同时，提供了高度的灵活性。



## 使用方法

#### 安装 zlog

在 Linux 系统中，可以通过以下命令安装 zlog：

```bash showLineNumbers
git clone https://github.com/HardySimpson/zlog.git
cd zlog
make
sudo make install
```

#### 配置文件

zlog 使用配置文件来定义日志的行为。一个典型的配置文件示例如下：

```ini showLineNumbers title="zlog.conf"
[global]
buffer_min = 1024
buffer_max = 2048

[formats]
simple = "%d %V [%p] %m%n"

[rules]
my_cat.DEBUG >stdout; simple
```

上述配置定义了一个名为 `my_cat` 的分类，使用 `simple` 格式，将 DEBUG 级别的日志输出到标准输出。

#### 初始化和使用

在代码中，可以按照以下方式使用 zlog：

```c showLineNumbers title="zlog_demo.c"
#include "zlog.h"

int main() {
    int rc;
    zlog_category_t *c;

    rc = zlog_init("zlog.conf");
    if (rc) {
        printf("init failed\n");
        return -1;
    }

    c = zlog_get_category("my_cat");
    if (!c) {
        printf("get cat fail\n");
        zlog_fini();
        return -2;
    }

    zlog_info(c, "hello, zlog");

    zlog_fini();
    return 0;
}
```

上述代码初始化 zlog，获取名为 `my_cat` 的分类，并记录一条 INFO 级别的日志。



## 常用 API

zlog 提供了丰富的 API，常用的包括：

- `zlog_init(const char *confpath)`：初始化 zlog，加载配置文件。
- `zlog_get_category(const char *name)`：获取指定名称的分类。
- `zlog_info(zlog_category_t *c, const char *format, ...)`：记录 INFO 级别的日志。
- `zlog_debug(zlog_category_t *c, const char *format, ...)`：记录 DEBUG 级别的日志。
- `zlog_error(zlog_category_t *c, const char *format, ...)`：记录 ERROR 级别的日志。
- `zlog_fini()`：释放资源，关闭 zlog。

此外，zlog 还提供了 `dzlog_*` 系列函数，适用于不需要分类的简单场景。



## 相关链接

- [https://github.com/HardySimpson/zlog](https://github.com/HardySimpson/zlog)
