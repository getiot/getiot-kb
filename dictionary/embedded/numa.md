---
sidebar_label: NUMA
sidebar_position: 7
slug: /numa
---

# NUMA



**NUMA**（Non-uniform memory access）是一种用于多处理器的计算机存储器设计架构。

过去，处理器被设计为 **对称多处理（Symmetric Multi-processing）**或 **统一内存架构（Uniform Memory Architecture，即 UMA）**机器，这意味着所有处理器都通过单一总线共享对系统中所有可用内存的访问。现在，随着大量数据计算应用程序的出现，内存访问速度要求增加，而在 UMA 机器中，由于多个 CPU 通过单个总线访问内存，共享总线上的负载更多，并且由于总线带宽有限， 存在多个 CPU 之间的延迟和冲突等挑战。

在这个以数据为中心的时代，为了解决内存总线瓶颈，催生了一种称为 **非均匀内存访问（即 NUMA）**或更准确的 **Cache-Coherent Numa（缓存一致 Numa，即 ccNUMA）** 的新架构。 在这种架构中，每个处理器都有一个本地内存库，它可以更接近（更低的延迟）访问。也就是说，我们将完整的可用内存分配给每个单独的 CPU，这些内存将成为他们自己的本地内存。如果任何 CPU 需要更多内存，它仍然可以从其他 CPU 访问内存，但延迟稍高。

![](https://static.getiot.tech/uma-and-numa.png#center)

如今，处理器速度如此之快，以至于它们通常需要将内存直接连接到它们所在的插槽上。 因此，与远程内存访问相比，从单个处理器到本地内存的内存访问不仅具有更低的延迟，而且不会引起互连和远程内存控制器的争用。但可能有一小组 CPU 一起访问它们自己的本地内存。 因此可以有多个这样的 CPU 和内存组，称为 NUMA 节点。

每个 NUMA 节点上面有自己的内存控制器，内存分配给 NUMA CPU 后，解决了内存总线瓶颈。但如果指令和数据随机放置，会导致数据获取时间变得差异巨大且不可控。通过在代码中，对于指令和数据进行 CPU 亲和性处理，可以使得数据和指令尽可能放到一个 NUMA 节点，从而减少跨节点数据访问。解决数据读取时间差异问题并提高效率。

![](https://static.getiot.tech/numa-node.png#center)



## 参考

- [What is NUMA (non-uniform memory access)?](https://www.techplayon.com/what-is-numa-non-uniform-memory-access/)

