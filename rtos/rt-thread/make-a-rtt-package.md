---
sidebar_position: 9
authors: [luhuadong]
---

# 制作 RT-Thread 软件包



![](https://static.getiot.tech/20200228222422195.jpg#center)


## 准备工作

### 环境搭建

- 下载 RT-Thread 源码
- 安装 ENV 工具
- 选择一个 BSP 包进行测试

![](https://static.getiot.tech/20200228222555732.png#center)



### 收集软件包的需求

根据您想制作的软件包，收集软件包的需求。

比如我们想做个控制 LED 闪烁的软件包，希望它有如下功能：

- 控制 LED 亮或灭；
- 控制 LED 闪烁时间；
- 控制 LED 闪烁频率；
- 控制 LED 闪烁次数；
- ......

同时，对于软件包的使用还有如下需求：

- 支持任意多个 LED；
- 接口简单，就像 `LOG_X` 一样，想在哪里触发 LED 动作，一行代码就能搞定。

这个阶段一定要点到即止，挑出最基本且重要的功能，然后进一步抽象。

![](https://static.getiot.tech/20200228222645734.gif#center)

**别忘了，还要给软件包起个好听的名字！**

我们决定基于链表来实现，并给软件包起名 **littled**，是 Little LED Daemon 的缩写，意思是一个小巧的 LED 驱动服务程序。我们希望它像后台服务程序一样工作，从而使应用层的调用变得简单。



### 创建远程代码仓库

在 GitHub 上创建一个名为 rtt-littled 的仓库，选择开源许可协议，添加 README.md 文件。OK！

![](https://static.getiot.tech/20200228222711163.png#center)



### 搭建本地软件包工程

将刚刚创建的远程仓库克隆到本地

```shell
git clone git@github.com:luhuadong/rtt-littled.git
```

进入本地仓库，创建 3 个目录

```shell
cd rtt-littled
mkdir src inc examples
```

其中 src 目录存放源文件，inc 目录存放头文件，examples 目录存放示例代码。然后在各目录下创建相应的文件，并添加一个 SConscript 文件用于指导编译。最终的目录框架如下：

```shell
├── examples
│   └── littled_sample.c
├── inc
│   └── littled.h
├── src
│   └── littled.c
├── LICENSE
├── README.md
└── SConscript
```



## 实现软件包功能

### 软件架构设计

littled 软件包采用类似 C/S 的架构，littled 后台线程负责接收来自用户线程的请求，并进行解析和响应，如果接收到需要连续动作的请求，则会创建子任务线程进行处理，接着继续等待请求。

![](https://static.getiot.tech/20200228222754571.png#center)

littled 内部维护一个链表，用于记录 LED 设备信息，初始化时会将 LED 节点插入链表，从而实现支持任意多 LED 的需求。



### 定义接口函数

#### 注册与注销

注册 LED 只需要提供引脚号和有效电平即可。

```c showLineNumbers
int  led_register(rt_base_t pin, rt_base_t active_logic);
```

参数 pin 表示 LED 引脚号，参数 active_logic 表示使 LED 亮的电平逻辑值（PIN_HIGH 或 PIN_LOW）。注册成功返回一个大于 0 的 LED 描述符，注册失败返回小于 0 的错误码。

对于已注册的 LED，当不需要使用了，可以将其注销。

```c showLineNumbers
void led_unregister(int ld);
```

参数 ld 表示将要注销的 LED 描述符。



#### 设置 LED 模式

LED 模式包括常亮、熄灭、翻转、闪烁，定义 led_mode 函数将其全部涵盖。采用软件模拟 PWM 的方式控制 LED 闪烁。

```c showLineNumbers
int  led_mode(int ld, 
              rt_uint32_t period, 
              rt_uint32_t pulse, 
              rt_uint32_t time, 
              rt_uint32_t count);
```

参数 ld 表示 LED 描述符，参数 period 表示周期时间，参数 pulse 表示脉冲宽度（高电平持续时间），参数 time 表示闪烁持续时间，参数 count 表示闪烁次数。

当 pulse = 0 时，LED 熄灭；当 pulse = period 时，LED 常亮。

![](https://static.getiot.tech/led-pwm-show.gif#center-200)



### 编写测试代码

实现接口函数之前，我们先把测试代码写好。这样有两个好处，一是更清楚我们想怎么使用它；二是后面可以一边实现接口函数一边测试，把功能刚好实现即可，避免过度开发，即测试驱动开发（TDD）。

```c showLineNumbers
#define LED1_PIN        GET_PIN(C, 7)

static int littled_sample(void)
{
	int led_test = led_register(LED1_PIN, PIN_HIGH);

    LED_ON(led_test);          /* 常亮 */
    rt_thread_mdelay(3000);
    LED_OFF(led_test);         /* 熄灭 */
    rt_thread_mdelay(3000);
    LED_BEEP(led_test);        /* 闪烁三下 */
    rt_thread_mdelay(5000);
    LED_BLINK(led_test);       /* 持续闪烁 */
    
    led_unregister(led_test);
}
#ifdef FINSH_USING_MSH
MSH_CMD_EXPORT(littled_sample, Driver LED based on littled);
#endif
```

为了方便调用，预先定义了几个模式：

```c showLineNumbers
#define LED_ON(ld)           led_mode(ld, 1, 1, 0, 0)
#define LED_OFF(ld)          led_mode(ld, 1, 0, 0, 0)
#define LED_TOGGLE(ld)       led_mode(ld, 0, 0, 0, 1)
#define LED_BEEP(ld)         led_mode(ld, DEFAULT_PERIOD,   DEFAULT_PULSE,   0, BEEP_COUNT)
#define LED_BELL(ld)         led_mode(ld, DEFAULT_PERIOD,   DEFAULT_PULSE,   BELL_TIME, 0)
#define LED_BLINK(ld)        led_mode(ld, DEFAULT_PERIOD,   DEFAULT_PULSE,   0, 0)
#define LED_BLINK_FAST(ld)   led_mode(ld, DEFAULT_PERIOD/2, DEFAULT_PULSE/2, 0, 0)
#define LED_BLINK_SLOW(ld)   led_mode(ld, DEFAULT_PERIOD*2, DEFAULT_PULSE*2, 0, 0)
```



### 实现接口函数和内部函数

#### 链表设计

根据需求，使用单向链表连接 LED 节点即可，节点结构体定义如下：

```c showLineNumbers
struct led_node
{
    int ld;
    rt_base_t pin;
    rt_base_t active_logic;

    rt_uint32_t period;
    rt_uint32_t pulse;
    rt_uint32_t time;
    rt_uint32_t count;

    struct rt_thread *tid;

    rt_mutex_t  lock;
    rt_slist_t  list;
};
```

有了 LED 节点，还需要定义一个链表头，用于节点的插入、删除、查询和修改。

```c showLineNumbers
struct littled_list_head
{
    rt_uint32_t ld_max;
    rt_mutex_t  lock;
    rt_slist_t  head;
};

static struct littled_list_head littled_list;
```

链表头成员 ld_max 表示当前注册 LED 的最大描述符。成员 lock 互斥锁用于保护链表，因为链表对于 littled 来说是临界资源。



#### 初始化

littled 作为一个后台服务线程，需要保证只有一个实例，即单例模式。因此初始化时需要先检查 littled_thread 线程是否已经创建成功。然后创建链表互斥锁、消息队列、littled 服务线程。

```c showLineNumbers
static rt_thread_t littled_thread = RT_NULL;

static int littled_init(void)
{
    /* Makesure singleton */
    if (littled_thread)
    {
        LOG_W("littled thread has been created");
        return -RT_ERROR;
    }

    littled_list.ld_max = 0;
    littled_list.lock   = RT_NULL;
    littled_list.head.next   = RT_NULL;

    /* Create a mutex lock for list */
    littled_list.lock = rt_mutex_create(...);
    if (littled_list.lock == RT_NULL)
        goto __exit;
    
    /* Create a message queue for thread */
    littled_mq = rt_mq_create(...);
    if (littled_mq == RT_NULL)
        goto __exit;

    /* create the littled daemon thread */
    littled_thread = rt_thread_create(...);
    if (littled_thread == RT_NULL)
        goto __exit;

    rt_thread_startup(littled_thread);
    return RT_EOK;

__exit:
    /* 删除已申请的资源 */
    return -RT_ERROR;
}
```

让 littled 线程自动启动

```c showLineNumbers
#ifdef PKG_USING_LITTLED
INIT_APP_EXPORT(littled_init);
#endif
```



#### 消息队列

为了实现应用线程与 littled 服务线程的异步操作，使用消息队列进行 LED 动作信息的传输。消息结构体的定义如下：

```c showLineNumbers
struct led_msg
{
    int ld;
    rt_uint32_t period;
    rt_uint32_t pulse;
    rt_uint32_t time;
    rt_uint32_t count;
};
```

消息队列

```c showLineNumbers
static rt_mq_t littled_mq = RT_NULL;
```



#### littled 服务线程

littled 服务线程入口函数如下，一旦接收到消息，会先在链表里查找该节点，如果找到则将消息中的信息更新到对应的 LED 节点。接着对消息进行解析，如果是常亮、熄灭、翻转等可以直接处理完毕的动作，则直接处理。如果是闪烁的请求，则创建 LED 任务线程进行处理。

```c showLineNumbers
static void littled_daemon_entry(void *args)
{
    while(1)
    {
        /* Wait message from queue */
        if (RT_EOK == rt_mq_recv(littled_mq, (void *)&msg, sizeof(msg), RT_WAITING_FOREVER))
        {
            rt_mutex_take(littled_list.lock, RT_WAITING_FOREVER);

            /* Find led node */

            /* Save message */

            /* Preprocessing */

            /* Start thread processing task */

            rt_mutex_release(littled_list.lock);
        }
    }
}
```

查找 LED 节点的操作如下：

```c showLineNumbers
            rt_slist_t *node = RT_NULL;
            struct led_node *led = RT_NULL;

            rt_slist_for_each(node, &littled_list.head)
            {
                led = rt_slist_entry(node, struct led_node, list);
                if (msg.ld == led->ld)
                    break;
            }
```

链表是临界资源，操作之前记得要上锁～



#### led_mode 接口函数

得益于异步的设计，led_mode 接口函数变得非常简单——对参数进行封装，发送到消息队列即可。

```c showLineNumbers
int led_mode(int ld, rt_uint32_t period, rt_uint32_t pulse, rt_uint32_t time, rt_uint32_t count)
{
    /* pack msg */
    struct led_msg msg;

    msg.ld     = ld;
    msg.period = period;
    msg.pulse  = pulse;
    msg.time   = time;
    msg.count  = count;

    /* send message queue */
    rt_mq_send(littled_mq, (void *)&msg, sizeof(msg));
    return RT_EOK;
}
```



好啦，大概实现流程就这样，led_register 和 led_unregister 函数以及更多细节，请直接查看代码：[https://github.com/luhuadong/rtt-littled](https://github.com/luhuadong/rtt-littled)



### 修改 SConscript 文件

littled 软件包的文件少，因此直接指定文件名就好啦

```python showLineNumbers
from building import *
Import('rtconfig')

src   = []
cwd   = GetCurrentDir()

# add littled src files.
if GetDepend('PKG_USING_LITTLED'):
    src += Glob('src/littled.c')

if GetDepend('PKG_USING_LITTLED_SAMPLE'):
    src += Glob('examples/littled_sample.c')

# add littled include path.
path  = [cwd + '/inc']

# add src and include to group.
group = DefineGroup('littled', src, depend = ['PKG_USING_LITTLED'], CPPPATH = path)

Return('group')
```

完成后可以将代码 commit 一下，push 到远程仓库，方便后续测试。



## 测试

### 生成软件包索引

RT-Thread 的 Env 工具为我们提供了自动生成软件包索引的向导功能。命令如下：

```shell
pkgs --wizard
```

大致流程如下图所示，输入 Package 名、版本号、类别、Git 仓库信息...... 即可。

![](https://static.getiot.tech/20200228222945961.png#center)



### 修改软件包索引

上一步执行完毕，会生成一个 littled 目录，里面有两个文件，Kconfig 和 package.json，但还需要进一步加工才能用。

在 Kconfig 增加 littled 软件包相应的配置项，比如缺省的周期时间、脉冲宽度等等。

```shell
if PKG_USING_LITTLED

    config PKG_USING_LITTLED_PERIOD
        int "default pwm period (ms)"
        default 1000

    config PKG_USING_LITTLED_PULSE
        int "default pwm pulse (ms)"
        default 500

    config PKG_USING_LITTLED_BELL_TIME
        int "default bell time (ms)"
        default 50000

    config PKG_USING_LITTLED_BEEP_COUNT
        int "default beep count"
        range 1 100
        default 3

    config PKG_USING_LITTLED_SAMPLE
        bool "Enable littled sample"
        default n
```

package.json 文件主要是修改 latest 版本信息。

```shell
{
    "version": "latest",
    "URL": "https://github.com/luhuadong/rtt-littled.git",
    "filename": "littled-latest.zip",
    "VER_SHA": "master"
}
```



### 本地测试软件包

将软件包索引添加到 env 的 packages 对应位置。

```shell
cp -r rtt-littled ~/.env/packages/packages/peripherals/
```

同时修改 peripherals 下的 Kconfig 文件，将 littled 的Kconfig 添加进去，不然 menuconfig 找不到。

```shell
source "$PKGS_DIR/packages/peripherals/littled/Kconfig"
```

将软件包添加到工程，在 BSP 工程目录执行 `scons --menuconfig`，配置路径如下：

```shell
RT-Thread online packages ---> 
    peripheral libraries and drivers ---> 
    [*] littled: Little LED Daemon for LED driver  --->
```

![](https://static.getiot.tech/20200228223025265.png#center)

保持配置，执行 `pkgs --update` 拉取软件包。如果拉取成功，说明软件包索引信息正确。



### 编译、测试、调试、优化

软件包拉取成功，可以选上测试示例进行编译，编译成功下载到板子进行测试。如果有问题可以重复上述步骤修改代码、提交、测试，直到满足功能需求。



## 发布

### 发布软件包版本

littled 软件包通过测试，即可提交代码到 GitHub 远程仓库。

```shell
cd littled
git add .
git commit -m "v1.0.0"
git push origin master
```

同时，fork RT-Thread 的 packages 仓库并 clone 到本地。

![](https://static.getiot.tech/20200228223053662.png#center)

为方便提交 PR，建议在 packages 本地仓库创建分支

```shell
git checkout -b develop
```

然后将 littled 软件包索引目录复制到 peripherals 目录下，并把 peripherals/Kconfig 的修改更新过去。

```shell
git add .
git commit -m "add littled"
git push origin develop
```



### 提交 Pull Request

完成上一步，在 GitHub 网页上找到对应的提交，可以看到 Pull Request 的提示。确认分支和提交信息无误后，即可向 RT-Thread 的 packages 仓库提交 PR。

之后就是等待审查，合并代码啦！



![](https://static.getiot.tech/2020022822310965.gif#center-300)





