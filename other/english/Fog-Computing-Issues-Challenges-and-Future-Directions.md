---
sidebar_position: 12
---

# 雾计算的问题、挑战和未来



## 摘要

In Cloud Computing, all the processing of the data collected by the node is done in the central server. This involves a lot of time as data has to be transferred from the node to central server before the processing of data can be done in the server. Also it is not practical to stream terabytes of data from the node to the cloud and back. To overcome these disadvantages, an extension of cloud computing, known as fog computing, is introduced. In this, the processing of data is done completely in the node if the data does not require higher computing power and is done partially if the data requires high computing power, after which the data is transferred to the central server for the remaining computations. This greatly reduces the time involved in the process and is more efficient as the central server is not overloaded. Fog is quite useful in geographically dispersed areas where connectivity can be irregular. The ideal use case requires intelligence near the edge where ultra-low latency is critical, and is promised by fog computing. The concepts of cloud computing and fog computing will be explored and their features will be contrasted to understand which is more efficient and better suited for real-time application.

在云计算中，节点收集的数据的所有处理都在中央服务器中完成。这涉及大量时间，因为数据必须从节点传输到中央服务器，然后才能在服务器中完成数据处理。此外，将 TB 级数据从节点流式传输到云并返回也是不切实际的。为了克服这些缺点，引入了云计算的扩展，称为雾计算。在这种情况下，如果数据不需要较高的计算能力，则数据的处理完全在节点中完成，如果数据需要较高的计算能力，则部分完成，然后将数据传输到中央服务器以进行剩余的计算。这大大减少了该过程所涉及的时间，并且由于中央服务器不会过载，因此效率更高。雾在连接可能不规则的地理分散区域非常有用。理想的用例需要在超低延迟至关重要的边缘附近的智能，雾计算承诺。将探讨云计算和雾计算的概念，并对比它们的特性，以了解哪个更高效，更适合实时应用。 

