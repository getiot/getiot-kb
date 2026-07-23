---
sidebar_position: 5
sidebar_label: C 扩展与 FFI
slug: /ruby-c-extension-ffi
---

# Ruby C 扩展与 FFI 简介

Ruby 可以调用 C 代码，也可以通过 C 扩展接入系统库或提升性能。这属于进阶主题，初学者先了解边界即可。

## 为什么需要 C 扩展

常见原因包括：

- 调用已有 C library。
- 接入系统底层 API。
- 提升性能敏感部分。
- 复用硬件、图像、加密等领域的原生库。

## C extension

C extension 是用 C 编写并编译的 Ruby 扩展。很多 gem 内部都有 C extension。

它的优点是性能和底层能力强，缺点是安装时可能需要编译环境，也可能遇到平台兼容问题。

## FFI

FFI 是 Foreign Function Interface 的缩写。使用 FFI gem 可以在 Ruby 中声明并调用 C 函数，而不一定手写完整 Ruby C extension。

概念上，你会声明函数所在 library、参数类型和返回类型，然后从 Ruby 中调用。

## 风险

:::warning
C 扩展和 FFI 会把你带到 Ruby 安全边界之外。指针、内存释放、ABI、线程和平台兼容性都需要认真处理。
:::

## 什么时候不该用

如果只是普通业务代码慢，先检查算法、数据库和 I/O。不要一遇到性能问题就写 C 扩展。

如果已有成熟 gem 能解决问题，优先使用成熟方案。

## 小结

C 扩展和 FFI 是 Ruby 接入底层生态的重要能力，但不是入门阶段的主战场。先写清楚 Ruby 代码，再在确有需要时进入这部分。

