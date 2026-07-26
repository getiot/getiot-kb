---
sidebar_position: 5
sidebar_label: 镜像格式与固件打包
slug: /image-formats-and-packaging
---

# U-Boot 镜像格式与固件打包

构建出 `u-boot.bin` 不代表它一定能被真实硬件启动。很多 SoC 的 Boot ROM 要求镜像带特定头部、校验、签名、对齐或打包格式。移植时必须理解“构建产物”和“可烧录固件”之间的差别。

一个很实用的判断是：构建产物是“原材料”，可烧录固件是“按目标 SoC 菜谱做出来的成品”。QEMU 可以直接吃 `u-boot.bin`，真实硬件往往不行。

## 1. 常见镜像类型

| 文件或格式 | 常见用途 |
| --- | --- |
| `u-boot.bin` | 裸二进制 U-Boot proper |
| `u-boot.img` | 带 legacy image header 的 U-Boot 镜像 |
| `u-boot.itb` | FIT 格式，可打包多个组件 |
| `u-boot-spl.bin` | SPL 裸二进制 |
| `flash.bin` | 常见的 SoC/厂商打包结果，含多个固件阶段 |
| `idbloader.img` | 某些平台的早期 loader 打包结果 |

不同平台含义不同，不能只看文件名判断是否可烧录。

## 2. 先识别文件格式

在主机上可以先用：

```bash
# [Host]
file u-boot.bin
file u-boot.img
file u-boot.itb
```

对于 U-Boot image 或 FIT，可以用：

```bash
# [Host]
tools/mkimage -l u-boot.img
tools/mkimage -l u-boot.itb
```

如果 `mkimage -l` 不能识别，说明它可能不是 U-Boot image/FIT，或者文件格式不对。

## 3. `mkimage`

`mkimage` 是 U-Boot 提供的主机工具，可生成 legacy image、FIT image、boot script 等：

```bash
# [Host]
tools/mkimage -l image.itb
```

查看脚本镜像：

```bash
# [Host]
tools/mkimage -l boot.scr
```

生成 boot script 的例子：

```bash
# [Host]
tools/mkimage -A arm64 -O linux -T script -C none \
  -n "boot script" \
  -d boot.cmd boot.scr
```

FIT 镜像则由 `.its` 文件描述，再生成 `.itb`。FIT 常用于把 kernel、DTB、ramdisk 和签名放在一起。

## 4. 平台打包工具

很多 SoC 还需要平台专用工具或 U-Boot `binman` 生成最终镜像。例如某些平台会把 SPL、TF-A、OP-TEE、U-Boot proper、DTB 按固定顺序打成一个文件。

你需要确认：

- U-Boot 是否已经有该平台的 binman 描述。
- 厂商 SDK 是否要求额外头部。
- 是否需要签名工具。
- 打包输入文件来自哪里。
- 输出文件应该烧到哪个介质和偏移。

不要手动拼接二进制，除非文档明确要求并且你理解每个偏移。

## 5. 打包时要核对的内容

- 每个组件的加载地址和入口地址。
- 固件排列顺序。
- 偏移、对齐和 padding。
- 是否需要签名或加密。
- 是否包含 DTB、TF-A、OP-TEE、OpenSBI。
- 烧录工具期望的文件格式。

:::warning
固件打包错误可能导致设备无法启动。量产前必须用可恢复设备、串口日志和原厂恢复流程验证。
:::

## 6. 地址和偏移不要混淆

打包时经常同时出现两类数字：

- 加载地址：镜像被加载到内存哪里运行。
- 存储偏移：镜像写在 flash、eMMC、SD card 的哪个位置。

这两类数字完全不是一回事。`0x40200000` 这类地址通常是内存地址；`seek=64`、`offset 0x8000` 这类通常是存储偏移。混淆它们会带来很危险的错误。

## 7. 验证打包结果

打包完成后，先做只读验证：

```bash
# [Host]
ls -lh flash.bin u-boot.itb
tools/mkimage -l u-boot.itb
```

如果有厂商工具提供解析功能，也先用解析功能确认头部、组件和偏移。上板前保存生成命令、输入文件版本和输出文件 hash，便于以后复现。

## 本章小结

U-Boot 构建产物只是原材料，真正写入设备的往往是经过平台工具打包后的固件。你要以目标 SoC Boot ROM 和板级文档为准，而不是凭经验猜测。

## 思考与练习

1. 解释 `u-boot.bin` 和可烧录固件之间的区别。
2. 使用 `mkimage -l` 查看一个 FIT 或 boot script。
3. 说明加载地址和存储偏移为什么不能混淆。
