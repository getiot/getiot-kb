---
sidebar_position: 1
slug: /libcurl
---

# libcurl 使用教程



![](https://static.getiot.tech/curl-logo.svg)



## 简介

libcurl 是一个很强大的开源网络处理库，主要功能就是用不同的协议连接和沟通不同的服务器。目前支持 http、https、ftp、gopher、telnet、dict、file 和 ldap 等协议。

libcurl 同样支持 HTTPS 证书授权，HTTP POST、HTTP PUT、FTP 上传，HTTP 基本表单上传、代理、cookies 和用户认证等功能。Google Chrome 内核就用到了 libcurl 库。

- 项目官网：[https://curl.se](https://curl.se)



## 安装

### Debian/Ubuntu 安装

安装 curl 命令行工具

```shell
sudo apt install curl
```

安装 libcurl 库（可以选择多种不同的 TLS 后端）

```shell
sudo apt install libcurl4-openssl-dev
sudo apt install libcurl4-nss-dev
sudo apt install libcurl4-gnutls-dev
```

### Redhat/Centos 安装

安装 curl 命令行工具

```shell
sudo yum install curl
```

安装 libcurl 开发包

```shell
sudo yum install libcurl-devel
```

### 手动编译安装

首先下载 libcurl 的最新源代码，然后编译成动态库或者静态库；然后把头文件和库文件拿出来加入到我们自己的工程中。

推荐还是直接使用编译好的 libcurl 库，因为是 C 程序接口，所以还是比较稳定的。



## 接口说明

libcurl 虽然用起来比较繁复，但大概可以就初分为4类函数：

1. 初始化：`curl_easy_init()`
2. 配置数据传输选项，设置回调函数：`curl_easy_setopt()`
3. 启动传输任务：`curl_easy_perform()`
4. 释放资源：`curl_easy_cleanup()`

其中 `curl_easy_setopt` 最为繁复，curl 有超多的配置选项可以选择，但是基本上可以跟 curl 命令行工具的参数选项对应起来。



### 头文件

只需要在你的工程中包含 `<curl/curl.h>` 头文件即可。

```c
#include <curl/curl.h>
```



## 应用示例

### HTTP 下载文件

这个实例访问了网上的一个图片资源，设置了一个代理，并且伪装成浏览器访问，并将其图片下载到本地，最后还实现了下载进度的显示。

```c
#include <stdio.h>
#include <stdbool.h>
#include <curl/curl.h>


size_t write_data(void *ptr, size_t size, size_t nmemb, void *stream)
{
    size_t written = fwrite(ptr, size, nmemb, (FILE *)stream);	
    return written;
}

//显示文件传输进度，dltotal代表文件大小，dlnow代表传输已经完成部分
//clientp是CURLOPT_PROGRESSDATA传入的值
int progress_callback(void *clientp, double dltotal, double dlnow, double ultotal, double ulnow)
{	
    if (dltotal != 0)
    {
        printf("%lf / %lf (%lf %%)\n", dlnow, dltotal, dlnow*100.0 / dltotal);
    }	
    return 0;
}

int main()
{
    const char *netlink = "https://static.getiot.tech/flag-of-china.png";
    const char *output = "test.png";

    curl_global_init(CURL_GLOBAL_ALL);		//初始化全局资源

    CURL *curl = curl_easy_init();		//初始化句柄

    //需要的话，可以设置代理
    //curl_easy_setopt(curl, CURLOPT_PROXY, "127.0.0.1:1080");

    //访问网址
    curl_easy_setopt(curl, CURLOPT_URL, netlink);

    //设置用户代理
    curl_easy_setopt(curl, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36");

    //注意以二进制打开
    FILE *fp = fopen(output, "wb");
    if (fp == NULL)
    {
        perror("fopen");
        curl_easy_cleanup(curl);
        return 0;
    }

    //写出数据
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_data);
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, fp);
    
    //实现下载进度
    curl_easy_setopt(curl, CURLOPT_NOPROGRESS, false);
    curl_easy_setopt(curl, CURLOPT_PROGRESSFUNCTION, progress_callback);
    curl_easy_setopt(curl, CURLOPT_PROGRESSDATA, NULL);

    //运行
    curl_easy_perform(curl);

    curl_easy_cleanup(curl);			//释放句柄

    fclose(fp);

    curl_global_cleanup(); //释放全局资源

    return 1;
}
```

### HTTP GET



### HTTP POST





## 更多资料

- [Everything curl - the book](https://everything.curl.dev/)



