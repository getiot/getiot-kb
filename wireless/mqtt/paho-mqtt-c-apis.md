---
sidebar_position: 11
authors: [luhuadong]
---

# Paho-MQTT C 库 API 接口



| 接口类型                                                     | 头文件       | 备注       |
| ------------------------------------------------------------ | ------------ | ---------- |
| [Paho MQTT C Client Library](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/) | MQTTClient.h | 非线程安全 |
| [Paho Asynchronous MQTT C Client Library](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/) | MQTTAsync.h  | 线程安全   |



## 数据结构

```c
typedef void* MQTTClient;
typedef void* MQTTAsync;
```



## MQTTClient 库接口

**MQTTClient_connect()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#aaa8ae61cd65c9dc0846df10122d7bd4e)

```c
int MQTTClient_connect(MQTTClient handle,
                       MQTTClient_connectOptions *options
)
```

此函数尝试使用指定的选项将以前创建的客户端（调用 `MQTTClient_create()` 函数）连接到 MQTT 服务器。如果要启用异步消息和状态通知，调用该函数之前必须先调用 `MQTTClient_setCallbacks()` 函数。



**MQTTClient_connect5()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#aa777f80cb3eec5610f976aff30b8c0d6)

```c
MQTTResponse MQTTClient_connect5(MQTTClient handle,
                                 MQTTClient_connectOptions *options,
                                 MQTTProperties *connectProperties,
                                 MQTTProperties *willProperties 
)
```

此函数尝试使用 MQTT 版本 5.0 和指定的选项将以前创建的客户端（调用 `MQTTClient_create()` 函数）连接到 MQTT 服务器。如果要启用异步消息和状态通知，调用该函数之前必须先调用 `MQTTClient_setCallbacks()` 函数。



**MQTTClient_create()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#a9a0518d9ca924d12c1329dbe3de5f2b6)

```c
int MQTTClient_create(MQTTClient *handle,
                      const char *serverURI,
                      const char *clientId,
                      int         persistence_type,
                      void *      persistence_context 
)
```

此函数创建一个 MQTT 客户端，以便连接到指定的服务器并使用指定的持久性存储（参考 `MQTTClient_persistence` 函数）。另外，与创建函数对应的是销毁函数 `MQTTClient_destroy()`。



**MQTTClient_createWithOptions()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#ade24f717a9b39d38b081e1d5e0db1661)

```c
int MQTTClient_createWithOptions(MQTTClient *handle,
                                 const char *serverURI,
                                 const char *clientId,
                                 int         persistence_type,
                                 void *      persistence_context,
                                 MQTTClient_createOptions *options 
)
```

此函数为 `MQTTClient_create()` 函数的带选项版本，用于创建一个 MQTT 客户端，以便连接到指定的服务器并使用指定的持久性存储（参考 `MQTTClient_persistence` 函数）。另外，与创建函数对应的是销毁函数 `MQTTClient_destroy()`。



**MQTTClient_destroy()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#ae700c3f5cfea3813264ce95e7c8cf498)

```c
void MQTTClient_destroy(MQTTClient *handle)
```

此函数用于释放分配给 MQTT 客户端的内存（调用 `MQTTClient_create()` 函数）。当不再需要客户端时，应该调用它。



**MQTTClient_disconnect()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#a1e4d90c13a3c0705bc4a13bfe64e6525)

```c
int MQTTClient_disconnect(MQTTClient handle, int timeout)
```

此函数尝试断开客户端与 MQTT 服务器的连接。为了让客户端有时间完成对调用此函数时正在传递的消息的处理，需要指定一个超时期限。当超时期限过期时，即使仍有未完成的消息确认，客户端也会断开连接。下一次客户端连接到同一服务器时，任何未完成的 QoS 1 或 2 消息将根据前一个连接和新连接的清理设置重试（参考 `MQTTClient_connectOptions.cleansession` 和 `MQTTClient_connect()`）。



**MQTTClient_disconnect5()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#a1762c469715b7f718c4e63a427e6c13c)

