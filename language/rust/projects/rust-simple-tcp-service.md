---
sidebar_position: 3
slug: /rust-simple-tcp-service
---

# 简单 TCP 服务

这个项目把 TCP Server 和多线程结合起来：每个连接由一个线程处理，服务端返回一段固定响应。

## 服务端代码

```rust title="src/main.rs" showLineNumbers
use std::io::{Read, Write};
use std::net::{TcpListener, TcpStream};
use std::thread;

fn handle_client(mut stream: TcpStream) -> std::io::Result<()> {
    let mut buf = [0; 1024];
    let n = stream.read(&mut buf)?;

    println!("request: {}", String::from_utf8_lossy(&buf[..n]));
    stream.write_all(b"HTTP/1.1 200 OK\r\nContent-Length: 12\r\n\r\nHello Rust!\n")?;

    Ok(())
}

fn main() -> std::io::Result<()> {
    let listener = TcpListener::bind("127.0.0.1:7878")?;
    println!("listen on http://127.0.0.1:7878");

    for stream in listener.incoming() {
        let stream = stream?;

        thread::spawn(move || {
            if let Err(err) = handle_client(stream) {
                eprintln!("client error: {err}");
            }
        });
    }

    Ok(())
}
```

## 测试

启动后用浏览器访问：

```text
http://127.0.0.1:7878
```

或使用：

```bash
curl http://127.0.0.1:7878
```

## 注意限制

这个示例每个连接创建一个线程，适合学习，不适合高并发生产环境。真实服务通常会使用线程池或异步运行时。

## 小结

一个最小 HTTP-like 服务可以帮助你理解网络协议最终仍然建立在字节读写之上。框架隐藏了细节，但你知道底层发生了什么。

