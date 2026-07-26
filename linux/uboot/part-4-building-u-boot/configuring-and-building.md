---
sidebar_position: 3
sidebar_label: 配置与编译 U-Boot
slug: /configuring-and-building
---

# 配置与编译 U-Boot

U-Boot 支持大量处理器、开发板和启动介质。你不能直接 `make` 一个“通用 U-Boot”，必须先选择目标板配置，也就是 `defconfig`。

可以把构建过程理解成三步：先选板子，再生成配置，最后按配置编译。`defconfig` 回答“我要构建哪类板子”；`.config` 回答“这次构建具体启用了哪些选项”。

## 1. 选择 QEMU ARM64 配置

进入源码目录：

```bash
# [Host]
cd /home/rudy/workspace/Projects/GetIoT/uboot-courses/u-boot-v2026.07
```

配置 QEMU ARM64：

```bash
# [Host]
make qemu_arm64_defconfig
```

这条命令会根据 `configs/qemu_arm64_defconfig` 生成 `.config`。你可以查看关键配置：

```bash
# [Host]
grep -E 'CONFIG_ARM|CONFIG_TARGET|CONFIG_BOOTSTD' .config
```

`configs/qemu_arm64_defconfig` 是一个精简配置文件，它只保存和默认值不同的关键选项。执行 `make qemu_arm64_defconfig` 后，Kconfig 系统会把默认值、依赖关系和 defconfig 合并成完整 `.config`。

## 2. 查看和调整配置

查看某个配置是否启用：

```bash
# [Host]
grep CONFIG_BOOTSTD .config
grep CONFIG_CMD_BOOTFLOW .config
```

如果你想交互式调整配置，可以使用：

```bash
# [Host]
make menuconfig
```

`menuconfig` 会修改 `.config`。如果你想把当前配置整理成新的最小 defconfig，可以使用：

```bash
# [Host]
make savedefconfig
```

它会生成 `defconfig` 文件。真实项目中通常再把它整理回 `configs/<board>_defconfig`。本教程入门阶段只需要知道这个流程，不要求你创建新板级 defconfig。

## 3. 编译

```bash
# [Host]
make CROSS_COMPILE=aarch64-linux-gnu- -j$(nproc)
```

如果你已经导出了 `CROSS_COMPILE`，可以简写：

```bash
# [Host]
make -j$(nproc)
```

编译成功后，源码根目录会生成 `u-boot.bin`、`u-boot`、`u-boot.map` 等文件。

如果你想让编译输出更容易记录，可以把日志保存下来：

```bash
# [Host]
make CROSS_COMPILE=aarch64-linux-gnu- -j$(nproc) 2>&1 | tee build.log
```

这样出错时可以回头搜索第一处错误，而不是只看终端最后几行。

## 4. 使用 out-of-tree 构建

U-Boot 支持把构建产物放到源码目录外，避免源码树被大量 `.o`、生成文件和镜像污染：

```bash
# [Host]
mkdir -p ../build/qemu-arm64
make O=../build/qemu-arm64 qemu_arm64_defconfig
make O=../build/qemu-arm64 CROSS_COMPILE=aarch64-linux-gnu- -j$(nproc)
```

产物会出现在 `../build/qemu-arm64/`。运行 QEMU 时也要使用对应路径：

```bash
# [Host]
qemu-system-aarch64 \
  -machine virt \
  -cpu cortex-a57 \
  -m 1024 \
  -nographic \
  -bios ../build/qemu-arm64/u-boot.bin
```

初学者可以先使用源码树内构建，等熟悉流程后再切换到 `O=` 方式。项目开发中更推荐 out-of-tree 构建。

## 5. 清理构建结果

只清理大部分构建产物：

```bash
# [Host]
make clean
```

同时清理 `.config`：

```bash
# [Host]
make mrproper
```

`mrproper` 会让源码树回到更干净的状态。你需要重新执行 `make qemu_arm64_defconfig` 才能再次编译。

如果使用 `O=../build/qemu-arm64`，清理也要带同样的 `O=`：

```bash
# [Host]
make O=../build/qemu-arm64 clean
```

## 6. 常见错误

#### 找不到交叉编译器

报错中出现 `aarch64-linux-gnu-gcc: not found`。检查工具链是否安装，或者 `CROSS_COMPILE` 是否写错。

#### 缺少 OpenSSL 头文件

报错中出现 `openssl/ssl.h` 或相关头文件。Ubuntu/Debian 上通常安装 `libssl-dev`。

#### 缺少 device tree compiler

报错中出现 `dtc`。安装 `device-tree-compiler`。

#### defconfig 名称错误

报错类似 `Can't find default configuration "arch/../configs/xxx_defconfig"`。确认配置文件存在：

```bash
# [Host]
ls configs/qemu_arm64_defconfig
```

#### 并行编译时错误太多

`-j$(nproc)` 会并行输出日志，错误信息可能交织在一起。可以临时降低并行度：

```bash
# [Host]
make CROSS_COMPILE=aarch64-linux-gnu- -j1
```

这会慢一些，但错误更容易看。

## 7. 在 QEMU 中运行

构建成功后，可以用前面章节的命令运行：

```bash
# [Host]
qemu-system-aarch64 \
  -machine virt \
  -cpu cortex-a57 \
  -m 1024 \
  -nographic \
  -bios u-boot.bin
```

看到 `U-Boot 2026.07` 横幅和 `=>` 提示符，就说明你编译出的镜像已经运行起来。

如果使用配套实验仓库的脚本，也可以在仓库根目录执行：

```bash
# [Host]
./scripts/run-qemu-uboot.sh
```

该脚本会检查 `u-boot-v2026.07/u-boot.bin` 是否存在，并使用 QEMU ARM64 `virt` 启动。

## 8. 构建验收清单

完成本章后，你应该能确认：

- `.config` 已生成。
- `u-boot.bin` 存在。
- QEMU 能显示 `U-Boot 2026.07`。
- U-Boot 命令行能执行 `version`、`bdinfo`。
- 如果构建失败，你能找到第一处真正错误。

## 本章小结

U-Boot 的构建流程可以概括为：选择 defconfig、生成 `.config`、交叉编译、运行验证。以后换开发板时，第一步通常就是找到对应的 defconfig。

## 思考与练习

1. 说明 `qemu_arm64_defconfig` 和 `.config` 的区别。
2. 分别尝试源码树内构建和 `O=` 构建，观察产物位置有什么不同。
3. 编译成功后，用 QEMU 启动并执行 `version`。
