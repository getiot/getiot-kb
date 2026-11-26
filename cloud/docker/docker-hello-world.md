---
sidebar_position: 6
slug: /docker-hello-world
---

# Docker Hello World



## 实操

```shell
docker image pull hello-world
```



```shell
docker images
```



```shell
docker run hello-world
```



```shell
Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/

```





## 分析

### hello-world 镜像里面有什么？



### 重新构建 hello-world 镜像

hello.c

```c
#include <stdio.h>

int main(void)
{
    printf("Hello from Docker! by getiot.tech\n");
    return 0;
}
```

编译

```shell
$CC --static hello.c -o hello
```

Dockerfile

```dockerfile
FROM scratch
ADD hello /
#RUN yun update
CMD ["/hello"]
```

构建

```shell
docker build -t getiot/hello .
```

运行

```shell
$ sudo docker run getiot/hello
Hello from Docker! by getiot.tech
```

