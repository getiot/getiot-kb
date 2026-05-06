---
sidebar_position: 9
sidebar_label: spdlog
slug: /spdlog
---

# spdlog（C++ 高性能日志库）

**spdlog** 是一个非常流行的 C++ 日志库，主打 **高性能**、**易用** 与 **可扩展**。它是 **header-only（可选）** 的设计风格，集成成本低；同时支持多种输出目标（console / 文件 / rotating / daily / syslog 等）、灵活的格式化（基于 `fmt`）、多线程安全以及异步日志。对桌面应用、服务端程序、工具链以及需要“既快又稳”的 C++ 项目来说，spdlog 是非常常见的选择。



## 主要特点

- **高性能**：同步与异步两种模式可选，适合高频日志场景。
- **多种输出（sinks）**：控制台、普通文件、滚动文件（rotating）、按天切分（daily）、syslog 等。
- **格式化能力强**：支持 `fmt` 风格格式化与 `pattern` 自定义输出格式。
- **多线程安全**：默认 logger 线程安全（不同 logger 可独立配置）。
- **可选 header-only**：只包含头文件即可用，也可编译成库以减少编译时间。
- **日志级别与过滤**：trace/debug/info/warn/error/critical/off，支持全局与单 logger 控制。



## 使用方法

下面给出几种常见的集成方式，你可以按项目现状选一种（推荐优先使用包管理器或 CMake FetchContent）。

### 1. 获取源码

```bash
git clone https://github.com/gabime/spdlog.git
```

### 2. 使用包管理器安装（推荐）

#### vcpkg

```bash
vcpkg install spdlog
```

#### Conan（示例）

在 `conanfile.txt` 添加：

```ini
[requires]
spdlog/1.15.0

[generators]
CMakeDeps
CMakeToolchain
```

> 版本号请以你项目实际锁定版本为准。

### 3. CMake FetchContent（零外部依赖管理）

在你的 `CMakeLists.txt` 中加入：

```cmake
include(FetchContent)

FetchContent_Declare(
  spdlog
  GIT_REPOSITORY https://github.com/gabime/spdlog.git
  GIT_TAG v1.15.0
)

FetchContent_MakeAvailable(spdlog)
```

然后链接：

```cmake
target_link_libraries(your_target PRIVATE spdlog::spdlog)
```



## 快速上手

### 1. 控制台输出

```cpp showLineNumbers
#include <spdlog/spdlog.h>

int main() {
  spdlog::info("hello spdlog");
  spdlog::warn("value={} hex={:#x}", 42, 42);
  spdlog::error("something wrong: {}", "bad input");
  return 0;
}
```

### 2. 创建文件 logger（基础文件）

```cpp showLineNumbers
#include <spdlog/sinks/basic_file_sink.h>

int main() {
  auto logger = spdlog::basic_logger_mt("file_logger", "app.log");
  logger->info("write to file: {}", 123);
  spdlog::flush_every(std::chrono::seconds(3));
}
```

### 3. 滚动文件（rotating）

当日志文件达到指定大小后滚动，保留固定数量的历史文件：

```cpp showLineNumbers
#include <spdlog/sinks/rotating_file_sink.h>

int main() {
  // 单文件 10MB，最多保留 5 个历史文件
  auto logger = spdlog::rotating_logger_mt("rot", "app.log", 10 * 1024 * 1024, 5);
  logger->info("rotating log test");
}
```

### 4. 按天切分（daily）

```cpp showLineNumbers
#include <spdlog/sinks/daily_file_sink.h>

int main() {
  // 每天 00:00 生成新文件
  auto logger = spdlog::daily_logger_mt("daily", "daily.log", 0, 0);
  logger->info("daily log");
}
```



## 日志级别与输出格式

### 日志级别

```cpp showLineNumbers
spdlog::set_level(spdlog::level::info);   // 全局最低级别
spdlog::set_level(spdlog::level::debug);  // 开发期常用
spdlog::set_level(spdlog::level::trace);  // 最详细
```

### pattern（输出格式）

常用 pattern 示例：

```cpp showLineNumbers
spdlog::set_pattern("[%Y-%m-%d %H:%M:%S.%e] [%^%l%$] [%t] %v");
```

常见占位符说明（节选）：

- **`%Y-%m-%d %H:%M:%S`**：日期时间
- **`%e`**：毫秒
- **`%l`**：日志级别（info/warn/...）
- **`%^` 与 `%$`**：启用/关闭颜色范围（仅彩色 sink 有效）
- **`%t`**：线程 ID
- **`%v`**：日志正文



## 异步日志（高吞吐场景）

异步日志适用于“日志量很大但又不想阻塞业务线程”的场景。典型做法是初始化线程池，然后创建异步 logger：

```cpp showLineNumbers
#include <spdlog/async.h>
#include <spdlog/sinks/rotating_file_sink.h>

int main() {
  // 队列长度 8192，后台线程 1 个（可按需增加）
  spdlog::init_thread_pool(8192, 1);

  auto sink = std::make_shared<spdlog::sinks::rotating_file_sink_mt>(
      "async.log", 10 * 1024 * 1024, 3);

  auto logger = std::make_shared<spdlog::async_logger>(
      "async",
      sink,
      spdlog::thread_pool(),
      spdlog::async_overflow_policy::block);

  spdlog::register_logger(logger);
  logger->info("async log ready");
}
```

常见溢出策略：

- **`block`**：队列满时阻塞生产者（更安全，不丢日志）
- **`overrun_oldest`**：覆盖最旧日志（不阻塞，但会丢日志）



## 常用 API 与实践建议

- **定期 flush**：`spdlog::flush_every(std::chrono::seconds(3));`
- **程序退出前 flush**：必要时显式 `spdlog::shutdown();`
- **为关键 logger 设置自动 flush**：例如 `logger->flush_on(spdlog::level::warn);`
- **避免过度拼接字符串**：用 `fmt` 参数化，减少不必要的临时对象
- **高频日志慎用 trace**：trace/debug 大量输出会显著影响性能与磁盘 IO



## 常见问题

### 1. “我写了日志但文件里没看到”

可能原因：

- 进程退出太快未 flush（加 `flush_every` 或退出前 `shutdown`）
- 日志级别过滤（确认 `set_level` 与 logger 级别）
- 文件权限/路径问题（相对路径随工作目录变化）

### 2. 编译很慢

spdlog 可 header-only 使用，但大型工程可能导致编译时间增长。实践上可以：

- 使用编译成库的方式（按项目构建系统配置）
- 或在 CMake 中启用/关闭相关选项，减少重复实例化（根据项目情况取舍）

### 3. 多线程下日志顺序“看起来乱”

多线程并发写日志时，时间相近的日志在不同线程交错属于正常现象。若你需要严格顺序，通常意味着要引入额外的队列/单线程写入约束（异步 logger 的单消费者也能改善“文件写入交错”，但并不等同于业务事件顺序）。



## 相关链接

- [spdlog 代码仓库](https://github.com/gabime/spdlog)
- [spdlog Wiki / Examples](https://github.com/gabime/spdlog/wiki/1.-QuickStart)

