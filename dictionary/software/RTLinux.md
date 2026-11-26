---
sidebar_label: RTLinux
sidebar_position: 13
slug: /rtlinux
---

# RTLinux

**RTLinux** （或称作“实时 Linux”）是 Linux 中的一种实时操作系统。它最早由美国新墨西哥州立大学数据挖掘技术学院的 V. Yodaiken 开发。目前，RTLinux 有一个由社区支持的免费版本，称为 [RTLinux Free](http://www.rtlinuxfree.com/)，以及一个来自 FSMLabs 的商业版本，称作 [RTLinux Pro](http://www.fsmlabs.com/)。

**RTLinux** 通过硬件和操作系统间的中断控制来支持硬实时（确定性）操作。进行确定性处理所需要的中断由实时核心加工，其他中断被送往非实时操作系统。操作系统运行为低优先级线程。先进先出管道（FIFOs）或共享内存可以被用来在操作系统和实时核心之间共享数据。
