---
sidebar_position: 3
slug: /java-url-http
sidebar_label: Java URL 与 HTTP 访问
---

# Java URL 与 HTTP 访问

URL 和 HTTP 访问是 Web 开发的基础。理解 URL 和 HTTP 客户端的使用是进行 Web 应用开发的关键。本章将详细介绍 Java 中的 URL 和 HTTP 访问。

## URL / URI 类

### URL 类

**`URL`**（Uniform Resource Locator）表示统一资源定位符。

```java
import java.net.URL;

// 创建 URL
URL url = new URL("https://www.example.com:8080/path?param=value#fragment");

// 获取 URL 组成部分
String protocol = url.getProtocol();  // "https"
String host = url.getHost();          // "www.example.com"
int port = url.getPort();             // 8080
String path = url.getPath();          // "/path"
String query = url.getQuery();        // "param=value"
String ref = url.getRef();            // "fragment"
```

### URI 类

**`URI`**（Uniform Resource Identifier）表示统一资源标识符，比 URL 更通用。

```java
import java.net.URI;

// 创建 URI
URI uri = new URI("https://www.example.com/path?param=value");

// URI 操作
URI base = new URI("https://www.example.com");
URI resolved = base.resolve("/path");  // 解析相对路径
URI relativized = base.relativize(resolved);  // 获取相对路径
```

### URL vs URI

| 特性 | URL | URI |
|:----:|:---:|:---:|
| 范围 | 资源定位符 | 资源标识符 |
| 关系 | URL 是 URI 的子集 | URI 更通用 |
| 使用 | 网络资源访问 | 资源标识 |

## HttpURLConnection 使用

### 基本使用

**`HttpURLConnection`** 用于发送 HTTP 请求。

```java
import java.net.*;
import java.io.*;

// 创建连接
URL url = new URL("https://www.example.com");
HttpURLConnection connection = (HttpURLConnection) url.openConnection();

// 设置请求方法
connection.setRequestMethod("GET");

// 设置请求头
connection.setRequestProperty("User-Agent", "Java Client");
connection.setRequestProperty("Accept", "application/json");

// 获取响应码
int responseCode = connection.getResponseCode();

// 读取响应
try (BufferedReader reader = new BufferedReader(
        new InputStreamReader(connection.getInputStream()))) {
    String line;
    while ((line = reader.readLine()) != null) {
        System.out.println(line);
    }
}

connection.disconnect();
```

### 设置连接属性

```java
HttpURLConnection connection = (HttpURLConnection) url.openConnection();

// 请求方法
connection.setRequestMethod("GET");
connection.setRequestMethod("POST");

// 超时设置
connection.setConnectTimeout(5000);  // 连接超时
connection.setReadTimeout(10000);   // 读取超时

// 请求头
connection.setRequestProperty("Content-Type", "application/json");
connection.setRequestProperty("Authorization", "Bearer token");

// 允许输入输出
connection.setDoInput(true);
connection.setDoOutput(true);

// 不使用缓存
connection.setUseCaches(false);
```

## GET 与 POST 请求

### GET 请求

```java
import java.net.*;
import java.io.*;

public class HttpGetExample {
    public static String sendGet(String urlString) throws IOException {
        URL url = new URL(urlString);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        
        connection.setRequestMethod("GET");
        connection.setRequestProperty("User-Agent", "Java Client");
        connection.setConnectTimeout(5000);
        connection.setReadTimeout(10000);
        
        int responseCode = connection.getResponseCode();
        System.out.println("响应码：" + responseCode);
        
        if (responseCode == HttpURLConnection.HTTP_OK) {
            try (BufferedReader reader = new BufferedReader(
                    new InputStreamReader(connection.getInputStream()))) {
                StringBuilder response = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) {
                    response.append(line);
                }
                return response.toString();
            }
        } else {
            return "请求失败，响应码：" + responseCode;
        }
    }
    
    public static void main(String[] args) throws IOException {
        String response = sendGet("https://www.example.com");
        System.out.println(response);
    }
}
```

