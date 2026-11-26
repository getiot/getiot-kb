---
sidebar_position: 6
sidebar_label: 网络代理配置
slug: /linux-network-configuration
authors: [luhuadong]
---

# Linux 网络配置



## 网络代理

网络代理是一种特殊的网络服务，客户端通过网络代理与真正要访问的服务端通信，再由代理将服务端的数据传送回客户端。使用代理有利于保障网络终端的隐私和安全，或者访问本地网络无法直接连通的服务器资源。

### 配置终端网络代理

代理服务器类型通常有 SOCKS5 和 HTTP(S) 两种，以架设在本机的代理服务器为例，例如使用 SOCKS5 通信，本地端口为 1080，那么代理服务的 URL 就是：

```bash
socks5://127.0.0.1:1080
```

要实现在终端使用网络代理，只需要设置环境变量 `http_proxy` 和 `https_proxy` 即可。例如：

```bash
export http_proxy="socks5://127.0.0.1:1080"
export https_proxy="socks5://127.0.0.1:1080"
```

如果使用的不是 SOCKS5 协议，而是 HTTP 协议的代理，则如下设置：

```bash
export http_proxy="http://127.0.0.1:1080"
export https_proxy="http://127.0.0.1:1080"
```

如果觉得设置两行有点麻烦，可以直接设置 `ALL_PROXY` 变量：

```bash
export ALL_PROXY="socks5://127.0.0.1:1080"
```

上述配置只会在当前终端生效，如果想要保存网络代理配置，可以将上面内容写入 shell 配置文件（例如 .bashrc 或者 .zshrc），这样每次打开终端都会自动执行配置。

还可以通过 alias 设置别名：

```bash
alias setproxy="export ALL_PROXY=socks5://127.0.0.1:1080"
alias unsetproxy="unset ALL_PROXY"
```

这样当终端需要（或者不需要）走代理时，就可以通过 setproxy 和 unsetproxy 命令快速配置。

配置完成后，可以通过下面命令检查终端是否处于代理状态。

```bash
curl cip.cc
```



### 配置 apt 网络代理

以 Ubuntu 为例，所有 apt 相关的配置文件都位于 /etc/apt/apt.conf.d 目录下。我们可以在该目录下创建一个专门用于网络代理的配置文件，这样可以避免弄脏其他配置文件。

1. 创建 proxy.conf 配置文件

   ```bash
   sudo touch /etc/apt/apt.conf.d/proxy.conf
   ```

2. 编辑 proxy.conf 文件，添加如下内容，配置 HTTP 和 HTTPS 代理

   ```bash
   Acquire::http::Proxy "http://user:password@proxy.server:port/";
   Acquire::https::Proxy "http://user:password@proxy.server:port/";
   ```

   用户名和密码可以省略，例如：

   ```bash
   Acquire::http::Proxy "socks5://127.0.0.1:1080";
   Acquire::https::Proxy "socks5://127.0.0.1:1080";
   ```

3. 保存，退出。

   网络代理配置将在下次运行 apt 时生效。



### 配置 git 网络代理

设置代理

```bash
git config --global http.proxy 'socks5://127.0.0.1:1080' 
git config --global https.proxy 'socks5://127.0.0.1:1080'
```

取消代理

```bash
git config --global --unset http.proxy
git config --global --unset https.proxy
```



### 配置浏览器网络代理




