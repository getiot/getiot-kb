---
sidebar_position: 4
---

# Yocto 设置默认密码



## 添加用户

在 image 配方中添加：

```shell
inherit extrausers
EXTRA_USERS_PARAMS = "useradd -P 2015*08 myUser;"
```

在 local.conf 中添加：

```shell
INHERIT += "extrausers"
EXTRA_USERS_PARAMS = "useradd -P 2015*08 myUser;"
```



## 设置 root 用户密码

在 image 配方中添加：

```shell
inherit extrausers
EXTRA_USERS_PARAMS = "usermod -P 1876*18 root;"
```

其中“1876*18”为设置的 root 用户密码。

在 local.conf 中添加：

```shell
INHERIT += "extrausers"
EXTRA_USERS_PARAMS = "usermod -P 1876*18 root;"
```

其中“1876*18”为设置的 root 用户密码。



## 密码如何加密？

在 image 配方中增加：

```shell
ROOTFS_POSTPROCESS_COMMAND += "change_root_psw;"
change_root_psw() {
   sed 's%^root:[^:]*:%root:<encrypted_password_goes_here>:%' \
       < ${IMAGE_ROOTFS}/etc/shadow \
       > ${IMAGE_ROOTFS}/etc/shadow.new;
   mv ${IMAGE_ROOTFS}/etc/shadow.new ${IMAGE_ROOTFS}/etc/shadow ;
}
```

获取加密密码串（方法一）

```shell
# -1 MD5; -5 SHA256; -6 SHA512
maxu@SUZJNKS01:~$ openssl passwd -1 -salt xyz yourpassword
$1$xyz$LDHRuETZ.YXX1mt7T22Ub/
```

获取加密密码串（方法二）

```shell
maxu@SUZJNKS01:~$ python3 -c "from getpass import getpass; from crypt import *; \
>     p=getpass(); print('\n'+crypt(p, METHOD_SHA512)) \
>     if p==getpass('Please repeat: ') else print('\nFailed repeating.')"
Password: 
Please repeat: 

$6$wzTPECiOsvnPPPjw$2jrHYmmIseK6TlpCo/tep5H45esyrqliY2srRHtfHE6LJPzcBT/wK5XyIHfFzJZUZkc4dtyjzhau45Mt.QSvB1
```