### POST 请求

```java
import java.net.*;
import java.io.*;

public class HttpPostExample {
    public static String sendPost(String urlString, String data) throws IOException {
        URL url = new URL(urlString);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        
        connection.setRequestMethod("POST");
        connection.setRequestProperty("Content-Type", "application/json");
        connection.setDoOutput(true);
        connection.setConnectTimeout(5000);
        connection.setReadTimeout(10000);
        
        // 发送数据
        try (OutputStream os = connection.getOutputStream()) {
            byte[] input = data.getBytes("UTF-8");
            os.write(input);
            os.flush();
        }
        
        int responseCode = connection.getResponseCode();
        System.out.println("响应码：" + responseCode);
        
        // 读取响应
        if (responseCode == HttpURLConnection.HTTP_OK) {
            try (BufferedReader reader = new BufferedReader(
                    new InputStreamReader(connection.getInputStream()))) {
                StringBuilder response = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) {
                    response.append(line);
                }
                return response.toString();
            }
        } else {
            // 读取错误响应
            try (BufferedReader reader = new BufferedReader(
                    new InputStreamReader(connection.getErrorStream()))) {
                StringBuilder error = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) {
                    error.append(line);
                }
                return "错误：" + error.toString();
            }
        }
    }
    
    public static void main(String[] args) throws IOException {
        String jsonData = "{\"name\":\"张三\",\"age\":20}";
        String response = sendPost("https://api.example.com/users", jsonData);
        System.out.println(response);
    }
}
```

## 示例：下载网页内容

### 示例 1：下载网页

```java
import java.net.*;
import java.io.*;

public class WebPageDownloader {
    public static String downloadPage(String urlString) throws IOException {
        URL url = new URL(urlString);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        
        connection.setRequestMethod("GET");
        connection.setRequestProperty("User-Agent", 
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64)");
        connection.setConnectTimeout(5000);
        connection.setReadTimeout(10000);
        
        int responseCode = connection.getResponseCode();
        if (responseCode == HttpURLConnection.HTTP_OK) {
            try (BufferedReader reader = new BufferedReader(
                    new InputStreamReader(connection.getInputStream(), "UTF-8"))) {
                StringBuilder content = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) {
                    content.append(line).append("\n");
                }
                return content.toString();
            }
        } else {
            throw new IOException("HTTP 错误：" + responseCode);
        }
    }
    
    public static void main(String[] args) {
        try {
            String content = downloadPage("https://www.example.com");
            System.out.println(content);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```

### 示例 2：保存网页到文件

```java
import java.net.*;
import java.io.*;
import java.nio.file.*;

public class WebPageSaver {
    public static void savePage(String urlString, String filename) throws IOException {
        URL url = new URL(urlString);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        
        connection.setRequestMethod("GET");
        connection.setConnectTimeout(5000);
        connection.setReadTimeout(10000);
        
        try (InputStream is = connection.getInputStream();
             FileOutputStream fos = new FileOutputStream(filename)) {
            byte[] buffer = new byte[8192];
            int length;
            while ((length = is.read(buffer)) != -1) {
                fos.write(buffer, 0, length);
            }
        }
        
        System.out.println("网页已保存到：" + filename);
    }
    
    public static void main(String[] args) {
        try {
            savePage("https://www.example.com", "page.html");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```

### 示例 3：HTTP 客户端工具类

