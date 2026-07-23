---
sidebar_position: 5
sidebar_label: Socket 网络编程
slug: /ruby-socket-intro
---

# Ruby Socket 网络编程入门

Socket 是更底层的网络接口。HTTP、Redis、MQTT 等协议最终都建立在网络连接和字节读写之上。Ruby 标准库的 `socket` 可以创建 TCP Server 和 Client。

## TCP Echo Server

创建 `server.rb`：

```ruby title="server.rb"
require "socket"

server = TCPServer.new("127.0.0.1", 3000)
puts "listen on 127.0.0.1:3000"

loop do
  client = server.accept
  message = client.gets
  client.puts "echo: #{message}"
  client.close
end
```

这个服务会把客户端发来的内容回显。

## TCP Client

创建 `client.rb`：

```ruby title="client.rb"
require "socket"

socket = TCPSocket.new("127.0.0.1", 3000)
socket.puts "hello"
puts socket.gets
socket.close
```

先运行 `server.rb`，再运行 `client.rb`。

## 地址和端口

`127.0.0.1` 表示本机回环地址，只能本机访问。

`3000` 是端口号，用来区分同一台机器上的不同网络服务。

如果你希望局域网其他设备访问服务，通常要监听 `0.0.0.0`，同时检查防火墙和网络环境。

## 示例限制

上面的 Server 一次处理一个连接，并且没有错误处理、超时和并发。它适合学习 socket 流程，不适合生产环境。

真实服务需要考虑：

- 多客户端并发
- 协议格式
- 超时
- 异常处理
- 连接关闭
- 安全边界

## 小练习

1. 修改 Echo Server，让它输出客户端地址。
2. 让客户端从用户输入读取消息。
3. 思考如果两个客户端同时连接会发生什么。

## 小结

Socket 让你看到网络通信的底层过程：监听、连接、读取、写入、关闭。理解它后，你会更容易理解 HTTP 和 Web 框架。

