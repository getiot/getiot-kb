---
sidebar_position: 1
slug: /java-networking
sidebar_label: Java 网络编程基础
---

# Java 网络编程基础

网络编程是 Java 应用开发中的重要部分。理解网络编程的基础概念是进行网络应用开发的前提。本章将详细介绍 Java 中的网络编程基础。

## TCP 与 UDP 区别

### TCP（传输控制协议）

**TCP**（Transmission Control Protocol）是面向连接的可靠传输协议。

**特点**：
- **面向连接**：需要先建立连接
- **可靠传输**：保证数据顺序和完整性
- **流量控制**：控制发送速度
- **拥塞控制**：避免网络拥塞
- **全双工**：可以同时双向通信

**适用场景**：
- 需要可靠传输的场景（文件传输、网页浏览）
- 需要保证数据顺序的场景
- 对数据完整性要求高的场景

```java
// TCP 示例：需要建立连接
Socket socket = new Socket("localhost", 8080);
// 连接建立后才能通信
```

### UDP（用户数据报协议）

**UDP**（User Datagram Protocol）是无连接的不可靠传输协议。

**特点**：
- **无连接**：不需要建立连接
- **不可靠**：不保证数据到达和顺序
- **速度快**：开销小，传输快
- **无流量控制**：可能丢包
- **单播/多播/广播**：支持多种传输方式

**适用场景**：
- 对速度要求高的场景（视频直播、游戏）
- 可以容忍少量丢包的场景
- 实时性要求高的场景

```java
// UDP 示例：不需要建立连接
DatagramSocket socket = new DatagramSocket();
// 直接发送数据包
```

### TCP vs UDP 对比

| 特性 | TCP | UDP |
|:----:|:---:|:---:|
| 连接 | 面向连接 | 无连接 |
| 可靠性 | 可靠 | 不可靠 |
| 速度 | 较慢 | 较快 |
| 开销 | 较大 | 较小 |
| 顺序 | 保证顺序 | 不保证顺序 |
| 适用场景 | 文件传输、网页 | 视频、游戏 |

## 核心类库

### InetAddress 类

**`InetAddress`** 表示 IP 地址。

```java
import java.net.InetAddress;

// 获取本地主机地址
InetAddress localhost = InetAddress.getLocalHost();
System.out.println("本地主机：" + localhost.getHostName());
System.out.println("IP 地址：" + localhost.getHostAddress());

// 根据主机名获取地址
InetAddress address = InetAddress.getByName("www.example.com");
System.out.println("IP 地址：" + address.getHostAddress());

// 获取所有地址
InetAddress[] addresses = InetAddress.getAllByName("www.example.com");
for (InetAddress addr : addresses) {
    System.out.println("IP：" + addr.getHostAddress());
}
```

### Socket 类（客户端）

**`Socket`** 表示客户端套接字，用于连接服务器。

```java
import java.net.Socket;
import java.io.*;

// 创建 Socket 连接
Socket socket = new Socket("localhost", 8080);

// 获取输入输出流
InputStream is = socket.getInputStream();
OutputStream os = socket.getOutputStream();

// 读写数据
os.write("Hello".getBytes());
byte[] buffer = new byte[1024];
int length = is.read(buffer);

// 关闭连接
socket.close();
```

### ServerSocket 类（服务器）

**`ServerSocket`** 表示服务器套接字，用于监听客户端连接。

```java
import java.net.ServerSocket;
import java.net.Socket;

// 创建服务器套接字
ServerSocket serverSocket = new ServerSocket(8080);

// 等待客户端连接
Socket clientSocket = serverSocket.accept();  // 阻塞等待

// 处理客户端连接
InputStream is = clientSocket.getInputStream();
OutputStream os = clientSocket.getOutputStream();

// 关闭
clientSocket.close();
serverSocket.close();
```

## 简单客户端与服务器示例

### 示例 1：TCP 客户端-服务器

**服务器端**：

```java
import java.net.*;
import java.io.*;

public class TCPServer {
    public static void main(String[] args) throws IOException {
        ServerSocket serverSocket = new ServerSocket(8080);
        System.out.println("服务器启动，等待客户端连接...");
        
        while (true) {
            Socket clientSocket = serverSocket.accept();
            System.out.println("客户端连接：" + clientSocket.getInetAddress());
            
            // 处理客户端请求
            new Thread(() -> {
                try {
                    handleClient(clientSocket);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }).start();
        }
    }
    
    private static void handleClient(Socket socket) throws IOException {
        try (BufferedReader reader = new BufferedReader(
                new InputStreamReader(socket.getInputStream()));
             PrintWriter writer = new PrintWriter(
                socket.getOutputStream(), true)) {
            
            String request = reader.readLine();
            System.out.println("收到请求：" + request);
            
            // 响应
            writer.println("服务器响应：" + request);
        } finally {
            socket.close();
        }
    }
}
```

**客户端**：