```c
int MQTTClient_disconnect5(MQTTClient           handle,
                           int                  timeout,
                           enum MQTTReasonCodes reason,
                           MQTTProperties *     props 
)
```

此函数为 `MQTTClient_disconnect()` 函数的 MQTT 5.0 版本，用于尝试断开客户端与 MQTT 服务器的连接。



**MQTTClient_free()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#a203b545c999beb6b825ec99b6aea79ab)

```c
void MQTTClient_free(void *ptr)
```

此函数释放 MQTT C Client 库分配的内存，特别是主题名称。当 client 库和应用程序使用不同版本的 C 编译器编译时，在 Windows 上需要这样做。因此，在释放任何 MQTT C Client 分配的内存时，始终使用此函数是一个很好的策略。



**MQTTClient_freeMessage()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#abd8abde4f39d3e689029de27f7a98a65)

```c
void MQTTClient_freeMessage(MQTTClient_message ** msg)
```

此函数释放分配给 MQTT 消息的内存，包括分配给消息有效负载的附加内存。当完全处理消息时，客户端应用程序调用此函数。重要提示：此函数不释放分配给消息主题字符串的内存。客户端应用程序负责使用 `MQTTClient_free()` 库函数释放此内存。



**MQTTClient_getPendingDeliveryTokens()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#a2a617c6b0492c04a4ddea592f5e53604)

```c
int MQTTClient_getPendingDeliveryTokens(MQTTClient handle,
                                        MQTTClient_deliveryToken **tokens
)
```

此函数设置一个指针，该指针指向当前正在传递（等待完成）的消息的传递令牌数组。

重要提示：在这个函数中，用于保存令牌数组的内存是 `malloc()` 分配的。当不再需要此内存时，客户端应用程序要负责释放此内存。



**MQTTClient_getVersionInfo()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#abe842456c914ce9201d277a972cc085e)

```c
MQTTClient_nameValue* MQTTClient_getVersionInfo(void)
```

此函数返回 MQTT C Client 库的版本信息，但不会返回任何跟踪信息。



**MQTTClient_global_init()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#a21804ede1a506d1d69a472bc30acc8ba)

```c
void MQTTClient_global_init(MQTTClient_init_options *inits)
```

MQTT 库的全局初始化，在程序开始时调用一次以设置全局行为。例如 `do_openssl_init` —— 如果 mqtt 库应该初始化 OpenSSL，或者在使用库之前依赖调用者进行初始化。



**MQTTClient_isConnected()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#a6e8231e8c47f6f67f7ebbb5dcb4c69c0)

```c
int MQTTClient_isConnected(MQTTClient handle)
```

此函数允许客户端应用程序测试某个 client 与 MQTT 服务器连接情况，已连接返回 true，否则返回 false。



**MQTTClient_publish()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#afe9c34013c3511b8ef6cd36bf703678d)

```c
int MQTTClient_publish(MQTTClient                handle,
                       const char *              topicName,
                       int                       payloadlen,
                       const void *              payload,
                       int                       qos,
                       int                       retained,
                       MQTTClient_deliveryToken *dt
)
```

此函数试图将消息发布到给定主题（另请参见 `MQTTClient_publishMessage` 函数)。当此函数成功返回时，将发出 `MQTTClient_deliveryToken`。如果客户端应用程序需要测试 QoS1 和 QoS2 消息的成功传递，可以异步或同步地完成（参考 [异步与同步客户端应用程序](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/async.html)、 `MQTTClient_waitForCompletion` 和 `MQTTClient_deliveryComplete` 函数）。



**MQTTClient_publishMessage()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#ace320b8a92c7087d9dd5cf242d50389d)

```c
int MQTTClient_publishMessage(MQTTClient                handle,
                              const char *              topicName,
                              MQTTClient_message *      msg,
                              MQTTClient_deliveryToken *dt
)
```

