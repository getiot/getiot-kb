---
sidebar_position: 3
slug: /go-commands
---

# Go 命令行工具

Go 语言提供了一系列实用的 Go 命令来简化程序的开发、构建和测试过程。安装 Go 语言开发环境后，即可使用 Go 命令行工具。

## 命令概览

Go 命令功能非常丰富，包含了一系列子命令，其语法格式如下：

```bash
go <command> [arguments]
```

下表列出了 Go 子命令及其简要说明。

| 子命令   | 说明                                                   | 示例                  |
| -------- | ------------------------------------------------------ | --------------------- |
| bug      | 在默认浏览器打开 go 的 GitHub 页面报告 Bug。           | `go bug`              |
| build    | 编译指定的源码文件或代码包及其依赖。                   | `go build hello.go`   |
| clean    | 清除执行其他 go 命令后遗留的目录和文件。               | `go clean`            |
| doc      | 显示软件包或符号的文档。                               | `go doc`              |
| env      | 打印 Go 的环境变量。                                   | `go env`              |
| fix      | 更新软件包以使用新的 API。                             | `go fix hello.go`     |
| fmt      | 重新格式化指定源码文件或软件包源代码，等效于 `gofmt`。 | `go fmt hello.go`     |
| generate | 通过源代码生成 Go 文件。                               | `go generate`         |
| get      | 将依赖项添加到当前模块并安装它们。                     | `go get <git-repo>`   |
| help     | 打印 Go 命令、子命令或变量的帮助信息。                 | `go help gopath`      |
| install  | 编译并安装软件包和依赖项。                             | `go install hello.go` |
| list     | 列出包或模块。                                         | `go list`             |
| mod      | 用于模块维护。                                         | `go mod init hello`   |
| work     | 用于工作空间维护。                                     | `go work sync`        |
| run      | 编译并运行 Go 程序。                                   | `go run hello.go`     |
| test     | 测试软件包。                                           | `go test hello.go`    |
| tool     | 运行指定的 go 工具。                                   | `go tool fix`         |
| version  | 打印 Go 的版本信息。                                   | `go version`          |
| vet      | 报告软件包中可能存在的错误。                           | `go vet hello.go`     |



## go env

env 子命令用于打印 Go 语言环境信息。命令语法如下：

```bash
go env [-json] [-u] [-w] [var ...]
```

打印 Go 语言所有的环境变量：

```bash
$ go env
GO111MODULE=''
GOARCH='amd64'
GOBIN=''
GOCACHE='/home/rudy/.cache/go-build'
GOENV='/home/rudy/.config/go/env'
```

打印 `GOPATH` 环境变量：

```bash
$ go env GOPATH
/home/rudy/go
```

同时打印多个环境变量：

```bash
$ go env GOROOT GOPATH
/usr/local/go
/home/rudy/go
```



## go build

build 子命令用于编译给定的代码包或 Go 语言源码文件及其依赖包，但不安装编译结果。命令语法如下：

```bash
go build [-o output] [build flags] [packages]
```

编译 hello.go 文件，生成 hello 可执行文件：

```bash
$ go build hello.go
```

编译 hello.go 文件并指定输出文件名，生成 world 可执行文件：

```bash
$ go build -o world hello.go
```

在模块目录中，直接执行 `go build` 即可编译：

```bash
$ go build
```



## go install

install 子命令用于编译包文件并在编译完成后将结果文件安装到指定目录。实际上，go install 比 go build 就多了一个安装步骤。命令语法如下：

```bash
go install [build flags] [packages]
```

编译指定的 hello.go 文件，并安装输出的可执行文件：

```bash
$ go install hello.go
```

在模块目录中编译并安装：

```bash
$ go install
```

可执行文件安装在由 `GOBIN` 环境变量命名的目录中，如果未设置 `GOBIN` 环境变量，则默认安装目录为 `~/go/bin/`。



## go get

get 子命令用于下载和安装指定软件包及其依赖，并更新 go.mod 文件。通常默认从 Git 仓库拉取软件包的最新版本，因此需要提前安装 git 工具。命令语法如下：

```bash
go get [-t] [-u] [-v] [build flags] [packages]
```

安装软件包依赖项或者将其升级到最新版本：

```bash
$ go get example.com/pkg
```

将软件包升级或降级到特定版本：

```bash
$ go get example.com/pkg@v1.2.3
```

删除模块依赖项并降级需要它的模块：

```bash
$ go get example.com/mod@none
```

将 Go 版本升级到最新版本：

```bash
$ go get go@latest
```

将 Go 工具链升级到当前 Go 工具链的最新补丁版本：

```bash
$ go get toolchain@patch
```



## go mod

mod 子命令提供对模块操作的访问。命令语法如下：

```bash
go mod <command> [arguments]
```

其中，command 包括：

- `download`：将模块下载至本地缓存。
- `edit`：通过工具或脚本编辑 go.mod。
- `graph`：打印模块要求图表。
- `init`：在当前目录中初始化新模块。
- `tidy`：添加缺失的模块并删除未使用的模块。
- `vendor`：制作依赖项的供应商副本（vendored copy）。
- `verify`：验证依赖项是否具有预期内容。
- `why`：解释为什么需要软件包或模块。

在当前目录初始化 hello 模块：

```bash
$ go mod init hello
go: creating new go.mod: module hello
```

此时会生成 go.mod 文件，内容如下：

```go
module hello

go 1.22.0
```

查看模块依赖列表：

```bash
$ go mod graph
hello go@1.22.0
go@1.22.0 toolchain@go1.22.0
```



## go run

run 子命令用于编译并运行给定的命令源码文件。命令语法如下：

```bash
go run [build flags] [-exec xprog] package [arguments...]
```

编译 main.go 文件并运行生成的可执行文件：

```bash
$ go run main.go
```



## go fix

fix 子命令用于修正指定软件包的源码文件中包含的过时语法和代码调用。命令语法如下：

```bash
go fix [-fix list] [packages]
```

通过指定文件，修复 main.go 文件中的代码：

```bash
$ go fix main.go
```

