---
sidebar_label: JSON-RPC
sidebar_position: 8
slug: /jsonrpc
---

# JSON-RPC



JSON-RPC 是一种无状态且轻量级的远程过程调用（RPC）传送协议，并且以传递 [JSON](/web/web-format-json/) 数据为主。相较于一般的 [REST](/http/http-restful-api/) 通过网址（如 `GET /user`）调用远程服务器，JSON-RPC 直接在内容中定义了欲调用的函数名称（如 `{"method": "getUser"}`），这使得开发者不会陷于该使用 PUT 或者 PATCH 的问题之中。

本文主要介绍 JSON-RPC 的一些数据结构及其相关的处理规则，它使用 JSON（[RFC 4627](https://www.ietf.org/rfc/rfc4627.txt)）作为数据格式，可以运行在基于 [Socket](/dictionary/socket/)、[HTTP](/http/http-intro/) 等诸多不同消息传输环境的同一进程中。



## 约定

由于 JSON-RPC 使用 JSON，它具有与其相同的类型系统。JSON 可以表示四个基本类型（String、Numbers、Boolean 和 Null）和两个结构化类型（Objects 和 Array）。注意当我们使用 JSON 数据类型时，第一个字母都必须大写，例如 Object、Array、String、Number、Boolean、Null，以及 True 和 False 也要大写。

在客户端与任何被匹配到的服务端之间交换的所有成员名字应是区分大小写的。函数、方法、过程都可以认为是可以互换的。客户端被定义为请求对象的来源及响应对象的处理程序，服务端被定义为响应对象的起源和请求对象的处理程序，如下图所示。

![](https://static.getiot.tech/JSON-RPC-works.png#center-600)



## 兼容性

目前存在两种 JSON-RPC 规范，分别是 JSON-RPC 1.0 和 JSON-RPC- 2.0。

- JSON-RPC 1.0 在多个方面缺乏实用性，特别是缺少名称参数和错误消息解释，引起的麻烦超出了预期。使得它更像是一种点对点的交流方式。
- JSON RPC 2.0 规范则解决了 1.0 版本的缺陷，表现得更加先进。使用客户机-服务器模式，同时增加了多种传输方式的支持。

值得注意的是，JSON-RPC 2.0 的请求对象和响应对象可能无法在较旧的 JSON-RPC 1.0 客户端或服务端正常运行。不过我们可以很容易地区分出两个版本，因为 2.0 版本中必须夹带一个命名为 `jsonrpc` 且值为 2.0 的字段，而 1.0 版本是没有此字段的。大部分的 2.0 实现应该考虑尝试兼容或者处理 1.0 的对象，即使不是对等的也应给其相关提示。



## 请求对象

发送一个请求对象至服务端代表一个 RPC 调用，一个请求对象包含下列成员：

- jsonrpc
- method
- params
- id

其中，id 成员用来两个对象之间的关联上下文。如果响应对象中包含了 id 成员，服务端必须回答相同的值。在请求对象中不建议使用 `NULL` 作为 id 值，因为规范将使用空值认定为未知 id 的请求。

没有包含 id 成员的请求对象为通知，作为通知的请求对象表明客户端对相应的响应对象并不感兴趣，本身也没有响应对象需要返回给客户端。

RPC 调用如果存在参数则必须为基本类型或结构化类型的参数值，要么为索引数组，要么为关联数组对象。

- 索引：参数必须为数组，并包含与服务端预期顺序一致的参数值。
- 关联名称：参数必须为对象，并包含与服务端相匹配的参数成员名称。没有在预期中的成员名称可能会引起错误。名称必须完全匹配，包括方法的预期参数名以及大小写。



## 响应对象

当发起一个 RPC 调用时，除通知之外，服务端都必须回复响应。响应表示为一个 JSON 对象，使用以下字段：

- jsonrpc
- result
- error
- id

响应对象必须包含 result 或 error 字段，但两个字段不能同时存在。



## 错误对象

当一个 RPC 调用遇到错误时，返回的响应对象必须包含错误成员参数，并且为带有下列成员参数的对象：

- code
- message
- data

-32768 至 -32000 为保留的预定义错误代码。在该范围内的错误代码不能被开发者自己定义，保留下列以供将来使用。错误代码基本与 XML-RPC [建议](http://xmlrpc-epi.sourceforge.net/specs/rfc.fault_codes.php)的一样。

| 错误码           | 消息                            | 解释                                                         |
| :--------------- | :------------------------------ | :----------------------------------------------------------- |
| -32700           | Parse error<br/>语法解析错误    | 服务端接收到无效的 JSON。该错误发送于服务器尝试解析 JSON 文本 |
| -32600           | Invalid Request<br/>无效请求    | 发送的 JSON 内容不是一个有效的请求对象。                     |
| -32601           | Method not found<br/>找不到方法 | 该方法不存在或无效。                                         |
| -32602           | Invalid params<br/>无效的参数   | 无效的方法参数。                                             |
| -32603           | Internal error<br/>内部错误     | JSON-RPC 内部错误。                                          |
| -32000 to -32099 | Server error<br/>服务端错误     | 预留用于自定义的服务器错误。                                 |

除此之外剩余的错误类型代码可供应用程序作为自定义错误。



## 批量调用

当需要同时发送多个请求对象时，客户端可以发送一个包含所有请求对象的数组。当批量调用的所有请求对象处理完成时，服务端则需要返回一个包含相对应的响应对象数组。

每个响应对象都应对应每个请求对象，除非是通知的请求对象。服务端可以并发的，以任意顺序和任意宽度的并行性来处理这些批量调用。这些相应的响应对象可以任意顺序的包含在返回的数组中，而客户端应该是基于各个响应对象中的 id 成员来匹配对应的请求对象。

如果批量调用的 RPC 操作本身非一个有效 JSON 或一个至少包含一个值的数组，则服务端返回的将单单是一个响应对象而非数组。如果批量调用没有需要返回的响应对象，则服务端不需要返回任何结果且不能返回一个空数组给客户端。



## 相关实现

- C 语言：[https://github.com/RitwikSaikia/jsonrpc](https://github.com/RitwikSaikia/jsonrpc)
- Golang：[https://github.com/ybbus/jsonrpc](https://github.com/ybbus/jsonrpc)
- TypeScript：[https://github.com/shogowada/json-rpc-2.0](https://github.com/shogowada/json-rpc-2.0)





## 参考

- [JSON-RPC 概念 - 区块链开发](http://static.kancloud.cn/daleboy/blockchain/2297828)
- [What Is JSON RPC?](https://www.wallarm.com/what/what-is-json-rpc)