此函数试图将消息发布到给定主题（另请参见 `MQTTClient_publish` 函数）。当此函数成功返回时，将发出一个 `MQTTClient_deliveryToken` 令牌。如果客户端应用程序需要测试 QoS1 和 QoS2 消息的成功传递，可以异步或同步地完成（参考 [异步与同步客户端应用程序](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/async.html)、 `MQTTClient_waitForCompletion` 和 `MQTTClient_deliveryComplete` 函数）。



**MQTTClient_publish5()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#a8148186cc7683a6bb57f621653df51df)

```c
MQTTResponse MQTTClient_publish5(MQTTClient  handle,
                                 const char *topicName,
                                 int         payloadlen,
                                 const void *payload,
                                 int         qos,
                                 int         retained,
                                 MQTTProperties *properties,
                                 MQTTClient_deliveryToken *dt
)
```

此函数使用 MQTT 版本 5.0，试图将消息发布到给定主题（另请参见 `MQTTClient_publishMessage5` 函数）。当此函数成功返回时，将发出 `MQTTClient_deliveryToken`。如果客户端应用程序需要测试 QoS1 和 QoS2 消息的成功传递，可以异步或同步地完成（参考 [异步与同步客户端应用程序](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/async.html)、 `MQTTClient_waitForCompletion` 和 `MQTTClient_deliveryComplete` 函数）。



**MQTTClient_publishMessage5()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#a362042ce973c012bad6a1aa3b5984f5d)

```c
MQTTResponse MQTTClient_publishMessage5(MQTTClient                handle,
                                        const char *              topicName,
                                        MQTTClient_message *      msg,
                                        MQTTClient_deliveryToken *dt
)
```

此函数使用 MQTT 版本 5.0，试图将消息发布到给定主题（另请参见 `MQTTClient_publish5` 函数）。当此函数成功返回时，将发出一个 `MQTTClient_deliveryToken` 令牌。如果客户端应用程序需要测试 QoS1 和 QoS2 消息的成功传递，可以异步或同步地完成（参考 [异步与同步客户端应用程序](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/async.html)、 `MQTTClient_waitForCompletion` 和 `MQTTClient_deliveryComplete` 函数）。



**MQTTClient_receive()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#a4c2df88d00a3dadd510a8cb774739366)

```c
int MQTTClient_receive(MQTTClient            handle,
                       char **               topicName,
                       int *                 topicLen,
                       MQTTClient_message ** message,
                       unsigned long         timeout
)
```

此函数执行传入消息的同步接收。只有当客户端应用程序没有设置回调方法以支持消息的异步接收时，才应该使用它（请参见 [异步与同步客户端应用程序](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/async.html) 以及 `MQTTClient_setCallbacks` 函数）。使用此函数可以编写单线程客户端订阅者应用程序。当调用时，此函数将阻塞，直到下一条消息到达或指定的超时过期为止（另请参见 `MQTTClient_yield` 函数）。

重要提示：应用程序在处理完成后必须释放分配给主题和消息的内存（请参见 `MQTTClient_freeMessage` 函数）。



**MQTTClient_setCallbacks()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#aad27d07782991a4937ebf2f39a021f83)

```c
int MQTTClient_setCallbacks(MQTTClient                    handle,
                            void *                        context,
                            MQTTClient_connectionLost *   cl,
                            MQTTClient_messageArrived *   ma,
                            MQTTClient_deliveryComplete * dc
)
```

此函数设置特定客户端的回调函数。如果客户端应用程序不使用特定的回调，请将相关参数设置为 NULL。调用 `MQTTClient_setCallbacks()` 将客户端置于多线程模式。任何必要的消息确认和状态通信都在后台处理，不需要客户端应用程序的任何干预。更多信息请参见 [异步与同步客户端应用程序](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/async.html)。

注意：在调用此函数时，MQTT 客户端必须断开连接。



**MQTTClient_setCommandTimeout()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#a96067a2fb74d2a61c7e93015629548e0)

```c
int MQTTClient_setCommandTimeout(MQTTClient    handle,
                                 unsigned long milliSeconds
)
```

