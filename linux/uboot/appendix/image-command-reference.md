---
sidebar_position: 3
sidebar_label: 镜像格式与启动命令对照
slug: /image-command-reference
---

# U-Boot 镜像格式与启动命令对照

启动命令必须与镜像格式匹配。初学阶段很多错误都来自把 `Image`、`zImage`、`uImage`、FIT image 混用。

| 镜像 | 常见文件名 | 常见平台 | 启动命令 |
| --- | --- | --- | --- |
| ARM64 raw kernel | `Image` | ARM64 | `booti` |
| ARM compressed kernel | `zImage` | 32-bit ARM | `bootz` |
| legacy U-Boot image | `uImage` | 多平台旧系统 | `bootm` |
| FIT image | `.itb` | 产品化系统 | `bootm` |
| EFI application | `*.efi` | UEFI 启动 | `bootefi` |
| boot script | `boot.scr` | U-Boot script | `source` |

ARM64 不使用 initramfs：

```bash
# [U-Boot]
booti ${kernel_addr_r} - ${fdt_addr_r}
```

ARM64 使用 initramfs：

```bash
# [U-Boot]
booti ${kernel_addr_r} ${ramdisk_addr_r}:${ramdisk_size} ${fdt_addr_r}
```

FIT：

```bash
# [U-Boot]
bootm ${fit_addr}
```

legacy `uImage`：

```bash
# [U-Boot]
bootm ${kernel_addr_r}
```

boot script：

```bash
# [U-Boot]
load mmc 0:1 ${scriptaddr} /boot/boot.scr
source ${scriptaddr}
```

指定 FIT 配置：

```bash
# [U-Boot]
bootm ${fit_addr}#conf-name
```

:::warning
不要只根据文件名判断格式。必要时使用 `file`、`mkimage -l`、`dumpimage -l` 或 U-Boot 启动命令的错误信息确认。
:::

## 主机侧查看命令

```bash
# [Host]
file Image uImage fit.itb boot.scr
mkimage -l fit.itb
mkimage -l boot.scr
dumpimage -l fit.itb
```
