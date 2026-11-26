---
sidebar_position: 1
---

# Wireshark 简介

Wireshark 是一款开源的网络协议分析工具，可帮助用户捕获和分析网络数据包。无论你是网络管理员、安全专家还是开发人员，Wireshark 都提供了深入了解网络通信的能力，使你能够追踪和分析网络中发生的数据交换。

Wireshark 作为一款开源工具，为用户提供了深度分析网络数据包的能力，是网络专业人士和爱好者不可或缺的利器。通过学习和使用 Wireshark，你将更好地理解网络的运作，提高网络管理和安全分析的能力。

![Wireshark 主界面](https://static.getiot.tech/wireshark-main-ui.png#center)



## 项目起源

Wireshark 诞生于20世纪90年代，其作者是 Gerald Combs。和那个时代的很多工程师一样，Gerald 技术精湛，热情上进，动手能力极强。当时他就职于一家网络提供商，时常需要分析软件来辅助工作。可是这样的软件太少了，而且一个 License 就要 80,000 美金，即便在今天，这也不是一笔小数目。于是，Gerald 决定自己写一个。

![Wireshark 作者 Gerald Combs](https://static.getiot.tech/Wireshark-founder-Gerald-Combs.jpeg#center)

Gerald 单枪匹马忙碌了几个月，在1998年7月，这个软件终于面世了。Gerald 把它命名为 Ethereal，正对应了它的功能 —— 还原以太网的真相。当你透过 Ethereal 看到网络时，不再是没有意义的 0 和 1，而是可以理解的简洁文字。有了它的专业解说，我们几乎能直接看懂网络上发生的一切。以前难以排查的问题，在它介入后便显露无遗。它还提供了权威的分析报告，比如重传率统计、响应时间和对话列表等，这解放了原本负担繁重的网络管理员，使他们有更多时间专注其他事务。

由于 Ethereal 写得太好了，而且是以 GNU GPL 开源许可证发布的，世界各地的开发者纷纷参与到这个项目中。没过多久，它就涵盖了世界上大多数通信协议，成为广受欢迎的网络分析软件。它可以用于教学，如果网络教师用它辅助上课，可以大大提高学生的兴趣。也可以辅助开发和测试，是调试网络程序的好工具。当然它最大的用途还是诊断问题；从数据链路层到应用层的种种协议，几乎涉及网络的地方就有它的用武之地。更难得的是，Gerald 并没有打算从中获利，它至今还是完全免费的，每位愿意学习的工程师都可以受益。

:::tip 笔记

谦虚的 Gerald 一直对创造 Wireshark 的过程轻描淡写，“I spent several months doing research and making notes.”

我们今天仍能想象其中的艰辛，即便是从业多年的工程师，对很多网络协议还一知半解，更不要说开发一个能分析协议的软件了。可见 Gerald 是一位既精通多种协议，又能写好代码的杰出工程师，同时还拥有常人难以企及的格局和境界。

:::

Ethereal 的代码版权自然是属于 Gerald 的，但 Ethereal 的商标则由他当时所在的公司 NIS（Network Integration Services）所拥有。2006年，Gerald 离开 NIS，加入了 CACE。由于和老东家在 Ethereal 的商标问题上无法达成一致，Gerald 把项目改名为 Wireshark。

而 Gerald 也一直在兢兢业业地维护 Wireshark。每个月都有新的协议出现，已有的协议也在推出新版本，他永远有忙不完的活。



## 主要功能

1. **网络数据包捕获：** Wireshark 允许用户在网络上捕获实时的数据包流量。这对于监视网络通信、分析协议和检测异常活动至关重要。
2. **多协议支持：** Wireshark支持众多网络协议，包括但不限于 TCP、UDP、IP、HTTP、HTTPS、FTP、DNS 等。用户可以通过过滤器选择感兴趣的协议进行分析。
3. **深入协议分析：** Wireshark 不仅能够捕获数据包，还能深入分析各种协议。用户可以查看每个数据包的协议头、数据负载和其他关键信息。
4. **网络故障排查：** 对于网络管理员而言，Wireshark 是一种强大的工具，可用于识别和排查网络故障。通过分析数据包，管理员能够快速找到问题的根本原因。
5. **安全分析：** 安全专家可以使用 Wireshark 检测潜在的网络威胁和攻击。通过观察流量模式和检查异常行为，可以提前发现可能的安全问题。
6. **用户友好的界面：** Wireshark 的用户界面直观友好，使得即使对网络分析不熟悉的用户也能够轻松上手。
7. **平台跨足：** Wireshark 可在多个操作系统上运行，包括 Windows、macOS 和 Linux，使其成为一个灵活且广泛适用的工具。



## 使用场景

- **网络故障排查：** 通过分析数据包，识别网络中的错误或异常，以便及时解决问题。
- **网络性能优化：** 监控网络流量，找出瓶颈和优化点，提高网络性能。
- **安全分析：** 检测潜在的网络攻击，提前发现异常行为，加强网络安全。
- **协议学习与研究：** 研究网络通信协议的结构和行为，深入了解各种协议的工作原理。
- **开发与测试：** 在软件开发和测试过程中，Wireshark 可用于捕获和分析应用程序的网络通信。



## 相关链接

- Wireshark 官网：[https://www.wireshark.org](https://www.wireshark.org)
- GitLab 仓库：[https://gitlab.com/wireshark/wireshark](https://gitlab.com/wireshark/wireshark)
- GitHub 仓库（镜像）：[https://github.com/wireshark/wireshark](https://github.com/wireshark/wireshark)

