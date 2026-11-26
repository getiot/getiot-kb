---
sidebar_position: 2
slug: /nodejs-yarn
---

# Node 包管理器 Yarn


![](https://static.getiot.tech/yarn-logo.png#center-200)

**Yarn**（英文全拼：Yet Another Resource Negotiator）是由 Facebook、Google、Exponent 和 Tilde 联合推出的一个快速、可靠、安全的依赖管理工具，一款新的 JavaScript 包管理工具。正如[官方文档](https://engineering.fb.com/2016/10/11/web/yarn-a-new-package-manager-for-javascript/)中写的，Yarn 是为了弥补 [npm](/nodejs/nodejs-npm/) 的一些缺陷而出现的。



## 安装 Yarn

在使用 Yarn 之前，首先要在你的系统上安装 Yarn 。虽然安装 Yarn 有很多种方式，但是建议采用这一种跨平台的安装方式 —— 通过 npm 安装。

```bash
npm install --global yarn
```

上述命令执行完毕，可以通过如下命令测试 Yarn 是否安装成功：

```bash
yarn --version
```



## Yarn 的特点

- **速度超快**：Yarn 缓存了每个下载过的包，所以再次使用时无需重复下载。 同时利用并行下载以最大化资源利用率，因此安装速度更快。
- **超级安全**：在执行代码之前，Yarn 会通过算法校验每个安装包的完整性。
- **超级可靠**：使用详细、简洁的锁文件格式和明确的安装算法，Yarn 能够保证在不同系统上无差异的工作。



## Yarn 的优势

相比于 npm，Yarn 最突出的优势是速度快！主要体现在以下两个方面：

- **并行安装**：无论 npm 还是 Yarn 在执行包的安装时，都会执行一系列任务。npm 是按照队列执行每个 package，也就是说必须要等到当前 package 安装完成之后，才能继续后面的安装。而 Yarn 是同步执行所有任务，提高了性能。
- **离线模式**：如果之前已经安装过一个软件包，用 Yarn 再次安装时之间从缓存中获取，就不用像 npm 那样再从网络下载了。



## Yarn 命令

| 命令                     | 描述                                   |
| ------------------------ | -------------------------------------- |
| yarn add                 | 添加依赖                               |
| yarn audit               | 对已安装的软件包执行漏洞审核           |
| yarn autoclean           | 从程序包依赖项中清除并删除不必要的文件 |
| yarn bin                 | 显示依赖 bin 文件夹的位置              |
| yarn cache               | 管理用户目录中的依赖缓存               |
| yarn check               | 验证当前项目中程序包依赖项             |
| yarn config              | 管理依赖配置文件                       |
| yarn create              | 创建 Yarn 工程                         |
| yarn dedupe              | 删除重复的依赖                         |
| yarn generate-lock-entry | 生成 Yarn 锁文件                       |
| yarn global              | 在全局安装依赖                         |
| yarn help                | 显示 Yarn 的帮助信息                   |
| yarn import              | 迁移当前依赖的项目 package-lock.json   |
| yarn info                | 显示有关依赖的信息                     |
| yarn init                | 初始化工程并创建 package.json 文件     |
| yarn install             | 用于安装项目的所有依赖项               |
| yarn licenses            | 列出已安装依赖的许可证及源码 url       |
| yarn link                | 链接依赖文件夹                         |
| yarn list                | 列出已安装的依赖                       |
| yarn login               | 存储您在 registry 上的用户名和 email   |
| yarn logout              | 清除你在 registry 上用户名和 email     |
| yarn outdated            | 列出所有依赖项的版本信息               |
| yarn owner               | 展示依赖作者                           |
| yarn pack                | 创建依赖项的压缩 gzip                  |
| yarn policies            | 规定整个项目中执行 Yarn 的版本         |
| yarn publish             | 将依赖发布到 npm 注册表                |
| yarn remove              | 删除依赖                               |
| yarn run                 | 运行定义的程序脚本命令                 |
| yarn tag                 | 在依赖上添加，删除或列出标签           |
| yarn team                | 管理组织中的团队，并更改团队成员身份   |
| yarn test                | 运行程序的 test 命令                   |
| yarn upgrade             | 将指定依赖升级为最新版本               |
| yarn upgrade-interactive | 更新过期依赖的简便方法                 |
| yarn version             | 展示依赖版本信息                       |
| yarn versions            | 展示所有依赖项版本信息                 |
| yarn why                 | 显示有关为什么安装依赖的信息           |
| yarn workspace           | Yarn 的工作区信息                      |
| yarn workspaces          | Yarn 的所有工作区信息                  |



## Yarn 和 npm 命令对比

下面以部分常用命令为例，列出等效的 yarn 和 npm 命令，方便读者记忆。

| npm 命令                             | yarn 命令                   | 说明                           |
| ------------------------------------ | --------------------------- | ------------------------------ |
| `npm install`                        | `yarn`                      | 一键安装 package.json 的所有包 |
| `npm install <package> --save`       | `yarn add <package>`        | 安装到 dependencies            |
| `npm install <package> --save-dev`   | `yarn add <package> --dev`  | 安装到 devDependencies         |
| `npm install <package>[@ver] --save` | `yarn add <package>[@ver]`  | 安装指定版本号的包             |
| `npm install <package> --global`     | `yarn global add <package>` | 全局安装某个包                 |
| `npm uninstall <package> --save`     | `yarn remove <package>`     | 删除某个包                     |
| `npm update --save`                  | `yarn upgrade`              | 更新所有包                     |
| `npm update --global`                | `yarn updade upgrade`       | 全局更新所有包                 |



## 相关链接

- 项目官网：[https://yarn.bootcss.com](https://yarn.bootcss.com/)

