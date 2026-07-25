---
sidebar_position: 2
slug: /java-socket
sidebar_label: Java Socket 编程
---

# Java Socket 编程

Socket 是网络编程的核心，用于实现客户端和服务器之间的通信。理解 Socket 的使用是进行网络应用开发的关键。本章将详细介绍 Java 中的 Socket 编程。

## Socket 构造与连接

### 创建 Socket

**创建客户端 Socket**：

```java
import java.net.Socket;
import java.net.InetSocketAddress;

// 方式 1：直接连接
Socket socket = new Socket("localhost", 8080);

// 方式 2：先创建，后连接
Socket socket2 = new Socket();
socket2.connect(new InetSocketAddress("localhost", 8080));

// 方式 3：指定超时
Socket socket3 = new Socket();
socket3.connect(new InetSocketAddress("localhost", 8080), 5000);  // 5 秒超时
```

### Socket 配置

```java
Socket socket = new Socket("localhost", 8080);

// 设置超时
socket.setSoTimeout(3000);  // 读写超时 3 秒

// 设置 TCP 选项
socket.setTcpNoDelay(true);  // 禁用 Nagle 算法
socket.setKeepAlive(true);   // 保持连接
socket.setReuseAddress(true);  // 重用地址

// 获取本地和远程地址
InetAddress localAddress = socket.getLocalAddress();
int localPort = socket.getLocalPort();
InetAddress remoteAddress = socket.getRemoteSocketAddress();
int remotePort = socket.getPort();
```

### 创建 ServerSocket

**创建服务器 Socket**：

```java
import java.net.ServerSocket;

// 创建服务器套接字
ServerSocket serverSocket = new ServerSocket(8080);

// 指定 backlog（等待队列长度）
ServerSocket serverSocket2 = new ServerSocket(8080, 50);

// 绑定到指定地址
ServerSocket serverSocket3 = new ServerSocket();
serverSocket3.bind(new InetSocketAddress("localhost", 8080));
```

## InputStream / OutputStream 读写

### 基本读写

```java
import java.net.Socket;
import java.io.*;

Socket socket = new Socket("localhost", 8080);

// 获取输入输出流
InputStream is = socket.getInputStream();
OutputStream os = socket.getOutputStream();

// 写入数据
String message = "Hello, Server!";
os.write(message.getBytes());
os.flush();

// 读取数据
byte[] buffer = new byte[1024];
int length = is.read(buffer);
String response = new String(buffer, 0, length);
System.out.println("响应：" + response);

socket.close();
```

### 使用 BufferedReader 和 PrintWriter

```java
try (Socket socket = new Socket("localhost", 8080);
     BufferedReader reader = new BufferedReader(
         new InputStreamReader(socket.getInputStream()));
     PrintWriter writer = new PrintWriter(
         socket.getOutputStream(), true)) {
    
    // 发送数据
    writer.println("Hello, Server!");
    
    // 接收数据
    String response = reader.readLine();
    System.out.println("响应：" + response);
}
```

### 使用 DataInputStream 和 DataOutputStream

```java
try (Socket socket = new Socket("localhost", 8080);
     DataInputStream dis = new DataInputStream(socket.getInputStream());
     DataOutputStream dos = new DataOutputStream(socket.getOutputStream())) {
    
    // 发送不同类型的数据
    dos.writeInt(100);
    dos.writeUTF("Hello");
    dos.writeDouble(3.14);
    dos.flush();
    
    // 读取数据
    int intValue = dis.readInt();
    String stringValue = dis.readUTF();
    double doubleValue = dis.readDouble();
}
```

## 简单聊天程序示例

### 示例 1：单客户端聊天服务器

**服务器端**：

