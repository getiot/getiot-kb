---
sidebar_position: 2
slug: /rust-tcp-echo-server
---

# TCP Echo Server

Echo Server 会把收到的数据原样发回去。它很适合用来理解 TCP 的监听、连接、读取和写入。

## 服务端代码

```rust title="src/main.rs" showLineNumbers
use std::io::{Read, Write};
use std::net::TcpListener;

fn main() -> std::io::Result<()> {
    let listener = TcpListener::bind("127.0.0.1:7878")?;
    println!("listening on 127.0.0.1:7878");

    for stream in listener.incoming() {
        let mut stream = stream?;
        let mut buf = [0; 1024];

        let n = stream.read(&mut buf)?;
        stream.write_all(&buf[..n])?;
    }

    Ok(())
}
```

## 测试服务

启动服务后，可以在另一个终端使用 `nc` 测试：

```bash
nc 127.0.0.1 7878
```

输入：

```text
hello
```

你会收到同样的内容。

## 这个版本的限制

这个示例一次只处理一个连接，而且每个连接只读一次。它适合学习 TCP 基本流程，不适合作为生产服务器。

## 小结

TCP Server 的基本步骤是：`bind` 地址，`incoming` 接收连接，从 `TcpStream` 读取数据，再写回响应。

