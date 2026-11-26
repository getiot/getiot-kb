---
sidebar_position: 7
---

# NanoPi R6S GPIO 使用



GPIO，全称 General-Purpose Input/Output（通用输入输出），是一种软件运行期间能够动态配置和控制的通用引脚。

在 NanoPi R6S 的主控芯片 RK3588S 中，一共有 5 组 GPIO bank，即 GPIO0 \~ GPIO4，每组又以 A0\~A7、B0\~B7、C0\~C7、D0\~D7 作为编号区分。所有的 GPIO 在上电后的初始状态都是输入模式，可以通过软件设为上拉或下拉，也可以设置为中断脚，驱动强度都是可编程的。

每个 GPIO 引脚除了用作通用输入/输出功能外，还可能有其他复用功能，例如 GPIO1_B3，可以作为 SPI0 的时钟引脚以及 UART4 的发送引脚。



## GPIO 驱动

RK3588 的 GPIO 驱动是在以下 pinctrl 文件中实现的：

```bash
kernel/drivers/pinctrl/pinctrl-rockchip.c
```

其核心是填充 GPIO bank 的方法和参数，并调用 `gpiochip_add` 注册到内核中。



## GPIO 编号计算

RK3588S 有 5 组 GPIO bank：GPIO0\~GPIO4，每组又以 A0\~A7、B0\~B7、C0\~C7、D0\~D7 作为编号区分，可通过以下公式计算引脚编号。

```bash
GPIO pin脚计算公式：pin = bank * 32 + number

GPIO 小组编号计算公式：number = group * 8 + X
```

下面演示 GPIO1_B3 pin 脚计算方法：

```c
bank = 1;   //GPIO1_B3 => 1, bank ∈ [0,4]
group = 1;  //GPIO1_B3 => 1, group ∈ {(A=0), (B=1), (C=2), (D=3)}
X = 0;      //GPIO1_B3 => 3, X ∈ [0,7]

number = group * 8 + X = 1 * 8 + 3 = 11
pin = bank * 32 + number = 1 * 32 + 11 = 43;
```



## GPIO 扩展引脚

NanoPi R6S 主板上提供了一个 12-pin 0.5mm FPC 连接器，除电源和地以外一共有 8 个 GPIO，还可扩展出最多 1 路 SPI、3 路 UART、1 路 I2C、2 路 SPDIF，具体引脚定义及其对应的 sysfs 编号如下表所示。

| Pin  | GPIO          | /sys/class/gpio | 说明          |
| ---- | ------------- | --------------- | ------------- |
| 1    | VCC3V3_SYS_S3 |                 | 3.3V 电源输出 |
| 2    | VCC3V3_SYS_S3 |                 | 3.3V 电源输出 |
| 3    | **GPIO1_B3**  | 32*1+8+3 = 43   | 3.3V          |
| 4    | GND           |                 | 地            |
| 5    | **GPIO1_B1**  | 32*1+8+3 = 41   | 3.3V          |
| 6    | **GPIO1_B4**  | 32*1+8+3 = 44   | 3.3V          |
| 7    | **GPIO1_B2**  | 32*1+8+3 = 42   | 3.3V          |
| 8    | GND           |                 | 地            |
| 9    | **GPIO1_B7**  | 32*1+8+3 = 47   | 3.3V          |
| 10   | **GPIO1_B6**  | 32*1+8+3 = 46   | 3.3V          |
| 11   | **GPIO3_C4**  | 32*3+16+4 = 116 | 3.3V          |
| 12   | **GPIO3_C5**  | 32*3+16+4 = 117 | 3.3V          |





## 设备树

GPIO1_B3 对应的设备树属性描述为：`<&gpio1 11 GPIO_ACTIVE_HIGH>`，由 `kernel/include/dt-bindings/pinctrl/rockchip.h` 的宏定义可知，也可以将 GPIO1_B3 描述为 `<&gpio1 RK_PB3 GPIO_ACTIVE_HIGH>`。

```c
#define RK_PA0		0
#define RK_PA1		1
#define RK_PA2		2
#define RK_PA3		3
#define RK_PA4		4
#define RK_PA5		5
#define RK_PA6		6
#define RK_PA7		7
#define RK_PB0		8
#define RK_PB1		9
#define RK_PB2		10
#define RK_PB3		11
...
```

当 GPIO1_B3 脚没有被其它外设复用时, 我们可以通过 export 导出该引脚去使用

```bash
$ cd /sys/class/gpio/
$ ls
export     gpiochip128  gpiochip32   gpiochip64  unexport
gpiochip0  gpiochip200  gpiochip509  gpiochip96

# 导出 gpio56
$ sudo echo 56 > /sys/class/gpio/export
$ ls /sys/class/gpio/
export  gpiochip0    gpiochip200  gpiochip509  gpiochip96
gpio56  gpiochip128  gpiochip32   gpiochip64   unexport

# 查看 gpio56 的方向和电平状态
$ ls /sys/class/gpio/gpio56
active_low  device  direction  edge  power  subsystem  uevent  value
$ sudo cat /sys/class/gpio/gpio56/direction
in
$ sudo cat /sys/class/gpio/gpio56/value
0
```



## 调试方法

### GPIO 调试接口

Debugfs 文件系统目的是为开发人员提供更多内核数据，方便调试。 这里 GPIO 的调试也可以用 Debugfs 文件系统，获得更多的内核信息。GPIO 在 Debugfs 文件系统中的接口为 `/sys/kernel/debug/gpio`，可以这样读取该接口的信息：