设置在等待来自服务器的 un/suback 响应时，un/ordering 命令的超时值。milliSeconds 不允许小于 5000 的值。



**MQTTClient_setDisconnected()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#a8adea083a162735d5c7592160088eea0)

```c
int MQTTClient_setDisconnected(MQTTClient handle,
                               void *     context,
                               MQTTClient_disconnected *co 
)
```

设置客户端的 `MQTTClient_disconnected()` 回调函数。如果从服务器接收到断开连接的数据包，将调用这个函数。该函数只对 MQTT V5 及以上版本有效。



**MQTTClient_setPublished()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#a9f13911351a3de6b1ebdabd4cb4116ba)

```c
int MQTTClient_setPublished(MQTTClient             handle,
                            void *                 context,
                            MQTTClient_published * co
)
```



**MQTTClient_setTraceCallback()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#a22870f94aa4cb1827626612f1ded7c69)

```c
void MQTTClient_setTraceCallback(MQTTClient_traceCallback *callback)
```

此函数在需要时设置跟踪回调。如果设置为 NULL，则不返回任何跟踪信息。默认的跟踪级别是 `MQTTASYNC_TRACE_MINIMUM`。



**MQTTClient_setTraceLevel()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#a4dfa35d29db54b10b15b8ac2d9a778be)

```c
void MQTTClient_setTraceLevel(enum MQTTCLIENT_TRACE_LEVELS level)
```

此函数设置将在跟踪回调中返回的跟踪信息的级别。



**MQTTClient_strerror()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#a9defda2979f6fedaae64fd85f5c2f617)

```c
void MQTTClient_setTraceCallback(MQTTClient_traceCallback *callback)
```

返回指向错误的字符串表示形式或 NULL 的指针。

使用后不要释放。如果错误代码未知，则返回 NULL。



**MQTTClient_subscribe()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#a9c1c28258f0d5c6a44ff53a98618f5f3)

```c
int MQTTClient_subscribe(MQTTClient  handle,
                         const char *topic,
                         int         qos
)
```

此函数试图将客户端订阅到单个主题，该主题可能包含通配符（请参见 [订阅通配符](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/wildcard.html)）。此调用还指定为订阅请求的 [QoS](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/qos.html) 服务质量（另请参见 `MQTTClient_subscribeMany` 函数）。



**MQTTClient_subscribe5()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#af35ab7375435f7b6388c5ff4610dad3d)

```c
MQTTResponse MQTTClient_subscribe5(MQTTClient             handle,
                                   const char *           topic,
                                   int                    qos,
                                   MQTTSubscribe_options *opts,
                                   MQTTProperties *       props 
)
```

此函数试图将 MQTT 5.0 版本客户端订阅到单个主题，该主题可能包含通配符（请参见 [订阅通配符](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/wildcard.html)）。此调用还指定为订阅请求的 [QoS](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/qos.html) 服务质量（另请参见 `MQTTClient_subscribeMany` 函数）。



**MQTTClient_subscribeMany()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#a92fa1c13f3db8399e042fbdbdfb692b3)

```c
int MQTTClient_subscribeMany(MQTTClient    handle,
                             int           count,
                             char *const * topic,
                             int *         qos
)
```

此函数试图将客户端订阅到多个主题，这些主题可能包含通配符（请参见 [订阅通配符](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/wildcard.html)）。此调用还指定为订阅请求的 [QoS](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/qos.html) 服务质量（另请参见 `MQTTClient_subscribe` 函数）。



**MQTTClient_subscribeMany5()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#a5390c2402f135c12826ffbf6fc261f7c)

```c
MQTTResponse MQTTClient_subscribeMany5(MQTTClient             handle,
                                       int                    count,
                                       char *const *          topic,
                                       int *                  qos,
                                       MQTTSubscribe_options *opts,
                                       MQTTProperties *       props
)
```

此函数试图将 MQTT 5.0 版本客户端订阅到多个主题，这些主题可能包含通配符（请参见 [订阅通配符](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/wildcard.html)）。此调用还指定为订阅请求的 [QoS](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/qos.html) 服务质量（另请参见 `MQTTClient_subscribe` 函数）。



