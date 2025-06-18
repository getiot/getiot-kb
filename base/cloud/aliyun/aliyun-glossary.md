---
sidebar_position: 2
slug: /aliyun-glossary
---

# 阿里云名词解释

本文列出阿里云计算服务平台的相关术语，覆盖 AWS 核心服务、工具及架构概念，适合开发者、运维人员快速查阅。

- **ECS**（Elastic Compute Service，云服务器）：弹性可扩展的云服务器实例，支持多种计算场景（如通用型、内存优化型）。
- **OSS**（Object Storage Service，对象存储）：高可靠、低成本的非结构化数据存储服务，适用于图片、视频等文件。
- **RDS**（Relational Database Service，云数据库）：托管 MySQL、PostgreSQL、SQL Server 等关系型数据库，支持自动备份与扩展。
- **VPC**（Virtual Private Cloud，专有网络）：在阿里云中构建逻辑隔离的私有网络，自定义 IP 地址段和路由规则。
- **SLB**（Server Load Balancer，负载均衡）：将流量分发到多台 ECS 实例，提升应用可用性和性能。
- **EIP**（Elastic IP Address，弹性公网 IP）：可动态绑定到 ECS 实例的公网 IP 地址，支持灵活配置。
- **CDN**（Content Delivery Network，内容分发网络）：将资源分发至全球加速节点，提高用户访问速度的服务。
- **ESS**（Elastic Scaling Service，弹性伸缩）：也称为 Auto Scaling，根据业务负载自动调整 ECS 实例数量，实现成本优化。
- **NAS**（Network Attached Storage，文件存储）：共享文件存储服务，支持多台 ECS 实例并发访问。
- **MaxCompute**（大数据计算）：分布式数据处理引擎，支持 PB 级数据分析和机器学习。
- **PAI**（Platform for AI，机器学习平台）：全流程 AI 开发平台，覆盖数据预处理、模型训练到在线推理。
- **PolarDB**（云原生数据库）：兼容 MySQL/PostgreSQL 的云原生数据库，支持高并发与弹性扩展。
- **Function Compute**（函数计算）：事件驱动的无服务器计算服务，按执行时间和资源消耗计费。
- **DCDN**（Dynamic Content Delivery Network，全站加速）：动态内容加速与静态资源分发结合，优化全球访问体验。
- **Security Group**（安全组）：虚拟防火墙，控制 ECS 实例的入站和出站流量规则。
- **RAM**（Resource Access Management，资源访问管理）：阿里云提供的管理用户身份与资源访问权限的服务。
- **IAM**（Identity and Access Management，身份与访问管理）：控制用户对云资源的权限策略，可以帮助云帐号安全地控制对云计算服务资源的访问。
- **ApsaraDB**（飞天数据库）：阿里云自研数据库系列（如 PolarDB、Redis、MongoDB 等）的统称。
- **DataWorks**（数据工场）：一站式大数据开发与治理平台，支持数据集成、调度和可视化。
- **SLS**（Log Service，日志服务）：实时日志采集、分析与存储，支持多源数据接入。
- **CloudMonitor**（云监控）：监控云资源使用状态，提供告警和自动化运维能力。
- **IoT Platform**（物联网平台）：连接和管理海量物联网设备，支持数据采集与规则引擎。
- **GA**（Global Accelerator，全球加速）：通过阿里云全球网络加速跨境访问，降低延迟。
- **Alibaba Cloud Linux**：阿里云自研操作系统，针对云场景优化性能和安全性。
- **BSS**（Business Support System，业务支撑系统）：费用中心，管理账单、资源续费与代金券。
- **ROS**（Resource Orchestration Service，资源编排）：通过模板自动化部署云资源，支持 IaC（基础设施即代码）。
- **WAF**（Web 应用防火墙）：防护 SQL 注入、XSS 等 Web 攻击，保障应用安全。
- **HBR**（Hybrid Backup Recovery，混合云备份）：统一管理本地和云上数据的备份与恢复。
- **ENS**（Edge Node Service，边缘节点服务）：将计算能力下沉至边缘节点，就近处理用户请求。
- **Quick BI**：自助式数据分析与可视化工具，支持生成实时报表。
- **飞天加速计划**：新用户免费体验 ECS、OSS 等核心服务的优惠活动。
- **ACA/ACP 认证**：阿里云助理工程师（ACA）和专业工程师（ACP）资格认证，验证云技能。
- **区域**（Region）：阿里云在全球范围内部署的独立地理区域（如华东1-杭州、华北2-北京），不同区域间网络完全隔离，用户可按合规或延迟需求选择部署位置。
- **可用区**（Availability Zone）：同一区域内电力和网络互相隔离的物理数据中心，提供冗余容灾能力（如华东1-可用区A/B/C）。
- **容灾**（Disaster Recovery）：通过跨可用区、跨区域备份或故障切换，保障业务在极端情况下的连续性（如多可用区部署、数据异地冗余）。
- **跨可用区部署**：将业务组件（如 ECS、RDS）分布在多个可用区，避免单点故障导致服务中断。
- **高可用性**（High Availability，HA）：通过冗余设计（如负载均衡 + 多可用区 ECS）确保系统持续稳定运行。
