---
sidebar_position: 14
slug: /wget
---

# wget 命令



## 介绍

**wget** 是一个用于从 web 下载文件的 Linux 命令行工具。支持 HTTP、HTTPS 和 FTP 协议，可以使用 HTTP 代理。

**语法**：

```bash
wget [option]... [URL]...
```

**选项**：

- **启动参数**
  - `-V`, `--version` ：显示版本信息后退出。
  - `-h`, `--help` ：显示帮助信息后退出。
  - `-b`, `--background` ：启动后转入后台执行。
  - `-e`, `--execute=COMMAND` ：执行 .wgetrc 格式的命令（wgetrc 格式参见 /etc/wgetrc 或 ~/.wgetrc）。
- **记录和输入文件参数**
  - `-o`, `--output-file=FILE` ：把记录写到 FILE 文件中。
  - `-a`, `--append-output=FILE` ：把记录追加到 FILE 文件中。
  - `-d`, `--debug` ：打印调试输出。
  - `-q`, `–quiet` ：安静模式（没有输出）。
  - `-v`, `--verbose` ：冗长模式（这是缺省设置）。
  - `-nv`, `--non-verbose` ：关闭冗长模式，但不是安静模式。
  - `-i`, `--input-file=FILE` ：下载在 FILE 文件中出现的 URLs。
  - `-F`, `--force-html` ：把输入文件当作 HTML 格式文件对待。
  - `-B`, `--base=URL` ：将 URL 作为在 `-i` 参数指定的文件中出现的相对链接的前缀。
  - `--sslcertfile=FILE` ：可选客户端证书。
  - `--sslcertkey=KEYFILE` ：可选客户端证书的 KEYFILE。
  - `--egd-file=FILE` ：指定 EGD socket 的文件名。
- **下载参数**
  - `--bind-address=ADDRESS` ：指定本地使用地址（主机名或 IP，当本地有多个 IP 或名字时使用）。
  - `-t`, `--tries=NUMBER` ：设定最大尝试链接次数（0 表示无限制）。
  - `-O`, `--output-document=FILE` ：把文档写到 FILE 文件中。
  - `-nc`, `--no-clobber` ：不要覆盖存在的文件或使用 .# 前缀。
  - `-c`, `--continue` ：接着下载没下载完的文件。
  - `--progress=TYPE` ：设定进程条标记。
  - `-N`, `--timestamping` ：不要重新下载文件除非比本地文件新。
  - `-S`, `--server-response` ：打印服务器的回应。
  - `--spider` ：不下载任何东西。
  - `-T`, `--timeout=SECONDS` ：设定响应超时的秒数。
  - `-w`, `--wait=SECONDS` ：两次尝试之间间隔 SECONDS 秒。
  - `--waitretry=SECONDS` ：在重新链接之间等待 1…SECONDS 秒。
  - `--random-wait` ：在下载之间等待 0…2*WAIT 秒。
  - `-Y`, `--proxy=on/off` ：打开或关闭代理。
  - `-Q`, `--quota=NUMBER` ：设置下载的容量限制。
  - `--limit-rate=RATE` ：限定下载输率。
- **目录参数**
  - `-nd`, `--no-directories` ：不创建目录。
  - `-x`, `--force-directories` ：强制创建目录。
  - `-nH`, `--no-host-directories` ：不创建主机目录。
  - `-P`, `--directory-prefix=PREFIX` ：将文件保存到目录 `PREFIX/…`。
  - `--cut-dirs=NUMBER` ：忽略 NUMBER 层远程目录。
- **HTTP 选项参数**
  - `--http-user=USER` ：设定 HTTP 用户名为 USER。
  - `--http-passwd=PASS` ：设定 http 密码为 PASS。
  - `-C`, `--cache=on/off` ：允许/不允许服务器端的数据缓存（一般情况下允许）。
  - `-E`, `--html-extension` ：将所有 text/html 文档以 .html 扩展名保存。
  - `--ignore-length` ：忽略 `Content-Length` 头域。
  - `--header=STRING` ：在 headers 中插入字符串 STRING。
  - `--proxy-user=USER` ：设定代理的用户名为 USER。
  - `--proxy-passwd=PASS` ：设定代理的密码为 PASS。
  - `--referer=URL` ：在 HTTP 请求中包含 `Referer: URL` 头。
  - `-s`, `--save-headers` ：保存 HTTP 头到文件。
  - `-U`, `--user-agent=AGENT` ：设定代理的名称为 AGENT 而不是 Wget/VERSION。
  - `--no-http-keep-alive` ：关闭 HTTP 活动链接（永久链接）。
  - `--cookies=off` ：不使用 cookies。
  - `--load-cookies=FILE` ：在开始会话前从文件 FILE 中加载 cookie。
  - `--save-cookies=FILE` ：在会话结束后将 cookies 保存到 FILE 文件中。
- **FTP 选项参数**
  - `-nr`, `–dont-remove-listing` ：不移走 .listing 文件。
  - `-g`, `--glob=on/off` ：打开或关闭文件名的 globbing 机制。
  - `--passive-ftp` ：使用被动传输模式（缺省值）。
  - `--active-ftp` ：使用主动传输模式。
  - `--retr-symlinks` ：在递归的时候，将链接指向文件（而不是目录）。
