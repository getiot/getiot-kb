---
sidebar_position: 4
sidebar_label: gRPC
slug: /grpc
---

# gRPC 远程过程调用框架

**gRPC** 是一个由 Google 开源的高性能远程过程调用（RPC）框架，旨在简化和加速跨语言、跨平台的服务通信。它基于 HTTP/2 协议，并使用 Protocol Buffers（protobuf）作为接口定义语言（IDL）和数据序列化格式，广泛应用于微服务架构、移动应用、物联网等领域。

在 gRPC 中，客户端应用可以直接调用其他机器上的服务器应用中的方法，如同调用本地对象一样，从而让你更轻松地创建分布式应用和服务。

:::tip

关于 gRPC 的详细使用方法请阅读《[gRPC 使用教程](/grpc/)》。

:::



## 主要特性

- **高性能通信**：利用 HTTP/2 的多路复用、头部压缩和流控等特性，实现低延迟、高吞吐量的通信。
- **多语言支持**：官方支持 C++, Java, Go, Python, C#, Ruby, Node.js 等多种语言，便于构建多语言系统。
- **多种通信模式**：
  - **一元 RPC**：客户端发送单个请求，服务器返回单个响应。
  - **服务器流式 RPC**：客户端发送请求，服务器返回数据流。
  - **客户端流式 RPC**：客户端发送数据流，服务器返回单个响应。
  - **双向流式 RPC**：客户端和服务器之间进行双向数据流通信。
- **代码自动生成**：通过 `.proto` 文件定义服务接口，使用 `protoc` 编译器自动生成客户端和服务器端代码，减少手动编码工作。
- **强类型接口**：使用 protobuf 定义接口和消息格式，提供强类型检查，减少运行时错误。
- **安全性**：支持 TLS 加密和认证机制，确保通信安全。



## 使用示例

以下是使用 C++ 实现 gRPC 的完整示例，包括服务定义、代码生成、服务器和客户端的实现。

### 定义服务接口（`.proto` 文件）

创建一个名为 `helloworld.proto` 的文件，内容如下：

```protobuf showLineNumbers title="helloworld.proto"
syntax = "proto3";

package helloworld;

// 定义服务
service Greeter {
  rpc SayHello (HelloRequest) returns (HelloReply);
}

// 请求消息
message HelloRequest {
  string name = 1;
}

// 响应消息
message HelloReply {
  string message = 1;
}
```



### 生成 C++ 代码

使用 `protoc` 编译器生成 C++ 代码：

```bash showLineNumbers
protoc -I=. --cpp_out=. helloworld.proto
protoc -I=. --grpc_out=. --plugin=protoc-gen-grpc=`which grpc_cpp_plugin` helloworld.proto
```

这将生成以下文件：

- `helloworld.pb.h` 和 `helloworld.pb.cc`：包含消息类的定义和实现。
- `helloworld.grpc.pb.h` 和 `helloworld.grpc.pb.cc`：包含服务类的定义和实现。



### 实现服务器端

创建一个名为 `server.cpp` 的文件，内容如下：

```cpp showLineNumbers title="server.cpp"
#include <iostream>
#include <memory>
#include <string>

#include <grpcpp/grpcpp.h>
#include "helloworld.grpc.pb.h"

using grpc::Server;
using grpc::ServerBuilder;
using grpc::ServerContext;
using grpc::Status;
using helloworld::Greeter;
using helloworld::HelloRequest;
using helloworld::HelloReply;

// 服务实现
class GreeterServiceImpl final : public Greeter::Service {
  Status SayHello(ServerContext* context, const HelloRequest* request,
                  HelloReply* reply) override {
    std::string prefix("Hello ");
    reply->set_message(prefix + request->name());
    return Status::OK;
  }
};

void RunServer() {
  std::string server_address("0.0.0.0:50051");
  GreeterServiceImpl service;

  ServerBuilder builder;
  // 监听指定地址
  builder.AddListeningPort(server_address, grpc::InsecureServerCredentials());
  // 注册服务
  builder.RegisterService(&service);
  // 构建并启动服务器
  std::unique_ptr<Server> server(builder.BuildAndStart());
  std::cout << "Server listening on " << server_address << std::endl;

  // 等待服务器关闭
  server->Wait();
}

int main(int argc, char** argv) {
  RunServer();
  return 0;
}
```



### 实现客户端

创建一个名为 `client.cpp` 的文件，内容如下：

```cpp showLineNumbers title="client.cpp"
#include <iostream>
#include <memory>
#include <string>

#include <grpcpp/grpcpp.h>
#include "helloworld.grpc.pb.h"

using grpc::Channel;
using grpc::ClientContext;
using grpc::Status;
using helloworld::Greeter;
using helloworld::HelloRequest;
using helloworld::HelloReply;

class GreeterClient {
 public:
  GreeterClient(std::shared_ptr<Channel> channel)
      : stub_(Greeter::NewStub(channel)) {}

  std::string SayHello(const std::string& user) {
    // 准备请求
    HelloRequest request;
    request.set_name(user);

    // 准备响应
    HelloReply reply;

    // 上下文
    ClientContext context;

    // 发起 RPC 调用
    Status status = stub_->SayHello(&context, request, &reply);

    // 处理响应
    if (status.ok()) {
      return reply.message();
    } else {
      std::cerr << "RPC failed: " << status.error_message() << std::endl;
      return "RPC failed";
    }
  }

 private:
  std::unique_ptr<Greeter::Stub> stub_;
};

int main(int argc, char** argv) {
  // 创建客户端
  GreeterClient greeter(grpc::CreateChannel("localhost:50051", grpc::InsecureChannelCredentials()));
  std::string user("world");
  std::string reply = greeter.SayHello(user);
  std::cout << "Greeter received: " << reply << std::endl;

  return 0;
}
```



### 编译和运行

使用以下命令编译服务器和客户端：

```bash showLineNumbers
g++ -std=c++11 server.cpp helloworld.pb.cc helloworld.grpc.pb.cc -o server `pkg-config --cflags --libs grpc++ grpc`
g++ -std=c++11 client.cpp helloworld.pb.cc helloworld.grpc.pb.cc -o client `pkg-config --cflags --libs grpc++ grpc`
```

编译完成后，首先启动服务器：

```bash
./server
```

然后在另一个终端窗口中运行客户端：

```bash
./client
```

客户端将输出：

```bash
Greeter received: Hello world
```



## 相关链接

- 项目网址：[http://www.grpc.io](http://www.grpc.io)
- GitHub 仓库：[https://github.com/grpc/grpc](https://github.com/grpc/grpc)

