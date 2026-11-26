---
sidebar_position: 3
---

# RESTful API 规范



## 概述

RESTful API 是一种 Web 应用程序的接口设计风格和开发方式。使用 RESTful 风格设计的 API 路由基于 HTTP，支持 XML 与 JSON 等格式的数据回传。

RESTful 风格设计的接口本身是通过请求方式的限制实现对网络资源状态的标识，类似于 GET 请求某一个路由路径，应当对应的是数据的获取。而使用 POST 方式进行路由路径的请求，应当对应数据的增加。



## HTTP 请求方式

一个 HTTP 请求可能会采用各种不同的请求方式，如下表所示。

| 请求方式 | 描述                                                  |
| -------- | ----------------------------------------------------- |
| GET      | 请求指定的页面信息，并且返回相关的数据。              |
| HEAD     | 类似于 GET 请求，但返回内容不包含主体，用于获取报头。 |
| POST     | 向后台服务器发送数据。                                |
| PUT      | 向后台服务器发送数据更新内容。                        |
| DELETE   | 指定删除内容的操作头。                                |
| CONNECT  | HTTP 1.1 中预留管道方式的代理服务器。                 |
| OPTIONS  | 获取服务器的性能等。                                  |
| TRACE    | 测试服务器的可用性，可以用于回显服务器收到的请求。    |
| PATCH    | 新引入对于 PUT 的补充，用于对局部内容进行更新。       |



## RESTful 种类划分

RESTful 是目前最流行的 API 设计规范，其核心思想就是对客户端发起的请求进行 5 种划分。不同的操作对应 5 种不同的 HTTP 请求方法，这是以逻辑操作功能为基础进行划分的，而不是传统的 API 设计以路径方式进行划分。

RESTful 划分的种类如下表所示。

| 请求方式 | 对应操作                     |
| -------- | ---------------------------- |
| GET      | 读取数据内容（Read）         |
| POST     | 新建或插入数据内容（Create） |
| PUT      | 更新数据内容（Update）       |
| PATCH    | 局部数据更新（Update）       |
| DELETE   | 删除操作（Delete）           |

理论上来说，RESTful API 就是符合上述规范的 API 设计。也就是说，相同的请求路径，由于请求方式不同，获取的数据结果会不同，或者会执行不同的数据操作。

不同的请求方式返回的 [HTTP 状态码](/http/http-status-code/) 可能不一样，或者相同的状态码但有不同的含义。例如：

| 请求方式 | 状态码 | 含义       |
| -------- | ------ | ---------- |
| GET      | 200    | OK         |
| POST     | 201    | Created    |
| PUT      | 200    | OK         |
| PATCH    | 200    | OK         |
| DELETE   | 204    | No Content |



## REST API 示例

下面是一个简单的 REST API 示例。

| 请求方式 | URL                                     | 动作         |
| -------- | --------------------------------------- | ------------ |
| GET      | `http://[hostname]/api/users`           | 检索用户列表 |
| GET      | `http://[hostname]/api/users/[user_id]` | 检索单个用户 |
| POST     | `http://[hostname]/api/users`           | 创建新用户   |
| PUT      | `http://[hostname]/api/users/[user_id]` | 更新用户信息 |
| DELETE   | `http://[hostname]/api/users/[user_id]` | 删除用户     |

