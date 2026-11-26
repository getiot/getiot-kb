---
sidebar_position: 7
authors: [luhuadong]
---

# ROS2 DDS 中间件

ROS2支持的DDS：eProsima’s Fast DDS、RTI’s Connext DDS、Eclipse Cyclone DDS 和 GurumNetworks GurumDDS，都是实时数据分发系统（DDS）的实现，用于在分布式系统中进行数据通信和集成。



ROS2的RMW（Robot Middleware）是一种通信层，用于处理ROS2中节点之间的数据交换。RMW的目的是在不同的节点之间传递消息和服务请求。它支持多种常用的中间件实现，例如DDS（Data Distribution Service）、FastRTPS、CycloneDDS等。RMW软件包实现了ROS 2的标准API，因此可以在不同的硬件平台和操作系统上运行。

RMW是ROS2的一个重要组件，它提供了以下功能：

支持多语言：RMW可以让不同语言实现的节点之间进行通信，ROS2提供了许多语言绑定，例如C++、Python、Java等。

支持多种中间件：RMW支持多种常用的中间件实现，例如DDS（Data Distribution Service）、FastRTPS、CycloneDDS等。这使得用户可以选择适合自己应用场景的中间件实现，从而实现高效的消息传输和实时性能。

支持实时性：RMW支持实时性，这是因为它的底层实现是一些底层库，例如EProsima Fast-RTPS，它可以提供高效的消息传输和实时性能。

易于扩展：RMW提供了一个灵活的架构，使得用户可以很容易地扩展和自定义RMW实现，以满足特定的需求。

总之，RMW是ROS2中一个重要的通信层，它提供了一种可靠的、灵活的通信机制，使得ROS 2可以很容易地支持不同的硬件平台、操作系统和编程语言，从而为机器人和自动化系统的开发提供了强大的支持。

| 名称                                 | 协议                         | RMW 实现                | 状态                                        |
| ------------------------------------ | ---------------------------- | ----------------------- | ------------------------------------------- |
| eProsima Fast RTPS                   | Apache 2                     | rmw_fastrtps_cpp        | 完全支持. 默认的RMW. 已经打包在发布的文件中 |
| RTI Connext commercial               | research                     | rmw_connext_cpp         | 完全支持. 需要从源码编译支持                |
| RTI Connext (dynamic implementation) | commercial, research         | rmw_connext_dynamic_cpp | 停止支持. alpha 8.* 之前版本完全支持        |
| PrismTech Opensplice                 | LGPL (only v6.4), commercial | rmw_opensplice_cpp      | 停止支持. alpha 8.* 之前版本完全支持        |
| OSRF FreeRTPS                        | Apache 2                     |                         | 部分支持. 开发暂停                          |



## eProsima’s Fast DDS

eProsima’s Fast DDS 是一款高性能、开源的实时数据分发系统（DDS）实现。它采用了基于发布-订阅模式的消息传递机制，用于在分布式系统中进行数据通信和集成。以下是 Fast DDS 的原理、优点和缺点：

(1)原理
Fast DDS 采用了基于 DDS 标准的数据分发机制，其中包括以下几个关键概念：
（1）Domain: 一个 DDS 系统中的逻辑分区，用于划分不同的数据域。
（2）Publisher: 一个 DDS 实体，用于发布数据。
（3）Subscriber: 一个 DDS 实体，用于订阅数据。
（4）Topic: 一个 DDS 实体，用于定义数据的类型和名称。
（5）Data Writer: 一个 DDS 实体，用于写入数据。
（6）Data Reader: 一个 DDS 实体，用于读取数据。
Fast DDS 还采用了一些优化措施，例如多线程支持、数据压缩和动态调整等，以提高性能和可靠性。

(2)优点
高性能：Fast DDS 采用了多种优化措施，包括多线程支持、数据压缩和动态调整等，以提高性能和可靠性。相比其他 DDS 实现，Fast DDS 在数据传输效率和延迟方面都有较好的表现。
可扩展性：Fast DDS 支持多种编程语言和平台，并且可以通过添加新的 Data Writers 和 Data Readers 来扩展系统。
开源：Fast DDS 是一款完全开源的 DDS 实现，可免费使用和修改，且社区活跃。

(3)缺点
学习成本高：Fast DDS 是一款比较复杂的 DDS 实现，需要掌握一些基本概念和原理，因此学习成本较高。
文档不够完善：Fast DDS 的文档相对较少，部分功能和配置方式需要通过代码或社区进行了解和调试。
综上所述，Fast DDS 是一款高性能、可扩展且完全开源的 DDS 实现，适用于对数据传输效率和延迟要求较高的分布式系统。



