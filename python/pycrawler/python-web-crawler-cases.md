---
sidebar_position: 4
---

# Python 爬虫经典案例



下面是我整理的一些 GitHub 上面经典的开源爬虫项目，涵盖的比较全面，供大家学习使用。

## WechatSogou 微信公众号爬虫

基于搜狗微信搜索的微信公众号爬虫接口，可以扩展成基于搜狗搜索的爬虫，返回结果是列表，每一项均是公众号具体信息字典。

GitHub 地址：https://github.com/Chyroc/WechatSogou

## DouBanSpider 豆瓣读书爬虫

可以爬下豆瓣读书标签下的所有图书，按评分排名依次存储，存储到 Excel 中，可方便大家筛选搜罗，比如筛选评价人数 >1000 的高分书籍；可依据不同的主题存储到 Excel 不同的 Sheet ，采用User Agent 伪装为浏览器进行爬取，并加入随机延时来更好的模仿浏览器行为，避免爬虫被封。

GitHub 地址：https://github.com/lanbing510/DouBanSpider

## zhihu_spider 知乎爬虫

此项目的功能是爬取知乎用户信息以及人际拓扑关系，爬虫框架使用 scrapy，数据存储使用 mongo.

GitHub 地址：https://github.com/LiuRoy/zhihu_spider

## bilibili-user Bilibili用户爬虫

总数据数：20119918，抓取字段：用户 id，昵称，性别，头像，等级，经验值，粉丝数，生日，地址，注册时间，签名，等级与经验值等。抓取之后生成B站用户数据报告。

GitHub 地址：https://github.com/airingursb/bilibili-user

## SinaSpider 新浪微博爬虫

主要爬取新浪微博用户的个人信息、微博信息、粉丝和关注。代码获取新浪微博 Cookie 进行登录，可通过多账号登录来防止新浪的反扒。主要使用 scrapy 爬虫框架。

GitHub 地址：https://github.com/LiuXingMing/SinaSpider

## distribute_crawler 小说下载分布式爬虫

使用 scrapy, Redis, MongoDB, graphite 实现的一个分布式网络爬虫, 底层存储 MongoDB 集群,分布式使用 Redis 实现,爬虫状态显示使用 graphite 实现，主要针对一个小说站点。

GitHub 地址：https://github.com/gnemoug/distribute_crawler

## CnkiSpider 中国知网爬虫

设置检索条件后，执行 src/CnkiSpider.py 抓取数据，抓取数据存储在 /data 目录下，每个数据文件的第一行为字段名称。

GitHub 地址：https://github.com/yanzhou/CnkiSpider

## LianJiaSpider 链家网爬虫

爬取北京地区链家历年二手房成交记录。涵盖链家爬虫一文的全部代码，包括链家模拟登录代码。

GitHub 地址：https://github.com/lanbing510/LianJiaSpider

## scrapy_jingdong 京东爬虫

基于 scrapy 的京东网站爬虫，保存格式为 csv。

GitHub 地址：https://github.com/taizilongxu/scrapy_jingdong

## QQ-Groups-Spider QQ 群爬虫

批量抓取 QQ 群信息，包括群名称、群号、群人数、群主、群简介等内容，最终生成 XLS(X) / CSV 结果文件。

GitHub 地址：https://github.com/caspartse/QQ-Groups-Spider

## wooyun_public 乌云爬虫

乌云公开漏洞、知识库爬虫和搜索。全部公开漏洞的列表和每个漏洞的文本内容存在 mongodb 中，大概约 2G 内容；如果整站爬全部文本和图片作为离线查询，大概需要 10G 空间、2 小时（ 10M 电信带宽）；爬取全部知识库，总共约 500M 空间。漏洞搜索使用了 Flask 作为 web server，bootstrap 作为前端。

GitHub 地址：https://github.com/hanc00l/wooyun_public

## spider hao123网站爬虫

以 hao123 为入口页面，滚动爬取外链，收集网址，并记录网址上的内链和外链数目，记录 title 等信息，windows7 32 位上测试，目前每 24 个小时，可收集数据为 10 万左右。

GitHub 地址：https://github.com/simapple/spider

## findtrip 机票爬虫（去哪儿和携程网）

Findtrip 是一个基于 Scrapy 的机票爬虫，目前整合了国内两大机票网站（去哪儿 + 携程）。

GitHub 地址：https://github.com/fankcoder/findtrip

## QQSpider

QQ空间爬虫，包括日志、说说、个人信息等，一天可抓取 400 万条数据。

GitHub 地址：https://github.com/LiuXingMing/QQSpider

## baidu-music-spider 百度音乐爬虫

百度mp3全站爬虫，使用redis支持断点续传。

GitHub 地址：https://github.com/Shu-Ji/baidu-music-spider

## tbcrawler 淘宝天猫商品爬虫

淘宝和天猫的爬虫,可以根据搜索关键词,物品 id 来抓去页面的信息，数据存储在 mongodb。

GitHub 地址：https://github.com/pakoo/tbcrawler

## stockholm 股票数据（沪深）爬虫

一个股票数据（沪深）爬虫和选股策略测试框架。根据选定的日期范围抓取所有沪深两市股票的行情数据。支持使用表达式定义选股策略。支持多线程处理。保存数据到JSON文件、CSV文件。

GitHub 地址：https://github.com/benitoro/stockholm

## BaiduyunSpider 百度云盘爬虫

分布式百度网盘爬虫，使用当前最流行的技术框架。适合个人学习以及二次开发。爬虫基于 Scrapy，灵活简单、易扩展，方便二次开发。使用 Scrapy-Redis 作为分布式中间件，可同时部署多个爬虫实例，以提升采集效率。Web后台管理基于React，Material Design 设计风格。

GitHub 地址：https://github.com/k1995/BaiduyunSpider

## Spider 社交数据爬虫

支持微博,知乎,豆瓣。

GitHub 地址：https://github.com/Qutan/Spider

## proxy pool

Python爬虫代理IP池(proxy pool)。

GitHub 地址：https://github.com/jhao104/proxy_pool

## music-163

爬取网易云音乐所有歌曲的评论。

GitHub 地址：https://github.com/RitterHou/music-163

## jandan_spider

爬取煎蛋妹纸图片。

GitHub 地址：https://github.com/kulovecc/jandan_spider

## CnblogsSpider

cnblogs列表页爬虫。

GitHub 地址：https://github.com/jackgitgz/CnblogsSpider

## spider_smooc

爬取慕课网视频。

GitHub 地址：https://github.com/qiyeboy/spider_smooc

## knowsecSpider2

知道创宇爬虫题目。

GitHub 地址：https://github.com/littlethunder/knowsecSpider2

## csdn-spider

爬取CSDN上的博客文章。

GitHub 地址：https://github.com/Kevinsss/csdn-spider

## ProxySpider

爬取西刺上的代理 IP，并验证代理可用性。

GitHub 地址：https://github.com/changetjut/ProxySpider