```java
import java.net.*;
import java.io.*;

public class ChatServer {
    public static void main(String[] args) throws IOException {
        ServerSocket serverSocket = new ServerSocket(8080);
        System.out.println("聊天服务器启动，等待客户端连接...");
        
        Socket clientSocket = serverSocket.accept();
        System.out.println("客户端已连接：" + clientSocket.getInetAddress());
        
        try (BufferedReader reader = new BufferedReader(
                new InputStreamReader(clientSocket.getInputStream()));
             PrintWriter writer = new PrintWriter(
                clientSocket.getOutputStream(), true);
             BufferedReader consoleReader = new BufferedReader(
                new InputStreamReader(System.in))) {
            
            // 接收消息线程
            Thread receiveThread = new Thread(() -> {
                try {
                    String message;
                    while ((message = reader.readLine()) != null) {
                        System.out.println("客户端：" + message);
                        if ("bye".equalsIgnoreCase(message)) {
                            break;
                        }
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            });
            receiveThread.start();
            
            // 发送消息
            String input;
            while ((input = consoleReader.readLine()) != null) {
                writer.println(input);
                if ("bye".equalsIgnoreCase(input)) {
                    break;
                }
            }
            
            receiveThread.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        } finally {
            clientSocket.close();
            serverSocket.close();
        }
    }
}
```

**客户端**：

```java
import java.net.*;
import java.io.*;

public class ChatClient {
    public static void main(String[] args) throws IOException {
        Socket socket = new Socket("localhost", 8080);
        System.out.println("已连接到服务器");
        
        try (BufferedReader reader = new BufferedReader(
                new InputStreamReader(socket.getInputStream()));
             PrintWriter writer = new PrintWriter(
                socket.getOutputStream(), true);
             BufferedReader consoleReader = new BufferedReader(
                new InputStreamReader(System.in))) {
            
            // 接收消息线程
            Thread receiveThread = new Thread(() -> {
                try {
                    String message;
                    while ((message = reader.readLine()) != null) {
                        System.out.println("服务器：" + message);
                        if ("bye".equalsIgnoreCase(message)) {
                            break;
                        }
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            });
            receiveThread.start();
            
            // 发送消息
            String input;
            while ((input = consoleReader.readLine()) != null) {
                writer.println(input);
                if ("bye".equalsIgnoreCase(input)) {
                    break;
                }
            }
            
            receiveThread.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        } finally {
            socket.close();
        }
    }
}
```

### 示例 2：多客户端聊天服务器

```java
import java.net.*;
import java.io.*;
import java.util.concurrent.*;
import java.util.ArrayList;
import java.util.List;

public class MultiClientChatServer {
    private static final int PORT = 8080;
    private static final List<ClientHandler> clients = new ArrayList<>();
    
    public static void main(String[] args) throws IOException {
        ServerSocket serverSocket = new ServerSocket(PORT);
        System.out.println("聊天服务器启动，端口：" + PORT);
        
        ExecutorService executor = Executors.newCachedThreadPool();
        
        while (true) {
            Socket clientSocket = serverSocket.accept();
            System.out.println("新客户端连接：" + clientSocket.getInetAddress());
            
            ClientHandler handler = new ClientHandler(clientSocket);
            synchronized (clients) {
                clients.add(handler);
            }
            executor.submit(handler);
        }
    }
    
    static class ClientHandler implements Runnable {
        private Socket socket;
        private BufferedReader reader;
        private PrintWriter writer;
        private String username;
        
        public ClientHandler(Socket socket) throws IOException {
            this.socket = socket;
            this.reader = new BufferedReader(
                new InputStreamReader(socket.getInputStream()));
            this.writer = new PrintWriter(
                socket.getOutputStream(), true);
        }
        
        @Override
        public void run() {
            try {
                // 获取用户名
                username = reader.readLine();
                broadcast(username + " 加入聊天室");
                
                String message;
                while ((message = reader.readLine()) != null) {
                    if ("bye".equalsIgnoreCase(message)) {
                        break;
                    }
                    broadcast(username + ": " + message);
                }
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                try {
                    socket.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
                synchronized (clients) {
                    clients.remove(this);
                }
                broadcast(username + " 离开聊天室");
            }
        }
        
        public void sendMessage(String message) {
            writer.println(message);
        }
    }
    
    private static void broadcast(String message) {
        synchronized (clients) {
            for (ClientHandler client : clients) {
                client.sendMessage(message);
            }
        }
    }
}
```