- **递归下载参数**
  - `-r`, `--recursive` ：递归下载。
  - `-l`, `--level=NUMBER` ：最大递归深度（inf 或 0 代表无穷）。
  - `--delete-after` ：在现在完毕后局部删除文件。
  - `-k`, `--convert-links` ：转换非相对链接为相对链接。
  - `-K`, `--backup-converted` ：在转换文件 X 之前，将之备份为 X.orig。
  - `-m`, `--mirror` ：等价于 `-r -N -l inf -nr`。
  - `-p`, `--page-requisites` ：下载显示 HTML 文件的所有图片。
- **递归下载中的包含和不包含**（accept/reject）
  - `-A`, `--accept=LIST` ：分号分隔的被接受扩展名的列表。
  - `-R`, `--reject=LIST` ：分号分隔的不被接受的扩展名的列表。
  - `-D`, `--domains=LIST` ：分号分隔的被接受域的列表。
  - `--exclude-domains=LIST` ：分号分隔的不被接受的域的列表。
  - `--follow-ftp` ：跟踪 HTML 文档中的 FTP 链接。
  - `--follow-tags=LIST` ：分号分隔的被跟踪的 HTML 标签的列表。
  - `-G`, `--ignore-tags=LIST` ：分号分隔的被忽略的 HTML 标签的列表。
  - `-H`, `--span-hosts` ：当递归时转到外部主机。
  - `-L`, `--relative` ：仅仅跟踪相对链接。
  - `-I`, `--include-directories=LIST` ：允许目录的列表。
  - `-X`, `--exclude-directories=LIST` ：不被包含目录的列表。
  - `-np`, `--no-parent` ：不要追溯到父目录。



## 示例

**下载单个文件**

```bash
wget https://github.com/getiot/helloworld/archive/refs/tags/v1.0.zip
```

**下载并以指定文件名保存**（wget 默认会以最后一个符号 `/` 后面的字符来命名下载文件）

```bash
wget -O helloworld.zip https://github.com/getiot/helloworld/archive/refs/tags/v1.0.zip
```

**限速下载**（wget 默认会占用全部可能的宽带下载，当需要下载大文件时，就有必要进行限速）

```bash
wget --limit-rate=300k https://github.com/getiot/helloworld/archive/refs/tags/v1.0.zip
```

**断点续传**（使用 -c 选项可以在重新启动 wget 时继续接着下载，而不是重新下载一个文件）

```bash
wget -c https://github.com/getiot/helloworld/archive/refs/tags/v1.0.zip
```

**后台下载**

```bash
wget -b https://github.com/getiot/helloworld/archive/refs/tags/v1.0.zip

Continuing in background, pid 1840.
Output will be written to `wget-log'.
```

对于下载非常大的文件的时候，我们可以使用 `-b` 选项进行后台下载，输出记录在 wget-log 文件，可以使用以下命令查看下载进度：

```bash
tail -f wget-log
```

**伪装代理名称下载**（有些网站能通过根据判断代理名称不是浏览器而拒绝你的下载请求，可以通过 `--user-agent` 选项参数伪装）

```bash
wget --user-agent="Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16" https://github.com/getiot/helloworld/archive/refs/tags/v1.0.zip
```

**增加重试次数**（wget 默认重试 20 次连接下载文件）

```bash
wget --tries=40 https://github.com/getiot/helloworld/archive/refs/tags/v1.0.zip
```

**下载多个文件**

```bash
wget -i filelist.txt
```

filelist.txt 文件记录下载链接文件，例如：

```bash
cat > filelist.txt
https://github.com/getiot/helloworld/archive/refs/tags/v1.0.zip
https://github.com/getiot/helloworld/archive/refs/tags/v2.0.zip
https://github.com/getiot/helloworld/archive/refs/tags/v3.0.zip
...
```

**镜像网站**（下载整个网站到本地）

```bash
wget --mirror -p --convert-links -P ./LOCAL <URL>
```

说明：

- `--miror` 开启镜像下载。
- `-p` 下载所有为 html 页面显示正常的文件。
- `--convert-links` 下载后，转换成本地的链接。
- `-P ./LOCAL` 保存所有文件和目录到本地指定目录。

**过滤指定格式下载**（下载一个网站，但不希望下载图片）

```bash
wget --reject=gif <URL>
```

**把下载信息存入日志文件**

```bash
wget -o download.log <URL>
```

**限制总下载文件大小**（如果下载的文件超过 5M 则退出下载，该选项只对递归下载有效）

```bash
wget -Q5m -i filelist.txt
```

**下载指定格式文件**

```bash
wget -r -A.pdf <URL>
```

可以在以下情况使用该功能：

- 下载一个网站的所有图片。
- 下载一个网站的所有视频。
- 下载一个网站的所有 PDF 文件。

**FTP 下载**

```bash
wget --ftp-user=USERNAME --ftp-password=PASSWORD <URL>
```

