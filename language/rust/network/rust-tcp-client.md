---
sidebar_position: 3
slug: /rust-tcp-client
---

# TCP Client

TCP Client 主动连接 Server，然后通过 `TcpStream` 发送和接收字节。

## 客户端代码

你可以配合上一节的 Echo Server 运行：

```rust title="src/main.rs" showLineNumbers
use std::io::{Read, Write};
use std::net::TcpStream;

fn main() -> std::io::Result<()> {
    let mut stream = TcpStream::connect("127.0.0.1:7878")?;

    stream.write_all(b"hello rust")?;

    let mut buf = [0; 1024];
    let n = stream.read(&mut buf)?;

    println!("{}", String::from_utf8_lossy(&buf[..n]));
    Ok(())
}
```

## 字节和字符串

网络传输的是字节，不是 Rust 字符串。`b"hello rust"` 是字节串，`String::from_utf8_lossy` 会把收到的字节尽量转换成可显示文本。

## 常见错误

如果 Server 没有启动，`connect` 会返回类似“connection refused”的错误。

如果端口不一致，Client 会连接到错误位置或连接失败。

## 小结

TCP Client 的主要动作是 `connect`、`write_all`、`read`。你写任何 TCP 客户端时，都可以从这个流程开始。

