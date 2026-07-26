---
sidebar_position: 4
sidebar_label: 认识 U-Boot 构建产物
slug: /build-artifacts
---

# 认识 U-Boot 构建产物

U-Boot 编译完成后会生成很多文件。初学者最容易困惑的是：到底哪个文件要拿去运行，哪个文件只是调试辅助，哪个文件用于特定启动介质？

本章不是要求你记住所有文件名，而是教你建立判断方法：先看文件格式，再看文件用途，最后再决定它是运行、烧录、调试还是分析用。

## 1. 常见产物

在 QEMU ARM64 实验中，你最常接触这些文件：

| 文件 | 作用 |
| --- | --- |
| `u-boot` | ELF 格式，包含符号信息，适合调试和反汇编 |
| `u-boot.bin` | 纯二进制镜像，QEMU `-bios` 常用 |
| `u-boot.map` | 链接 map 文件，可查看符号和地址布局 |
| `u-boot.dtb` | U-Boot 使用的设备树，具体是否生成取决于配置 |
| `.config` | 当前构建配置 |
| `include/generated/autoconf.h` | 根据 `.config` 生成的 C 头文件 |

运行 QEMU 时通常使用：

```bash
# [Host]
qemu-system-aarch64 -machine virt -cpu cortex-a57 -m 1024 -nographic -bios u-boot.bin
```

## 2. 用工具识别产物

先用 `ls` 看文件是否存在：

```bash
# [Host]
ls -lh u-boot u-boot.bin u-boot.map .config
```

再用 `file` 看格式：

```bash
# [Host]
file u-boot
file u-boot.bin
```

你通常会看到 `u-boot` 是 ELF 文件，而 `u-boot.bin` 是普通 data 或 raw binary。`file` 不一定能识别裸二进制的内部含义，但它能帮你区分“带元数据的 ELF”和“裸数据”。

查看镜像大小：

```bash
# [Host]
size u-boot
wc -c u-boot.bin
```

`size` 会显示 ELF 中 text、data、bss 等段大小；`wc -c` 则显示裸二进制文件字节数。

## 3. ELF 与 bin 的区别

`u-boot` 是 ELF 文件，里面有段信息、符号表、调试信息。GDB 和 `objdump` 更喜欢它：

```bash
# [Host]
aarch64-linux-gnu-objdump -h u-boot
```

`u-boot.bin` 是把可加载内容抽出来后的裸二进制。很多 ROM、烧录工具或 QEMU 固件入口需要的是这种格式。

你可以这样粗略理解：

- `u-boot`：给开发者和调试器看的。
- `u-boot.bin`：给机器加载执行的。

在 QEMU 里，`-bios u-boot.bin` 使用的是裸二进制。如果你把 `u-boot` ELF 直接传给某些固件加载入口，它可能无法识别。

## 4. map 文件有什么用

`u-boot.map` 能帮助你回答：

- 某个函数被链接到了哪里。
- 哪些对象文件进入了最终镜像。
- 镜像体积主要被哪些模块占用。

例如查找 `board_init_r`：

```bash
# [Host]
grep ' board_init_r' u-boot.map
```

你也可以查看某个命令是否进入最终链接结果。例如查找 `do_booti`：

```bash
# [Host]
grep ' do_booti' u-boot.map
```

如果某个函数在源码中存在，但 map 文件里找不到，可能说明它没有被当前配置编译或链接进镜像。

## 5. 生成文件目录

U-Boot 构建过程中会生成很多中间文件。几个常见位置：

| 路径 | 作用 |
| --- | --- |
| `.config` | 当前完整配置 |
| `include/generated/autoconf.h` | C 代码使用的配置宏 |
| `include/config/` | 构建生成的配置相关头文件 |
| `spl/` | 启用 SPL 时的构建目录 |
| `tools/` | 主机工具，如 `mkimage`、`dumpimage` |

如果使用 `O=../build/qemu-arm64`，这些文件会出现在构建输出目录，而不是源码根目录。排查时一定要确认自己正在看哪个构建目录。

## 6. 主机工具

U-Boot 构建还会生成一些在 Host 上运行的工具：

- `tools/mkimage`
- `tools/dumpimage`
- `tools/mkenvimage`

它们不是目标板上运行的 U-Boot，而是在开发主机上用来制作或查看镜像的工具。例如：

```bash
# [Host]
tools/mkimage -V
```

如果你只安装发行版的 `u-boot-tools`，也可能得到这些工具，但版本未必和教程源码一致。学习时优先使用当前源码构建出来的 `tools/mkimage`。

## 7. 其他平台的产物

真实 SoC 上你可能还会看到：

- `u-boot.img`：带 U-Boot legacy image header 的镜像。
- `u-boot.itb`：FIT 格式镜像。
- `SPL`、`u-boot-spl.bin`：早期小型加载器。
- `idbloader.img`、`flash.bin` 等厂商或 SoC 相关打包产物。

这些文件不能跨平台乱用。具体烧录哪个文件，必须以目标 SoC 启动 ROM、板级文档和 U-Boot board 文档为准。

:::warning
不要看到 `u-boot.bin` 就直接烧录到真实开发板。真实硬件可能要求 SPL、TF-A、OP-TEE、OpenSBI 或厂商头部打包后的镜像。
:::

## 本章小结

QEMU ARM64 入门时重点记住 `u-boot.bin` 用来运行，`u-boot` 用来调试，`u-boot.map` 用来看链接结果。到了真实硬件，构建产物会受到启动 ROM 和固件打包格式影响。

## 思考与练习

1. 使用 `file` 比较 `u-boot` 和 `u-boot.bin`。
2. 使用 `grep` 在 `u-boot.map` 中查找 `board_init_r`。
3. 说明为什么真实硬件不能随便烧录 QEMU 使用的 `u-boot.bin`。
