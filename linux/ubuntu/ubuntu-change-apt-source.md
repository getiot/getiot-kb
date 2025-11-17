---
sidebar_position: 6
---

# Ubuntu 更换源


本文将介绍修改 Ubuntu 系统的镜像源地址的方法，例如，更换为清华源：

```bash
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
sudo sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list
sudo sed -i 's/security.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list
```

国内常用的镜像源地址列表：

```bash
mirrors.tuna.tsinghua.edu.cn
mirrors.163.com
linux.xidian.edu.cn
mirrors.sohu.com
mirrors.cloud.tencent.com
```

