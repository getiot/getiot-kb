---
sidebar_position: 2
sidebar_label: glog
slug: /glog
---

# glog 高性能 C++ 日志库

**glog** 是一个由 Google 开发的 C++ 日志库，提供简洁高效的日志记录功能，广泛应用于各种 C++ 项目中。



## 概况与特点

- **日志级别**：支持四种日志级别：`INFO`、`WARNING`、`ERROR` 和 `FATAL`。`FATAL` 级别的日志在输出后会终止程序。
- **流式 API**：采用 C++ 风格的流式语法，使用 `LOG()` 宏记录日志信息。
- **条件与频率控制**：提供 `LOG_IF`、`LOG_EVERY_N` 等宏，实现条件和频率控制的日志记录。
- **断言检查**：通过 `CHECK` 系列宏进行断言检查，帮助在开发过程中捕捉错误。
- **线程安全**：设计为线程安全，适用于多线程环境。
- **日志文件管理**：支持日志文件的自动命名和轮转，便于日志管理。



## 使用方法

#### 1. 安装 glog

在 Linux 系统中，可以通过以下命令安装 glog：

```bash
sudo apt-get install libgoogle-glog-dev
```

或者从源码编译安装：

```bash
git clone https://github.com/google/glog.git
cd glog
mkdir build && cd build
cmake ..
make
sudo make install
```

#### 2. 初始化与使用

在代码中使用 glog：

```cpp showLineNumbers
#include <glog/logging.h>

int main(int argc, char* argv[]) {
    google::InitGoogleLogging(argv[0]);

    LOG(INFO) << "This is an info message.";
    LOG(WARNING) << "This is a warning message.";
    LOG(ERROR) << "This is an error message.";
    // LOG(FATAL) << "This is a fatal message."; // 程序将在此终止

    google::ShutdownGoogleLogging();
    return 0;
}
```

默认情况下，日志文件会保存在 `/tmp` 目录下，文件名格式为：

```bash
/tmp/<program_name>.<hostname>.<user>.log.<severity>.<date>.<time>.<pid>
```

#### 3. 配置选项

通过设置全局变量控制日志行为：

```cpp showLineNumbers
FLAGS_logtostderr = true;       // 将日志输出到标准错误
FLAGS_alsologtostderr = true;    // 同时输出到标准错误和日志文件
FLAGS_log_dir = "/path/to/log";  // 设置日志文件目录
FLAGS_minloglevel = 1;           // 设置最低日志级别（0:INFO, 1:WARNING, 2:ERROR, 3:FATAL）
```

这些变量需要在 `InitGoogleLogging` 调用之前设置。



## 常用宏与 API

- `LOG(severity)`：记录指定级别的日志。
- `LOG_IF(severity, condition)`：当条件为真时记录日志。
- `LOG_EVERY_N(severity, N)`：每 N 次记录一次日志。
- `LOG_IF_EVERY_N(severity, condition, N)`：当条件为真时，每 N 次记录一次日志。
- `CHECK(condition)`：断言检查，条件为假时输出 `FATAL` 日志并终止程序。
- `DCHECK(condition)`：仅在调试模式下进行断言检查。

这些宏提供了灵活的日志记录和调试功能，帮助开发者更好地监控和诊断程序行为。



## 相关链接

- [glog 代码仓库](https://github.com/google/glog)
