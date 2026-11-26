---
sidebar_position: 18
draft: true
authors: [luhuadong]
---

# 电动汽车 AUTOSAR 架构



本文从AUTOSAR架构入手,简述了AUTOSAR架构组成及方法论,着重介绍了VCU软件功能开发,包括整车高压上点、下电管理、扭矩管理、驱动系统热管理、高压能量管理、低压能量管理、充电管理、诊断管理等功能,接着介绍了VCU软件的集成流程,将符合AUTOSAR架构的底层软件和应用层软件集成一起,最后对集成的软件进行单元测试、MIL测试及HIL测试,以满足系统的需求。



汽车电子技术已成为汽车各方面功能拓展、性能提升的重要技术支撑。随着汽车新能源化与智能化的逐步推进，汽车电子技术的功能需求将不断增加，控制软件也将变得越来越复杂。为了提升软件复用度，提高软件开发质量与效率、降低开发风险和成本，在2003年，由全球汽车制造商、零部件供应商及其他半导体和软件系统公司联合建立了汽车开放系统架构联盟（AUTomotive Open System ARchitecture，AUTOSAR），并联合推出了一个开放的、标准化的汽车嵌入式系统软件架构 —— AUTOSAR 规范。

AUTOSAR 规范在国外的应用已经较为普遍和成熟，随着 AUTOSAR 规范的认可度越来越高，它有望成为整个汽车电子行业普遍使用的软件标准。近年来，随着国内一些企业纷纷加入新能源汽车“三电”相关控制器的研发，控制器正向开发需求不断增加，AUTOSAR 规范在国内的应用也进入了一个高潮，基于 AUTOSAR 平台可以使得开发者更高效、更高质量地完成汽车嵌入式系统软件的开发。



## 从 OSEK 到 AUTOSAR

为了迎合汽车高精度、高实时性、高可靠性控制的需要，嵌入式实时操作系统（RTOS）逐渐在 ECU 中使用。与此同时，由于不同实时操作系统间应用程序接口（API）各不相同，出现应用程序的移植性差等问题。

于是，在1993年德国汽车工业界提出了 OSEK（汽车电子开放式系统及其接口标准）。该体系最初得到宝马、博世、戴姆勒-克莱斯勒、西门子、大众等公司的支持。1994年，随着标致和雷诺加入该体系，他们将法国汽车工业使用的汽车分布式执行标准（VDX）也纳入该体系，并在1995年的研讨会上得到共识，从而产生了 OSEK/VDX 标准。



---



本AUTOSAR教程描述了AUTOSAR架构层及其功能。关于AUTOSAR的教程描述了AUTOSAR的基础知识，AUTOSAR架构组件，端口，接口，通信模式等。对AUTOSAR的应用层、运行环境(RTE)、基本软件(微控制器抽象层、ECU抽象层、服务层、复杂驱动程序)也进行了说明。



## AUTOSAR 简介

AUTOSAR 是汽车开放系统架构（AUTomotive Open System Architecture）的简称，是一个开放的、标准化的汽车嵌入式系统软件架构（也称为 AUTOSAR 规范）。同时也是一个由全球 150 多家汽车制造商、零部件供应商及其他半导体和软件系统公司组成的联盟。

AUTOSAR 的目标是建立一个开放和标准化的汽车软件架构，简化汽车软件的开发。帮助管理软件开发中的产品修改、可靠升级、可重用性和可伸缩性等问题。

