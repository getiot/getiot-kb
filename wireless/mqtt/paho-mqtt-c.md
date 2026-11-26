---
sidebar_position: 10
authors: [luhuadong]
---

# Paho-MQTT C 库使用



Paho C 客户端包含四个变体库，包括共享库和静态库：

- **paho-mqtt3a** - 异步访问模式（asynchronous）(MQTTAsync)
- **paho-mqtt3as** - 带 SSL 的异步访问模式（asynchronous with SSL）(MQTTAsync)
- **paho-mqtt3c** - 同步访问模式（"classic" / synchronous）(MQTTClient)
- **paho-mqtt3cs** - 带 SSL 的同步访问模式（"classic" / synchronous with SSL）(MQTTClient)



## 安装

以最新的代码为例，首先从 GitHub 下载 paho.mqtt.c 代码

```shell
git clone https://github.com/eclipse/paho.mqtt.c.git
```

使用 cmake 编译，先创建 build 构建目录

```shell
cd paho.mqtt.c
mkdir build
cd build
```

然后构建、编译、安装

```shell
cmake ..
make
sudo make install
```

默认安装在 /usr/local 目录下面。

```shell
rudy@pocket-ubuntu:/usr/local/lib$ ls -l libpaho*
lrwxrwxrwx 1 root root     19 9月   9 09:46 libpaho-mqtt3a.so -> libpaho-mqtt3a.so.1
lrwxrwxrwx 1 root root     23 9月   9 09:46 libpaho-mqtt3a.so.1 -> libpaho-mqtt3a.so.1.3.9
-rw-r--r-- 1 root root 252880 9月   9 09:18 libpaho-mqtt3a.so.1.3.9
lrwxrwxrwx 1 root root     19 9月   9 09:46 libpaho-mqtt3c.so -> libpaho-mqtt3c.so.1
lrwxrwxrwx 1 root root     23 9月   9 09:46 libpaho-mqtt3c.so.1 -> libpaho-mqtt3c.so.1.3.9
-rw-r--r-- 1 root root 217840 9月   9 09:18 libpaho-mqtt3c.so.1.3.9
```



## 使用

示例代码 [MQTTClient_publish.c](https://github.com/getiot/linux-c/blob/main/network/mqtt/MQTTClient/MQTTClient_publish.c) 实现了一个简单的 MQTT 发布者客户端。

下载代码

```shell
https://github.com/getiot/linux-c.git
cd linux-c/network/mqtt/MQTTClient
```

编译

```shell
gcc MQTTClient_publish.c -o MQTTClient_publish -lpaho-mqtt3c -lpaho-mqtt3a
```

运行

```shell
./MQTTClient_publish
```

如果出现 “error while loading shared libraries: libpaho-mqtt3c.so.1” 错误，请执行下面命令添加动态库的搜索路径。

```shell
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib
```

当然，为了保证看到运行效果，您需要在本地安装并启动 MQTT Broker 服务器，[mosquitto](/foss/mosquitto/) 是一个不错的选择。在 Debian/Ubuntu 系统中，可以通过下面命令快速安装。

```shell
sudo apt install mosquitto
sudo apt install mosquitto-clients
```

启动订阅者，订阅 “test” 主题

```shell
mosquitto_sub -d -t test
```

这时候再启动 MQTTClient_publish 程序

```shell
$ ./MQTTClient_publish 
Waiting for up to 10 seconds for publication of Hello, GetIoT.tech!
on topic 'test' for client with ClientID: ubuntu
Message with delivery token 1 delivered
```



## API 参考

- [Paho MQTT C Client Library](https://eclipse.github.io/paho.mqtt.c/MQTTClient/html/)



