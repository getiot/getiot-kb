---
sidebar_position: 4
---

# Linux GPIO 子系统

从硬件看，GPIO（General Purpose Input/Output）是引脚的一种工作模式；从软件看，它就是一条数字线：可配置为输入或输出，电平只有高 / 低两种状态。

内核 GPIO 子系统提供申请、配置方向、读写电平、去抖、映射为 IRQ 等能力。使用前应先向内核**申请所有权**，避免多个驱动争用同一引脚。

## 两套接口

| 接口 | 特点 | 建议 |
| --- | --- | --- |
| 整数编号接口（legacy） | GPIO 用 `unsigned` 编号标识 | 已过时，仅维护旧代码时接触 |
| 描述符接口（descriptor / gpiod） | 用不透明描述符 + 专用 API | **新驱动首选** |

本文先讲仍常见于旧代码与教材中的整数接口，并在文末说明推荐方向。头文件：

```c
#include <linux/gpio.h>      /* legacy */
#include <linux/gpio/consumer.h>  /* gpiod */
```

## Legacy：申请与配置

```c
static int gpio_request(unsigned gpio, const char *label);
void gpio_free(unsigned int gpio);
static bool gpio_is_valid(int number);
```

- `gpio`：GPIO 编号  
- `label`：内核 / debugfs（如 `/sys/kernel/debug/gpio`）中的标签  
- 成功返回 0，失败返回负错误码  
- 不确定编号是否有效时，可先用 `gpio_is_valid()`  

申请成功后设置方向：

```c
static int gpio_direction_input(unsigned gpio);
static int gpio_direction_output(unsigned gpio, int value);
```

输出方向的 `value` 表示方向生效后的初始电平。这些调用最终落到提供该 GPIO 的控制器驱动（`struct gpio_chip`）的回调上。

部分控制器支持输入去抖（平台相关）：

```c
static int gpio_set_debounce(unsigned gpio, unsigned debounce); /* 单位：ms */
```

:::note
申请与配置通常应在可能睡眠的上下文中完成（例如驱动 `probe`），不要在硬中断顶半部里做。
:::

## Legacy：读 / 写电平

访问前先判断控制器回调是否可能睡眠：

```c
int gpio_cansleep(unsigned gpio);
```

读写 API**不返回错误码**，因此必须在申请 / 配置阶段检查返回值。

### 原子上下文（不可睡眠）

片内、纯 MMIO 的 GPIO 控制器通常不会睡眠，`gpio_cansleep()` 为 false。可在 IRQ 处理函数中使用：

```c
static int gpio_get_value(unsigned gpio);
void gpio_set_value(unsigned int gpio, int value);
```

`0` 表示低，非 0 表示高。

### 可能睡眠的上下文

挂在 I2C / SPI 等总线上的 GPIO 扩展器，访问总线可能睡眠，`gpio_cansleep()` 应为 true。不要在硬中断顶半部直接访问；应使用带 `_cansleep` 后缀的接口：

```c
static int gpio_get_value_cansleep(unsigned gpio);
void gpio_set_value_cansleep(unsigned gpio, int value);
```

行为与无后缀版本相同，但可避免内核在「错误上下文访问 GPIO」时打印警告。

## GPIO 映射为 IRQ

输入 GPIO 常可作中断源（边沿或电平，由需求和硬件能力决定）。控制器负责提供 GPIO→IRQ 映射：

```c
int gpio_to_irq(unsigned gpio);
```

返回 IRQ 号后，再用 `request_irq()` / `request_threaded_irq()` / `devm_request_threaded_irq()` 注册处理函数：

```c
static irqreturn_t my_interrupt_handler(int irq, void *dev_id)
{
    /* ... */
    return IRQ_HANDLED;
}

int gpio_int = of_get_gpio(np, 0);          /* 旧写法示意 */
int irq_num = gpio_to_irq(gpio_int);
int error = devm_request_threaded_irq(&client->dev, irq_num, NULL,
                my_interrupt_handler,
                IRQF_TRIGGER_RISING | IRQF_ONESHOT,
                "my-gpio", my_data);
```