## RTI’s Connext DDS

RTI’s Connext DDS 是一款高性能、可靠性强的实时数据分发系统（DDS）实现，它采用了发布-订阅模式进行消息传递，用于在分布式系统中进行数据通信和集成。以下是 Connext DDS 的原理、优点和缺点：

(1)原理
Connext DDS 采用了基于 DDS 标准的数据分发机制，其中包括以下几个关键概念：

Domain: 一个 DDS 系统中的逻辑分区，用于划分不同的数据域。
Publisher: 一个 DDS 实体，用于发布数据。
Subscriber: 一个 DDS 实体，用于订阅数据。
Topic: 一个 DDS 实体，用于定义数据的类型和名称。
Data Writer: 一个 DDS 实体，用于写入数据。
Data Reader: 一个 DDS 实体，用于读取数据。
Connext DDS 还采用了一些优化措施，例如多线程支持、数据压缩和动态调整等，以提高性能和可靠性。同时，Connext DDS 还支持多种 QoS（Quality of Service）配置，例如数据可靠性、延迟、带宽等，以满足不同的业务需求。

(2)优点
高性能：Connext DDS 采用了多种优化措施，包括多线程支持、数据压缩和动态调整等，以提高性能和可靠性。相比其他 DDS 实现，Connext DDS 在数据传输效率和延迟方面都有较好的表现。
可靠性强：Connext DDS 支持多种数据可靠性配置，例如数据重传、持久化存储和数据冗余等，以提高数据传输的可靠性和安全性。
可扩展性：Connext DDS 支持多种编程语言和平台，并且可以通过添加新的 Data Writers 和 Data Readers 来扩展系统。
支持多种 QoS 配置：Connext DDS 支持多种 QoS 配置，可以根据不同的业务需求进行灵活配置。

(3)缺点
商业化授权：Connext DDS 是一款商业化授权的 DDS 实现，需要购买授权才能使用，不是完全免费的。
学习成本高：Connext DDS 是一款比较复杂的 DDS 实现，需要掌握一些基本概念和原理，因此学习成本较高。
开源程度较低：Connext DDS 的部分代码和文档并不开源，可能会限制部分用户的定制和二次开发能力。



## Eclipse Cyclone DDS

Eclipse Cyclone DDS 是一款开源、高性能、可靠性强的实时数据分发系统（DDS）实现，它是基于 Eclipse IoT 项目的 Eclipse Zenoh 和 Eclipse Hono 项目中的 DDS 实现而来，用于在分布式系统中进行数据通信和集成。以下是 Cyclone DDS 的原理、优点和缺点：

(1)原理
Cyclone DDS 采用了基于 DDS 标准的数据分发机制，其中包括以下几个关键概念：
（1）DDS 数据发布与订阅
DDS数据发布者将数据写入发布者本地缓存区域，DDS数据订阅者从订阅者本地缓存区域读取数据。DDS提供了完整的数据发布、订阅过程管理，包括发布者和订阅者的注册和发现，发布者和订阅者间的匹配，以及数据分发等过程。

（2）数据传输方式
Eclipse Cyclone DDS使用UDP进行数据传输，支持多种传输方式。DDS提供了多种QoS（Quality of Service）级别，可以根据需求设置不同的传输方式和策略，以达到最优的数据传输效果。

（3）数据编解码
Eclipse Cyclone DDS使用平台无关的IDL（Interface Definition Language）语言描述数据格式，通过IDL编译器生成对应的数据结构、序列化和反序列化代码，从而实现数据编解码。IDL文件可根据需要进行修改和定制，以满足具体的应用场景。

（4）数据订阅管理
Eclipse Cyclone DDS支持多种订阅管理策略，包括最近消息优先、时间戳优先、优先级、按序列号订阅等。DDS提供了灵活的订阅策略配置，可以根据应用需求灵活选择。

（5）数据质量管理
Eclipse Cyclone DDS提供了丰富的数据质量管理功能，包括可靠性保证、实时性保证、事务性保证等。DDS提供了多种QoS级别，支持不同的数据传输需求。

（6）发现和分发
Eclipse Cyclone DDS提供了完整的发现和分发过程管理，包括数据发布者和订阅者的注册、发现、匹配，以及数据分发等过程。DDS提供了多种发现和分发策略，可以根据需求配置不同的策略。

