---
sidebar_position: 1
slug: /nodejs-npm
---

# Node 包管理器 npm



自 2009 年以来，Node.js 一直席卷全球。成千上万个系统基于 Node.js 构建，促使开发者在社区宣称“JavaScript 正在吞噬软件”。Node 成功的主要因素之一是它广受欢迎的软件包管理器——npm，因为 npm 使 JavaScript 开发人员可以快速方便地共享软件包。本文主要介绍 npm 命令的使用。

![](https://static.getiot.tech/nodejs-npm.png#center-400)


## NPM 工具

Node.js 框架最强大的功能之一是能够轻松地使用 Node 包管理器（Node Package Manager，NPM）安装各种 Node 扩展模块。NPM 工具提供了 Node 包查找、安装、删除、发布等实用功能，下面列出 NPM 的一些常用命令。

### conf

conf 命令用于配置 NPM 包管理器，例如查询配置信息：

```bash
npm config list
```

更换镜像源：

```bash
npm config set registry https://registry.npmmirror.com
```

查询镜像源配置：

```bash
npm config get registry
```

### init

init 命令会以交互形式创建项目描述文件 package.json。

```bash
npm init
```

填写的项目信息包括：

| 项目           | 说明                                                     |
| -------------- | -------------------------------------------------------- |
| name           | 项目名称                                                 |
| version        | 项目的版本号                                             |
| description    | 项目的描述信息                                           |
| entry point    | 项目的入口文件，默认为 index.js                          |
| test command   | 项目启动时脚本命令                                       |
| git repository | 项目对应的 Git 仓库地址                                  |
| keywords       | 关键词，可用于 NPM 搜索                                  |
| author         | 项目作者                                                 |
| license        | 项目要发行的时候使用的许可证书，默认为 ISC（类似于 BSD） |

### search

search 命令用于在存储库中查找模块包。例如查找 express 包：

```bash
npm search express
```

### install

install 命令用于安装 Node 包，需要使用在存储库或本地位置上的一个 package.json 文件。例如：

```bash
npm install
npm install express
npm install express@0.1.1
npm install ../tModule.tgz
```

使用 `-g` 选项可在全局位置安装 Node 包，例如：

```bash
npm install express -g
```

:::tip

在 npm 5 之前的版本，使用 `npm install` 默认选项安装包时，仅仅会把包下载到 node_modules 目录中，并不会同时修改 package.json 文件，因此需要使用 `--save` 选项在安装包的同时修改 package.json 文件。

而在 npm 5 之后的版本，`npm install` 安装包时，默认会修改 package.json 文件，因此 `--save` 选项已经不再需要了。

:::

### remove

remove 命令用于删除已安装的模块，例如：

```bash
npm remove express
```

### pack

pack 命令用于将在 package.json 文件中定义的模块封装成 .tgz 文件。例如：

```bash
npm pack
```

### view

view 命令用于显示模块的详细信息。例如：

```bash
npm view express
```

### publish

publish 命令用于将在 package.json 文件中定义的模块发布到[注册表](https://npmjs.org)。例如：

```bash
npm publish
```

### unpublish

unpublish 命令用于取消一个已发布的模块。例如：

```bash
npm unpublish myModule
```

### owner

使用 owner（所有者名称）可以在存储库中添加、删除包和列出包的所有者。例如 owner 为 getiot，包名为 myModule：

```bash
npm add getiot myModule    # 添加
npm rm getiot myModule     # 删除
npm ls myModule            # 列出
```



## Node 包

- [express](https://www.npmjs.com/package/express)：一个保持最低程度规模的灵活 Node.js Web 应用程序框架。
- [lodash](https://www.npmjs.com/package/lodash)：一个一致性、模块化、高性能的 JavaScript 实用工具库。
- [moment](https://www.npmjs.com/package/moment)：一个日期、时间处理工具类，对于 JavaScript 的日期时间处理功能非常强悍和全面。 





