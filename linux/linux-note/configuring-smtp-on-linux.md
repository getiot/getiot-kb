---
sidebar_position: 2
---

# Linux  配置邮件服务



## 概述

### 什么时候会用到邮件服务

在使用 LInux 系统时，有很多场景需要用到邮件服务。例如，当您想向 Linux 内核提交 patch，那么就需要事先配置好邮件服务，以便于与内核团队协作。或者在 Linux 服务器出现异常时，希望能主动向管理员发送告警信息，那么就需要事先配置好邮件服务，才具备发送邮件的功能。

在 Linux 操作系统环境中，可以配置邮件服务器，也可以配置邮箱客户端。

本篇主要是配置邮件客户端，这对于发送服务器一些系统信息十分有必要。



### SMTP 和 SMTPS

SMTP 和 SMTPS 都是用来发送邮件的。SMTPS 是加密版的 SMTP，也就是在 SMTP 的基础上使用 ssl 来对数据进行加密、防篡改等，因此更安全。目前腾讯云、阿里云、华为云等都推荐使用 SMTPS，默认禁止 SMTP（可以通过工单申请开放 SMTP）。

SMTP 的默认端口是 25，SMTPS 的默认端口通常是 587。由于历史原因，有些 SMTPS 使用 465 端口。



## 邮箱客户端

### mail

安装

```shell
sudo apt install mailutils
```

编辑配置文件，在最后一行添加内容如下：

```shell
set from=xxx@163.com
set smtp=smtp.163.com
set smtp-auth-user=xxx@163.com
set smtp-auth-password=***
# smtp-auth-password表示我邮箱的第三方客户端授权码
set smtp-auth=login
```

测试发送

```shell
mail -s "hello" luhuadong@163.com < /etc/hosts
```

如果收到邮件，说明配置成功



自动化脚本 smtp.sh

```shell
#!/bin/bash
# FileName:             smtp.sh
# Version:              1.0
# Date:                 2020-04-24
# Author:               baige
# Description:          the script for smtp configration
read -p "Please Input Your Email Provider [163/qq/126]: " provider
read -p "Please Input Your Email Account: " account
read -p "Please Input Your Auth-Password: " password
echo "Waiting For A Moment..."
yum install mailx sendmail -y >/dev/null0
cat >>/etc/mail.rc<< EOF
set from=$account@$provider.com   #邮箱地址
set smtp=smtp.$provider.com     #smtp服务器
set smtp-auth-user=$account    #邮箱账号
set smtp-auth-password=$password   #授权密码，注意是授权密码，不是在web页面上登邮箱的密码，授权密码可以在邮箱的pop3/smtp设置页面自行设置。
set smtp-auth=login
EOF
systemctl start sendmail
```

执行脚本，这里输入自己的邮箱信息即可。发送邮件测试

```shell
echo '邮件内容' | mail -s '邮件主题' 3473067134@qq.com
```

测试的目标邮箱可以正常收到邮件，配置成功。

因为smtps使用了ssl加密，所以在smtp的基础上，我们加上ssl证书相关的配置即可。

```shell
#!/bin/bash
# FileName:             smtps.sh
# Version:              1.0
# Date:                 2020-04-24
# Author:               baige
# Description:          the script for smtps configration
read -p "Please Input Your Email Provider [163/qq/126]: " provider
read -p "Please Input Your Email Account: " account
read -p "Please Input Your Auth-Password: " password
echo "Waiting For A Moment..."
yum install mailx sendmail -y >/dev/null
mkdir -p /root/.certs/  #从这里开始，均为下载ssl证书及相关配置#
echo -n | openssl s_client -connect smtp.$provider.com:465 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > ~/.certs/$provider.crt >/dev/null
certutil -A -n "GeoTrust SSL CA" -t "C,," -d ~/.certs -i ~/.certs/$provider.crt >/dev/null
certutil -A -n "GeoTrust Global CA" -t "C,," -d ~/.certs -i ~/.certs/$provider.crt >/dev/null
certutil -L -d /root/.certs >/dev/null
cat >>/etc/mail.rc<< EOF #以下为邮箱账户相关配置#
set from=$account@$provider.com
set smtp=smtps://smtp.$provider.com:465
set smtp-auth-user=$account@$provider.com
set smtp-auth-password=$password
set smtp-auth=login
set ssl-verify=ignore
set nss-config-dir=/root/.certs"
EOF
systemctl start sendmail
```



