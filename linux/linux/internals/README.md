---
sidebar_position: 0
sidebar_label: Linux 系统内部机制
slug: /linux-internals
---

# Linux 系统内部机制

这一章帮助你从“会用 Linux”走向“理解 Linux”。你会看到 `/proc`、`/sys`、`/dev` 这些特殊文件系统如何暴露内核和设备信息，也会了解 udev、PAM、audit 等系统机制。

这些内容不需要一开始全部精通，但它们会在嵌入式 Linux、系统排错、权限认证和安全审计中反复出现。

建议按顺序阅读：

- [Proc 文件系统](linux-proc-filesystem.md)
- [Sys 文件系统](linux-sys-filesystem.md)
- [Dev 文件系统](linux-dev-filesystem.md)
- [Linux udev 简介](linux-udev.md)
- [Linux PAM 认证机制](linux-pam.md)
- [Linux audit 审计系统](linux-audit.md)
