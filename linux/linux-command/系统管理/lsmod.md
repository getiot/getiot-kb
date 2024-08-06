---
sidebar_position: 25
slug: /lsmod
---

# lsmod 命令



## 介绍

**lsmod**（英文全拼：list modules）命令用于显示已经加载到内核中的模块的状态信息。

由于 Linux 操作系统内核支持模块化的特性，因此在编译内核时，无须把全部的功能都编译进内核，可以将这些功能编译成一个个单独的模块，待需要时再分别载入。

实际上，lsmod 的工作原理是从 /proc/modules 文件读取当前已加载的内核模块的信息，再以更方便用户阅读的格式显示。因此，lsmod 命令的用法很简单，不需要任何选项参数。



## 示例

查看当前系统已加载的内核模块

```bash
$ lsmod
Module                  Size  Used by
rfcomm                 81920  4
cmac                   16384  3
algif_hash             16384  1
algif_skcipher         16384  1
af_alg                 28672  6 algif_hash,algif_skcipher
bnep                   24576  2
binfmt_misc            24576  1
amdgpu               5214208  0
iommu_v2               20480  1 amdgpu
gpu_sched              36864  1 amdgpu
snd_hda_codec_hdmi     61440  1
intel_rapl_msr         20480  0
intel_rapl_common      28672  1 intel_rapl_msr
......
```

如果内核模块很多，不利于阅读，可以配合 [grep](/linux-command/grep) 等命令进行过滤。

比如查看是否已加载 coretemp 模块

```bash
$ lsmod | grep coretemp
coretemp               20480  0
```

