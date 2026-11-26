---
sidebar_position: 18
slug: /javascript-get-server-url
---

# JavaScript 获取服务端 IP、端口、URL 等信息



假设一个场景：某台物联网设备对外提供 HTTP 服务，用户可通过设备 IP 地址登录 Web 界面进行操作，Web 前端通过 WebSocket 与后端建立连接，那么 Web 前端如何知道目标设备 websocket 通道的 URL 地址？

实际上，由于 Web 界面是由用户在浏览器输入 URL 访问的（例如路由器的默认 IP 地址 192.168.0.1），因此前端的 HTML 页面理应知道目标设备的 IP 地址。浏览器为每一个打开的窗口创建了一个 Window 对象，表示一个包含 DOM 文档的窗口，因此我们可以通过 JavaScript 脚本从中获取到服务端 IP、端口、URL 等信息。

下面是一些简单的示例：

1. 设置或获取整个 URL 为字符串

   ```javascript
   console.log(window.location.href);
   ```

2. 设置或获取 location 或 URL 的 hostname 和 port 端口号

   ```javascript
   console.log(window.location.host);
   ```

3. 设置或获取与 URL 关联的端口号

   ```javascript
   console.log(window.location.port);
   ```

4. 设置或获取 URL 的协议部分

   ```javascript
   console.log(window.location.protocol);
   ```

5. 设置或获取对象指定的文件名或路径

   ```javascript
   console.log(window.location.pathname);
   ```

6. 设置或获取 href 属性中在井号“#”后面的分段

   ```javascript
   console.log(window.location.hash);
   ```

7. 设置或获取 href 属性中跟在问号后面的部分

   ```javascript
   console.log(window.location.search);
   ```

8. 获取变量的值（截取等号后面的部分）

   ```javascript
   var url = window.location.search;
   console.log(url);
   ```

9. 用来得到当前网页的域名

   ```javascript
   var domain = document.domain;
   console.log(domain);
   ```

10. 设置 WebSocket 通道的 URL

    ```javascript
    var url = "ws://" + window.location.host + "/ws";
    console.log(url);
    ```

完整代码可在 [这里](https://gitee.com/luhuadong/Web_Learning/blob/master/JavaScript/get_server_ip/index.html) 获取。