```java
import java.net.*;
import java.io.*;
import java.util.Map;

public class HttpClient {
    public static String get(String urlString, Map<String, String> headers) throws IOException {
        URL url = new URL(urlString);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        
        connection.setRequestMethod("GET");
        connection.setConnectTimeout(5000);
        connection.setReadTimeout(10000);
        
        // 设置请求头
        if (headers != null) {
            for (Map.Entry<String, String> entry : headers.entrySet()) {
                connection.setRequestProperty(entry.getKey(), entry.getValue());
            }
        }
        
        return readResponse(connection);
    }
    
    public static String post(String urlString, String data, Map<String, String> headers) throws IOException {
        URL url = new URL(urlString);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        
        connection.setRequestMethod("POST");
        connection.setDoOutput(true);
        connection.setConnectTimeout(5000);
        connection.setReadTimeout(10000);
        
        // 设置请求头
        if (headers != null) {
            for (Map.Entry<String, String> entry : headers.entrySet()) {
                connection.setRequestProperty(entry.getKey(), entry.getValue());
            }
        }
        
        // 发送数据
        if (data != null) {
            try (OutputStream os = connection.getOutputStream()) {
                os.write(data.getBytes("UTF-8"));
                os.flush();
            }
        }
        
        return readResponse(connection);
    }
    
    private static String readResponse(HttpURLConnection connection) throws IOException {
        int responseCode = connection.getResponseCode();
        
        InputStream inputStream = responseCode >= 200 && responseCode < 300
            ? connection.getInputStream()
            : connection.getErrorStream();
        
        if (inputStream == null) {
            return "响应码：" + responseCode;
        }
        
        try (BufferedReader reader = new BufferedReader(
                new InputStreamReader(inputStream, "UTF-8"))) {
            StringBuilder response = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                response.append(line).append("\n");
            }
            return response.toString();
        }
    }
}
```

### 示例 4：处理重定向

```java
import java.net.*;

public class RedirectHandler {
    public static String followRedirects(String urlString) throws IOException {
        URL url = new URL(urlString);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        
        connection.setInstanceFollowRedirects(false);  // 手动处理重定向
        
        int responseCode = connection.getResponseCode();
        
        // 处理重定向
        if (responseCode == HttpURLConnection.HTTP_MOVED_PERM ||
            responseCode == HttpURLConnection.HTTP_MOVED_TEMP ||
            responseCode == HttpURLConnection.HTTP_SEE_OTHER) {
            String location = connection.getHeaderField("Location");
            return followRedirects(location);  // 递归跟随
        }
        
        // 读取内容
        try (BufferedReader reader = new BufferedReader(
                new InputStreamReader(connection.getInputStream()))) {
            StringBuilder content = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                content.append(line);
            }
            return content.toString();
        }
    }
}
```

## HTTP 客户端的最佳实践

### 1. 使用 try-with-resources

```java
// ✅ 推荐
try (InputStream is = connection.getInputStream()) {
    // 读取数据
}
```

### 2. 设置超时

```java
connection.setConnectTimeout(5000);
connection.setReadTimeout(10000);
```

### 3. 处理不同响应码

```java
int responseCode = connection.getResponseCode();
if (responseCode == HttpURLConnection.HTTP_OK) {
    // 成功
} else if (responseCode == HttpURLConnection.HTTP_NOT_FOUND) {
    // 未找到
} else {
    // 其他错误
}
```

### 4. 使用 Java 11+ HttpClient（推荐）

```java
// Java 11+ 推荐使用新的 HttpClient
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

HttpClient client = HttpClient.newHttpClient();
HttpRequest request = HttpRequest.newBuilder()
    .uri(URI.create("https://www.example.com"))
    .build();
HttpResponse<String> response = client.send(request, 
    HttpResponse.BodyHandlers.ofString());
System.out.println(response.body());
```

## 小结

Java URL 与 HTTP 访问要点：

- **URL/URI**：表示网络资源地址
- **HttpURLConnection**：发送 HTTP 请求
- **GET 请求**：获取资源
- **POST 请求**：提交数据
- **响应处理**：读取响应内容

**关键要点**：
- URL 用于定位网络资源
- HttpURLConnection 用于 HTTP 通信
- GET 用于获取数据，POST 用于提交数据
- 设置超时和请求头
- 正确处理响应码

理解了 URL 与 HTTP 访问，你就能进行 Web 开发。在下一章，我们将学习 Java JDBC 数据库连接。
