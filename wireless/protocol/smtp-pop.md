---
sidebar_position: 10
---

# SMTP / POP 协议



## 协议介绍

### SMTP

SMTP 的全称是“Simple Mail Transfer Protocol”，即简单邮件传输协议。它是一组用于从源地址到目的地址传输邮件的规范，通过它来控制邮件的中转方式。SMTP 协议属于 TCP/IP 协议簇，它帮助每台计算机在发送或中转信件时找到下一个目的地。SMTP 服务器就是遵循 SMTP 协议的发送邮件服务器。

SMTP 认证，简单地说就是要求必须在提供了账户名和密码之后才可以登录 SMTP 服务器，这就使得那些垃圾邮件的散播者无可乘之机。

增加 SMTP 认证的目的是为了使用户避免受到垃圾邮件的侵扰。

### POP3

POP3 是 Post Office Protocol 3 的简称，即邮局协议的第3个版本，它规定怎样将个人计算机连接到 Internet 的邮件服务器和下载电子邮件的电子协议。它是因特网电子邮件的第一个离线协议标准，POP3 允许用户从服务器上把邮件存储到本地主机（即自己的计算机）上，同时删除保存在邮件服务器上的邮件，而 POP3 服务器则是遵循 POP3 协议的接收邮件服务器，用来接收电子邮件的。

### IMAP

IMAP 全称是 Internet Mail Access Protocol，即交互式邮件存取协议，它是跟 POP3 类似邮件访问标准协议之一。不同的是，开启了 IMAP 后，您在电子邮件客户端收取的邮件仍然保留在服务器上，同时在客户端上的操作都会反馈到服务器上，如：删除邮件，标记已读等，服务器上的邮件也会做相应的动作。所以无论从浏览器登录邮箱或者客户端软件登录邮箱，看到的邮件以及状态都是一致的。



## 免费邮箱服务

下列收集了比较常见的 smtp 和 pop。当然，如果业务量不是非常巨大，下面的东西还可以免费用一下，但是如果类似一下子要发送大量的邮箱，这个还是考虑专业第三方发送邮件服务。

- 新浪邮箱 smtp 服务器
  - 外发服务器：smtp.vip.sina.com
  - 收件服务器：pop3.vip.sina.com
- 新浪免费邮件
  - 外发服务器：smtp.sina.com.cn
  - 收件服务器：pop3.sina.com.cn
- 163 邮箱 smtp 服务器
  - pop：pop.163.com
  - smtp：smtp.163.com
- QQ 邮箱 smtp 服务器及端口
  - imap.qq.com，使用SSL，端口号993
  - smtp.qq.com，使用SSL，端口号465或587
- yahoo 邮箱 smtp 服务器
  - pop.mail.yahoo.com.cn
  - smtp.mail.yahoo.com
- 126 邮箱 smtp 服务器
  - pop： pop.126.com
  - smtp： smtp.126.com
- 新浪免费邮箱
  - POP3：pop.sina.com
  - SMTP：smtp.sina.com
  - SMTP端口号：25
- 新浪 VIP 邮箱
  - POP3：pop3.vip.sina.com
  - SMTP：smtp.vip.sina.com
  - SMTP端口号：25
- 新浪企业邮箱
  - POP3：pop.sina.com
  - SMTP：smtp.sina.com
  - SMTP端口号：25
- 雅虎邮箱
  - POP3：pop.mail.yahoo.cn
  - SMTP：smtp.mail.yahoo.cn
  - SMTP端口号：25
- 搜狐邮箱
  - POP3：pop3.sohu.com
  - SMTP：smtp.sohu.com
  - SMTP端口号：25
- TOM 邮箱
  - POP3：pop.tom.com
  - SMTP：smtp.tom.com
  - SMTP端口号：25
- Gmail 邮箱
  - POP3：pop.gmail.com
  - SMTP：smtp.gmail.com
  - SMTP端口号：587 或 25
- QQ 邮箱
  - POP3：pop.qq.com
  - SMTP：smtp.qq.com
  - SMTP端口号：25

