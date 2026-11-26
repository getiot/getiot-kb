---
sidebar_position: 32
sidebar_label: Web 服务器组件
---

# 潘多拉 RT-Thread Web 服务器组件



## 实验概述

本实验使用 **WebNet** 软件包创建一个 Web 服务器，并展示 Web 服务器静态页面、CGI（事件处理）、AUTH（基本认证）、Upload（文件上传）等部分功能。



## 硬件连接

本实验需要依赖 IoTBoard 板卡上的 WiFi 模块完成网络通信，因此请确保硬件平台上的 WiFi 模组可以正常工作。同时依赖 TF 卡模块提供文件存储功能。

可参考《[潘多拉 RT-Thread WiFi 管理](/pandora/rtt-pandora-wifi-manager/)》和《[潘多拉 RT-Thread SD 卡文件系统](/pandora/rtt-pandora-file-system-sdcard/)》了解相关信息。



## 准备工作

1. 在 TF 卡根目录下创建 webnet 文件夹。
2. 在 webnet 文件夹里创建 admin 和 upload 两个文件夹。
3. 将 /ports/webnet/index.html 复制到 TF 卡的 webnet 文件夹里。

index.html 文件是访问 web 服务器时默认展示的页面，我们提供的 html 文件是用来测试本例程的相关功能的。熟悉 HTML 语言的开发者可以自己编写 index.html 页面，并放入 webnet 文件夹里。

**提示**：可以在 WebNet 软件包配置中修改 web 服务器的根目录。

