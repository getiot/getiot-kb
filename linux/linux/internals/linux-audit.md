---
sidebar_position: 6
sidebar_label: audit 审计系统
slug: /linux-audit
authors: [luhuadong]
---

# Linux audit 审计系统



Linux 审计系统（audit）为追踪系统中与安全相关的信息提供了途径。基于预配置原则，audit 将生成日志项从而记录尽可能多的在系统中发生的事件。这一信息对执行关键任务的环境尤其重要，它可以确定那些违反安全策略的人以及他们的行为。audit 不会为系统提供额外的安全保护；相反，它只是用来发现系统中违反安全策略的行为。通过额外的措施例如 SELinux 可以进一步地防止这些违反行为。


