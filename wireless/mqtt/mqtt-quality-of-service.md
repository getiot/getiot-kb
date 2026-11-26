---
sidebar_position: 4
authors: [luhuadong]
---

# MQTT 服务质量



MQTT 协议提供了 3 种消息服务质量等级（Quality of Service），它保证了在不同的网络环境下消息传递的可靠性。

- QoS 0：消息最多传递一次，如果当时客户端不可用，则会丢失该消息。
- QoS 1：消息传递至少 1 次。
- QoS 2：消息仅传送一次。