![RT-Thread WebNet 服务器组件](https://static.getiot.tech/pandora-rtt-scons-menuconfig-webnet.png#center)



## 示例代码

本示例主要展示了 WebNet 的几个常用功能，在 main 函数中主要完成一下几个任务：

- 挂载 SD 卡；
- 初始化 WiFi，等待 WiFi 自动连接成功；
- 启动 WebNet 服务。

main 函数代码如下：

```c showLineNumbers title="applications/main.c"
int main(void)
{
    int result = RT_EOK;

    /* 等待 WIFI 初始化完成 */
    rt_hw_wlan_wait_init_done(500);

    /* 挂载文件系统 */
    if (dfs_mount("sd0", "/", "elm", 0, 0) == 0)
    {
        LOG_I("Filesystem initialized!");
    }
    else
    {
        LOG_E("Failed to initialize filesystem!");
    }

    /* 创建信号量 */
    rt_sem_init(&net_ready, "net_ready", 0, RT_IPC_FLAG_FIFO);

    /* 注册 WIFI 连接成功回调函数 */
    rt_wlan_register_event_handler(RT_WLAN_EVT_READY, wlan_ready_handler, RT_NULL);

    /* 配置 WIFI 自动连接 */
    wlan_autoconnect_init();

    /* 使能 WIFI 自动连接 */
    rt_wlan_config_autoreconnect(RT_TRUE);

    /* 等待连接成功 */
    result = rt_sem_take(&net_ready, RT_WAITING_FOREVER);
    if (result != RT_EOK)
    {
        LOG_E("Wait net ready failed!");
        return -RT_ERROR;
    }

    /* 启动 webnet demo */
    webnet_demo();

    return 0;
}
```

当 WiFi 连接成功后，会调用 `webnet_test()` 函数，该函数会开启 CGI，AUTH 验证和上传功能，然后启动 WebNet。`webnet_test()` 函数代码如下：

```c
void webnet_demo(void)
{
    /* 注册 CGI 处理函数 */
    webnet_cgi_register("hello", cgi_hello_handler);
    webnet_cgi_register("calc", cgi_calc_handler);

    /* 设置 AUTH 验证 */
    webnet_auth_set("/admin", "admin:admin");

    /* 添加上传入口 */
    webnet_upload_add(&upload_entry_upload);

    /* 启动 WebNet */
    webnet_init();
}
```

完整代码：[29_iot_web_server](https://github.com/RT-Thread/IoT_Board/tree/master/examples/29_iot_web_server)



## 编译运行

编译工程

```bash
$ scons
...
LINK rtthread-stm32l4xx.elf
arm-none-eabi-objcopy -O binary rtthread-stm32l4xx.elf rt-thread.bin
arm-none-eabi-size rtthread-stm32l4xx.elf
   text	   data	    bss	    dec	    hex	filename
 411624	   2700	  44128	 458452	  6fed4	rtthread-stm32l4xx.elf
scons: done building targets.
```

将 bin 文件上传到 STM32

```bash
st-flash write rt-thread.bin 0x8000000
```

打开串口终端，输出如下内容

```basic
 \ | /
- RT -     Thread Operating System
 / | \     4.0.1 build Jan 10 2022
 2006 - 2019 Copyright by rt-thread team
lwIP-2.0.2 initialized!
[I/sal.skt] Socket Abstraction Layer initialize success.
[SFUD] Find a Winbond flash chip. Size is 16777216 bytes.
[SFUD] w25q128 flash device is initialize success.
msh />[I/FAL] RT-Thread Flash Abstraction Layer (V0.2.0) initialize success.
[I/OTA] RT-Thread OTA package(V0.1.3) initialize success.
[I/OTA] Verify 'wifi_image' partition(fw ver: 1.0, timestamp: 1529386280) success.
[I/WLAN.dev] wlan init success
[I/WLAN.lwip] eth device init ok name:w0
[I/main] Filesystem initialized!
[Flash] EasyFlash V3.2.1 is initialize success.
[Flash] You can get the latest version on https://github.com/armink/EasyFlash .
[I/WLAN.mgnt] wifi connect success ssid:FCTC_89
[I/wn] RT-Thread webnet package (V2.0.0) initialize success.
[I/WLAN.lwip] Got IP address : 192.168.3.183
```



## 测试

在浏览器（这里使用谷歌浏览器）中输入刚刚打印的设备 IP 地址，将访问我们之前放入根目录（/webnet）的 index.html 文件。如下图所示，页面文件正常显示：

![RT-Thread WebNet Web 服务](https://static.getiot.tech/pandora-webnet-webserver.png#center)

该页面上显示了 WebNet 软件包的基本功能介绍，并在下方给出相应的测试示例。

### AUTH 基本认证例程

在主页（/index.html）**AUTH Test** 模块下点击 *基本认证功能测试：用户名及密码为 admin:admin* 按键，弹出基本认证对话框，输入用户名 `admin`，密码 `admin`。成功输入用户名和密码后，会进入根目录下 /admin 目录。

### Upload 文件上传例程

在主页上 **Upload File Test** 模块下点击 *选择文件* 按键，选取需要上传的文件，点击 *上传* ，可以将文件上传到根目录下的 /upload 目录。

例如上传一张图片 pandora.png，此时 MSH 终端显示：

```bash
[I/main] Upload FileName: pandora.png
[I/main] Content-Type   : image/png
[I/main] save to: /webnet/upload/pandora.png
[D/main] write: length 2753
[D/main] write: length 2920
...
[D/main] write: length 2920
[D/main] write: length 3373
[I/main] Upload FileSize: 67446
```

### INDEX 目录显示例程

INDEX 例程演示页面文件列表功能。在主页 **INDEX Test** 模块下点击 *INDEX 功能测试：访问/upload 目录* 按键，会跳转到根目录下 /upload 目录，并且列出该目录下所有文件名和文件长度。

### CGI 事件处理例程

本例程提供两个 CGI 示例：**hello world** 例程和 **calc** 例程，用于演示 CGI 事件处理的基本功能。

**1、hello world 例程**

hello world 例程演示了在页面演示文本内容功能，在主页 **CGI Test** 模块下点击 *hello world* 按键，会跳转到新页面显示日志信息，新页面显示了 `hello world` 说明 CGI 事件处理成功。

**2、calc 例程**

calc 例程中使用 CGI 功能在页面上展示了简单的加法计算器功能，在例程主页 **CGI Test** 模块下点击 *calc* 按键，会跳转到新的页面，输入两个数字点击 *计算* 按键，页面会显示两数字相加的结果。



## 思考总结

WebNet 是 RT-Thread 官方开源的、轻量级、可定制嵌入式 Web 服务器，支持 HTTP 1.0/1.1、AUTH 基本认证、CGI、文件上传、预压缩、缓存、断点续传等功能。极大地方便了用户在嵌入式设备上提供 Web 服务，实现更灵活的物联网应用。

