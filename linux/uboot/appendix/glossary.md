---
sidebar_position: 5
sidebar_label: 术语表
slug: /glossary
---

# U-Boot 术语表

| 术语 | 解释 |
| --- | --- |
| Boot ROM | SoC 内部固化的第一段启动代码 |
| Bootloader | 启动加载器，负责加载后续固件或操作系统 |
| U-Boot proper | 完整功能的 U-Boot 主体 |
| SPL | Secondary Program Loader，常用于早期 DRAM 初始化和加载 U-Boot proper |
| TPL | Tertiary Program Loader，比 SPL 更早或更小的阶段 |
| VPL | Verification Program Loader，与验证启动场景相关 |
| DTB | Device Tree Blob，设备树二进制 |
| FDT | Flattened Device Tree，扁平设备树格式 |
| control FDT | U-Boot 自己使用的设备树 |
| bootargs | U-Boot 传给 Linux kernel 的命令行参数 |
| bootcmd | U-Boot 自动启动时执行的环境变量 |
| FIT | Flattened Image Tree，U-Boot 现代镜像封装格式 |
| legacy image | 传统 U-Boot image 格式，常见文件名 `uImage` |
| Driver Model | U-Boot 的现代驱动模型 |
| bootdev | Standard Boot 中的启动设备 |
| bootmeth | Standard Boot 中的启动方法 |
| bootflow | Standard Boot 扫描到的一条可启动配置 |
| TF-A | Trusted Firmware-A，常见 ARMv8 EL3 固件 |
| OP-TEE | 开源 Trusted Execution Environment |
| OpenSBI | RISC-V supervisor binary interface 固件 |
| rootfs | Linux 根文件系统 |
| initramfs | Linux 早期临时根文件系统 |
| TFTP | Trivial File Transfer Protocol，常用于开发阶段网络加载 |
| NFS root | Linux 通过网络挂载根文件系统的启动方式 |
| Boot ROM recovery | SoC 提供的恢复启动模式，名称和能力随平台不同 |
| environment | U-Boot 环境变量集合，可来自默认配置或持久化存储 |
| `saveenv` | 将当前 environment 写入持久化存储的命令 |
| `bootdelay` | 自动启动前等待用户中断的时间 |
| `bootcount` | 启动次数计数，常用于失败回滚 |
| A/B slot | 两套可切换系统分区中的一个启动槽位 |
| Recovery | 用于恢复主系统的最小系统或启动路径 |
| Root of Trust | 信任根，安全启动链中最早被信任的硬件或固件基础 |
| FIT signature | FIT 镜像签名机制，用于验证镜像来源和完整性 |
| `mkimage` | U-Boot 主机工具，用于生成或查看 U-Boot 镜像 |
| `dumpimage` | U-Boot 主机工具，用于查看或提取镜像内容 |
