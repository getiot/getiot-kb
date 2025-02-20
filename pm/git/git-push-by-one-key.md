---
sidebar_position: 17
slug: /git-push-by-one-key
---

# Git 一键三连


在使用 Git 时，最常用的莫过于 add -> commit -> push 三步操作了。但是对于懒惰的程序员来说，一遍遍地敲简直就是灾难！

除了按 &uarr; 方向键，有没有办法实现一键三连？ 😎 

噔噔！写个脚本 git-push.sh，如下：

```bash showLineNumbers title="git-push.sh"
#!/bin/bash

if [ -z "$(git status --porcelain)" ];
then
    echo "IT IS CLEAN"
	exit 0
fi

echo "Enter your message"
read message
if [ -z "${message}" ];
then
	message="update"
fi

git add .
git commit -m"${message}"
echo "Pushing data to remote server!!!"
git push -u origin master

exit 0
```

增加执行权限：

```bash
chmod +x git-push.sh
```

为方便使用，把它放到系统路径下：

```bash
sudo cp git-push.sh /usr/local/bin/
```

赶紧试一下吧

```bash
LetsGit$ git-push.sh 
Enter your message
记得 点赞、投币、收藏！
```
