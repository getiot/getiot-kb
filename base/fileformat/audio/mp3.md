---
sidebar_position: 1
slug: /mp3
---

# MP3 格式（通用音频）



MP3 的英文全称是 **MPEG-1** or **MPEG-2 Audio Layer III**，是当今流行的一种数字音频编码和有损压缩格式，它被设计来大幅降低音频数据量，通过舍弃 PCM 音频资料中对人类听觉不重要的部分，从而达成压缩成较小文件的目的。



## 起源

MP3 格式始于二十世纪 80 年代中期，由位于德国埃尔朗根（Erlangen）研究组织弗劳恩霍夫协会（Fraunhofer）的一组工程师发明，并于 1991 年标准化。该协会致力于研究高质量、低数据率的声音编码，虽然 MP3 是有损压缩格式，但对于大多数用户的听觉感受来说，MP3 的音质与最初的不压缩音频相比没有明显的下降。

后来随着 MP3 的普及，曾对音乐产业造成冲击与影响。



## MPEG Audio 标准

MPEG（Moving Picture Experts Group）是 ISO 下的一个动态图像专家组，它制定的 MPEG 标准广泛应用于各种多媒体中。MPEG 标准包括视频和音频标准，其中音频标准已制定出 MPEG-1、MPEG-2、MPEG-2AAC 和 MPEG-4。

MPEG-1 和 MPEG-2 标准使用同一个音频编码解码族 —— Layer1、2、3。MPEG-2 的一个新特点是采用低采样率扩展降低数据流量，另一特点是多通道扩展，将主声道增加为 5 个。MPEG-2AAC（MPEG-2 Advanced Audio Coding）标准是 FraunhoferIIS 和 AT&T 公司于 1997 年推出的，旨在显著减少数据流量，MPEG22AAC 采用的修正的离散余弦变换（MDCT，Modified Discrete Co2sine Transform）算法，采样率可在 8KHz 到 96KHz 之间，声道数可在 1-48 之间。

MPEG Audio Layer1、2、3 三个层使用相同的滤波器组、位流结构和头信息，采样频率为 32KHz、4411KHz 或 48KHz。

- Layer1 是为数字压缩磁带 DCC（DigitalCompactCassette）设计的，数据流量为 384kbps。
- Layer2 在复杂性和性能间作了权衡，数据流量下降到 256kbps-192kbps。
- Layer3一开始就为低数据流量而设计，数据流量在 128kbps-112kbps，Layer3 增加了 MDCT 变换，使其频率分辨能力是 Layer2 的 18 倍，Layer3 还使用了与 MPEGVid2eo 类似的平均信息量编码（EntropyCoding）减少了冗余信息。

目前，MP3 绝大部分使用的是 MPEG21 标准。



## MP3 文件结构

MP3 文件大体分为三部分：TAG_V2（ID3V2），Frame, TAG_V1（ID3V1）。其中，音频数据由帧（frame）构成的，帧是 MP3 文件最小的组成单位。 

| 组成  | 描述                                                         |
| ----- | ------------------------------------------------------------ |
| ID3V2 | 包含了作者、作曲、专辑等信息，长度不固定，扩展了 ID3V1 的信息量。 |
| Frame | 一系列的帧，个数由文件大小和帧长决定。每个 FRAME 的长度可能不固定，也可能固定，由位率 bitrate 决定；每个 FRAME 由分为帧头和数据实体两部分帧头记录了 mp3 的位率、采样率、版本等信息，每个帧之间相互独立。 |
| ID3V1 | 包含了作者、作曲、专辑等信息，长度为 128BYTE。               |





## 参考

- [https://zh.m.wikipedia.org/zh-sg/MP3](https://zh.m.wikipedia.org/zh-sg/MP3)
- [MP3格式音频文件结构解析](https://www.cnblogs.com/ranson7zop/p/7655474.html)