(2)优点
开源：Cyclone DDS 是一款开源的 DDS 实现，代码和文档都可以自由获取和修改。
高性能：Cyclone DDS 采用了多种优化措施，包括多线程支持、零拷贝内存管理和动态调整等，以提高性能和可靠性。相比其他 DDS 实现，Cyclone DDS 在数据传输效率和延迟方面都有较好的表现。
可靠性强：Cyclone DDS 支持多种数据可靠性配置，例如数据重传、持久化存储和数据冗余等，以提高数据传输的可靠性和安全性。
可扩展性：Cyclone DDS 支持多种编程语言和平台，并且可以通过添加新的 Data Writers 和 Data Readers 来扩展系统。
支持多种 QoS 配置：Cyclone DDS 支持多种 QoS 配置，可以根据不同的业务需求进行灵活配置。

(3)缺点
社区资源相对较少：Cyclone DDS 是比较新的 DDS 实现，相比其他 DDS 实现，其社区资源还比较少，可能会影响用户的使用和开发。
文档和教程相对较少：相比其他 DDS 实现，Cyclone DDS 的文档和教程相对较少，可能会影响用户的学习和开发。
部分功能尚未完善：Cyclone DDS 相比其他 DDS 实现，部分功能尚未完善，例如 DDS Security 功能在 Cyclone DDS 中还没有完全实现。



## GurumNetworks GurumDDS

GurumNetworks GurumDDS 是一款基于 DDS 标准的开源实现，目标是提供高性能、高可靠性和可扩展性的分布式系统解决方案。它采用 C++ 编写，支持多种操作系统平台和硬件架构。

GurumDDS 的核心部分是 Data Distribution Service (DDS) 的实现，它提供了一种分布式数据传输的机制，支持发布/订阅模式和数据订阅的 QoS 配置。此外，GurumDDS 还提供了一些其他功能，例如实时性能量度、可靠性配置、多路复用支持、类型安全等。

(1)原理
1.发布/订阅模型：GurumDDS 的基本通信机制是发布/订阅模型，即发布者 (publisher) 将数据发布到数据空间 (data space) 中，订阅者 (subscriber) 从数据空间中订阅感兴趣的数据。GurumDDS 将数据空间分为主题 (topic) 和分区 (partition) 两个层次，主题表示数据的类型，分区表示数据的分组。发布者可以向不同的主题和分区发布数据，订阅者可以从不同的主题和分区订阅数据。

2.QoS 配置：GurumDDS 支持多种 QoS 配置，包括可靠性、持久化、传输优先级、最大传输速率、最大传输延迟等。发布者和订阅者可以根据应用需求进行不同的 QoS 配置，以满足数据传输的要求。

3.DDS API：GurumDDS 提供了一套 C++ API，用于发布者和订阅者之间的数据通信。API 包括 DataWriter、DataReader、Topic、Participant 等类，用户可以通过这些类进行数据的发布、订阅和管理。

4.网络传输协议：GurumDDS 支持多种网络传输协议，包括 TCP、UDP、共享内存和 Infiniband 等。用户可以根据应用需求选择合适的传输协议。

5.多线程架构：GurumDDS 的实现采用基于事件驱动的多线程架构，每个线程处理不同的任务，包括网络 I/O、消息传输、事件处理等。多线程架构使得 GurumDDS 在数据传输时具有高效的性能表现。

(2)优点
高性能：GurumDDS 采用基于事件驱动的多线程模型，使得它在数据传输时具有高效的性能表现。此外，它支持对传输的数据进行压缩和编码优化，进一步提升了数据传输的效率。

高可靠性：GurumDDS 提供了多种可靠性配置选项，包括持久化存储、重传机制、失效检测等，使得数据传输过程中出现的错误得以及时检测和修复，提高了系统的可靠性。

可扩展性：GurumDDS 支持分布式部署，可以横向扩展节点，满足不同规模和复杂度的应用需求。

开源：GurumDDS 是一个开源项目，用户可以免费使用和修改其源代码，方便用户自定义功能和适配应用需求。

(3)缺点
社区相对较小：相比其他 DDS 实现，GurumDDS 的社区资源和用户群相对较小，文档和支持资源有限。

功能相对简单：相比其他 DDS 实现，GurumDDS 在某些功能上可能相对简单，如安全性和监测工具等方面可能还需要进一步完善。

总体来说，GurumDDS 是一款性能优异、可靠性高、可扩展性好的 DDS 实现，适用于分布式系统的设计和开发。虽然它的社区规模和功能相对简单，但其开源性和可定制性为用户提供了更多的自由度和灵活性。



