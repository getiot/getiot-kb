---
sidebar_label: hwclock 命令
sidebar_position: 21
slug: /hwclock
---

# hwclock 命令



## 介绍

**hwclock**（英文全拼：hardware clock）命令用于显示与设定硬件时钟（RTC）。

在 Linux 系统中，有硬件时钟与系统时钟等两种时钟。硬件时钟保存在 RTC 中，由外置电池供电，系统掉电后仍会继续工作。在系统启动是，系统时钟会从硬件时钟获取，以便得到一个相对准确的时钟，之后系统时钟便独立工作，通常还会从 NTP 服务器同步更新时间。更新后的系统时间可以通过 hwclock 命令回写到硬件时钟。

**语法**：

```bash
hwclock [function] [option...]
```

**功能**：

- `-r`, `--show` ：读取硬件时钟，并按 ISO 8601 格式输出（默认功能）。
- `--get` ：读取硬件时钟，等效于 `--show`。
- `--set` ：根据 `--date` 选项给定的值设定硬件时钟。
- `-s`, `--hctosys` ：从硬件时钟设定系统时钟。
- `-w`, `--systohc` ：从系统时钟设定硬件时钟。
- `-V`, `--version` ：显示版本信息并退出。
- `-h`, `--help` ：显示帮助信息并退出。

**选项**：

- `-D`, `--debug` ：显示 hwclock 执行时详细的信息（该选项已过时，建议使用 `--verbose`）。
- `--date=date_string` ：与 `--set` 功能一起使用，用于指定日期时间字符串。
- `--delay=seconds` ：此选项允许在设置时钟时间时覆盖内部使用的延迟。rtc_cmos 的默认值为 0.5 (500ms)，对于其他 RTC 类型，延迟为 0。如果 RTC 类型无法确定（从 sysfs），那么它也默认为 0.5 以向后兼容。
- `--directisa` ：hwclock 预设从 /dev/rtc 设备来存取硬件时钟。若无法存取时，可用此参数直接以 I/O 指令来存取硬件时钟。
- `--test` ：仅测试程序，而不会实际更改硬件时钟。
- `-l`, `--localtime` ：使用本地时间进行设置。
- `-u`, `--utc` ：使用 UTC 时间进行设置。
- `-v`, `--verbose` ：显示 hwclock 执行时详细的信息。

注意：hwclock 命令的功能（function）是互斥的，同一时间只能指定一个功能；选项（option）则可以灵活使用。



## 示例

使用硬件时钟作为参考（看作 UTC 时间），设置系统时钟：

```bash
hwclock --utc --hctosys
```

将系统时钟回同步到硬件时钟（看作 UTC 时间）：

```bash
hwclock --utc --systohc
```

