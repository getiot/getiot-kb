---
sidebar_position: 8
authors: [luhuadong]
---

# MQTT 同步和异步



在一些 MQTT 的实现中（例如 paho.mqtt.c）提供了 **同步访问** 和 **异步访问** 两种模式。

- **同步访问**（synchronous）—— 请求时会阻塞在访问处，直到有结果返回；
- **异步访问**（asynchronous）—— 将请求委托给 MQTT  Client，然后直接返回（零等待），当结果返回时调用对应的回调函数。





