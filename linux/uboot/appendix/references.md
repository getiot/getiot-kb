---
sidebar_position: 6
sidebar_label: 参考资料
slug: /references
---

# U-Boot 参考资料

本教程优先参考 Mainline [U-Boot v2026.07](https://github.com/getiot/uboot-courses/tree/main/u-boot-v2026.07) 源码和随源码发布的官方文档。建议你阅读源码中的这些资料：

- `u-boot-v2026.07/README`
- `u-boot-v2026.07/doc/board/emulation/qemu-arm.rst`
- `u-boot-v2026.07/doc/develop/bootstd/`
- `u-boot-v2026.07/doc/develop/driver-model/`
- `u-boot-v2026.07/doc/develop/devicetree/`
- `u-boot-v2026.07/doc/develop/environment.rst`
- `u-boot-v2026.07/doc/develop/spl.rst`
- `u-boot-v2026.07/doc/usage/fit/`
- `u-boot-v2026.07/doc/usage/cmd/`
- `u-boot-v2026.07/doc/mkimage.1`
- `u-boot-v2026.07/doc/dumpimage.1`

外部资料建议以官方来源为准：

- U-Boot 官方文档：https://docs.u-boot.org/
- U-Boot 官方源码：https://source.denx.de/u-boot/u-boot
- QEMU 官方文档：https://www.qemu.org/docs/master/
- Linux kernel 文档：https://docs.kernel.org/
- Devicetree Specification：https://www.devicetree.org/specifications/
- Trusted Firmware-A：https://trustedfirmware-a.readthedocs.io/
- OP-TEE：https://optee.readthedocs.io/
- OpenSBI：https://github.com/riscv-software-src/opensbi

如果你使用特定 SoC 或开发板，还应优先阅读芯片厂商 reference manual、开发板原理图、BSP 文档和启动 ROM 文档。

## 配套实验仓库

- GetIoT U-Boot Courses：https://github.com/getiot/uboot-courses

该仓库用于保存教程配套脚本、QEMU 配置样例和实验说明。大体积 kernel/rootfs 镜像通常不建议直接放入仓库。
