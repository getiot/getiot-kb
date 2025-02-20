---
sidebar_position: 5
slug: /git-clone
---

# Git 克隆



如果想在克隆 git 仓库的同时修改本地目录的名称，可以在命令后面添加目录名称。

```bash
git clone [远程仓库地址] [想要重命名的文件夹名称]
```



## 不指定分支克隆

```bash
git clone [远程仓库地址]
```

拉取默认分支（通常为 master 或 main）



## 指定分支克隆

```bash
git clone -b [分支名称] [远程仓库地址]
```



## 指定 tag 克隆

```bash
git clone -b [tag标签] [远程仓库地址]
```

