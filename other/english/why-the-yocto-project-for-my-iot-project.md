---
sidebar_position: 9
---

# 为什么将 Yocto 用于我的物联网项目？

> 本文来自 ELCE 演讲，2017年7月3日，Drew Moseley，[YouTube 视频](https://www.youtube.com/watch?v=TRLF4jQcZQ8)



## 引言

Software developers in the embedded and Internet of Things (IoT) spaces face a dizzying array of options which it comes to choosing Operating Systems (OS) to support their designs. Decisions made regarding the hardware and tools will obviously have a major impact on the success of your project. Assuming you have the flexibility to choose the components that are best for your design, and that there are no limitations due to historical decisions or backward compatibility, then it pays to invest in upfront research to understand the options and make the best choice for your project and design team.

嵌入式和物联网（IoT）领域中的软件开发人员在为其设计选择操作系统时，往往面临众多令人眼花缭乱的选择。有关硬件和工具的决策显然将对项目的成功产生重大影响。假设您可以灵活地选择最适合您的设计的组件，并且不受历史决定或向后兼容性的限制，那么您有必要在前期投入研究以了解不同的方案，并为您的项目和设计团队作出最佳选择。

When the focus of your system is primarily electro-mechanical with simple control logic, a Linux design may be overkill and using an RTOS or control loop may be more appropriate. When the focus of the system is more on data processing and networking, it may make sense to consider Linux for your design. If your system has elements of both, you can certainly implement the electro-mechanical aspects in Linux as the Linux kernel arguably has device support for a wider range of peripherals than most other systems. A more complex system may require a dual-OS setup using either asynchronous multiprocessing on a multi-core chipset or multiple chips. Pairing a small 8- or 16- bit microcontroller running an RTOS or custom-designed control loop software with a 32- or 64- bit microcontroller running Linux is a common design solution providing the best of both approaches.

当您的系统重点主要是具有简单控制逻辑的机电时，Linux 设计可能会显得过于庞大，此时选择 RTOS 或前后台循环控制可能更合适。当系统的重点更多地放在数据处理和网络上时，在您的设计中考虑使用 Linux 可能是有意义的。如果您的系统对这两方面有需求，那么您可以肯定会在 Linux 中实现机电方面的功能，因为与大多数其他系统相比，Linux 内核可以为更广泛的外围设备提供设备支持。更复杂的系统可能需要使用多核芯片组，或多个芯片上的异步多处理功能来建立双 OS。为了取得最佳效果，将运行 RTOS 或定制设计的控制回路软件的小型 8 位或 16 位微控制器与运行 Linux 的 32 位或 64 位微控制器一起配合使用是一种常见的解决方案。

One compelling reason to use Linux in your design is its ubiquity. Books, videos, and other training materials are easily available, and finding a blog or a conference presentation that describes a use case similar to your design is just a web-search away. Resources such as [stackoverflow.com](https://stackoverflow.com/) and [quora.com](https://www.quora.com/) are full of interesting, timely information that can help during your education and design cycles. Additionally, online courses from vendors such as edx.org, coursera.org, and udacity.com are available (many for free) covering a wide variety of Linux-related topics.

在您的设计中使用 Linux 的一个令人信服的原因是它的普遍性。书籍、视频和其他培训材料很容易获得，而找到描述与您的设计相似的用例的博客或会议演示文稿仅需进行网络搜索。诸如 stackoverflow.com 和 quora.com 之类的资源中充满了有趣、及时的信息，可以在您的教育和设计周期中提供帮助。此外，还有像 edx.org、coursera.org 和 udacity.com 等供应商提供的在线课程（许多免费），涵盖了与 Linux 相关的各种主题。

The amount of available software to run on Linux systems is staggering. For any portion of your design that relies on externally defined protocols, APIs, etc., you can likely find an implementation that runs on Linux. For many such software components, you will find a vibrant developer community providing bugfixes, support, and feature development. Integrating these bits into your Linux design is routinely straightforward, but will vary depending on your choice of distribution or build system. Fortunately, the common distribution and build systems also have active communities who can provide assistance with items that are not integrated by default.

在 Linux 系统上运行的可用软件数量惊人。对于依赖于外部定义的协议，API 等的设计的任何部分，您都可能会找到在 Linux 上运行的实现。对于许多此类软件组件，您将找到一个充满活力的开发人员社区，其中提供了错误修复、支持和功能开发。通常，将它们集成到 Linux 设计中是很简单的，但是会根据您选择的发行版或构建系统而有所不同。幸运的是，通用的分发和构建系统还具有活跃的社区，可以为默认情况下未集成的项目提供帮助。

There is also no shortage of talented developers with Linux expertise. Due to the wide industry adoption of Linux-based designs, finding engineers with relevant experience is relatively painless. From the hiring team's perspective, finding engineers who are already trained in the technologies you need is a distinct advantage. From the engineer's perspective, working on technologies you find interesting and being able to apply your expertise to multiple potential employers is a great benefit. In short, matching hiring needs to talent is greatly simplified with Linux and related technologies.

也不乏具有 Linux 专业知识的有才华的开发人员。由于行业广泛采用基于 Linux 的设计，因此寻找具有相关经验的工程师相对容易。从招聘团队的角度来看，找到已经接受过所需技术培训的工程师是一个明显的优势。从工程师的角度来看，开发您认为有趣的技术并能够将您的专业知识应用于多个潜在雇主是一个很大的好处。简而言之，Linux 和相关技术极大地简化了与人才匹配的招聘需求。

There are a wide variety of distribution and build systems you can use to develop your embedded Linux system. Many desktop distributions can be pared down for use in limited resource environment and systems such as [Ubuntu](https://www.ubuntu.com/core) have varieties specifically targeted at IoT devices. The Raspberry Pi platform uses a customized Debian image as its primary target OS image. Additionally, there are several options for cross-compiling a full Linux system; Yocto, OpenWRT, and Buildroot are the three most common. These systems are generally hosted on a standard desktop Linux distribution and will cross-build a Linux system for your chosen target device. Changes that are needed will first be built into a target image on the Linux desktop and deployed to the target installation media from there.

您可以使用各种各样的发行和构建系统来开发嵌入式 Linux 系统。可以缩减许多桌面发行版，以在有限的资源环境中使用，并且像 Ubuntu 这样的系统具有专门针对 IoT 设备的版本。Raspberry Pi 平台使用定制的 Debian 映像作为其主要目标 OS 映像。此外，还有多种选择可以交叉编译完整的 Linux 系统。Yocto、OpenWRT 和 Buildroot 是最常见的三个。这些系统通常托管在标准桌面 Linux 发行版上，并将为您选择的目标设备交叉构建 Linux 系统。所需的更改将首先内置到 Linux 桌面上的目标映像中，然后从那里部署到目标安装介质。

In our discussions below, we will describe the [Yocto Project](https://yoctoproject.org/) in more detail and explain why we believe it is a good choice for embedded Linux designs intended for the IoT.

在下面的讨论中，我们将更详细地描述 Yocto 项目，并解释为什么我们认为它是用于 IoT 的嵌入式 Linux 设计的好选择。

## 嵌入式注意事项

**Embedded Considerations**

Development for embedded Linux blurs the line between embedded and desktop development and can provide the best of both models. Many embedded Linux systems host functionality such as an SSH server, a GUI, and on-target tools, thereby allowing for a development workflow similar to traditional desktop development. Code written in scripting languages can be directly modified in the deployed system and changes tested without a costly build/deploy cycle. For compiled code, the compute capability of many such systems is limited and on-target builds can be painfully slow. Using a cross-compilation environment for such tasks is appreciably faster and feels more like traditional embedded development providing the developer with all the tools and functionality available on the development host OS. The utility of having a full-blown Linux system on the target, with all the ready-made software as well as the large number of software developers familiar with the platform, outweigh cost concerns that might otherwise force the selection of a lower-priced hardware platform.

嵌入式 Linux 的开发模糊了嵌入式和桌面开发之间的界线，可以提供这两种模型中的最佳优势。许多嵌入式 Linux 系统承载 SSH 服务器，GUI 和目标工具等功能，从而允许类似于传统桌面开发的开发工作流程。可以在部署的系统中直接修改用脚本语言编写的代码，并测试更改，而无需花费昂贵的构建/部署周期。对于已编译的代码，许多此类系统的计算能力受到限制，并且按目标构建可能会非常缓慢。使用交叉编译环境执行此类任务的速度明显更快，并且感觉更像传统的嵌入式开发，为开发人员提供了开发主机 OS 上可用的所有工具和功能。

Setting up a cross-compilation environment is notoriously tricky. Getting the right combination of toolchain components and libraries can be an exercise in frustration. Matching the kernel headers with both your desktop distribution kernel and your embedded kernel can be a challenge. There are a variety of options for obtaining a pre-built cross-toolchain; if you are fortunate, there may be one available through the package manager on your desktop development system. If the packages from your distribution provider do not work for you, using a build system such as [crosstool-NG](https://crosstool-ng.github.io/) may be necessary.

众所周知，设置交叉编译环境很棘手。正确组合工具链组件和库可能会让人沮丧。将内核头文件与桌面分发内核和嵌入式内核相匹配可能也是一个挑战。获取预构建的交叉工具链有多种选择。如果幸运的话，您的桌面开发系统上的软件包管理器可能会提供了一个。如果发行商没有提供相应的软件包，则可能需要使用诸如 crosstool-NG 之类的构建系统。

Developer connectivity to embedded target boards is generally through serial ports and Ethernet. Fortunately, embedded Linux has broad support for these devices and generally poses no obstacles for your design team. Driver support in Windows and MacOS host systems can be problematic as these device drivers may not be included in the default OS and may require the installation of third-party drivers.

开发人员与嵌入式目标板的连接通常是通过串行端口和以太网。幸运的是，嵌入式 Linux 对这些设备有广泛的支持，通常不会对您的设计团队造成任何障碍。Windows 和 MacOS 主机系统中的驱动程序支持可能会出现问题，因为这些设备驱动程序可能未包含在默认操作系统中，并且可能需要安装第三方驱动程序。

JTAG support is somewhat scattered in embedded Linux and is mostly useful for low-level kernel debug. Additionally, it is highly dependent on vendor support from the semiconductor manufacturer as well as the JTAG equipment maker. Debugging application and user-space code is generally better accomplished with widely available and ported tools such as GDB.

对 JTAG 的支持在嵌入式 Linux 中有些分散，主要用于底层内核调试。此外，它高度依赖半导体制造商以及 JTAG 设备制造商的供应商支持。通常，使用广泛使用和移植的工具（例如 GDB）可以更好地完成应用程序和用户空间代码的调试。

Projects in the embedded and IoT spaces use a wide variety of chip architectures and boards. The Linux kernel has been ported to the vast majority of commercially available parts and will, in all likelihood, already support your chosen chipset. Most of the semiconductor vendors develop kernel code and drivers directly for support of their products, making it easy to adopt Linux for your design. Not all vendor contributions are available in the stock kernels from [kernel.org](http://kernel.org/) however, so you may need to do some research and integration work to gather all the software components necessary for your chosen platform.

嵌入式和物联网领域的项目使用各种各样的芯片架构和电路板。Linux 内核已移植到绝大多数市售部件上，并且很可能已经支持您选择的芯片组。大多数半导体供应商直接开发内核代码和驱动程序来支持其产品，从而使在设计中轻松采用 Linux 成为可能。但是，并不是所有供应商的贡献都可以从 kernel.org 的库存内核中获得，因此您可能需要进行一些研究和集成工作，以收集所选平台所需的所有软件组件。

## Yocto 项目描述

**Yocto Project Description**

The [Yocto Project defines itself](https://yoctoproject.org/about) as “an open source collaboration project that provides templates, tools, and methods to help you create custom Linux-based systems for embedded products regardless of the hardware architecture.” It's roughly analogous to the concept of [desktop Linux distributions](https://en.wikipedia.org/wiki/Linux_distribution); however, that is a bit of an over-simplification. Yocto is more properly referred to as a [meta-distribution](http://wiki.c2.com/?MetaDistribution). It is a collection of recipes, configuration values, and dependencies that are used to create a custom Linux runtime image tailored to your specific needs.

Yocto 项目将自己定义为“一个开源协作项目，提供模板、工具和方法来帮助您为嵌入式产品创建基于 Linux 的自定义系统，而不管硬件架构如何。” 它大致类似于桌面 Linux 发行版的概念，但这么说又过于简化了。Yocto 更恰当地称为元分布。它是配方，配置值和依赖项的集合，用于创建根据您的特定需求量身定制的定制 Linux 运行时映像。

The Yocto Project focuses on mechanisms and leaves you, the developer, free to impose policy based on your design. Where desktop distributions will select options such as packaging format and *init* systems, Yocto provides configuration points to allow you to select these based on your needs. By default, users can select *deb* , *rpm* , *ipk* , or *tar* package formats; or easily add a new one by adding a custom *bbclass* file. Similarly, selecting either the *sysvinit* or *system* init systems is a simple configuration change in your local build files.

Yocto 项目着重于机制，使开发人员可以自由地根据您的设计强加政策。在桌面发行版将选择诸如打包格式和初始化 系统之类的选项的地方，Yocto 提供了配置点，使您可以根据需要选择这些配置点。默认情况下，用户可以选择 deb、rpm、ipk 或 tar 软件包格式；或通过添加自定义 bbclass 文件轻松添加一个新文件。同样，选择 sysvinit 或 system init 系统是对本地构建文件的简单配置更改。

A Yocto build starts by building many of the native utilities needed by the build system itself. This is performed to minimize the dependencies on the host OS and to ensure a known set of package versions. Most configurations then proceed to build a tested and known good cross-compilation environment before moving on to building the binaries for the target platform. Due to the large number of packages built for a Yocto configuration, this can consume significant resources and time on the host system.

Yocto 构建开始于构建构建系统本身所需的许多本机实用程序。这样做是为了最大程度地减少对主机 OS 的依赖性，并确保有一组已知的软件包版本。然后，大多数配置将继续构建经过测试且已知的良好交叉编译环境，然后再继续构建目标平台的二进制文件。由于为Yocto配置构建了许多软件包，因此这会在主机系统上消耗大量资源和时间。

The package definitions include various phases (e.g., fetch, compile, install, package) and must specify any runtime or build-time dependencies. The build is controlled by an executive called *bitbake* , which is responsible for processing the dependencies and scheduling the tasks. The tasks are executed in parallel as much as will be allowed by the host system resources and the interdependencies between the tasks. Additionally, the intermediate outputs of each of the build stages are maintained using a shared state mechanism to allow for reuse across similar builds, and this can result in a significant speed improvement.

程序包定义包括各个阶段（例如，获取，编译，安装，打包），并且必须指定任何运行时或构建时依赖项。该构建由一个称为 bitbake 的执行程序控制，该执行程序负责处理依赖关系和安排任务。任务将在主机系统资源和任务之间的相互依赖关系允许的范围内并行执行。此外，使用共享状态机制维护每个构建阶段的中间输出，以允许在相似的构建中重复使用，这可以显着提高速度。

## Yocto 的优点

### 功能特性

**Yocto advantages: Features**

Yocto's focus on mechanism over policy allows wide latitude for system developers. This approach ensures that you are free to set the policy based on the needs of your design rather than having to adapt to decisions enforced by the system software provider. Yocto provides sensible defaults to allow developers to get started quickly but the mechanisms to change these policies are well documented and simple to adopt.

Yocto 注重于机制而非策略，这为系统开发人员提供了更大的自由度。这种方法可确保您可以根据设计需求自由设置策略，而不必适应系统软件提供商执行的决策。Yocto 提供了明智的默认设置，以允许开发人员快速入门，但是更改这些策略的机制已被详细记录且易于采用。

The [Yocto layer infrastructure](https://layers.openembedded.org/layerindex/branch/master/layers) is an integral part of the Yocto model. Layers group related functionality into separate bundles, which can be added to your build setup only as required. This greatly reduces the complexity of each individual layer and allows them to be developed at their own pace. Layers are included in your build with a priority ordering, allowing higher priority layers to override and modify settings from the base layers.

该 Yocto 层基础设施是 Yocto 模型的一个组成部分。层将与功能相关的功能分为不同的捆绑包，仅可根据需要将其添加到构建设置中。这大大降低了每个单独层的复杂性，并使它们可以按照自己的进度进行开发。图层按优先级顺序包含在构建中，从而允许较高优先级的图层覆盖和修改基础图层中的设置。

Platform layers generally support adding boards to Yocto; they will generally contain custom kernel and bootloader components as well as any board-specific runtime packages and configurations. The following list shows platform layers provided by many of the semiconductor industry heavyweights. These layers provide support for a wide range of commercially available chips and boards and should be used as a starting point for any design containing any of these parts.

平台层通常支持向 Yocto 添加板；它们通常将包含自定义内核和引导加载程序组件，以及任何特定于板的运行时软件包和配置。下表显示了许多半导体行业重量级人物提供的平台层。这些层为广泛的市场上可买到的芯片和电路板提供了支持，应该用作包含这些部件中任何一个的任何设计的起点。

- https://layers.openembedded.org/layerindex/branch/master/layer/meta-qcom/
- https://layers.openembedded.org/layerindex/branch/master/layer/meta-ti/
- https://layers.openembedded.org/layerindex/branch/master/layer/meta-freescale/
- https://layers.openembedded.org/layerindex/branch/master/layer/meta-amd/

Feature layers add functionality that is not generally valuable to all Yocto users, but that is deemed too complicated to include in the base layers. The following list shows some of the feature layers available today.

特征层添加的功能通常对所有 Yocto 用户而言并不有价值，但是被认为过于复杂而无法包含在基础层中。以下列表显示了当今可用的某些要素图层。

- https://layers.openembedded.org/layerindex/branch/master/layer/meta-mender-core/
- https://layers.openembedded.org/layerindex/branch/master/layer/meta-qt5/
- https://layers.openembedded.org/layerindex/branch/master/layer/meta-nodejs/
- https://layers.openembedded.org/layerindex/branch/master/layer/meta-snappy/

In a traditional desktop Linux distribution model, you generally install from a CD or USB key and then perform additional package installations and configurations in the running target system. The Yocto workflow is different; it consists of running a full build on your development machine, the output of which is an image containing the entire target system. With a bit of care, you can eliminate most, if not all, of the configuration steps needed in the running target allowing for a more predictable software load and reducing the number of dimensions in your test matrix. Yocto can even configure your runtime software to use a read-only root filesystem, thereby resulting in systems that always start from a known-good state; of course, this requires efforts on your part to ensure that state is saved properly to a persistent data store.

在传统的桌面 Linux 分发模型中，通常是从 CD 或 USB 密钥安装，然后在正在运行的目标系统中执行其他软件包安装和配置。Yocto 工作流程有所不同，它包括在开发机器上运行完整版本，其输出是包含整个目标系统的映像。稍加注意，您就可以消除运行目标中所需的大多数（如果不是全部）配置步骤，从而可以更可预测地加载软件并减少测试矩阵中的维数。Yocto 甚至可以将运行时软件配置为使用只读的根文件系统，从而使系统始终从已知良好的状态启动。当然，这需要您自己确保状态正确保存到持久数据存储中。

Additionally, the Yocto project follows a strict release schedule. This predictability is crucial for projects that are based on Yocto and allows the development teams to plan their activities. Developers can choose which Yocto branch on which to base their activities as a function of their needs. The development branch will ensure access to the latest features while the [stable branches](https://wiki.yoctoproject.org/wiki/Stable_branch_maintenance) will reduce the pace of changes while still allowing for updates to address CVE (common vulnerabilities and exposures) issues and other potential security concerns.

此外，Yocto 项目遵循严格的发布时间表。这种可预测性对于基于 Yocto 的项目至关重要，并允许开发团队计划其活动。开发人员可以根据自己的需要选择活动的基础Yocto分支。开发分支将确保访问最新功能，而稳定分支将减少更改的速度，同时仍允许进行更新以解决 CVE（常见漏洞和披露）问题和其他潜在的安全隐患。

### 行业和社区的支持

**Yocto Advantages: Industry and community support**

The Yocto Project website has the following to say about the ecosystem surrounding Yocto: **"Nothing is as important to an open source project as the [ecosystem](https://www.yoctoproject.org/ecosystem) of individuals and organizations around it."**

Yocto Project 网站对 Yocto 周围的生态系统有以下说法：**“对于开源项目，没有什么比它周围的个人和组织的生态系统重要。”**

This is easily one of the primary advantages of Yocto. The value of community cannot be stressed highly enough; support forums and expertise are readily available, as is an active development community pushing Yocto forward. As an open source project, you can modify it yourself to suit your needs or find someone to do it for you; and there is no concern of a software vendor changing strategies and leaving you to start over.

这很显然是 Yocto 的主要优势之一。社区的价值再怎么强调也不为过，支持论坛和专业知识随时可用，活跃的开发社区也在推动 Yocto 向前发展。作为一个开源项目，您可以根据自己的需要对其进行修改，或者找人为您完成，无需担心软件供应商会改变策略并让您重新开始。

Yocto is also widely adopted in the industry. In addition to semiconductor vendors, there are a number of vendors providing commercially supported Yocto software and services. The Yocto project [participants page](https://www.yoctoproject.org/ecosystem/yocto-project-participants) shows the variety of industry players that are using Yocto. Additionally, industry initiatives such as the [GENIVI Alliance](https://www.genivi.org/) and [Automotive Grade Linux](https://www.automotivelinux.org/) help to push Yocto adoption into the automotive industry.

Yocto 在行业中也被广泛采用。除半导体供应商外，还有许多供应商提供商业支持的 Yocto 软件和服务。Yocto 项目参与者页面显示了使用 Yocto 的各种行业参与者。此外，诸如 GENIVI Alliance 和 Automotive Grade Linux 之类的行业计划还有助于将 Yocto 推向汽车行业。

### 工具和 SDK

**Yocto Advantages: Tools and SDK**

As discussed above, getting a properly supported cross toolchain can require a large effort. The Yocto project includes recipes to build a fully functional toolchain as part of your project build. This toolchain, which has been tested by the Yocto community across a wide variety of architectures and platforms, will suffice — in most cases — to support your project. If needed, this toolchain can be easily customized using standard Yocto recipe mechanisms. Additionally, if your target chip supports features that are not enabled in the default toolchain (e.g., custom instructions or optimizations), specifying platform-specific tuning parameters is a simple addition in your platform layer. Finally, if you have the need to use a prebuilt toolchain provided by a third-party, there are mechanisms built-in to Yocto to allow this. Support for several providers of commercial toolchains is available in the default Yocto source code and can be extended to additional providers with relatively modest efforts.

如上所述，获得适当支持的交叉工具链可能需要大量的精力。Yocto 项目包括在项目构建过程中构建功能齐全的工具链的配方。Yocto 社区已经在各种体系结构和平台上对该工具链进行了测试，在大多数情况下，该工具链足以支持您的项目。如果需要，可以使用标准 Yocto 配方机制轻松定制此工具链。此外，如果您的目标芯片支持默认工具链中未启用的功能（例如，自定义指令或优化），则在平台层中只需添加特定于平台的调整参数即可。最后，如果您需要使用第三方提供的预构建工具链，则 Yocto 内置了一些机制来允许这种情况。

Yocto can also bundle the tools and libraries needed for your platform into an SDK that can be delivered to application developers. This is simpler than requiring such developers to run full Yocto system builds and allows for an optimized application development workflow while ensuring that these developers have the proper versions of all components needed for their work.

Yocto 还可以将平台所需的工具和库捆绑到可交付给应用程序开发人员的 SDK 中。这比要求此类开发人员运行完整的 Yocto 系统构建要简单，并允许优化的应用程序开发工作流程，同时确保这些开发人员具有工作所需的所有组件的正确版本。

## Yocto 的缺点

**Yocto Disadvantages**

There is a fairly steep learning curve with Yocto. The terminology alone can be daunting (e.g., what is the difference between Yocto, Poky, and OpenEmbedded?). The number of options for configuring your target can make it difficult to assess the best choices. Getting a basic system up and running can be achieved quickly by following any of the tutorials available with a simple web search. However, understanding what changes need to be made for your particular design may require a nontrivial amount of research and investigation. To be sure, there are valid reasons for the complexity and we feel that the advantages discussed above make it worth the effort. Once you have completed the initial ramp-up, further design efforts will proceed much more quickly.

学习曲线相当陡峭。仅术语本身就令人生畏（例如，Yocto、Poky 和 OpenEmbedded 之间有什么区别？）。用于配置目标的选项数量众多，因此难以评估最佳选择。通过遵循简单的 Web 搜索中可用的任何教程，可以快速实现基本系统的启动和运行。但是，了解需要对您的特定设计进行哪些更改可能需要大量的研究和调查。可以肯定的是，存在复杂性的正当理由，我们认为上面讨论的优点值得付出努力。一旦完成了初始准备工作，进一步的设计工作将更快地进行。

For developers who are used to traditional desktop and server software development, the Yocto workflow can be confusing. In a desktop development environment, the host OS provider generally provides a mechanism to install new packages. In Ubuntu for instance, new packages are easily installed using the *apt-get* command. The packages are available in pre-compiled binaries from servers accessible through an Internet connection. In Yocto, you will need to modify your configuration and rebuild to add additional packages; there are no Internet-hosted package libraries generally available to pull from.

对于习惯了传统台式机和服务器软件开发的开发人员，Yocto 工作流程可能会造成混乱。在桌面开发环境中，主机 OS 提供程序通常提供一种安装新软件包的机制。例如，在 Ubuntu 中，可以使用 apt-get 命令轻松安装新软件包。可通过可通过 Internet 连接访问的服务器中的预编译二进制文件中提供的软件包。在 Yocto 中，您将需要修改配置并重建以添加其他软件包。通常没有互联网托管的软件包库可供提取。

Working in a cross-build environment can feel unfamiliar and requires developers to understand both the host and target systems. Being able to develop code, compile (or simply run in a scripting environment), and quickly test in your target system can be faster than running a *bitbake* build and deploying a new image to your target. To be clear, Yocto does support development tools on the target to support this kind of workflow; however, once the required code has been developed and debugged, there is an additional step needed to integrate those changes back into the Yocto build environment. An intermediate approach is to make the changes in the Yocto environment, but to then deploy only the updated packages. The Yocto build system outputs packages in a standard format (*rpm* , *deb* , *ipk* , or *tar* ) that can be installed into a running system using utilities on the target such as *rpm* or *ipk* . These approaches work fine to optimize development cycle times early in the lifecycle; however, as you get closer to product release, you generally want to minimize or eliminate the differences between your test images and your production images — manually installing packages or modifying code on a running system effectively creates a custom image.

在交叉构建环境中工作可能会感到陌生，并且要求开发人员同时了解主机和目标系统。能够在目标系统中开发代码，进行编译（或仅在脚本环境中运行）和快速测试，比运行 bitbake 构建并将新映像部署到目标中要快。需要明确的是，Yocto 确实支持目标开发工具来支持这种工作流程。但是，一旦开发并调试了所需的代码，则还需要执行其他步骤才能将这些更改重新集成到 Yocto 构建环境中。一种中间方法是在 Yocto 环境中进行更改，然后仅部署更新的软件包。Yocto 构建系统以标准格式（rpm、deb、ipk 或 tar），可以使用目标上的实用程序（例如 rpm 或 ipk）将其安装到正在运行的系统中。这些方法可以很好地在生命周期的早期优化开发周期。但是，随着产品发布的临近，您通常希望最小化或消除测试映像和生产映像之间的差异 —— 在正在运行的系统上手动安装软件包或修改代码可以有效地创建自定义映像。

Finally, the build times for a full Yocto build can be significant. This is, in general, unavoidable due to the large number of packages that need to be built for a fully functioning Linux system; however, this can be greatly mitigated by the Yocto shared state mechanism.

最后，完整的 Yocto 构建的构建时间可能很长。通常，由于需要为功能齐全的 Linux 系统构建大量软件包，因此这是不可避免的。但是，可以通过 Yocto 共享状态机制大大减轻这种情况。

## 物联网特定需求

**IoT Specific Needs**

The Yocto Project is an excellent choice for IoT projects. All the advantages discussed above are valid for designs in the IoT space. Sean Hudson states:

"*We recommend the Yocto Project, which is the basis for our own Mentor Embedded Linux (MEL), to customers because of its flexibility, wide industry support, large community, and support for long term maintenance. For the Internet of Things (IoT), the need to support diverse architectures, multiple device configurations, and target software combinations make it a great fit for creating a Linux basis for IoT devices.*" —— Sean Hudson, Member of Technical Staff and Embedded Linux Architect / Mentor, A Siemens Business / Yocto Project Advisory Board Founding Member / Current OpenEmbedded Board Member

Yocto 项目是物联网项目的绝佳选择。以上讨论的所有优势对于物联网领域的设计都是有效的。肖恩·哈德森指出：

“*我们向客户推荐 Yocto 项目，它是我们自己的 Mentor 嵌入式 Linux（MEL）的基础，因为它具有灵活性，广泛的行业支持，庞大的社区以及对长期维护的支持。对于物联网（IoT），支持多种架构，多种设备配置以及目标软件组合的需求使其非常适合为 IoT 设备创建 Linux 基础。*” —— Sean Hudson，西门子商业 Yocto 项目顾问委员会 / 技术人员和嵌入式 Linux 架构师 / 导师 / 创始成员 / 现任 OpenEmbedded 董事会成员

Wikipedia [defines the IoT](https://en.m.wikipedia.org/wiki/Internet_of_things) as:

"*The inter-networking of physical devices, vehicles (also referred to as “connected devices” and “smart devices”), buildings, and other items embedded with electronics, software, sensors, actuators, and network connectivity which enable these objects to collect and exchange data.*"

维基百科将物联网定义为：

*物理设备、车辆的互联（也称为“连接的设备”和“智能设备”），建筑物以及其他嵌入了电子、软件、传感器、执行器和网络连接的物品的互连网络，使这些对象可以收集和交换数据。*

There are, broadly speaking, two types of IoT devices: small systems hosting sensors or actuators, and large systems such as IoT gateways, Network Attached Storage (NAS) boxes, home automation routers, etc. Linux is likely overkill for the small systems as many of them run an 8- or 16- bit microcontrollers that cannot easily support Linux. For the larger devices, Linux in general, and Yocto in particular, is an excellent option. More and more, these types of devices are prototyped (and sometimes implemented) with easily available consumer hardware devices such as the [Raspberry Pi](https://www.raspberrypi.org/) or the [BeagleBone](http://beagleboard.org/). The Yocto Project has excellent support for these (and many other similar) boards, and is an excellent way to get started quickly on your IoT project.

从广义上讲，有两种类型的 IoT 设备：托管传感器或执行器的小型系统，以及 IoT 网关、网络连接存储（NAS）盒、家庭自动化路由器等大型系统。它们中的许多运行不能轻松支持 Linux 的 8 位或 16 位微控制器。对于较大的设备，通常是 Linux，尤其是 Yocto 是一个很好的选择。这些类型的设备越来越多地使用易于获得的消费类硬件设备（例如 Raspberry Pi 或 BeagleBone）进行原型设计（有时是实现）。Yocto 项目为这些（以及许多其他类似）板提供了出色的支持，并且是快速开始您的 IoT 项目的绝佳方法。

Many connected devices are deployed and managed as a large fleet of devices. In these cases, the predictability of software contents described above is a major advantage. Manually updating devices is resource-intensive and prone to error, and having a definitive list of devices and their software contents is a first step in being able to secure the fleet. If deployed devices can make significant modifications to their software, it can be difficult to know, with any certainty, which updates are required.

许多连接的设备作为大量设备进行部署和管理。在这些情况下，上述软件内容的可预测性是一个主要优势。手动更新设备会占用大量资源，并且容易出错，拥有设备及其软件内容的确定清单是确保车队安全的第一步。如果已部署的设备可以对其软件进行重大修改，则可能很难确定要进行哪些更新。

IoT systems tend to use software, libraries, and protocols that are not necessarily in wide use in desktop Linux distributions. Many of the common packages such as MQTT and AMQP are readily added to your Yocto build using standard Yocto layers:

物联网系统倾向于使用台式机 Linux 发行版中不一定广泛使用的软件，库和协议。可以使用标准 Yocto 层将许多常见的软件包（例如 MQTT 和 AMQP）轻松添加到您的 Yocto 构建中：

- **MQTT:** http://cgit.openembedded.org/meta-openembedded/tree/meta-python/recipes-devtools/python/python-paho-mqtt_1.2.bb
- **AMQP:** http://cgit.openembedded.org/meta-openembedded/tree/meta-oe/recipes-connectivity/rabbitmq-c/rabbitmq-c_0.7.0.bb

Additionally, industry initiatives such as [IoTivity](https://www.iotivity.org/) are directly supported by Yocto using a feature layer:

此外，Yocto 使用功能层直接支持诸如 IoTivity 之类的行业计划：

- https://layers.openembedded.org/layerindex/branch/master/layer/meta-oic/

## 结束语

**Conclusion**

Developers have a variety of good options for Linux distributions and build systems. The Yocto Project is a solid option for most embedded projects and serves as an excellent starting point. The benefits of the Yocto build system as outlined in this article are among the reasons it is so widely used in the embedded software industry. Product development in the IoT space is proceeding at a blistering pace and many of those devices have feature sets that benefit from a Linux implementation. Yocto's wide variety of features, expandability and fine-grained control over the contents of the target image make it ideally suited for projects in these spaces and is certainly worth some investigation as you start your design.

对于 Linux 发行版和构建系统，开发人员有多种不错的选择。Yocto 项目是大多数嵌入式项目的可靠选择，并且是一个很好的起点。本文概述的 Yocto 构建系统的好处是其在嵌入式软件行业中得到如此广泛使用的原因之一。物联网领域的产品开发正以惊人的速度进行，其中许多设备的功能集都受益于 Linux 实施。Yocto 的各种功能，可扩展性和对目标图像内容的细粒度控制使其非常适合这些空间中的项目，并且在您开始设计时当然值得进行一些研究。

**Drew Moseley** is currently part of the [Mender.io](https://mender.io/) open source project to deploy OTA software updates to embedded Linux devices. He was raised in Tampa, Florida, and attended the University of Florida. Drew has spent his career in embedded software and developer tools with stints at Intel, Motorola, Red Hat, Monta Vista, Mentor Graphics, and — most recently — at [Mender.io](https://mender.io/). He has spent the last 10 years working on embedded Linux, with the last 6 years focused on Yocto. Drew is a retired fencer, fencing coach, and referee. In his spare time, he enjoys working on electronics projects, minimizing his life, and spending time in the Florida sun.

Drew Moseley 目前是 Mender.io 开源项目的一员，该项目旨在将 OTA 软件更新部署到嵌入式 Linux 设备上。他在佛罗里达州坦帕长大，并就读于佛罗里达大学。Drew 在英特尔，摩托罗拉，红帽，Monta Vista，Mentor Graphics 以及最近的 Mender.io 从事嵌入式软件和开发工具方面的职业生涯。在过去的 10 年中，他从事嵌入式 Linux 的工作，而在过去的 6 年中，他专注于 Yocto。德鲁（Drew）是退休的击剑运动员，击剑教练和裁判。在业余时间，他喜欢从事电子项目，最大限度地减少生活，并在佛罗里达的阳光下度过。

![](https://static.getiot.tech/drewmoseley-meta-dmoseley-local-config.png#center)



---

- 原文链接：https://www.embedded.com/why-the-yocto-project-for-my-iot-project/
- 资料下载：https://elinux.org/images/c/c1/Why-the-Yocto-Project-for-My-IoT-Project-Drew-Moseley-Mender.io_.pdf