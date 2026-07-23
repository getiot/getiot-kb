---
sidebar_position: 1
slug: /rust-ip-socket-addr
---

# IP 地址与 Socket 地址

网络程序经常需要处理地址。Rust 用 `IpAddr` 表示 IP 地址，用 `SocketAddr` 表示 IP 加端口。

## 解析 IP 地址

```rust title="src/main.rs" showLineNumbers
use std::net::IpAddr;

fn main() {
    let ip: IpAddr = "127.0.0.1".parse().unwrap();
    println!("{ip}");
}
```

`parse()` 会根据目标类型解析字符串。

## SocketAddr

```rust
use std::net::SocketAddr;

let addr: SocketAddr = "127.0.0.1:8080".parse().unwrap();
println!("ip={}, port={}", addr.ip(), addr.port());
```

`127.0.0.1:8080` 表示本机的 `8080` 端口。

## 常见地址

- `127.0.0.1`：本机回环地址，只能本机访问
- `0.0.0.0`：监听所有 IPv4 网卡
- `localhost`：通常解析到本机地址

:::note
开发测试时常用 `127.0.0.1`。如果你希望局域网其他设备访问服务，通常要监听 `0.0.0.0`，并检查防火墙设置。
:::

## 小结

IP 地址定位主机，Port 定位进程，`SocketAddr` 把它们组合起来。写网络程序时，先确认程序监听在哪个地址和端口。