**MQTTClient_unsubscribe()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#aa8731be3dbc6a25f41f037f8bbbb054b)

```c
int MQTTClient_unsubscribe(MQTTClient  handle,
                           const char *topic
)
```

此函数试图删除由指定客户端创建的现有订阅。



**MQTTClient_unsubscribe5()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#a58356c13867f18df60fd4c7ec9457c48)

```c
MQTTResponse MQTTClient_unsubscribe5(MQTTClient      handle,
                                     const char *    topic,
                                     MQTTProperties *props
)
```

此函数试图删除指定客户端使用 MQTT 5.0 进行的现有订阅。



**MQTTClient_unsubscribeMany()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#a50abbce720d50b9f84b97ff9fa1f546d)

```c
int MQTTClient_unsubscribeMany(MQTTClient   handle,
                               int          count,
                               char *const *topic
)
```

此函数试图删除对指定客户端创建的主题列表的现有订阅。



**MQTTClient_unsubscribeMany5()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#a46bdb532d2153110ccffb2f0748d1ba5)

```c
MQTTResponse MQTTClient_unsubscribeMany5(MQTTClient      handle,
                                         int             count,
                                         char *const *   topic,
                                         MQTTProperties *props
)
```

此函数试图删除对指定客户端使用 MQTT 5.0 版本创建的主题列表的现有订阅。



**MQTTClient_waitForCompletion()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#a83807ec81fe8c3941e368ab329d43067)

```c
int MQTTClient_waitForCompletion(MQTTClient               handle,
                                 MQTTClient_deliveryToken dt,
                                 unsigned long            timeout
)
```

此函数由客户端应用程序调用，以使主线程的执行与完成的消息发布同步。调用时，`MQTTClient_waitForCompletion()` 会阻止执行，直到消息成功传递或指定的超时过期为止。请参见异步客户端应用程序与同步客户端应用程序。



**MQTTClient_yield()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#a8ad3d29864a9ca08202b0832e0f6678e)

```c
void MQTTClient_yield(void)
```

在实现单线程客户端时，定期调用此函数以允许处理消息重试并发送 MQTT 保持活动（keepalive）的 ping 包。如果应用程序定期调用 `MQTTClient_receive()`，则不需要调用此函数。



