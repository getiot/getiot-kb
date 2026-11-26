---
sidebar_label: WebSocket
sidebar_position: 10
slug: /websocket
---

# WebSocket

WebSocket 是 HTML5 提供的一种新的网络通讯协议，用于在客户端和服务器（浏览器和服务器）之间建立连接，并使它们之间能够实时通信。

## WebSocket 和 HTTP 的区别

我们知道，HTTP 的工作模式是请求-响应模式，是不支持持久连接的（长连接，循环连接的不算）。而 WebSocket 的主要区别在于，它允许你接收数据，而不必像 HTTP 中那样单独发送请求。连接建立后，数据会自己来，而不需要发送请求。

简单来说，WebSocket 协议可以同时接收和发送信息，允许全双工双向通信，从而实现更快的信息交换。

WebSocket 作为一种新协议，和 HTTP 协议基本没有关系，相同的地方只有为了兼容现有浏览器的握手规范而借用的 HTTP 的协议。

## WebSocket 应用场景

当你需要实时数据更新和向客户端发送消息的能力时，WebSocket 协议是理想的选择。常见的应用案例包括社交网络、推送通知、聊天应用、聊天机器人、IoT 应用等。

例如在聊天或股票应用中，使用 WebSocket 协议就可以实时接收不断更新的信息。

## WebSocket 示例

```javascript showLineNumbers
let socket = new WebSocket("wss://getiot.tech/websocket/demo/hello");

socket.onopen = function(e) {
  alert("[open] Connection established");
  alert("Sending to server");
  socket.send("My name is John");
};

socket.onmessage = function(event) {
  alert(`[message] Data received from server: ${event.data}`);
};

socket.onclose = function(event) {
  if (event.wasClean) {
    alert(`[close] Connection closed cleanly, code=${event.code} reason=${event.reason}`);
  } else {
    // e.g. server process killed or network down
    // event.code is usually 1006 in this case
    alert('[close] Connection died');
  }
};

socket.onerror = function(error) {
  alert(`[error]`);
};
```

## 相关链接

- [WebSocket Introduction](https://javascript.info/websocket)
- [The WebSocket API (WebSockets)
](https://developer.mozilla.org/en-US/docs/Web/API/WebSockets_API)
