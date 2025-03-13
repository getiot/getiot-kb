---
sidebar_position: 49
---

# 局域网文件传输工具

![局域网文件传输/共享工具](https://static.getiot.tech/lan-file-sharing.png#center)

本文分享一些好用的局域网文件传输（文件共享）工具，通过这类工具，你可以很方便地在同一个网络中的多台设备之间分享文件。例如，在两台电脑之间传送文档、将手机的照片传送到电脑等等。

当然，你使用像微信、QQ、飞书等常见聊天或办公软件也可以达到传输文件的目的，但这些软件都太重了，有时候并不是一个很好的选择。有时候，你只是想在同一个网络中的两台设备间快速传送一个文件而已，你并不想扫描二维码登录、也不需要连接互联网（Internet）。

相对来说，使用专用的局域网文件传输工具，具有以下几个好处：

1. **隐私、安全性**

   使用局域网共享文件的好处之一是它天生提供的隐私。由于文件仅在同一网络上的设备之间传输，因此无需担心文件被网络外的人拦截。

2. **不需要 Internet**

   局域网传输文件的另一个显着优点是它不需要互联网连接，这在互联网访问受限或不可用的情况下特别有用。

3. **传输速度快**

   由于局域网内的设备彼此靠得更近，不需要经过复杂的中继网络设备，因此局域网传输文件通常比通过 Internet 传输文件快得多。

下面是我们收集的一些好用的局域网文件传输/共享工具，按照惯例，我们会尽量提供最好的开源和免费的应用程序，任何人都可以免费下载、使用甚至修改它。



## 飞秋/飞鸽传书

飞秋（FeiQ）曾经是个非常好用的局域网通信软件，不仅可以传输文件，还可以聊天，可惜现在几乎不更新了。其中一个原因是因为飞秋是在飞鸽传书 IPMSG 协议上开发的，由于当时的飞鸽传书界面很丑且不怎么更新，于是就有程序员在此基础上开发了飞秋。而后来飞鸽传书又恢复了更新，并提供桌面端和移动端的多端支持，不过移动端的更新较慢。

如果你只是想在电脑上传输文件，那么它们还算是一个不错的选择。

- [飞秋 FeiQ 官网](https://www.feiq.cn)
- [飞鸽传书官网](http://www.ipmsg.org.cn)



## AirDrop（隔空投送）

AirDrop 是苹果公司 iOS、iPadOS 和 macOS 系统下特有的功能，用于在多台设备之间分享文件，只要将文件拖动到使用隔空投送功能的好友的头像上，就能进行一对一的文件传输（类似于无线网络传输）。

AirDrop 的工作原理是先利用蓝牙来发现和握手，然后建立点对点的 Wi-Fi 连接来传输文件。如果你用的都是苹果的设备，那么 AirDrop 会是一个非常方便的工具。

参考：[在 Mac 上使用“隔空投送”](https://support.apple.com/zh-cn/102538)



## LocalSend

LocalSend 是一个免费、开源、跨平台的应用程序，它可以将文件共享到附近的设备。你不需要连接互联网，不需要外部服务器，只需通过本地 LAN 网络即可发送文件和消息。LocalSend 使用 Flutter 技术开发，提供多端支持，包括 Android、iOS、macOS、Windows 和 Linux 等系统都可以使用。

LocalSend 是一个开源软件，使用 MIT 许可证，你可以在 [GitHub](https://github.com/localsend/localsend) 找到它的源码以及各平台的安装包。

![LocalSend 局域网文件传输工具](https://static.getiot.tech/LocalSend-02.png#center)



## ShareDrop

ShareDrop 是一款受 Apple AirDrop 服务启发的 Web 应用程序，它允许你直接在设备之间传输文件，而无需先将它们上传到任何服务器。它使用 [WebRTC](https://webrtc.org) 进行安全的点对点（peer-to-peer）文件传输，并使用 [Firebase](https://www.firebase.com) 进行状态管理和 WebRTC 信令。

ShareDrop 允许你将文件发送到同一本地网络中的其他设备（即在相同 IP 网段的设备），无需任何配置，只需在这些设备上打开 [https://www.sharedrop.io](https://www.sharedrop.io)，它们就会看到对方。操作方法是单击页面右上角的“+”按钮，此时会创建一个具有唯一 URL 的房间，并与你想要向其发送文件的其他人共享此 URL 或二维码。一旦你在其设备上的浏览器中打开此页面，就会看到彼此的头像。现在，多个设备之间就可以在网络中传送文件了。

![ShareDrop 传送文件](https://static.getiot.tech/ShareDrop.png#center)

ShareDrop 和 AirDrop 之间的主要区别在于，ShareDrop 需要互联网连接才能发现其他设备，而 AirDrop 不需要互联网连接，因为它在它们之间创建了临时无线网络。另一方面，ShareDrop 允许你在移动设备（Android 和 iOS）和桌面设备之间甚至网络之间共享文件。

ShareDrop 是一个开源软件，使用 MIT 许可证，你可以在 [GitHub](https://github.com/szimek/sharedrop) 找到它的源码。



## EZShare

Ezshare 是一款开源的局域网文件共享软件，允许用户在同一网络上的设备之间共享文件，就像是一个不需要连接互联网的 Google Drive。它的设计易于使用和配置，具有简单的基于 Web 的界面，允许用户快速创建共享文件夹并管理访问权限，用户还可以设置密码保护以增加安全性。

EZShare 后端基于 Node.js 实现，你可以在 [GitHub](https://github.com/mifi/ezshare) 上找到它。



## LAN Share

LAN Share 是另一个开源局域网文件共享软件，允许用户在同一网络上的设备之间共享文件。LAN Share 的设计易于使用，并提供许多功能，例如拖放文件共享、无大小限制的文件传输，以及用于增强安全性的端到端加密等等。

LAN Share 基于 Qt 框架实现，使用 GPLv3 许可证，你可以在 [GitHub](https://github.com/abdularis/LAN-Share) 找到它。此外，[官方 LAN Share 网站](https://appimage.github.io/LANShare/) 上还有 AppImage 包可供下载。 

![LAN Share 局域网文件共享软件](https://static.getiot.tech/LAN-Share.png#center)



## croc（命令行工具）

**`croc`** 是一个简单但功能强大的命令行工具，使用它你可以在任何两台计算机简单、安全地传输文件和文件夹。 据我所知，*croc* 是唯一可以执行以下操作的 CLI 文件传输工具：

- 允许任何两台计算机传输数据（使用中继）
- 提供端到端加密（使用 PAKE）
- 实现轻松的跨平台传输（Windows、Linux、Mac）
- 允许多个文件传输
- 允许恢复中断的传输
- 不需要本地服务器或端口转发
- ipv6 优先，ipv4 后备
- 可以使用代理，如 Tor

Corc 使用 Go 语言编写，采用 MIT 许可证，你可以在 [GitHub](https://github.com/schollz/croc) 找到它。

发送一个文件的命令如下：

```bash
$ croc send [file(s)-or-folder]
Sending 'file-or-folder' (X MB)
Code is: code-phrase
```

在另一台设备输入以下命令接收该文件：

```bash
$ croc code-phrase
```

这里的 *code-phrase* 用于建立密码验证密钥协议（PAKE），该协议为发送者和接收者生成用于端到端加密的密钥。



<!--

---



## Updog

Updog 是 Python 的 `SimpleHTTPServer` 的替代品。它允许通过 HTTP/S 上传和下载，可以设置临时 SSL 证书并使用 HTTP 基本身份验证。

安装方式：

```bash
pip3 install updog
```

[GitHub](https://github.com/sc0tfree/updog)



## Airshare

Airshare is a Python-based tool that transfers data between two machines in a local network using Multicast-DNS. It also provides a non-CLI HTTP gateway. The tool is completely offline and supports blazing fast content transfer within a local network. It lets you transfer plain text and files.

Additionally, it supports transfer of multiple files, directories and large files, and can be used as a module in other Python programs. Airshare is cross-platform, working on Linux, Windows, and Mac, and also supports mobile devices. Furthermore, it uses Multicast-DNS service registration and discovery, making content easily accessible with human-readable codes.

[GitHub](https://github.com/KuroLabs/Airshare)



## D-LAN

[GitHub](https://github.com/Ummon/D-LAN)



## LANDrop

[LANDrop](https://landrop.app/)

[GitHub](https://github.com/LANDrop/LANDrop)



---



## Node.js-LAN-File-Sharing

This is a small Node.js app designed for sharing files while on the same network. Especially useful when you are trying to get a file from a friend and their device has a single broken USB port.

Once installed, it creates a local web server that enables you to share files and access them from your network.

**Its features include:**

- Easy to use Drag and Drop file upload.
- Faster than uploading to a server then downloading since you are the server.
- Works with large files (tested with >2gb).
- The page opens fast due to being lightweight. (Native JS + Vue 2)

The main disadvantage of this app is that it requires technical skills to setup and use.



## LanXchange

LanXchange is a simple tool for spontaneous, local network file transfers. Supports Windows, macOS and Linux PCs and Android phones.

It is written in Java and work in portable mode. It also supports multiple file transfers, large file transfers and allows you to exchange, share and transfer files between different systems, platforms, and devices.

LanXchange is released under the GPL-3.0 License.



## ffsend

ffsend is a command-line terminal app that allow you to share files and directory easy. All files are always encrypted on the client, and secrets are never shared with the remote host. An optional password may be specified, and a default file lifetime of 1 (up to 20) download or 24 hours is enforced to ensure your stuff does not remain online forever.

ffsend works on Windows, macOS, FreeBSD and Linux. It is also can be installed using Docker.

**ffsend features include:**

- Fully featured and friendly command line tool
- Upload and download files and directories securely, always encrypted on the client
- Additional password protection, generation and configurable download limits
- File and directory archiving and extraction
- Built-in share URL shortener and QR code generator
- Supports Send v3 (current) and v2
- History tracking your files for easy management
- Ability to use your own Send hosts
- Inspect or delete shared files
- Accurate error reporting
- Streaming encryption and uploading/downloading, very low memory footprint
- Intended for use in [scripts](https://github.com/timvisee/ffsend#scriptability) without interaction

This project is released under the **GNU GPL-3.0** license.



## Transmitic Beta

Transmitic is a secure program for sharing and transferring files directly between users. It is built with Rust, has no file size limit, and allows for download pause and resume. You can add users and choose which files and folders to share with them. The goal is to simplify the process of transferring files between computers. If you have ever wanted to send files directly from one computer to another, Transmitic can help.



## Hansip

Hansip is a robust and secure file-sharing server that provides users with an easy and effective way to share files with others. It is suitable for individuals who want to share personal files and small to medium organizations that need to share confidential documents.

One of the most significant features of Hansip is its End-to-End encryption, which ensures that only authorized users can access your files. This feature provides an added layer of security that is essential for anyone who values their privacy and wants to keep their files safe.

In addition to its security features, Hansip is extremely user-friendly. Its interface is simple and intuitive, enabling you to upload and share files with others quickly and easily. Furthermore, Hansip is scalable, making it easy to adapt to your organization's growing needs. You can easily create new users and groups, set permissions, and manage your files from a central dashboard.

[GitHub](https://github.com/slaveofcode/hansip)



## [Sharing GUI](https://github.com/imyuanx/sharing-GUI)

Sharing GUI is a simple tool that enables easy file sharing to multiple devices on the LAN or public network. With Sharing GUI, you can share files to multiple devices on the LAN or public network using only one client, while other devices can use the web. The client supports macOS, Windows, and Linux.

Sharing GUI allows you to download your files on other devices, accept files on other devices, and access your clipboard on other devices. It supports both LAN and public network, identity authentication, and ngrok for quickly sharing to the public network.



## ShareBox

Sharebox is a powerful web-based file management application designed to make file-sharing a breeze. With its user-friendly interface, you can easily share files from your host machine to any device on your local network or over the internet in just a few clicks.

What's more, Sharebox requires minimal or zero configuration, making it a great tool for users who are not tech-savvy. It comes bundled in a single executable file, which means you don't have to worry about downloading or installing multiple files.

For those looking to share files over the internet, Sharebox has got you covered. It comes with an integrated [Vex](https://github.com/bleenco/vex) client that eliminates the need for configuring firewalls or NAT on your local network. This means you can easily share files with friends, family, or colleagues without any hassle.



## send-it

Yet another simple terminal app that allows you to share your files directly from your terminal. It supports drag and drop, and comes with a reactive progress bar.



## Dropzone

Dropzone is an innovative software that provides a range of features to facilitate communication and file sharing among friends and colleagues in a local area network (LAN). With Dropzone, users can easily share files, chat, and access remote terminals with others on the same network, making it an ideal tool for collaborative work environments. The software is designed to be extremely user-friendly, with zero-configuration required, making it accessible even to those who are not tech-savvy.

It is written in C# programming language, which ensures its compatibility with Windows platforms. Moreover, the software is constantly updated and improved to ensure optimal performance and reliability.



## localCloud

This simple app allows you to create a local cloud system for your local network. You can set admin username, password, token, upload and share files among computors in your network.



## Portal

Portal is a lightweight command-line file transfer utility for file transfer for the network and the web. It can be installed for Windows, Linux, Arch Linux, macOS.

**Portal features include:**

- End-to-end encryption using [PAKE2](https://en.wikipedia.org/wiki/Password-authenticated_key_agreement)
- Direct transfer of files if possible (e.g. sender and receiver are in the same local network)
- Fallback to relay server if sender and receiver cannot connect directly
- Parallel gzip compression of files for faster and more efficient transfers
- Hosting your own relay (we'd appreciate it if you plan to send a lot of data!)
- Configurability and shell completions
- A shiny UI ⭐✨ to gaze your eyes upon while you wait for your files



## Gocho

Local Network File Sharing

Gocho allows you to share a chosen directory with others on the same local network, without the need to setup Samba or OS-oriented settings. It provides a local dashboard which you can access through your browser, to discover what others are sharing without knowing other's IP addresses. [GitHub](https://github.com/donkeysharp/gocho)

Gocho 允许您与同一本地网络上的其他人共享选定的目录，而无需设置 Samba 或面向操作系统的设置。 它提供了一个本地仪表板，您可以通过浏览器访问该仪表板，以便在不知道其他人的 IP 地址的情况下发现其他人正在共享的内容。

Gocho is written in Go Lang, and it is released under the MIT license.

The supported platforms are:

- GNU/Linux 32 bits
- GNU/Linux 64 bits
- macOS (Intel and Apple Silicon)
- Windows 32 bits
- Windows 64 bits



## NitroShare

[NitroShare](https://nitroshare.net/)

https://github.com/nitroshare



## LanXchange

[LanXchange](https://lanxchange.com/)



## FileFly

[FileFly](https://www.fileflyapp.com/)





## 参考

- [19 Open-source Free LAN File Transfer and File Sharing Apps and Scripts](https://medevel.com/19-lan-file-transfer-file-sharing/)



-->