```bash
root@FriendlyElec:~# cat /sys/kernel/debug/gpio
gpiochip0: GPIOs 0-31, parent: platform/fd8a0000.gpio, gpio0:

gpiochip1: GPIOs 32-63, parent: platform/fec20000.gpio, gpio1:
 gpio-39  (                    |reset               ) out hi 
 gpio-48  (                    |K1                  ) in  hi ACTIVE LOW
 gpio-49  (                    |sys_led             ) out lo 
 gpio-50  (                    |wan_led             ) out lo 
 gpio-51  (                    |lan1_led            ) out hi 
 gpio-52  (                    |lan2_led            ) out lo 
 gpio-58  (                    |vbus5v0-typec       ) out hi 

gpiochip2: GPIOs 64-95, parent: platform/fec30000.gpio, gpio2:

gpiochip3: GPIOs 96-127, parent: platform/fec40000.gpio, gpio3:
 gpio-111 (                    |snps,reset          ) out hi ACTIVE LOW
 gpio-121 (                    |reset               ) out hi 

gpiochip4: GPIOs 128-159, parent: platform/fec50000.gpio, gpio4:
 gpio-140 (                    |vcc-3v3-sd-s0-regula) out hi 
 gpio-141 (                    |vcc5v0-host-20      ) out hi 
 gpio-142 (                    |enable              ) out hi 

gpiochip5: GPIOs 509-511, parent: platform/rk806-pinctrl.2.auto, rk806-gpio, can sleep:
```

从读取到的信息中可以知道，内核把 GPIO 当前的状态都列出来了，以 GPIO1 组为例，gpio-56(GPIO1_D0) 输出高电平 (out hi)。

### 查看 pinmux-pins

使用命令

```bash
cat /sys/kernel/debug/pinctrl/pinctrl-rockchip-pinctrl/pinmux-pins
```

得到结果

```bash
Pinmux settings per pin
Format: pin (name): mux_owner gpio_owner hog?
pin 0 (gpio0-0): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 1 (gpio0-1): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 2 (gpio0-2): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 3 (gpio0-3): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 4 (gpio0-4): fe2c0000.mmc (GPIO UNCLAIMED) function sdmmc group sdmmc-det
pin 5 (gpio0-5): feb20000.spi (GPIO UNCLAIMED) function spi2 group spi2m2-pins
pin 6 (gpio0-6): feb20000.spi (GPIO UNCLAIMED) function spi2 group spi2m2-pins
pin 7 (gpio0-7): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 8 (gpio0-8): 6-0051 (GPIO UNCLAIMED) function hym8563 group rtc-int
...
pin 47 (gpio1-15): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 48 (gpio1-16): gpio-keys gpio1:48 function gpio-key group key1-pin
...
```

说明：`pin 0` 这一列表示引脚编号，`gpio0-0` 这一列表示 gpio 组编号，后面 `MUX UNCLAIMED` 这一列表示数据选择器的拥有者，`GPIO UNCLAIMED` 这一列表示 gpio 的拥有者。

其中 `MUX UNCLAIMED` 表示该引脚还没有被节点使用 pinctrl 去进行控制，例如：节点 spi2 被启用，它拥有 pinctrl-0 属性，对引脚 pin 5 功能作出出修改，复用为 i2c ，则该引脚的信息会变为 `pin 5 (gpio0-5): feb20000.spi (GPIO UNCLAIMED) function spi2 group spi2m2-pins `，它被地址为 feb20000、名字为 spi2 的节点使用 pinctrl 配置，pinctrl 的值是 spi2m2-pins。

`GPIO UNCLAIMED` 表示还没有注册的 gpio 使用该引脚，我们来看 gpio_keys 的例子：

```c
/ {
	model = "FriendlyElec NanoPi R6S";
	compatible = "friendlyelec,nanopi-r6s", "rockchip,rk3588";

	gpio_keys: gpio-keys {
		compatible = "gpio-keys";
		pinctrl-names = "default";
		pinctrl-0 = <&key1_pin>;

		button@1 {
			debounce-interval = <50>;
			gpios = <&gpio1 RK_PC0 GPIO_ACTIVE_LOW>;
			label = "K1";
			linux,code = <BTN_1>;
			wakeup-source;
		};
	};
}

&pinctrl {
	gpio-key {
		key1_pin: key1-pin {
			rockchip,pins = <1 RK_PC0 RK_FUNC_GPIO &pcfg_pull_up>;
		};
	};
}
```

注册 gpio-keys 引脚后，引脚信息会变成 `pin 48 (gpio1-16): gpio-keys gpio1:48 function gpio-key group key1-pin `，它被名为 gpio_keys 的节点使用 pinctrl 配置，pinctrl 的值是 key1_pin，该引脚还被申请为 gpio-key。

提示：设备树的 pinctrl 配置文件位于 `kernel/arch/arm64/boot/dts/rockchip/rk3588s-pinctrl.dtsi`。



### 使用 gpiod

安装 gpiod 软件包

```bash
sudo apt install gpiod
```

查看 RK3588 所有 GPIO line 的信息

```bash
sudo gpioinfo
```

读取 gpiochip1 的 line 11（也就是 GPIO1_B3）的值（只能读取 unused 状态的 line 值）

```bash
sudo gpioget gpiochip1 11
```

设置 gpiochip1 的 line 11 的值为 0（低电平）

```bash
sudo gpioset gpiochip1 11=0
```



```bash
line  11:      unnamed       unused   input  active-high
```



```bash
line  11:      unnamed      "blink"  output  active-high [used]
```

