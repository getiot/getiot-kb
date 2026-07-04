---
sidebar_position: 2
---

# PHP 安装



本文主要介绍如何在 Linux 系统中安装 PHP 及其依赖环境，并演示如何运行一个 php 脚本。



## Linux 安装 PHP

PHP 通常与 Linux、Apache 和 MySQL 搭配，用于开发服务端 Web 程序，这套组合也被称为“**LAMP**”。所以在开发 PHP 程序时，除了安装 php 解释器以外，还需要安装 Apache、MySQL 以及各种组件和库。

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

<Tabs>
  <TabItem value="redhat" label="Redhat/CentOS" default>
```bash
sudo yum install php

# 安装 Apache
sudo yum install httpd
# 安装组件，支持 MySQL 等
sudo yum install php-mysql php-gd libjpeg* php-imap php-ldap \
                 php-odbc php-pear php-xml php-xmlrpc php-mbstring \
                 php-mcrypt php-bcmath php-mhash libmcrypt
```
  </TabItem>
  <TabItem value="debian" label="Debian/Ubuntu">
```bash
sudo apt install php

# 安装 Apache
sudo apt install apache2
# 安装 PHP 的 Apache 模块
sudo apt install php libapache2-mod-php
```
  </TabItem>
</Tabs>


安装完成后，执行 `php --version` 命令，如果看到版本信息则说明安装成功。例如：

```bash
$ php --version
PHP 7.4.3 (cli) (built: Nov 25 2021 23:16:22) ( NTS )
Copyright (c) The PHP Group
Zend Engine v3.4.0, Copyright (c) Zend Technologies
    with Zend OPcache v7.4.3, Copyright (c), by Zend Technologies
```



## 运行 php 脚本

创建一个 test.php 文件，输入如下内容：

```php
<?php

echo "Hello, World!\n";
```

执行 `php test.php` 命令，运行 php 脚本：

```bash
$ php test.php
Hello, World!
```

