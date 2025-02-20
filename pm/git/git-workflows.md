---
sidebar_position: 15
slug: /git-workflows
---

# Git 工作流



## 为什么要确定工作流

在使用 Git 的过程中，如果没有清晰流程和规划，每个人都提交一堆杂乱无章的 commit，那么项目很快就会变得难以协调和维护。

我们适合哪种协作方式？

- 每个人都直接推送到主仓库的 master 分支
- 在主仓库创建自己的分支进行开发，定期合并代码
- 将主仓库 fork 到一份个人仓库进行开发，定期提交、合并代码



## 常见的分支模型

![Git 常见分支模型](https://static.getiot.tech/git-workflow-release-cycle-4maintenance.png#center)



### 单分支模型

只创建 master 分支



### 生产/开发模型

支持 master、develop 类型分支



### 特性/发布模型

支持 master、develop、feature 类型分支



### 开发/发布分离模型

支持 master、develop、feature、release 类型分支



### 开发/发布/缺陷分离模型

支持 master、develop、feature、release、hotfix 类型分支











