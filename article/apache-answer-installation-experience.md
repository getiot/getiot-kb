---
sidebar_position: 8
slug: /apache-answer-installation-experience
---

# Apache Answer 开源问答社区安装体验

![](https://static.getiot.tech/answer-banner.png#center)

**Answer** 是由 SegmentFault 思否团队打造的一款问答平台软件，后端使用 Go 语言编写，于2022年10月24日（程序员节）正式开源。你可以免费使用 Answer 高效地搭建一个问答社区，并用于产品技术问答、客户支持、用户交流等场景。

2023年10月9日，Answer 顺利通过投票，以全票通过的优秀表现正式进入 Apache 软件基金会（ASF）孵化器。10月18日，Answer 项目正式移交到 Apache 软件基金会名下，从此改名为 Apache Answer。



## 主要功能

- **提问和回答**：提出问题并从你的用户和团队那里获得答案。
- **组织内容**：将你的内容组织为分类和标签。
- **集成**：与你现有的工具和服务集成。
- **游戏化**：奖励用户的贡献。
- **现代用户界面**：现代且响应式的用户界面。
- **可扩展**：使用插件扩展 Answer。
- **开源**：免费且开源。



## 安装方法

官方文档有介绍[安装流程](https://answer.apache.org/zh-CN/docs/installation)，推荐使用 Docker Compose 方式安装和运行 Answer，命令如下：

```bash
curl -fsSL https://raw.githubusercontent.com/apache/incubator-answer/main/docker-compose.yaml | docker compose -p answer -f - up
```

Linux 系统需要单独安装 `docker-compose` 命令，安装方法可参考《[Docker Compose 安装和使用](/docker/docker-compose/)》。

不过呢，我在实践过程中发现 `raw.githubusercontent.com` 这个链接无法访问，因此无法获取 docker-compose.yaml 文件。实际上，docker-compose.yaml 文件在 Answer 项目的源代码中就有提供。所以我的方法是先克隆 Answer 仓库：

```bash
git clone git@github.com:apache/incubator-answer.git
```

切换到 incubator-answer 目录，再执行 `docker-compose` 命令，如下：

```bash
cd incubator-answer
echo "$(cat docker-compose.yaml)" | docker-compose -p answer -f - up
```

此时终端会打印如下内容：

```bash
WARN[0000] -: `version` is obsolete                     
[+] Running 7/7
 ✔ answer Pulled                                                                                           23.3s 
   ✔ 4abcf2066143 Pull complete                                                                            17.7s 
   ✔ c61465cefb8e Pull complete                                                                            11.1s 
   ✔ ac109b4ee423 Pull complete                                                                            16.0s 
   ✔ 0373f8f02f03 Pull complete                                                                            14.4s 
   ✔ d907b44088ea Pull complete                                                                            16.6s 
   ✔ 4f4fb700ef54 Pull complete                                                                            18.3s 
[+] Running 2/3
 ✔ Network answer_default       Created                                                                     0.0s 
 ✔ Volume "answer_answer-data"  Created                                                                     0.0s 
 ⠴ Container answer-answer-1    Created                                                                     0.4s 
Attaching to answer-1
answer-1  | [upload-dir] try to install...
answer-1  | [upload-dir] install success, upload directory is /data/uploads
answer-1  | [i18n] try to install i18n bundle...
answer-1  | [i18n] find i18n bundle 44
answer-1  | install all initial environment done
answer-1  | [SUCCESS] answer installation service will run at: http://localhost:80/install/
......
```

Answer 默认使用 `9080` 端口，在浏览器输入 [http://localhost:9080](http://localhost:9080/) 即可访问。第一次访问会进入安装页面，如下：

![](https://static.getiot.tech/answer-install-01.png#center)

按照提示选择语言、配置数据库。Answer 支持 MySQL、PostgreSQL 和 SQLite 作为数据库后端。最小的环境是 SQLite，不需要任何额外的配置，这里使用 SQLite3 完成第一次体验。

![](https://static.getiot.tech/answer-install-03.png#center)

然后填写网站的基本信息，就完成安装配置了！

![](https://static.getiot.tech/answer-install-07.png#center)



## 使用体验

完成安装配置后，登录网站，可以看到如下页面。

![](https://static.getiot.tech/answer-install-08.png#center)

此时网站非常干净，点击“我要提问”添加第一个问题。

![](https://static.getiot.tech/answer-install-09.png#center)

这样网站首页就有了第一条信息啦！

![](https://static.getiot.tech/answer-install-11.png#center)



## 资源链接

- 官方网站：[https://answer.apache.org](https://answer.apache.org) ([via](https://github.com/apache/incubator-answer-website))
- 代码仓库：[https://github.com/apache/incubator-answer](https://github.com/apache/incubator-answer)
- 插件仓库：[https://github.com/apache/incubator-answer-plugins](https://github.com/apache/incubator-answer-plugins)
- 在线文档：[https://answer.apache.org/docs/](https://answer.apache.org/docs/)
- 社区：[https://meta.answer.dev](https://meta.answer.dev)



## 小结

Apache Answer 开源问答平台软件的安装方法非常简单，可以很方便地搭建一个问答社区。同时，Answer 界面干净清爽，后台提供了定制化配置功能，也支持插件扩展，确实是一个很棒的开源软件！