## 综合示例（legacy）

下面用整数接口演示：两个按键、两个 LED；`BTN1` 触发中断时，把 `BTN2` 的电平写到两个 LED 上。**GPIO 编号请换成你板子上实际空闲且已正确复用的脚。**

```c showLineNumbers
#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/gpio.h>
#include <linux/interrupt.h>

static unsigned int GPIO_LED_RED = 49;
static unsigned int GPIO_BTN1 = 115;
static unsigned int GPIO_BTN2 = 116;
static unsigned int GPIO_LED_GREEN = 120;
static int irq_btn1;

static irqreturn_t btn1_pushed_irq_handler(int irq, void *dev_id)
{
    int state = gpio_get_value(GPIO_BTN2);

    gpio_set_value(GPIO_LED_RED, state);
    gpio_set_value(GPIO_LED_GREEN, state);
    pr_info("BTN1 IRQ: BTN2 state = %d\n", state);
    return IRQ_HANDLED;
}

static int __init gpio_demo_init(void)
{
    int retval;

    if (!gpio_is_valid(GPIO_LED_RED) || !gpio_is_valid(GPIO_LED_GREEN) ||
        !gpio_is_valid(GPIO_BTN1) || !gpio_is_valid(GPIO_BTN2))
        return -ENODEV;

    gpio_request(GPIO_LED_GREEN, "green-led");
    gpio_request(GPIO_LED_RED, "red-led");
    gpio_request(GPIO_BTN1, "button-1");
    gpio_request(GPIO_BTN2, "button-2");

    gpio_direction_input(GPIO_BTN1);
    gpio_direction_input(GPIO_BTN2);
    /* 若控制器支持：gpio_set_debounce(GPIO_BTN1, 200); */

    gpio_direction_output(GPIO_LED_RED, 0);
    gpio_direction_output(GPIO_LED_GREEN, 0);

    irq_btn1 = gpio_to_irq(GPIO_BTN1);
    retval = request_threaded_irq(irq_btn1, NULL, btn1_pushed_irq_handler,
                      IRQF_TRIGGER_LOW | IRQF_ONESHOT,
                      "gpio-demo-btn1", NULL);
    if (retval) {
        pr_err("request_threaded_irq failed: %d\n", retval);
        return retval;
    }

    pr_info("gpio demo loaded\n");
    return 0;
}

static void __exit gpio_demo_exit(void)
{
    free_irq(irq_btn1, NULL);
    gpio_free(GPIO_LED_RED);
    gpio_free(GPIO_LED_GREEN);
    gpio_free(GPIO_BTN1);
    gpio_free(GPIO_BTN2);
    pr_info("gpio demo unloaded\n");
}

module_init(gpio_demo_init);
module_exit(gpio_demo_exit);
MODULE_LICENSE("GPL");
```

## 新代码请用 gpiod

Descriptor 接口用 `struct gpio_desc *`，从设备树 / ACPI 按名字获取，例如：

```c
struct gpio_desc *led = devm_gpiod_get(dev, "led", GPIOD_OUT_LOW);
gpiod_set_value(led, 1);
```

对应 DT 中常写 `led-gpios`（后缀 `-gpios` / `-gpio`）。相比硬编码全局编号，这种方式与具体 SoC 编号解耦，也更安全。

:::tip
整数 API（`gpio_request`、`gpio_get_value` 等）在新内核中仍可能编译，但文档与社区均推荐 **gpiod**。学习时理解「申请 → 配置 → 访问 → IRQ」流程即可；写新驱动请直接用 `linux/gpio/consumer.h`。
:::

## 小结

- GPIO 子系统统一管理数字线的方向、电平与中断映射  
- 先申请所有权，再配置；访问时区分是否可睡眠  
- Legacy 用整数编号；新驱动用描述符（gpiod）并从 DT 获取  

