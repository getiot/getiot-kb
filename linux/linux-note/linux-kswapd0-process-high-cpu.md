---
sidebar_position: 3
---

# Linux kswapd0 进程 CPU 占用率高



kswapd0 是虚拟内存管理中，负责换页的，操作系统每过一定时间就会唤醒 kswapd ，看看内存是否紧张，如果不紧张，则睡眠，在 kswapd 中，有2个阀值，pages_hige 和 pages_low，当空闲内存页的数量低于 pages_low 的时候，kswapd进程就会扫描内存并且每次释放出 32 个 free pages，直到 free page 的数量到达 pages_high。通过阻止 kswapd0 进程过渡活跃地消耗 CPU 的方法是设置大页内存。