### 示例 3：文件传输

```java
import java.net.*;
import java.io.*;

public class FileTransferServer {
    public static void main(String[] args) throws IOException {
        ServerSocket serverSocket = new ServerSocket(8080);
        System.out.println("文件传输服务器启动");
        
        while (true) {
            Socket clientSocket = serverSocket.accept();
            new Thread(() -> {
                try {
                    handleFileTransfer(clientSocket);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }).start();
        }
    }
    
    private static void handleFileTransfer(Socket socket) throws IOException {
        try (DataInputStream dis = new DataInputStream(socket.getInputStream());
             DataOutputStream dos = new DataOutputStream(socket.getOutputStream())) {
            
            // 接收文件名
            String filename = dis.readUTF();
            System.out.println("接收文件：" + filename);
            
            // 接收文件大小
            long fileSize = dis.readLong();
            
            // 接收文件内容
            try (FileOutputStream fos = new FileOutputStream("received_" + filename)) {
                byte[] buffer = new byte[8192];
                long totalRead = 0;
                int length;
                
                while (totalRead < fileSize && (length = dis.read(buffer)) != -1) {
                    fos.write(buffer, 0, length);
                    totalRead += length;
                }
            }
            
            // 发送确认
            dos.writeUTF("文件接收成功");
            System.out.println("文件接收完成：" + filename);
        } finally {
            socket.close();
        }
    }
}
```

### 示例 4：Echo 服务器

```java
import java.net.*;
import java.io.*;

public class EchoServer {
    public static void main(String[] args) throws IOException {
        ServerSocket serverSocket = new ServerSocket(8080);
        System.out.println("Echo 服务器启动");
        
        while (true) {
            Socket clientSocket = serverSocket.accept();
            new Thread(() -> {
                try (BufferedReader reader = new BufferedReader(
                        new InputStreamReader(clientSocket.getInputStream()));
                     PrintWriter writer = new PrintWriter(
                        clientSocket.getOutputStream(), true)) {
                    
                    String line;
                    while ((line = reader.readLine()) != null) {
                        System.out.println("收到：" + line);
                        writer.println("Echo: " + line);  // 回显
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                } finally {
                    try {
                        clientSocket.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }).start();
        }
    }
}
```

## Socket 编程的最佳实践

### 1. 使用 try-with-resources

```java
// ✅ 推荐
try (Socket socket = new Socket("localhost", 8080)) {
    // 使用 socket
}
```

### 2. 设置超时

```java
Socket socket = new Socket();
socket.connect(new InetSocketAddress("localhost", 8080), 5000);
socket.setSoTimeout(3000);
```

### 3. 使用线程池

```java
ExecutorService executor = Executors.newFixedThreadPool(10);
while (true) {
    Socket client = serverSocket.accept();
    executor.submit(() -> handleClient(client));
}
```

### 4. 正确处理异常

```java
try {
    Socket socket = new Socket("localhost", 8080);
    // 使用 socket
} catch (ConnectException e) {
    System.err.println("连接失败");
} catch (SocketTimeoutException e) {
    System.err.println("连接超时");
} catch (IOException e) {
    System.err.println("IO 错误");
}
```

## 小结

Java Socket 编程要点：

- **Socket 构造**：多种方式创建和连接
- **流操作**：使用 InputStream/OutputStream 读写
- **服务器**：使用 ServerSocket 监听连接
- **多客户端**：使用线程池处理多个客户端
- **最佳实践**：使用 try-with-resources、设置超时

**关键要点**：
- Socket 用于客户端连接
- ServerSocket 用于服务器监听
- 使用流进行数据读写
- 多客户端使用线程池处理
- 正确关闭资源和处理异常

理解了 Socket 编程，你就能开发网络应用。在下一章，我们将学习 Java URL 与 HTTP 访问。