**MQTTPropertyName()** : [MQTTProperties.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_properties_8h.html#afa0a7306d7b6174c5bc417ca49d99851)

```c
const char* MQTTPropertyName(enum MQTTPropertyCodes value)
```

返回 MQTT V5 属性代码的可打印字符串说明。



**MQTTReasonCode_toString()** : [MQTTReasonCodes.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_reason_codes_8h.html#a91922a5e3c1e5ec7670b6e296854f1b7)

```c
const char* MQTTReasonCode_toString(enum MQTTReasonCodes value)
```

返回 MQTT V5 原因代码的可打印字符串说明。



**MQTTResponse_free()** : [MQTTClient.h](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/_m_q_t_t_client_8h.html#a01bd2c5f98ec5c0636a106db33f2b01b)

```c
void MQTTResponse_free(MQTTResponse response)
```

释放与 MQTT 响应关联的存储空间。



## MQTTAsync 库接口

MQTTAsync_connect() : [MQTTAsync.h](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/_m_q_t_t_async_8h.html#a0388b226a414b09fa733f6d65004ec32)

```c

int MQTTAsync_connect	(	MQTTAsync 	handle,
const MQTTAsync_connectOptions * 	options 
)	
```



MQTTAsync_create() : [MQTTAsync.h](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/_m_q_t_t_async_8h.html#a5462c4618d0a229116db5fbadacf95d2)

```c

int MQTTAsync_create	(	MQTTAsync * 	handle,
const char * 	serverURI,
const char * 	clientId,
int 	persistence_type,
void * 	persistence_context 
)	
```





MQTTAsync_createWithOptions() : [MQTTAsync.h](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/_m_q_t_t_async_8h.html#a78cbe1b851fea48001112f7ba9e4ea62)

```c

int MQTTAsync_createWithOptions	(	MQTTAsync * 	handle,
const char * 	serverURI,
const char * 	clientId,
int 	persistence_type,
void * 	persistence_context,
MQTTAsync_createOptions * 	options 
)	
```



MQTTAsync_destroy() : [MQTTAsync.h](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/_m_q_t_t_async_8h.html#ad5562f9dc71fbd93d25ad20b328cb887)

```c

void MQTTAsync_destroy	(	MQTTAsync * 	handle	)	

```



MQTTAsync_disconnect() : [MQTTAsync.h](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/_m_q_t_t_async_8h.html#adc69afa4725f8321bdaa5a05aec5cfd5)

```c

int MQTTAsync_disconnect	(	MQTTAsync 	handle,
const MQTTAsync_disconnectOptions * 	options 
)	
```



MQTTAsync_free() : [MQTTAsync.h](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/_m_q_t_t_async_8h.html#a2b836f58612a2c4627e40ae848da190d)

```c
void MQTTAsync_free	(	void * 	ptr	)	
```



MQTTAsync_freeMessage() : [MQTTAsync.h](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/_m_q_t_t_async_8h.html#a9b45db63052fe29ab1fad22d2a00c91c)

```c

void MQTTAsync_freeMessage	(	MQTTAsync_message ** 	msg	)	

```



MQTTAsync_getPendingTokens() : [MQTTAsync.h](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/_m_q_t_t_async_8h.html#abc92f60743fc471643b473abbc987be0)

```c
int MQTTAsync_getPendingTokens	(	MQTTAsync 	handle,
MQTTAsync_token ** 	tokens 
)	
```



MQTTAsync_getVersionInfo() : [MQTTAsync.h](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/_m_q_t_t_async_8h.html#a7cf29b785a1d4ff1de2e67e2f916b658)

```c
MQTTAsync_nameValue* MQTTAsync_getVersionInfo	(	void 		)
```



MQTTAsync_global_init() : [MQTTAsync.h](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/_m_q_t_t_async_8h.html#a1705e75a48999cb45bf85c15608478f5)

```c
void MQTTAsync_global_init	(	MQTTAsync_init_options * 	inits	)
```



MQTTAsync_isComplete() : [MQTTAsync.h](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/_m_q_t_t_async_8h.html#ab207095cab6f9a48b52cdb593b8456f4)

```c

int MQTTAsync_isComplete	(	MQTTAsync 	handle,
MQTTAsync_token 	token 
)	
```



MQTTAsync_isConnected() : [MQTTAsync.h](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/_m_q_t_t_async_8h.html#a46c332245c379629ae11f457fc179457)

```c
int MQTTAsync_isConnected	(	MQTTAsync 	handle	)
```



MQTTAsync_malloc() : [MQTTAsync.h](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/_m_q_t_t_async_8h.html#af5500ba58592afafaade2fcabdc61e61)

```c
void* MQTTAsync_malloc	(	size_t 	size	)
```



MQTTAsync_reconnect() : [MQTTAsync.h](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/_m_q_t_t_async_8h.html#abd3ea01869b89ff23f9522640479c395)

```c
int MQTTAsync_reconnect	(	MQTTAsync 	handle	)	
```



MQTTAsync_send() : [MQTTAsync.h](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/_m_q_t_t_async_8h.html#a63c66a311ab16239a4175ff671871bf2)

```c
int MQTTAsync_send	(	MQTTAsync 	handle,
const char * 	destinationName,
int 	payloadlen,
const void * 	payload,
int 	qos,
int 	retained,
MQTTAsync_responseOptions * 	response 
)
```



MQTTAsync_sendMessage() : [MQTTAsync.h](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/_m_q_t_t_async_8h.html#a5687171e67e98f9ea590c9e3b64cde18)

```c
int MQTTAsync_sendMessage	(	MQTTAsync 	handle,
const char * 	destinationName,
const MQTTAsync_message * 	msg,
MQTTAsync_responseOptions * 	response 
)
```



MQTTAsync_setAfterPersistenceRead() : [MQTTAsync.h](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/_m_q_t_t_async_8h.html#ab4d16e3c57502be6a7d1b1d3bcc382f3)

```c
int MQTTAsync_setAfterPersistenceRead	(	MQTTAsync 	handle,
void * 	context,
MQTTPersistence_afterRead * 	co 
)
```



MQTTAsync_setBeforePersistenceWrite() : [MQTTAsync.h](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/_m_q_t_t_async_8h.html#a1002b09c62a096578c9b3e0135eb98c1)

```c
```



MQTTAsync_setCallbacks() : [MQTTAsync.h](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/_m_q_t_t_async_8h.html#ae9ae8d61023e7029ef5a19f5219c3599)

```c
```



MQTTAsync_setConnected() : [MQTTAsync.h](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/_m_q_t_t_async_8h.html#a18cc19740d9b00c629dc53a4420ecf1f)

```c
```



MQTTAsync_setConnectionLostCallback() : [MQTTAsync.h](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/_m_q_t_t_async_8h.html#aee15bbd9224efd9dcce9b4ae491b2e2e)

```c
```



MQTTAsync_setDeliveryCompleteCallback() : [MQTTAsync.h](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/_m_q_t_t_async_8h.html#a94ec624ee22cc01d2ca58a9e646a2665)

```c
```



MQTTAsync_setDisconnected() : [MQTTAsync.h](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/_m_q_t_t_async_8h.html#ada4dd26d23c8849c51e4ab8200339040)

```c
```



MQTTAsync_setMessageArrivedCallback() : [MQTTAsync.h](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/_m_q_t_t_async_8h.html#a44abc360051b918a39b0596a137775ae)

```c
```



MQTTAsync_setTraceCallback() : [MQTTAsync.h](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/_m_q_t_t_async_8h.html#a0b350581324a4ff0eaee71e7a6721388)

```c
```



MQTTAsync_setTraceLevel() : [MQTTAsync.h](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/_m_q_t_t_async_8h.html#ac7fbab13a0b2e5dd4ee11efbbb9f6a3a)

```c
```



MQTTAsync_setUpdateConnectOptions() : [MQTTAsync.h](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/_m_q_t_t_async_8h.html#aa078aec3eba83481f63db3c3939a5da9)

```c
```



MQTTAsync_strerror() : [MQTTAsync.h](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/_m_q_t_t_async_8h.html#a875cd089a8b23eb3fd50c0406fc75d9f)

```c
```



MQTTAsync_subscribe() : [MQTTAsync.h](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/_m_q_t_t_async_8h.html#ae10bd009934b3bb4a9f4abae7424a611)

```c
```



MQTTAsync_subscribeMany() : [MQTTAsync.h](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/_m_q_t_t_async_8h.html#ac78620b33434a187255bd1a3faec1578)

```c
```



MQTTAsync_unsubscribe() : [MQTTAsync.h](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/_m_q_t_t_async_8h.html#a08d18ece91c1b011011354570d8ac1ab)

```c
```



MQTTAsync_unsubscribeMany() : [MQTTAsync.h](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/_m_q_t_t_async_8h.html#a69fd433ce1b9b6a1b3b453c4793a9311)

```c
```



MQTTAsync_waitForCompletion() : [MQTTAsync.h](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/_m_q_t_t_async_8h.html#a4fe09cc9c976b1cf424e13765d6cd8c9)

```c
```



MQTTPropertyName() : [MQTTProperties.h](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/_m_q_t_t_properties_8h.html#afa0a7306d7b6174c5bc417ca49d99851)

```c
```



MQTTReasonCode_toString() : [MQTTReasonCodes.h](https://eclipse.github.io/paho.mqtt.c/MQTTAsync/html/_m_q_t_t_reason_codes_8h.html#a91922a5e3c1e5ec7670b6e296854f1b7)

```c
```



