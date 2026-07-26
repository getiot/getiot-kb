---
sidebar_position: 2
sidebar_label: Verified Boot 与安全启动
slug: /verified-boot
---

# U-Boot Verified Boot 与安全启动

Verified Boot 的目标是确认被启动的软件没有被篡改。它通常通过 hash、数字签名和信任链实现。你可以把它理解为：启动链上的每一阶段，都要验证下一阶段的完整性和来源。

安全启动很容易被写成“打开签名选项”的功能说明，但真实产品中它首先是威胁模型问题。你要先定义自己防什么，再决定使用哪些机制。

## 1. Verified Boot 与 Secure Boot

这两个词经常混用，但侧重点不同：

- Verified Boot 强调验证启动组件完整性和签名。
- Secure Boot 通常强调从硬件 Root of Trust 开始建立信任链，并限制只能运行可信代码。

在真实产品中，它们往往一起设计。

## 2. 先建立威胁模型

你至少要回答：

- 攻击者能否物理接触设备？
- 攻击者能否改写启动介质？
- 调试口是否开放？
- environment 是否可修改？
- recovery 是否允许加载未签名镜像？
- 升级包来自哪里，如何验证？

如果攻击者可以随意替换 U-Boot 本身，那么 U-Boot 验证 kernel 并不能形成完整安全链。此时必须依赖 Boot ROM、硬件 Root of Trust、熔丝或安全存储来保护第一阶段。

## 3. U-Boot 中的常见做法

U-Boot 支持 FIT hash 和 FIT signature。典型思路是：

1. 用 `.its` 描述 kernel、DTB、ramdisk。
2. 为每个组件计算 hash。
3. 使用私钥签名配置。
4. 把公钥信息编入 U-Boot control FDT。
5. U-Boot 启动 FIT 时验证签名。

这样可以防止攻击者替换 kernel 或 DTB 后被直接启动。

这里有两个层次：

- hash：确认内容没有变化。
- signature：确认内容由持有私钥的一方签发。

只有 hash 而没有签名，不能抵抗“内容和 hash 一起被替换”的攻击。

## 4. 信任链不能只靠 U-Boot

如果攻击者可以替换 U-Boot 本身，那么 U-Boot 再验证 kernel 意义有限。因此产品级安全启动通常还需要：

- SoC Boot ROM 验证第一阶段镜像。
- 一次性熔丝或安全存储保存公钥 hash。
- 禁用未授权调试接口。
- 保护 environment，避免改启动参数绕过校验。
- 设计密钥管理和撤销策略。

:::warning
安全启动是系统工程，不是简单打开一个 U-Boot 配置选项。密钥、生产烧录、调试口、恢复模式和升级流程都必须一起设计。
:::

## 5. 密钥管理

安全启动中最敏感的是私钥。基本原则：

- 私钥不要放进设备。
- 私钥不要提交到 Git 仓库。
- 构建机、CI、签名服务要有访问控制。
- 量产密钥和开发密钥分开。
- 设计密钥轮换和撤销策略。

开发阶段可以用测试密钥学习流程，但文档和脚本要明确标记，避免测试密钥进入量产。

## 6. environment 与启动参数保护

即使 kernel 已签名，如果 environment 可被任意修改，也可能绕过安全策略。例如攻击者修改 `bootargs`，进入单用户模式，或指定不安全的 rootfs。

产品中要考虑：

- 禁止或限制 `env save`。
- 保护启动命令。
- 禁用未授权 console。
- recovery 只接受签名镜像。
- 对关键状态变量做校验。

## 7. 入门阶段怎么学

建议先在 QEMU 或可恢复开发板上学习 FIT hash，再学习 FIT signature。确认你能解释：

- 签名保护的是哪个配置。
- 公钥在哪里。
- 私钥是否只留在构建环境。
- 验证失败时系统如何处理。

学习顺序建议：

1. 普通 FIT 启动。
2. FIT hash 验证。
3. FIT signature。
4. 公钥编入 U-Boot control FDT。
5. 验证失败路径。
6. 再讨论硬件 Root of Trust。

## 8. 常见误区

#### 只签 kernel，不签 DTB

DTB 会影响内存、设备、reserved-memory、bootargs 等关键行为。只签 kernel，放任 DTB 被替换，安全边界会很弱。

#### recovery 可以启动任意镜像

如果 recovery 能启动未签名镜像，那么攻击者可能直接走 recovery 绕过安全启动。

#### 调试口永远开放

生产设备如果保留未授权调试口，安全启动链可能被物理调试绕过。是否关闭、锁定或鉴权调试口，需要产品级决策。

## 本章小结

Verified Boot 解决“启动的是否是可信软件”。U-Boot 提供了重要能力，但完整信任链必须从硬件、固件、密钥和升级策略一起考虑。

## 思考与练习

1. 画出你的产品启动信任链，从 Boot ROM 到 Linux。
2. 解释 hash 和 signature 的区别。
3. 列出 environment 可能绕过安全启动的两种方式。
