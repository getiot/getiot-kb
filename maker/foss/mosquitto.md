---
sidebar_position: 23
slug: /mosquitto
---

# Mosquitto



![](https://static.getiot.tech/mosquitto-logo.png#center-300)



## 简介

**Mosquitto** 是一款开源的 MQTT 消息代理（服务器）软件，由 Eclipse 基金会主导开发，采用 EPL（Eclipse Public License 2.0）和 EDL（Eclipse Distribution License 1.0）双重许可。

Mosquitto 提供轻量级的、支持可发布/可订阅的的消息推送模式，使设备对设备之间的短消息通信变得简单，比如现在应用广泛的低功耗传感器，手机、嵌入式计算机、微型控制器等移动设备。

Mosquitto 安装之后默认提供了 mosquitto_pub 和 mosquitto_sub 两个命令行 MQTT 客户端工具。Mosquitto CLI 有多个配置选项，支持 TLS 证书连接、通过代理服务器连接，支持 debug 模式，在 debug 模式下可以获取更详细的消息信息。

Mosquitto 相关工具和文件说明如下：

- [mosquitto](https://mosquitto.org/man/mosquitto-8.html)：Mosquitto 代理服务器
- [mosquitto.conf](https://mosquitto.org/man/mosquitto-conf-5.html)：Mosquitto 代理服务器的配置文件
- [mosquitto_passwd](https://mosquitto.org/man/mosquitto_passwd-1.html)：用于生成 Mosquitto 密码文件的命令行实用工具
- [mosquitto_pub](https://mosquitto.org/man/mosquitto_pub-1.html)：用于将消息发布到代理服务器的命令行实用工具
- [mosquitto_sub](https://mosquitto.org/man/mosquitto_sub-1.html)：用于订阅代理服务器上的主题的命令行实用工具
- [mosquitto_rr](https://mosquitto.org/man/mosquitto_rr-1.html)：用于使用代理服务器进行简单的请求/响应（request/response）的命令行实用工具



## 使用

### 安装

通过 SSH 登录 Linux 系统（比如树莓派），执行下面命令安装 mosquitto。

**安装 mosquitto 服务器（broker）**

```shell
sudo apt install mosquitto
```

安装完后会有 mosquitto 和 mosquitto_passwd 两个命令行工具。

**安装 mosquitto 客户端**

```shell
sudo apt install mosquitto-clients
```

安装完后会有 mosquitto_pub、mosquitto_rr 和 mosquitto_sub 三个命令行工具。

### 测试

接着再打开另一个 SSH 连接，这里把它称为 SSH2（前面那个终端称为 SSH1），其中 SSH1 作为订阅者（subscriber），SSH2 作为发布者（publisher）。

[SSH1]：订阅 test/topic1 主题

```shell
mosquitto_sub -d -t test/topic1
```

[SSH2]：发布 test/topic1 主题的消息

```shell
mosquitto_pub -d -t test/topic1 -m "hello, getiot.tech"
```

看看 [SSH1] 是否已经收到消息？



## 参数配置

1.retry_interval

当QoS为1或2的消息已经被发送后，mosquitto在一段时间内仍未接收到客户端的反馈消息,将重新发送消息。 默认为20秒

2.sys_interval

每隔一段时间将更新$SYS层级话题的状态，其中包含着proker的状态信息。 默认为10秒

3.store_clean_interval

表示间隔多长时间将不再被使用的消息销毁掉。该值越小，使用的内存就会越小但会需要更多的处理时间。 如果设置为0，表示不被

使用的消息将会及时销毁。 默认为10秒

\4. pid_file  默认为/var/run/mosquitto.pid

5.user  设置mosquitto启动用户

6.max_inflight_messages

表示允许多大数量的QoS为1或2消息被同时进行传输处理。这些消息包括正在进行握手的消息和进行重新发送的消息。默认为20个，

如果设置为0，表示不设限制；如果为1，则会确保消息被顺序处理。

7.max_queued_messages

表示允许多大数量的QoS为1或2消息在队列中进行排队。 默认为100个

8.max_connections

设置最大的连接数  -1表示不限制

9.autosave_interval

表示当开启持久化设置时，间隔多少时间mosquitto会把内存中的消息保存到磁盘中。默认为30分钟，当设置为0时，只有mosquitto

关闭的时候才会写的磁盘中。

10.persistence

设置为true时，所有的连接，订阅和消息数据都会被保存到磁盘的mosquitto.db文件中。当mosquitto重启的时候，它会从mosquitto.db文件中

重新加载数据。

11.persistence_location  默认为/var/lib/mosquitto/

12.log_dest

设置日志的输出目的地 可以是：stdout stderr syslog topic  如果输出到某个文件的话可以这样设置log_dest file /var/log/mosquitto.log  要赋予对mosquitto.log文件的读写权限。

13.log_type  日志类型：debug, error, warning, notice, information, subscribe, unsubscribe, websockets, none, all

14.log_timestamp  是否记录日志时间

15.clientid_prefixes

设置只有clientId以某个前缀开始的客户端才允许连接到mosquitto broker.

16.allow_duplicate_messages

如果一个客户端订阅了多个topic时，设置是否允许接收重复的消息。比如订阅了foo/# 和 foo/+/baz。

17.autosave_on_changes

If true, mosquitto will count the

number of subscription changes, retained messages received and queued

messages and if the total exceeds autosave_interval then the in-memory

database will be saved to disk. If false, mosquitto will save the

in-memory database to disk by treating autosave_interval as a time in

seconds

18.persistent_client_expiration

持久订阅的过期设置。 对于将clean session设置为false的持久订阅客户端，如果在一定的时间段里面没有重新连接mosquitto将会被移除。

这并不是一个标准的配置项，因为对于ＭＱＴＴ协议来说所有的持久订阅应该是永远有效的。

如：　persistent_client_expiration 2m　　persistent_client_expiration 14d　persistent_client_expiration 1y

ｈ：小时　　ｄ：天　　ｍ：月　　ｙ：年

19.queue_qos0_messages　是否将ＱｏＳ为０的消息计算到max_queued_messages参数中



## 主题

客户端可以通过订阅$SYS树来查询broker的信息。标记为static的topic只在客户端订阅时发送一次，其他的topic会每隔sys_interval 秒更新一次， 如果sys_interval 为0，则不会发送更新。

注意，如果使用命令行与 `$SYS` topic交互，shell会把 `$` 解析为环境变量，所以需要将topic用单引号括起来例如’ `$SYS/...`’或者使用转义字符，例如 `$SYS/..`

下面列出了所有相关的topic

```bash
$SYS/broker/bytes/received
```

Broker从启动之后至今接收到的字节总数

The total number of bytes received since the broker started.

```bash
$SYS/broker/bytes/sent
```

Broker从启动之后至今发送的字节总数

The total number of bytes sent since the broker started.

```bash
$SYS/broker/clients/connected,
$SYS/broker/clients/active (不再使用)
```

当前连接的客户端的总数

The number of currently connected clients.

```bash
$SYS/broker/clients/expired
```

The number of disconnected persistent clients that have been expired and removed through the persistent_client_expiration option.

```bash
$SYS/broker/clients/disconnected,
$SYS/broker/clients/inactive (deprecated)
```

The total number of persistent clients (with clean session disabled) that are registered at the broker but are currently disconnected.

```bash
$SYS/broker/clients/maximum
```

The maximum number of clients that have been connected to the broker at the same time.

```bash
$SYS/broker/clients/total
```

The total number of active and inactive clients currently connected and registered on the broker.

```bash
$SYS/broker/connection/#
```

When bridges are configured to/from the broker, common practice is to provide a status topic that indicates the state of the connection. This is provided within $SYS/broker/connection/ by default. If the value of the topic is 1 the connection is active, if 0 then it is not active. See the Bridges section below for more information on bridges.

```bash
$SYS/broker/heap/current size
```

The current size of the heap memory in use by mosquitto. Note that this topic may be unavailable depending on compile time options.

```bash
$SYS/broker/heap/maximum size
```

The largest amount of heap memory used by mosquitto. Note that this topic may be unavailable depending on compile time options.

```bash
$SYS/broker/load/connections/+
```

The moving average of the number of CONNECT packets received by the broker over different time intervals. The final "+" of the hierarchy can be 1min, 5min or 15min. The value returned represents the number of connections received in 1 minute, averaged over 1, 5 or 15 minutes.

```bash
$SYS/broker/load/bytes/received/+
```

The moving average of the number of bytes received by the broker over different time intervals. The final "+" of the hierarchy can be 1min, 5min or 15min. The value returned represents the number of bytes received in 1 minute, averaged over 1, 5 or 15 minutes.

```bash
$SYS/broker/load/bytes/sent/+
```

The moving average of the number of bytes sent by the broker over different time intervals. The final "+" of the hierarchy can be 1min, 5min or 15min. The value returned represents the number of bytes sent in 1 minute, averaged over 1, 5 or 15 minutes.

```bash
$SYS/broker/load/messages/received/+
```

The moving average of the number of all types of MQTT messages received by the broker over different time intervals. The final "+" of the hierarchy can be 1min, 5min or 15min. The value returned represents the number of messages received in 1 minute, averaged over 1, 5 or 15 minutes.

```bash
$SYS/broker/load/messages/sent/+
```

The moving average of the number of all types of MQTT messages sent by the broker over different time intervals. The final "+" of the hierarchy can be 1min, 5min or 15min. The value returned represents the number of messages send in 1 minute, averaged over 1, 5 or 15 minutes.

```bash
$SYS/broker/load/publish/dropped/+
```

The moving average of the number of publish messages dropped by the broker over different time intervals. This shows the rate at which durable clients that are disconnected are losing messages. The final "+" of the hierarchy can be 1min, 5min or 15min. The value returned represents the number of messages dropped in 1 minute, averaged over 1, 5 or 15 minutes.

```bash
$SYS/broker/load/publish/received/+
```

The moving average of the number of publish messages received by the broker over different time intervals. The final "+" of the hierarchy can be 1min, 5min or 15min. The value returned represents the number of publish messages received in 1 minute, averaged over 1, 5 or 15 minutes.

```bash
$SYS/broker/load/publish/sent/+
```

The moving average of the number of publish messages sent by the broker over different time intervals. The final "+" of the hierarchy can be 1min, 5min or 15min. The value returned represents the number of publish messages sent in 1 minute, averaged over 1, 5 or 15 minutes.

```bash
$SYS/broker/load/sockets/+
```

The moving average of the number of socket connections opened to the broker over different time intervals. The final "+" of the hierarchy can be 1min, 5min or 15min. The value returned represents the number of socket connections in 1 minute, averaged over 1, 5 or 15 minutes.

```bash
$SYS/broker/messages/inflight
```

The number of messages with QoS>0 that are awaiting acknowledgments.

```bash
$SYS/broker/messages/received
```

The total number of messages of any type received since the broker started.

```bash
$SYS/broker/messages/sent
```

The total number of messages of any type sent since the broker started.

```bash
$SYS/broker/publish/messages/dropped
```

The total number of publish messages that have been dropped due to inflight/queuing limits. See the max_inflight_messages and max_queued_messages options in mosquitto.conf(5) for more information.

```bash
$SYS/broker/publish/messages/received
```

The total number of PUBLISH messages received since the broker started.

```bash
$SYS/broker/publish/messages/sent
```

The total number of PUBLISH messages sent since the broker started.

```bash
$SYS/broker/retained messages/count
```

The total number of retained messages active on the broker.

```bash
$SYS/broker/store/messages/count,
$SYS/broker/messages/stored (deprecated)
```

The number of messages currently held in the message store. This includes retained messages and messages queued for durable clients.

```bash
$SYS/broker/store/messages/bytes
```

The number of bytes currently held by message payloads in the message store. This includes retained messages and messages queued for durable clients.

```bash
$SYS/broker/subscriptions/count
```

The total number of subscriptions active on the broker.

```bash
$SYS/broker/version
```

The version of the broker. Static.



## 状态

通过 netstat 命令查看 mosquitto 链接数量

```bash
netstat -an | grep 1883
```





## 相关链接

- 项目官网：[https://mosquitto.org](https://mosquitto.org/)
- 文档中心：[https://mosquitto.org/documentation/](https://mosquitto.org/documentation/)
- GitHub 仓库：[https://github.com/eclipse/mosquitto](https://github.com/eclipse/mosquitto)
- API 手册：[https://mosquitto.org/api/files/mosquitto-h.html](https://mosquitto.org/api/files/mosquitto-h.html)



## 参考

- [https://raspberry-valley.azurewebsites.net/Mosquitto/](https://raspberry-valley.azurewebsites.net/Mosquitto/)
- [mosquitto查看系统状态信息](https://blog.csdn.net/lclfans1983/article/details/105740622)

