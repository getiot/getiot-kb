---
sidebar_position: 2
slug: /go-environment
---

# Go 语言开发环境

Go 语言支持 Linux、Windows 和 macOS 等主流操作系统。你可以在 [这里](https://golang.google.cn/dl/) 下载 Go 语言的安装包。

例如当前最新的稳定版本 1.22.1：

| 系统平台             | 安装包                      | 备注                              |
| -------------------- | --------------------------- | --------------------------------- |
| Microsoft Windows    | go1.22.1.windows-amd64.msi  | 支持 Windows 10 及以上版本        |
| Apple macOS (ARM64)  | go1.22.1.darwin-arm64.pkg   | 支持 macOS 11 及以上版本          |
| Apple macOS (x86-64) | go1.22.1.darwin-amd64.pkg   | 支持 macOS 10.15 及以上版本       |
| Linux                | go1.22.1.linux-amd64.tar.gz | 支持 Linux 内核 2.6.32 及以上版本 |
| Source               | go1.22.1.src.tar.gz         | 源代码                            |



## Linux 安装方法

以下介绍了在 Linux（类 Unix）系统下使用源码安装方法：

1. 下载 Go 语言的安装包。

   ```bash
   wget https://golang.google.cn/dl/go1.22.1.linux-amd64.tar.gz
   ```

2. 将下载的源码包解压至 `/usr/local`目录。

   ```bash
   tar -C /usr/local -xzvf go1.22.1.linux-amd64.tar.gz
   ```

3. 将 `/usr/local/go/bin` 目录添加至 `PATH` 环境变量。

   ```bash
   export PATH=$PATH:/usr/local/go/bin
   ```

4. 打开一个新的终端，执行 `go version` 命令可验证是否安装成功。

   ```bash
   $ go version
   go version go1.22.1 linux/amd64
   ```

注意：在 macOS 系统中，你可以使用 .pkg 结尾的安装包直接双击来完成安装，安装在 `/usr/local/go` 目录下，并将安装路径 `/usr/local/go/bin` 配置到变量环境中。



## Windows 系统下安装

Windows 下可以使用 .msi 后缀的安装包来安装，例如 go1.22.1.windows-amd64.msi。默认情况下，.msi 文件会安装在 `C:\Program Files\Go` 目录下。你可以指定安装目录并将其添加到 `PATH` 环境变量中，这样就可以在命令窗口中使用 go 命令。

![](https://static.getiot.tech/golang-install-on-windows-01.jpeg#center-600)



### 配置 GOPROXY

Go 1.22.1 版本之后，开始使用 go mod 模式来管理依赖环境。由于国内访问不到默认的 `GOPROXY` 配置链接，所以我们需要换一个 PROXY，这里推荐使用 `https://goproxy.io` 或 `https://goproxy.cn`。

执行下面的命令修改 `GOPROXY` 配置：

```bash
go env -w GOPROXY=https://goproxy.cn,direct
```

### GO MOD 设置

要启用 go module 支持首先要设置环境变量 `GO111MODULE`，通过它可以开启或关闭模块支持，它有三个可选值：off、on、auto，默认值是 auto。

- `GO111MODULE=off` 禁用模块支持，编译时会从 `GOPATH` 和 vendor 文件夹中查找包。
- `GO111MODULE=on` 启用模块支持，编译时会忽略 `GOPATH` 和 vendor 文件夹，只根据 go.mod 下载依赖。
- `GO111MODULE=auto`，当项目在 `$GOPATH/src` 外且项目根目录有 go.mod 文件时，开启模块支持。

通过以下命令修改：

```bash
go env -w GO111MODULE=on
```

使用 go module 模式新建项目时，我们需要通过 `go mod init` 项目名命令对项目进行初始化，该命令会在项目根目录下生成 go.mod 文件。例如，我们使用 hello 作为我们第一个 Go 项目的名称，执行如下命令。

```bash
go mod init hello
```

运行之前可以使用 `go mod tidy` 命令将所需依赖添加到 go.mod 文件中，并且能去掉项目中不需要的依赖。



## 安装测试

在工作区创建一个 hello.go 文件，代码如下：（示例代码可通过 [GitHub](https://github.com/getiot/go-courses) 获取）

```go
package main

import "fmt"

func main() {
    fmt.Println("Hello, World!")
}
```

打开终端，切换到 hello.go 文件所在目录，执行 `go run hello.go` 命令运行 hello.go 代码。输出结果如下：

```bash
$ go run hello.go
Hello, World!
```