### mutt + msmtp

msmtp 是一个 SMTP 客户端，可将邮件传送至 SMTP 服务端。而 Mutt 是一个 email 客户端，它不能直接传送邮件，更多的是承担对 email 的管理功能。

安装

```shell
sudo apt install mutt msmtp
```

安装完成后，还需要

```shell
groups msmtp
sudo touch /var/log/msmtp
sudo chown msmtp:msmtp /var/log/msmtp
sudo chmod 660 /var/log/msmtp
```

添加 ~/.msmtprc 配置文件，以 163 邮箱为例，内容如下：

```shell
account default 
host smtp.163.com   
port 25
from xxx@163.com   # 按照实际情况填写真实的邮箱地址
auth login
tls off
user xxx           # 邮箱使用者名称
password ******    # 这里填的是授权码，不是邮箱登录密码
logfile /var/log/msmtp
```

支持 tls

```shell
defaults
port 587
tls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
account freemail
host smtp.partner.outlook.cn
from chen_dong@abc.cn
auth on
user zhang_san@abc.cn
password XXXXXXX
logfile ~/.msmtp.log
account default : freemail
```



测试

```shell
msmtp -t 870179822@qq.com
```

配置 Mutt，/etc/Muttrc

```shell
set sendmail='/usr/bin/msmtp'
set use_from=yes
set realname="Rudy Lo"
set editor="vim"
set from=luhuadong@163.com
set envelope_from=yes
auto_view text/html
set charset='utf-8'
set send_charset='utf-8'
#set locale ="zh_CN.UTF-8"
set content_type = 'text/html\;charset=utf-8'
set rfc2047_parameters=yes
```

上面的 realname 可以任意设定，这样当您发邮件给别人的时候，收件人看到发到发件人的 title 就是这里设定的内容。

简单测试

```shell
echo "Hello, World!" | mutt -s "GetIoT.tech" 870179822@qq.com
```

新增附件测试

```shell
echo "Hello, World!" | mutt -s "GetIoT.tech" 870179822@qq.com -a /etc/lsb-release
```



### 测试邮箱服务器

```shell
$ msmtp --host=smtp.163.com --serverinfo
SMTP server at smtp.163.com (m12-16.163.com [220.181.12.16]), port 25:
    163.com Anti-spam GT for Coremail System (163com[20141201])
Capabilities:
    PIPELINING:
        Support for command grouping for faster transmission
    STARTTLS:
        Support for TLS encryption via the STARTTLS command
    AUTH:
        Supported authentication methods:
        PLAIN LOGIN 
This server might advertise more or other capabilities when TLS is active.
```





## 常见免费邮箱

常见免费邮箱 SMTP 服务地址及端口

|    邮箱     | 服务 |    服务器地址    | SSL端口号 | 非SSL端口号 |
| :---------: | :--: | :--------------: | :-------: | :---------: |
|   163邮箱   | IMAP |   imap.163.com   |    993    |     143     |
|             | SMTP |   smtp.163.com   |  465/994  |     25      |
|             | POP3 |   pop.163.com    |    995    |     110     |
|   QQ邮箱    | IMAP |   imap.qq.com    |    993    |     143     |
|             | SMTP |   smtp.qq.com    |  465/587  |     25      |
|             | POP3 |    pop.qq.com    |    995    |      –      |
| foxmail邮箱 | IMAP | imap.foxmail.com |    993    |     143     |
|             | SMTP | smtp.foxmail.com |    465    |     25      |
|             | POP3 | pop.foxmail.com  |    995    |     110     |
|  gmail邮箱  | IMAP |  imap.gmail.com  |    993    |      –      |
|             | SMTP |  smtp.gmail.com  |  465/587  |      –      |
|             | POP3 |  pop.gmail.com   |    995    |      –      |



