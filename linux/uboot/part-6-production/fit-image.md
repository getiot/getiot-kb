---
sidebar_position: 1
sidebar_label: FIT 镜像与启动配置
slug: /fit-image
---

# U-Boot FIT 镜像与启动配置

FIT 是 Flattened Image Tree 的缩写，是 U-Boot 推荐的现代镜像封装方式之一。它可以把 kernel、多个 DTB、ramdisk、hash、签名和启动配置放在一个 `.itb` 文件中。

你已经学过手动加载 `Image`、DTB 和 initramfs。FIT 并没有改变 Linux 启动的本质，它只是把这些启动组件和选择规则打包成一个结构化文件，让启动流程更适合产品维护。

## 1. FIT 解决什么问题

传统启动方式常常需要分别加载 kernel、DTB、initramfs，然后手动指定启动参数。FIT 可以把这些组件组织到一个结构化镜像中，并支持：

- 多个配置，例如不同板型选择不同 DTB。
- hash 校验。
- 数字签名。
- 统一加载和启动。

典型场景包括：

- 同一个产品有多个硬件版本，每个版本使用不同 DTB。
- 升级包希望把 kernel、DTB、ramdisk 作为一个整体校验。
- 安全启动需要验证启动配置。
- 你希望减少启动分区中散落的文件数量。

## 2. ITS 文件

FIT 通常由 `.its` 描述文件生成。一个极简结构包括：

```dts
/dts-v1/;

/ {
    description = "GetIoT U-Boot FIT example";
    #address-cells = <1>;

    images {
        kernel {
            description = "Linux kernel";
            data = /incbin/("Image");
            type = "kernel";
            arch = "arm64";
            os = "linux";
            compression = "none";
            load = <0x40200000>;
            entry = <0x40200000>;
            hash {
                algo = "sha256";
            };
        };

        fdt {
            description = "QEMU ARM64 DTB";
            data = /incbin/("qemu-arm64.dtb");
            type = "flat_dt";
            arch = "arm64";
            compression = "none";
            hash {
                algo = "sha256";
            };
        };
    };

    configurations {
        default = "conf";
        conf {
            kernel = "kernel";
            fdt = "fdt";
        };
    };
};
```

这份 ITS 可以分成两层：

- `images`：定义有哪些组件，例如 kernel、fdt、ramdisk。
- `configurations`：定义如何组合这些组件启动。

`load` 和 `entry` 是内存地址。对 ARM64 `Image` 来说，二者常常相同，但这不是所有镜像格式的通用规则。真实产品应根据平台文档和 kernel 要求设置。

生成 FIT：

```bash
# [Host]
mkimage -f fit-qemu-arm64.its fit-qemu-arm64.itb
```

生成后先查看：

```bash
# [Host]
mkimage -l fit-qemu-arm64.itb
```

你应该能看到 FIT 中包含的 images、hash 和 configurations。

## 3. 加入 ramdisk 的配置

如果需要 initramfs，可以增加一个 ramdisk image，并在配置中引用它：

```dts
ramdisk {
    description = "initramfs";
    data = /incbin/("initramfs.cpio.gz");
    type = "ramdisk";
    arch = "arm64";
    os = "linux";
    compression = "gzip";
    hash {
        algo = "sha256";
    };
};
```

配置中加入：

```dts
conf {
    kernel = "kernel";
    fdt = "fdt";
    ramdisk = "ramdisk";
};
```

这样 U-Boot 启动 FIT 时会按配置处理 ramdisk，而不需要你在命令行里单独传 `${ramdisk_addr_r}:${ramdisk_size}`。

## 4. 启动 FIT

```bash
# [U-Boot]
load virtio 0:1 ${kernel_addr_r} /boot/fit-qemu-arm64.itb
bootm ${kernel_addr_r}
```

FIT 启动通常使用 `bootm`，不要因为 ARM64 kernel 本身是 `Image` 就改用 `booti`。

如果 FIT 中有多个配置，可以指定配置名：

```bash
# [U-Boot]
bootm ${kernel_addr_r}#conf
```

配置名称来自 ITS 中 `configurations` 下的节点名。真实项目中常会使用 `conf-board-a`、`conf-board-b` 之类的名字。

## 5. hash 与签名

FIT 中的 `hash` 可以发现镜像内容是否意外损坏，但它本身不能证明镜像来自可信来源。攻击者如果能同时替换 FIT 内容和 hash，单纯 hash 就不够。

FIT signature 会对配置或镜像进行数字签名，需要配合公钥和私钥。签名属于 Verified Boot 话题，下一章会继续讲。

## 6. 何时使用 FIT

FIT 适合：

- 一份镜像支持多个 DTB。
- 需要 hash 或签名。
- 产品希望减少启动文件数量。
- 升级系统需要明确校验启动组件。

如果只是学习手动启动，普通 `Image + DTB` 更容易理解。等启动链稳定后，再引入 FIT。

## 7. 常见问题

### `mkimage -l` 看不懂

先找 `Images` 和 `Configurations`。你只要能回答“这个 FIT 里有哪些组件，默认配置使用了哪些组件”，就已经抓住重点。

### `bootm` 找不到配置

检查配置名是否写对，`bootm ${addr}#conf` 中的 `conf` 必须和 ITS 节点一致。

### FIT 加载成功但 Linux 不启动

仍然按普通启动排查：kernel 格式、DTB、bootargs、rootfs。FIT 只是封装方式，不会替你修复错误 DTB 或 root 参数。

## 本章小结

FIT 把启动组件和配置打包成结构化镜像，是 U-Boot 产品化的重要工具。先理解普通启动，再学习 FIT，会顺畅很多。

## 思考与练习

1. 解释 ITS 中 `images` 和 `configurations` 的区别。
2. 使用 `mkimage -l` 查看一个 FIT 文件包含哪些组件。
3. 说明 FIT hash 和 FIT signature 分别解决什么问题。
