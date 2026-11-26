---
sidebar_position: 2
slug: /nodejs-installation
---

# Node.js 安装



本文介绍如何在 Linux 系统上安装 Node.js 软件工具，可以选择下载 Node.js 源码或预编译安装包，下面以 Ubuntu 为例进行演示。



## 通过二进制文件安装

首先打开 [Node.js 下载](https://nodejs.org/zh-cn/download/) 页面下载所需版本的 Node.js 安装包。本文以当前最新的长期维护版 v16.13.1 为例。

![](https://static.getiot.tech/nodejs-download-page.png#center)

安装步骤如下：

1、下载 node-v16.13.1-linux-x64.tar.xz 到本地并切换到下载目录。

2、将 node-v16.13.1-linux-x64.tar.xz 解压缩到安装目录，这里使用 `/usr/local/lib/nodejs` 目录。

```bash showLineNumbers
 VERSION=v16.13.1
 DISTRO=linux-x64
 sudo mkdir -p /usr/local/lib/nodejs
 sudo tar -xJvf node-$VERSION-$DISTRO.tar.xz -C /usr/local/lib/nodejs 
```

3、在 `~/.profile` 文件末尾设置环境变量。

```bash showLineNumbers
# Nodejs
VERSION=v16.13.1
DISTRO=linux-x64
export PATH=/usr/local/lib/nodejs/node-$VERSION-$DISTRO/bin:$PATH
```

4、刷新环境设置。

```bash
. ~/.profile
```

5、检查是否安装成功。

```bash
$ node -v
$ npm version
$ npx -v
```

上述命令的输出可能如下：

```bash
rudy@Latitude-3420:~$ node -v
v16.13.1
rudy@Latitude-3420:~$ npm version
{
  npm: '8.1.2',
  node: '16.13.1',
  v8: '9.4.146.24-node.14',
  uv: '1.42.0',
  zlib: '1.2.11',
  brotli: '1.0.9',
  ares: '1.18.1',
  modules: '93',
  nghttp2: '1.45.1',
  napi: '8',
  llhttp: '6.0.4',
  openssl: '1.1.1l+quic',
  cldr: '39.0',
  icu: '69.1',
  tz: '2021a',
  unicode: '13.0',
  ngtcp2: '0.1.0-DEV',
  nghttp3: '0.1.0-DEV'
}
rudy@Latitude-3420:~$ npx -v
8.1.2
```



## 设置 npm 源

安装好 Node.js 之后，对于国内的开发者，建议将 npm 源替换为国内的镜像源进行加速。否则很容易在使用 npm 安装软件包时卡住，出现类似于 `timing idealTree:#root Completed` 的问题。

以淘宝镜像源为例，设置的方法如下：

```bash
npm config set registry https://registry.npmmirror.com
```

设置完成后，可通过下面命令验证：

```bash
npm config get registry
```

如果返回 `https://registry.npmmirror.com`，则说明设置成功。

