---
sidebar_position: 52
slug: /picture-host-management-software
---

# 图床管理工具

![](https://static.getiot.tech/picture-host-management-software-banner.webp)

**图床**（Image Hosting Service）是专门用于存储和托管图片的在线服务。用户将图片上传到图床服务器后，会生成一个公开的访问链接（URL），可以直接嵌入到网页、博客、社交媒体或其他应用中，无需将图片存储在本地服务器上。

国内外常见图床平台有七牛云、Imgur、Cloudinary、阿里云 OSS、腾讯云 COS、GitHub 等。图床除了提供上传、存储、访问、删除等基本功能，通常还提供图片格式转换、压缩、裁剪、打水印等图片处理功能，以及防盗链、访问权限等安全相关功能。

图床平台通常会提供网页端的操作界面，但有时候操作起来不是很方便，这个时候就需要用到图床管理工具来提高效率了。本文收集并整理了一些好用的图床管理工具，使用这些工具可以高效地完成图片文件上传、删除等管理工作。



## PicGo

PicGo 是一个用于快速上传图片并获取图片 URL 链接的开源工具，支持七牛云、腾讯云 COS、阿里云 OSS、GitHub、Imgur 等 20 多种图床。PicGo 提供图形界面和命令行工具（PicGo-Core），支持 Windows、Linux、macOS 操作系统，并且提供插件系统来增加扩展功能（如文件管理、资源检测）。

PicGo 基于 Electron + Vue 开发，可通过 `npm` 命令安装，安装命令如下：

```bash
npm install -g picgo
```

使用示例：

- 上传图片

  ```bash
  picgo upload /path/to/image.jpg
  ```

- 配置图床

  ```bash
  picgo set uploader
  ```

GitHub 地址：[https://github.com/Molunerfinn/PicGo](https://github.com/Molunerfinn/PicGo)



## PicFlow

**PicFlow** 是一个用于自动化处理（缩放/压缩）图片并上传到云存储平台（如七牛云）的命令行工具，它使用 Python 语言编写，支持 Windows、Linux 和 macOS。除了上传功能外，PicFlow 还提供了许多图片处理功能，包括缩放、格式转换、质量压缩等等，它的目标是成为一个好用的图片处理和上传工具。

使用 `pip` 命令即可安装 PicFlow：

```bash
pip install picflow
```

使用前需要执行 `picflow config init` 命令配置 `ACCESS_KEY` 和 `SECRET_KEY` 等信息。

PicFlow 通过 process、batch、upload、info 等子命令提供相应的功能，下面是一些命令示例：

```bash
# 压缩为 WebP 并上传
picflow process --format webp --quality 85 ~/images/photo.jpg
# 递归处理整个文件夹
picflow batch ~/gallery --scale 50% --output ~/compressed_gallery
# 直接上传图片
picflow upload ~/images/photo.jpg
# 同时上传多张图片
picflow upload test.jpg test2.jpg test3.jpg
# 先处理后上传图片
picflow process --scale 256 --format webp --quality 85 test.jpg
```



## qshell

qshell 是七牛云官方提供的命令行工具，支持文件上传、删除、批量管理、资源状态查询。它使用 Go 语言开发，支持 Windows、Linux、macOS 操作系统。 但由于是七牛云专用的工具，因此不支持其他图床。

qshell 工具有两类命令，一类需要鉴权，另一类不需要。上传、删除等操作是需要鉴权的命令，所以这类命令运行之前，需要使用 `account` 命令来设置七牛账号的 `AccessKey` 和 `SecretKey`。设置命令如下：

```bash
qshell account <AccessKey> <SecretKey> <name>
```

其中，`name` 表示该账号的名称，它是本地记录的账户名称，用户可以任意设置。

另外，如果参数首字母是 `-`，那么需要使用 `--` 选项来避免把该项识别成命令行选项。如下：

```bash
qshell account -- <AccessKey> <SecretKey> <name>
```

如果你有多个七牛云账号，可以连续使用 `qshell account` 命令添加账号信息，qshell 会保存这些账号的信息。添加完成后，可以使用 `qshell user` 命令列举账号信息，切换账号或删除账号等。

```bash
# 上传文件
qshell fput <Bucket> <Key> <LocalFile>
# 删除文件
qshell delete <Bucket> <Key>
# 列出文件
qshell listbucket <Bucket>
```

GitHub 地址：[https://github.com/qiniu/qshell](https://github.com/qiniu/qshell)



## uPic

uPic（upload Picture）是一款 Mac 端的图床（文件）上传客户端，可将图片、各种文件上传到配置好的指定提供商的对象存储中。然后快速获取可供互联网访问的文件 URL。

通过 Homebrew 安装：

```bash
brew install bigwig-club/brew/upic --cask
```

GitHub 地址：[https://github.com/gee1k/uPic](https://github.com/gee1k/uPic)



## PicUploader

PicUploader 是一个用 PHP 语言开发的图床工具，它简化了图片上传流程，帮助你快速将你的图片上传到云图床，并自动返回 Markdown 格式链接到剪贴板，特别适合应用于各类文档和博客文章编写流程中。

- 支持 Windows、Linux、MacOS 服务器；
- 支持压缩后上传、添加图片或文字水印；
- 支持多文件同时上传，以及同时上传到多个云；
- 支持右击任意文件上传、快捷键上传剪贴板截图、Web 版上传；
- 支持作为 Mweb、Typora 发布图片接口、作为 PicGo、ShareX、uPic 等的自定义图床；
- 支持在服务器上部署作为图床接口，支持上传任意格式文件。

GitHub 地址：[https://github.com/xiebruce/PicUploader](https://github.com/xiebruce/PicUploader)



## Cloudinary CLI

Cloudinary CLI 是 Cloudinary 平台提供的命令行工具，用于通过终端直接管理云端存储的图片、视频等资源。它允许开发者无需登录网页控制台即可完成上传、转换、删除、搜索等操作，适合集成到自动化脚本或 CI/CD 流程中。

Cloudinary CLI 是用 Python 语言开发的工具，可通过 pip 命令安装：

```bash
pip3 install cloudinary-cli
```

安装完成后会有一个 `cld` 命令，下面是常用的几个命令：

```bash
cld --help         # Lists available commands.
cld search --help  # Shows usage for the Search API.
cld admin          # Lists Admin API methods.
cld uploader       # Lists Upload API methods.
```

GitHub 地址：[https://github.com/cloudinary/cloudinary-cli](https://github.com/cloudinary/cloudinary-cli)

