---
sidebar_label: curl 命令
sidebar_position: 13
slug: /curl
---

# curl 命令



## 介绍

**curl**（英文全拼：CommandLine URL）命令是在命令行方式下工作，利用 URL 的语法进行数据的传输或者文件的传输。

通常大家会把 curl 理解为下载工具，但其实它的功能十分强大。curl 支持包括 HTTP、HTTPS、FTP 等传输协议，还支持 POST、cookies、认证、从指定偏移处下载部分文件、用户代理字符串、限速、文件大小、进度条等功能。甚至可用于网页处理流程和数据检索自动化。

URL 即 Uniform Resource Locator（统一资源定位符），是用于完整地描述 Internet 上网页和其他资源的地址的一种标识方法。比如 `https://getiot.tech` 就是一个 URL。

**语法**：

```bash
curl [options / URLs]
```

**选项**：

- `-a`, `--append` ：上传文件时，附加到目标文件。
- `-A`, `--user-agent <string>` ：设置用户代理发送给服务器。
- `-anyauth` ：可以使用“任何”身份验证方法。
- `-b`, `--cookie <name=string/file>` ：cookie 字符串或文件读取位置。
- `-c`, `--cookie-jar <file>` ：操作结束后把 cookie 写入到这个文件中。
- `-C`, `--continue-at <offset>` ：断点续转。
- `-d`, `--data <data>` ：以 post 的方式传送数据。
- `-D`, `--dump-header <file>` ：把 header 信息写入到该文件中。
- `-e`, `--referer` ：来源网址。
- `-E`, `--cert <cert[:passwd]>` ：客户端证书文件和密码（SSL）。
- `-f`, `--fail` ：连接失败时不显示 http 错误。
- `-F`, `--form <name=content>` ：模拟 http 表单提交数据。
- `-G`, `--get` ：以 get 的方式来发送数据。
- `-H`, `--header <line>` ：自定义头信息传递给服务器。
- `-I`, `--head` ：只显示请求头信息。
- `-o`, `--output <file>` ：写入文件而不是标准输出。
- `-O`, `--remote-name` ：将输出写入与远程文件名字相同的文件。
- `-s`, `--silent` ：静默模式。不输出任何东西。
- `-u`, `--user <user[:password]>` ：设置服务器的用户和密码。
- `-U`, `--proxy-user <user[:password]>` ：设置代理用户名和密码。



## 示例

抓取“人人都懂物联网”网站首页：

```bash
curl https://getiot.tech
```

将网页数据保存到本地文件：

```bash
curl https://getiot.tech > index.html
```

设置 cookies：

```bash
curl https://getiot.tech --cookie "user=root;pass=123456"
```

设置用户代理字符串：

```bash
curl URL --user-agent "Mozilla/5.0"
curl URL -A "Mozilla/5.0"
```

进行 HTTP 或者 FTP 的登录认证（可以指定密码，也可以不指定密码在后续操作中输入密码）：

```bash
curl -u user:pwd https://getiot.tech
curl -u user https://getiot.tech
```

只打印响应头部信息：

```bash
curl -I https://getiot.tech
```

下载远程文件：

```bash
curl -O https://static.getiot.tech/flag-of-china.png
```

下载远程文件，并重命名：

```bash
curl -o test.png https://static.getiot.tech/flag-of-china.png
```

下载远程文件，并显示下载进度：

```bash
curl -# -O https://static.getiot.tech/flag-of-china.png
```

下载并执行 nvm 的安装脚本（`-o-` 选项指定将下载的数据输出到标准输出，而不是保存为文件，这意味着下载的内容会被直接传输到管道）：

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
```