![](https://static.getiot.tech/AUTOSAR-vs-conventional-arch.png)

由于汽车电子工业的创新，电子控制单元(ECU)的软件高度依赖于硬件。这将导致更高的成本和ecu之间的功能重新定位的更多努力。

AUTOSAR 引入了应用软件和 ECU (即硬件)之间的标准化层。这使得软件独立于选择的微控制器和 OEM。这简化了开发过程，并有助于应用程序软件的重用。

AUTOSAR 涵盖以下工作主题，包括软件体系结构、方法学和应用程序接口。在 AUTOSAR 体系结构中，标准化层被称为“基本软件”层，如下所述。

## AUTOSAR 架构层

![](https://static.getiot.tech/AUTOSAR-Architecture.jpg)

作为 AUTOSAR 教程的一部分，让我们了解 AUTOSAR 体系结构层。如图2所示，AUTOSAR 体系结构有3个主要层次，即应用层、 RTE 层和基本软件层。基本软件包括多个子层，即服务层、 ECU 抽象层和抽象层微控制器。“基础软件”层的这三个子层提供了具有不同服务功能的模块，如操作系统服务、网络通信、存储服务、管理服务等。此外，这三个子层中还存在各种总线类型，包括 CAN、 LIN、 Flexray、 MOST 等。

### 应用层

应用程序层由相互连接的软件组件组成。基于组件的软件工程是一个可重复使用的自包含的工件，它实现一个具有给定属性的功能。这些软件组件封装了应用程序的各个部分，并通过称为 VFB (“虚拟功能总线”)的硬件独立总线进行通信。如果软件组件绑定到不同的 ecu，那么它们可以通过各自的 rte 和基本软件层进行通信。在这种情况下，RTE 在专用 ECU 上实现 VFB。「基本软件」为应用程式开发人员提供多项服务功能。

虚拟功能总线: 虚拟功能总线是对整个车辆的 AUTOSAR 软件组件互连的抽象。不同软件组件之间以及软件组件与其环境(例如硬件驱动程序、操作系统、服务等)之间的通信可以独立于任何底层硬件(例如通信系统)指定。VFB 的功能由通信模式提供。

### 运行时环境（RTE）

所有 AUTOSAR 软件组件之间的交互都是通过 AUTOSAR 执行期函式库进行的，AUTOSAR 接口规范确保了连接性。

AUTOSAR运行时环境(RTE)充当系统级通信中心，用于ecu之间和ecu内部的信息交换。

RTE是特定ECU的虚拟功能总线的运行时表示。•RTE为AUTOSAR软件组件提供通信抽象，为ecu间(使用CAN、LIN、Flexray、MOST等)或ecu内通信提供相同的接口和服务。

由于软件组件的通信要求取决于应用程序，因此需要定制 RTE

RTE 应支持软件组件的多个实例化。

### 基础软件

- AUTOSAR 软件组件不允许直接访问基本软件。
- 基础软件是标准化的软件层，为软件组件提供服务。 它不执行任何功能性工作，位于 AUTOSAR 运行时环境之下。它包含标准化组件和 ECU 特定组件。
- 标准化组件包括以下内容。
  - services，包括诊断协议； NVRAM、闪存和内存管理。
  - Communication 通信框架（例如 CAN、LIN、FlexRay...）、I/O 管理和网络管理。
- ECU 特定组件包括以下内容。
  - 操作系统
  - 微控制器抽象
  - 复杂的设备驱动程序



## AUTOSAR 组件、端口、接口

**SW 组件**：实现具有给定属性的功能的可重用自包含人工制品。 组件具有明确定义的端口，组件可以通过这些端口与其他组件交互。

**端口**：端口总是只属于一个组件，代表一个组件和其他组件之间的交互点。 为了定义在组件的端口上提供或需要的服务或数据，引入了 AUTOSAR 接口概念。

**接口**：AUTOSAR 接口可以是客户端-服务器或发送方-接收方类型。

- 客户端-服务器接口定义了一组可以调用的操作。
- 发送者-接收者接口，用于面向数据的通信。



- 一个端口可以
  - PPort（提供接口）
  - RPort（所需接口）
  当 PPort 提供接口时，该端口所属的组件
  - 提供客户端-服务器接口中定义的操作的实现
  - 生成在面向数据的发送者-接收者接口中描述的数据。
  当组件的 RPort 需要 AUTOSAR 接口时，组件可以
  - 当接口是客户端 - 服务器时调用操作
  - 读取发送方-接收方接口中描述的数据元素。

## AUTOSAR 通信模式

基本的沟通模式
- 客户端 - 服务器
- 发送者 - 接收者

接口指定
- 什么信息发送方接收方通信传输
- 客户端 - 服务器通信可以调用哪些参数的服务
接口的正式描述在软件组件模板中，还包括可以使用的数据类型和接口兼容性。
基本通信模式的详细行为由属性指定。 具有这些属性，例如 可以定义数据队列的长度以及接收方（阻塞、非阻塞等）和发送方（循环发送等）的行为。



**Client-Server 通信**

The server is a provider and the client is a user of a service.

The client initiates the communication, requesting that the server performs a service, transferring a parameter set if necessary.

The server waits for incoming communication requests from a client, performs the requested service and dispatches a response to the client's request.

The direction of initiation is used to categorize whether an AUTOSAR Software Component is a client or a server. A single component can be both a client and a server depending on the software realization.

After the service request is initiated and until the response of the server is received The client can be blocked (synchronous communication) - non-blocked (asynchronous communication).

服务器是提供者，客户端是服务的用户。

客户端发起通信，请求服务器执行服务，必要时传输参数集。

服务器等待来自客户端的传入通信请求，执行请求的服务并发送对客户端请求的响应。

启动方向用于对 AUTOSAR 软件组件是客户端还是服务器进行分类。 根据软件实现的不同，单个组件既可以是客户端，也可以是服务器。

在发起服务请求之后，直到收到服务器的响应，客户端可以被阻塞（同步通信）——非阻塞（异步通信）。



**Sender-Receiver 通信**

Model for the asynchronous distribution of information where a sender distributes information to one or several receivers.
The sender is not blocked (asynchronous communication) and neither expects nor gets a response from the receivers (data or control flow), the sender just provides the information and the receivers decides autonomously when and how to use it.
It is the responsibility of the communication infrastructure to distribute the information.
The sender does not know the identity or the number of receivers

信息的异步分发模型，其中发送方将信息分发给一个或多个接收方。

发送方没有被阻塞（异步通信），既不期望也不得到接收方的响应（数据或控制流），发送方只提供信息，接收方自主决定何时以及如何使用它。

分发信息是通信基础设施的责任。

发送方不知道接收方的身份或数量



## AUTOSAR 架构示例

![](https://static.getiot.tech/AUTOSAR-Architecture-Example.jpg)