![](https://static.getiot.tech/fog-computing-diagram.png#center)



## 1. 介绍（INTRODUCTION）

Networking is shaped by two obvious trends - Cloud-based Internet and mobile computing. Cloud computing [1, 2] forms a basic need for all organizations that deal with large amount of data. Cloud forms to be very efficient in storing large amount of data and providing access to it from anywhere in the world. This could lead to unauthorized access to personal data or a firm's private data [3]. In relation to cloud-computing, bringing services to the edge of the network is fog computing. Fog computing deals with user behaviour profiling and decoy information technology to prevent unauthorized access. In Fog Computing, computing resources and application services are distributed in the most logical, efficient places, at any point along the continuum from the data source to the cloud. Fog computing is defined as "a scenario where a large number of heterogeneous wireless devices are connected together in a network, communicate and potentially cooperate among them and with the network to perform storage and processing tasks without the intrusion of third parties". Although this definition is debatable, this defines how fog computing differs from the related technologies.

网络受到两个明显趋势的影响 —— 基于云的互联网和移动计算。云计算是所有处理大量数据的组织的基本需求。云形式可以非常有效地存储大量数据并提供从世界任何地方对其的访问。这可能导致未经授权访问个人数据或公司的私人数据。关于云计算，将服务带到网络边缘是雾计算。雾计算处理用户行为分析和诱饵信息技术，以防止未经授权的访问。在雾计算中，计算资源和应用程序服务分布在从数据源到云的连续体中的任何一点上，最合乎逻辑、最高效的地方。雾计算被定义为“大量异构无线设备在网络中连接在一起，在它们之间以及与网络之间进行通信和潜在合作以执行存储和处理任务而不受第三方入侵的场景”。虽然这个定义值得商榷，但这定义了雾计算与相关技术的不同之处。

Fog Computing avoids primarily to store data in large-scale data centers. Fog Computing offers a significant amount of measurement, control and configuration is performed at or near the end-user. Fog Computing supports emerging Internet of Everything (IoE) applications that demand real-time/predictable latency. Fog supports densely distributed data collection points, through devices called Fog nodes [4]. The major difference between cloud computing and Fog computing is on the support of location awareness. Fog Computing, composed of geo-distributed Fog servers, targets to deliver the localized and location based services [5]. It is centralized or distributed in regional areas. Fog servers have localized data storage center that avoids delay in computing

雾计算主要避免将数据存储在大型数据中心。雾计算提供了在最终用户处或附近执行的大量测量、控制和配置。雾计算支持需要实时、可预测延迟的新兴万物互联（IoE）应用程序。Fog 通过称为 Fog 节点的设备支持密集分布的数据收集点。云计算和雾计算的主要区别在于对位置感知的支持。雾计算由地理分布式雾服务器组成，旨在提供本地化和基于位置的服务。它集中或分布在区域区域。雾服务器有本地化的数据存储中心，避免计算延迟。

## 2. 概述（OVERVIEW）

Fog computing is defined as a distributed computing paradigm that fundamentally extends the services provided by the cloud to the edge of the network [6]. Cisco defines it as fog computing is considered as an extension of the cloud computing paradigm from the core of network to the edge of the network [7]. It facilitates the computation, storage and networking between the end devices and the traditional cloud servers.

雾计算被定义为一种分布式计算范式，从根本上将云提供的服务扩展到网络边缘。思科将其定义为雾计算被认为是云计算范式从网络核心到网络边缘的扩展。它促进了终端设备和传统云服务器之间的计算、存储和联网。

Instead of running application only in the cloud, fog computing involves the cloud as well as the edge devices between the end devices and cloud servers to run the application. Fog computing takes advantages of both edge and cloud computing while it benefits from edge devices’ close proximity to the endpoints, it also leverages the on-demand scalability of cloud resources[8]. It basically reduces the load on the cloud server by efficiently using the resources available in the edge nodes to do partial computation and also it reduces the traffic to the cloud server by doing filtering operations in the nodes.

雾计算不是只在云中运行应用程序，而是涉及云以及终端设备和云服务器之间的边缘设备来运行应用程序。雾计算利用边缘计算和云计算的优势，同时受益于边缘设备靠近端点，它还利用了云资源的按需可扩展性。它通过有效地使用边缘节点中可用的资源进行部分计算来基本上减少云服务器上的负载，并通过在节点中进行过滤操作来减少到云服务器的流量。

There are mainly two concepts which are usually confused with fog computing. These concepts are Mobile Edge Computing (MEC) and Mobile Cloud Computing (MCC). MCC basically suggests that both the data storage and data processing is done outside the mobile in a cloud. So it moves the data and computing power from the individual mobile to the cloud. MEC is similar to that of a Cloudlet. It can be seen as a cloud computing paradigm in a more concentrated. It is like a cloud server running on an edge of a mobile network[9]. Fog computing is a mixture of two of these concepts along with features of its own making it more reliable and useful.

主要有两个概念通常与雾计算混淆。这些概念是移动边缘计算（MEC）和移动云计算（MCC）。MCC 基本上建议数据存储和数据处理都在移动设备之外的云中完成。因此，它将数据和计算能力从个人移动设备转移到云端。MEC 类似于 Cloudlet。它可以被看作是一种更集中的云计算范式。它就像运行在移动网络边缘的云服务器。雾计算是这两个概念的混合，以及它自己的特性，使其更可靠和有用。

## 3. 问题（ISSUES）

Fog computing extends cloud computing and acts on Internet of Things. These devices, called the fog nodes can be deployed in any environment with a network connection. Fog computing has additional storage resources at the edges to process the requirements. Hence, the Fog server needs to adapt its services leading to management and maintenance cost. In addition, the operator needs to encounter the following issues:

雾计算扩展了云计算并作用于物联网。这些称为雾节点的设备可以部署在具有网络连接的任何环境中。雾计算在边缘有额外的存储资源来处理需求。因此，雾服务器需要调整其服务，从而导致管理和维护成本。此外，运营商还需要遇到以下问题：

### 3.1. 隐私（Privacy）

Fog computing being dominated by wireless primarily, there is a big concern for network privacy. Network operator generates configurations manually, fog nodes being deployed at the edge of Internet, massive maintenance cost is involved [10]. The leakage of private data is gaining attention while using networks. The end users are more accessible to the Fog nodes. Because of this, more sensitive information is collected by Fog nodes than remote cloud. Encryption methods like HAN (Home-Area Network) can be used to counter these issues.

雾计算主要由无线主导，网络隐私受到很大关注。网络运营商手动生成配置，雾节点部署在互联网边缘，涉及大量维护成本。在使用网络时，私人数据的泄漏越来越受到关注。最终用户更容易接触到雾节点。因此，雾节点比远程云收集更多敏感信息。HAN（家庭局域网）等加密方法可用于解决这些问题。

### 3.2. 安全（Security）

The main security issue is the authentication of the devices involved in fog computing at different gateways. Each appliance has its own IP address. A malicious user may use a fake IP address to access information stored on the particular fog node. To overcome this access control an intrusion detection system has to be applied at all layers of the platform [11].

主要的安全问题是在不同网关上对涉及雾计算的设备进行身份验证。每个设备都有自己的 IP 地址。恶意用户可能会使用虚假 IP 地址访问存储在特定雾节点上的信息。为了克服这种访问控制，必须在平台的所有层应用入侵检测系统。

### 3.3. 网络管理（Network Management）

Being connected to heterogeneous devices, managing the fog nodes, the network, connection between each nodes will be burden unless SDN and NFV techniques are applied [12].

除非应用 SDN 和 NFV 技术，否则连接到异构设备、管理雾节点、网络、每个节点之间的连接将是负担。

### 3.4. 雾服务器的放置（Placement of Fog Servers）

Placing a group of fog servers in such a way that they deliver maximum service to the local requirements is an issue. Analyzing the work done in each node in the server before placing them reduces the maintenance cost [13].

以这样一种方式放置一组雾服务器，以便它们为本地需求提供最大的服务是一个问题。在放置它们之前分析在服务器中的每个节点中完成的工作降低了维护成本。

### 3.5. 计算延迟（Delay in Computing）

Delays due to Data aggregation, Resource over-usage reduces the effectives of services provided by the fog servers, causing delay in computing data. Data Aggregation should take place before data processing, Resource-limited fog nodes should be designed scheduling by using priority and mobility model.

数据聚合造成的延迟，资源过度使用降低了雾服务器提供的服务的有效性，导致计算数据的延迟。数据聚合应该在数据处理之前进行，资源有限的雾节点应该使用优先级和移动性模型来设计调度。

### 3.6. 能源消耗（Energy Consumption）

Since fog environments use large number of fog nodes, the computation is distributed and can be less energy-efficient. Hence, reduction of energy consumption in fog computing is essential [14].

由于雾环境使用大量雾节点，因此计算是分布式的并且能源效率较低。因此，减少雾计算中的能源消耗是必不可少的。



## 4. 应用（APPLICATIONS）

Fog computing have huge benefits in the real time applications. It is broadly used in IOT applications which involves real time data. It acts as an extended version of cloud computing. It is an intermediate between the cloud and end users (closer to end users).It can used in both the ways, that can be between machine and machine or between the human to machine.

雾计算在实时应用中具有巨大的优势。它广泛用于涉及实时数据的物联网应用。它充当云计算的扩展版本。它是云和终端用户（更接近终端用户）之间的中间体。它可以用于两种方式，可以在机器与机器之间或人与机器之间。

![](https://static.getiot.tech/fog-computing.png#center)

### 4.1. 移动大数据分析（Mobile Big Data Analytics）

In IOT (Internet of things) data is collected in bulk and it can’t be stored in cloud (Not efficient enough). In such situations it is beneficial to use fog computing instead of cloud computing as fog nodes are much closer to end systems.It also eliminates other problems such as delay, traffic, processing speed, delivery time, response time, storage data transportation and data processing. Fog computing could be the future of IOT applications.

在 IOT（物联网）中，数据是批量收集的，无法存储在云中（效率不够）。 在这种情况下，使用雾计算代替云计算是有益的，因为雾节点更接近终端系统。它还消除了其他问题，如延迟、流量、处理速度、交付时间、响应时间、存储数据传输和数据处理 . 雾计算可能是物联网应用的未来。

### 4.2. 大坝的水压（Water Pressure at Dams）

Sensors installed in dams send data to the cloud where the data is analyzed and officials are alerted in case of any discrepancies. The problem faced here is the delay of information which could be dangerous. To solve this, Fog is used, and since it is near the end systems it is easier to transmit data, analyze it and give instantaneous feedback.

安装在大坝中的传感器将数据发送到云端，在那里对数据进行分析，并在出现任何差异时向官员发出警报。这里面临的问题是信息的延迟，这可能是危险的。为了解决这个问题，使用了雾，因为它靠近终端系统，所以更容易传输数据、分析数据并提供即时反馈。

### 4.3. 智能公用事业服务（Smart Utility Service）

Here the main aim is to conserve time, money and energy. The analysis of data needs to run every minute to stay updated. This mostly involves the end users therefore cloud might not serve the purpose. These applications inform users everyday as to which appliances conserve more energy. IOT also creates a lot of traffic in the network where sending other data is difficult therefore fog is a good alternative.

这里的主要目的是节省时间、金钱和精力。数据分析需要每分钟运行一次以保持更新。这主要涉及最终用户，因此云可能无法达到目的。这些应用程序每天都会通知用户哪些电器更节能。物联网还会在网络中产生大量流量，在这些流量中发送其他数据很困难，因此雾是一个不错的选择。

### 4.4. 健康数据（Health Data）

When data needs to be transferred from one hospital to another high security and data integrity is a must. This can be provided by using Fog since the data is transferred locally. These fog nodes can be used by the labs to update the patient’s lab records which can be accessed by the nearby hospitals easily. Hardcopies of medical history and health issues of a patient need not be carried as these unified records can be accessed by any doctor.

当数据需要从一家医院转移到另一家医院时，必须具备高安全性和数据完整性。这可以通过使用 Fog 来提供，因为数据是在本地传输的。实验室可以使用这些雾节点来更新患者的实验室记录，附近的医院可以轻松访问这些记录。无需携带患者病史和健康问题的硬拷贝，因为任何医生都可以访问这些统一记录。

## 5. 架构（ARCHITECTURE）

![](https://static.getiot.tech/fog-computing-architecture.png#center)

One major problem faced with cloud computing is the bandwidth, especially on wireless networks. The problem only increases as the Internet of things continues to expand with a large number of physical objects connected wirelessly. Fog computing solves this problem by storing data in local computers and devices generally referred to as fog nodes. Any device with computing, storage and network connectivity can be utilized as a fog node e.g. hand-held devices, tablets, PC’s, routers etc. These fog nodes are managed by Fog Data Service which serves various purposes like control and security of data, data reduction, data virtualization and edge analytics. Data could also be sent to the cloud for long term analytics.

云计算面临的一个主要问题是带宽，尤其是在无线网络上。随着物联网不断扩展，大量物理对象以无线方式连接，这个问题只会越来越严重。雾计算通过将数据存储在通常称为雾节点的本地计算机和设备中来解决这个问题。任何具有计算、存储和网络连接的设备都可以用作雾节点，例如 手持设备、平板电脑、PC、路由器等。这些雾节点由雾数据服务管理，用于各种目的，如数据控制和安全、数据缩减、数据虚拟化和边缘分析。数据也可以发送到云端进行长期分析。



## 6. 比较（COMPARISON BETWEEN CLOUD COMPUTING AND FOG COMPUTING）

Cloud computing is a great solution when there is an uninterrupted access to a cloud server capable of processing and transmitting data quickly to the end device. Fog computing is mainly an architecture of heterogeneous devices in which certain applications and services are managed at the node by a smart device but the actual management is by the cloud. Fog computing primarily targets the mobile users while cloud targets the general internet users. The service type is localized in fog computing whereas in cloud, it’s globalized. Though the storage is limited in fog computing compared to cloud computing, the distance between the users is very less that it can be communicated through wireless connections but in cloud computing, communication is through IP networks.

当可以不间断地访问能够处理数据并将数据快速传输到终端设备的云服务器时，云计算是一个很好的解决方案。雾计算主要是一种异构设备的架构，其中某些应用程序和服务由智能设备在节点管理，但实际管理由云计算。雾计算主要针对移动用户，而云计算主要针对一般互联网用户。服务类型在雾计算中是本地化的，而在云中，它是全球化的。虽然与云计算相比，雾计算中的存储空间有限，但用户之间的距离非常小，可以通过无线连接进行通信，但在云计算中，通信是通过 IP 网络进行的。

Comparing the parameters of fog and cloud computing, in fog computing, Mobility is supported whereas in cloud it's limited. The number of service nodes in fog is more than in the other. Real time interactions are supported in the former while it's not supported in the latter. Providing local security in cloud is tedious while it is possible in Fog computing.

比较雾计算和云计算的参数，在雾计算中，移动性是支持的，而在云中它是有限的。 雾中的服务节点数量多于其他。前者支持实时交互，后者不支持。在云中提供本地安全是乏味的，而在雾计算中是可能的。

Table 1. Comparisons of the Parameters of Cloud and Fog computing

| Parameters                     | Cloud computing        | Fog computing               |
| ------------------------------ | ---------------------- | --------------------------- |
| Server nodes Location          | Within the Internet    | At the edge of the network  |
| Client and Server Distance     | Multiple hops          | Single/Multiple hops        |
| Latency                        | High                   | Low                         |
| Delay Jitter                   | High                   | Very low                    |
| Security                       | Less secure, Undefined | More secure, can be defined |
| Awareness about Location       | No                     | Yes                         |
| Vulnerability                  | High Probability       | Very low probability        |
| Geographical Distribution      | Centralized            | Dense and Distributed       |
| Number of Server nodes         | Few                    | Very Large                  |
| Real Time Interactions         | Supported              | Supported                   |
| Kind of last mile connectivity | Leased line            | Wireless                    |
| Mobility                       | Limited support        | Supported                   |



表1. 云计算与雾计算参数对比

| 参数                 | 云计算           | 雾计算         |
| -------------------- | ---------------- | -------------- |
| 服务器节点位置       | 互联网内         | 在网络边缘     |
| 客户端和服务器距离   | 多跳             | 单跳/多跳      |
| 延迟                 | 高               | 低             |
| 延迟抖动             | 高               | 非常低         |
| 安全                 | 不太安全，未定义 | 更安全，可定义 |
| 位置感知             | 不支持           | 支持           |
| 漏洞                 | 高概率           | 极低的概率     |
| 地理分布             | 集中式           | 密集和分布式   |
| 服务器节点数         | 少               | 很多           |
| 实时互动             | 支持             | 支持           |
| 最后一英里连接的种类 | 专线             | 无线           |
| 流动性               | 有限的支持       | 支持           |




## 7. 结论（CONCLUSION）

Fog Computing and its applications has been discussed .Fog computing has the ability to handle the flooding of data created by Internet of Things on the edge of the network. The characteristics of fog computing like mobility, proximity to end-users, low latency, location awareness, heterogeneity and due to its real-time applications fog computing platform is considered as the appropriate platform for Internet of Things. Fog computing is entering an exciting time, where it can positively affect operational costs. Fog computing resolves problems related to congestion, space and internet traffic. Fog computing also provides an intelligent platform to manage the distributed and real-time nature of emerging IoT infrastructures. Developing these services at the edge through fog computing will lead to new business models and opportunities for network operators.

雾计算及其应用已经讨论过。雾计算有能力处理由物联网在网络边缘产生的数据洪流。雾计算具有移动性、接近最终用户、低延迟、位置感知、异构性等特点，并且由于其实时应用，雾计算平台被认为是适合物联网的平台。雾计算正在进入一个激动人心的时代，它可以对运营成本产生积极影响。雾计算解决了与拥塞、空间和互联网流量相关的问题。雾计算还提供了一个智能平台来管理新兴物联网基础设施的分布式和实时性。通过雾计算在边缘开发这些服务将为网络运营商带来新的商业模式和机会。



---

原文链接：[Fog Computing: Issues, Challenges and Future Directions](http://ijece.iaescore.com/index.php/IJECE/article/view/8736/7395)