```java
import java.net.*;
import java.io.*;

public class TCPClient {
    public static void main(String[] args) throws IOException {
        Socket socket = new Socket("localhost", 8080);
        
        try (BufferedReader reader = new BufferedReader(
                new InputStreamReader(socket.getInputStream()));
             PrintWriter writer = new PrintWriter(
                socket.getOutputStream(), true)) {
            
            // 发送请求
            writer.println("Hello, Server!");
            
            // 接收响应
            String response = reader.readLine();
            System.out.println("服务器响应：" + response);
        } finally {
            socket.close();
        }
    }
}
```

### 示例 2：UDP 客户端-服务器

**服务器端**：

```java
import java.net.*;

public class UDPServer {
    public static void main(String[] args) throws IOException {
        DatagramSocket socket = new DatagramSocket(8080);
        byte[] buffer = new byte[1024];
        
        while (true) {
            DatagramPacket packet = new DatagramPacket(buffer, buffer.length);
            socket.receive(packet);  // 接收数据包
            
            String message = new String(packet.getData(), 0, packet.getLength());
            System.out.println("收到消息：" + message);
            
            // 发送响应
            String response = "服务器收到：" + message;
            byte[] responseData = response.getBytes();
            DatagramPacket responsePacket = new DatagramPacket(
                responseData, 
                responseData.length,
                packet.getAddress(),
                packet.getPort()
            );
            socket.send(responsePacket);
        }
    }
}
```

**客户端**：

```java
import java.net.*;

public class UDPClient {
    public static void main(String[] args) throws IOException {
        DatagramSocket socket = new DatagramSocket();
        
        String message = "Hello, Server!";
        byte[] data = message.getBytes();
        InetAddress serverAddress = InetAddress.getByName("localhost");
        
        // 发送数据包
        DatagramPacket packet = new DatagramPacket(
            data, 
            data.length, 
            serverAddress, 
            8080
        );
        socket.send(packet);
        
        // 接收响应
        byte[] buffer = new byte[1024];
        DatagramPacket responsePacket = new DatagramPacket(buffer, buffer.length);
        socket.receive(responsePacket);
        
        String response = new String(responsePacket.getData(), 0, responsePacket.getLength());
        System.out.println("服务器响应：" + response);
        
        socket.close();
    }
}
```

### 示例 3：多客户端服务器

```java
import java.net.*;
import java.io.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class MultiClientServer {
    private static final int PORT = 8080;
    private static final ExecutorService executor = Executors.newFixedThreadPool(10);
    
    public static void main(String[] args) throws IOException {
        ServerSocket serverSocket = new ServerSocket(PORT);
        System.out.println("服务器启动，端口：" + PORT);
        
        while (true) {
            Socket clientSocket = serverSocket.accept();
            System.out.println("新客户端连接：" + clientSocket.getInetAddress());
            
            executor.submit(() -> {
                try {
                    handleClient(clientSocket);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            });
        }
    }
    
    private static void handleClient(Socket socket) throws IOException {
        try (BufferedReader reader = new BufferedReader(
                new InputStreamReader(socket.getInputStream()));
             PrintWriter writer = new PrintWriter(
                socket.getOutputStream(), true)) {
            
            String line;
            while ((line = reader.readLine()) != null) {
                System.out.println("收到：" + line);
                writer.println("Echo: " + line);
            }
        } finally {
            socket.close();
        }
    }
}
```

## 网络编程的最佳实践

### 1. 使用 try-with-resources

```java
// ✅ 推荐：自动关闭资源
try (Socket socket = new Socket("localhost", 8080)) {
    // 使用 socket
}

// ❌ 不推荐：手动关闭
// Socket socket = new Socket("localhost", 8080);
// try {
//     // 使用 socket
// } finally {
//     socket.close();
// }
```

### 2. 处理异常

```java
try {
    Socket socket = new Socket("localhost", 8080);
    // 使用 socket
} catch (ConnectException e) {
    System.err.println("连接失败：" + e.getMessage());
} catch (IOException e) {
    System.err.println("IO 错误：" + e.getMessage());
}
```

### 3. 设置超时

```java
Socket socket = new Socket();
socket.connect(new InetSocketAddress("localhost", 8080), 5000);  // 5 秒超时
socket.setSoTimeout(3000);  // 读写超时 3 秒
```

### 4. 使用线程池处理多客户端

```java
ExecutorService executor = Executors.newFixedThreadPool(10);

while (true) {
    Socket client = serverSocket.accept();
    executor.submit(() -> handleClient(client));
}
```

## 小结

Java 网络编程基础要点：

- **TCP**：面向连接，可靠传输
- **UDP**：无连接，快速传输
- **Socket**：客户端套接字
- **ServerSocket**：服务器套接字
- **InetAddress**：IP 地址表示

**关键要点**：
- TCP 可靠但慢，UDP 快但不可靠
- Socket 用于客户端连接
- ServerSocket 用于服务器监听
- 使用线程池处理多客户端
- 正确处理异常和资源关闭

理解了网络编程基础，你就能开发网络应用。在下一章，我们将学习 Java Socket 编程。
