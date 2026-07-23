---
sidebar_position: 4
slug: /rust-udp-example
---

# UDP 收发示例

UDP 不需要先建立连接。你可以把它理解成发送一封短消息：消息可能到达，也可能丢失，顺序也不一定可靠。

## UDP Server

```rust title="src/main.rs" showLineNumbers
use std::net::UdpSocket;

fn main() -> std::io::Result<()> {
    let socket = UdpSocket::bind("127.0.0.1:9000")?;
    let mut buf = [0; 1024];

    let (n, peer) = socket.recv_from(&mut buf)?;
    println!("from {peer}: {}", String::from_utf8_lossy(&buf[..n]));

    socket.send_to(b"ok", peer)?;
    Ok(())
}
```

## UDP Client

```rust title="src/main.rs" showLineNumbers
use std::net::UdpSocket;

fn main() -> std::io::Result<()> {
    let socket = UdpSocket::bind("127.0.0.1:0")?;
    socket.send_to(b"ping", "127.0.0.1:9000")?;

    let mut buf = [0; 1024];
    let (n, _) = socket.recv_from(&mut buf)?;
    println!("{}", String::from_utf8_lossy(&buf[..n]));

    Ok(())
}
```

`127.0.0.1:0` 表示让操作系统自动选择一个本地端口。

## 适用场景

UDP 常用于对延迟敏感、能容忍丢包的场景，例如部分实时音视频、局域网发现、简单传感器数据上报等。

## 小结

UDP 的基本动作是 `bind`、`send_to`、`recv_from`。它比 TCP 更轻，但可靠性需要你自己在应用层处理。

