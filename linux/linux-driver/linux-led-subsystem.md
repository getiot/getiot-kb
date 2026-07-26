---
sidebar_position: 6
---

# Linux LED 子系统

Linux LED 子系统把各类指示灯（GPIO LED、PWM LED、硬件专用 LED 等）抽象成统一接口。用户空间可通过 sysfs（如 `/sys/class/leds/`）控制亮度、触发器（trigger）；驱动侧则对接具体硬件。

板级上最常见的是 **`gpio-leds`**：在设备树里声明若干 GPIO 灯，由内核通用驱动管理，应用或内核触发器即可点亮。

## 设备树：gpio-leds

节点 `compatible = "gpio-leds"`，子节点表示每一颗灯。常用属性：

| 属性 | 说明 | 备注 |
| --- | --- | --- |
| `gpios` | LED 对应的 GPIO，格式见 GPIO binding | 必需（对 gpio-leds） |
| `function` | LED 功能名，见 `dt-bindings/leds/common.h` | 可选，推荐 |
| `color` | 颜色 ID，如 `LED_COLOR_ID_RED` | 可选 |
| `label` | 旧式标签名；新命名更推荐 function/color | 可选 |
| `linux,default-trigger` | 默认触发器，如 `heartbeat`、`disk-activity` | 可选 |
| `default-state` | `"on"` / `"off"` / `"keep"` | 可选 |
| `retain-state-suspended` | 休眠时保持状态 | 可选 |
| `retain-state-shutdown` | 关机路径保持状态 | 可选 |
| `panic-indicator` | 标记为 panic 指示灯 | 可选 |

绑定文档随内核版本演进，以树内 `Documentation/devicetree/bindings/leds/` 为准。

## LED 命名约定

推荐格式：`devicename:color:function`（某些段可为空）。

示例：

```text
red:disk
white:flash
red:indicator
phy1:green:wlan
phy3::wlan
:kbd_backlight
input5::kbd_backlight
input3::numlock
mmc1::status
white:status
```

`function` 常用宏定义在 `include/dt-bindings/leds/common.h`，例如：

```c
#define LED_FUNCTION_ACTIVITY      "activity"
#define LED_FUNCTION_DISK          "disk"
#define LED_FUNCTION_DISK_ACTIVITY "disk-activity"
#define LED_FUNCTION_FAULT         "fault"
#define LED_FUNCTION_HEARTBEAT     "heartbeat"
#define LED_FUNCTION_STATUS        "status"
#define LED_FUNCTION_POWER         "power"
#define LED_FUNCTION_WLAN          "wlan"
#define LED_FUNCTION_CHARGE        "charging"
/* ... 还有 capslock、usb、panic 等，见头文件完整列表 */
```

在 DTS 中可 `#include <dt-bindings/leds/common.h>` 后写 `function = LED_FUNCTION_DISK;`。

## 示例

```c showLineNumbers
#include <dt-bindings/gpio/gpio.h>
#include <dt-bindings/leds/common.h>

leds {
    compatible = "gpio-leds";

    led0 {
        gpios = <&mcu_pio 0 GPIO_ACTIVE_LOW>;
        linux,default-trigger = "disk-activity";
        function = LED_FUNCTION_DISK;
    };

    led1 {
        gpios = <&mcu_pio 1 GPIO_ACTIVE_HIGH>;
        /* BIOS 若已检测到硬件故障，保持当前亮灭 */
        default-state = "keep";
        function = LED_FUNCTION_FAULT;
    };
};

run-control {
    compatible = "gpio-leds";

    led_red {
        gpios = <&mpc8572 6 GPIO_ACTIVE_HIGH>;
        color = <LED_COLOR_ID_RED>;
        default-state = "off";
    };

    led_green {
        gpios = <&mpc8572 7 GPIO_ACTIVE_HIGH>;
        color = <LED_COLOR_ID_GREEN>;
        default-state = "on";
    };
};

charger-leds {
    compatible = "gpio-leds";

    led_charge {
        gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
        linux,default-trigger = "max8903-charger-charging";
        retain-state-suspended;
        function = LED_FUNCTION_CHARGING;
    };
};
```

## 用户空间怎么用

注册成功后，每颗灯大致对应：

```bash
/sys/class/leds/<name>/
  brightness
  max_brightness
  trigger
  ...
```

例如：

```bash
# 查看可用触发器
cat /sys/class/leds/*/trigger

# 手动点亮（具体路径以板子为准）
echo 1 > /sys/class/leds/red:status/brightness

# 心跳闪烁
echo heartbeat > /sys/class/leds/red:status/trigger
```

触发器由内核其它子系统提供（磁盘活动、网卡、CPU、heartbeat 等），把「谁决定亮灭」从 LED 驱动里拆出去，和「机制 vs 策略」的思路一致。

## 写驱动时

- 多数板级指示灯：**只配 DTS + gpio-leds**，不必写驱动  
- 特殊硬件（I2C LED 控制器、呼吸灯引擎等）：实现 LED class 设备，注册到 LED 子系统，仍可复用同一套 sysfs / trigger  

## 小结

- LED 子系统统一指示灯的控制与触发器  
- `gpio-leds` + 规范命名即可覆盖大量板级场景  
- 用户空间用 `/sys/class/leds/`；内核侧优先复用通用驱动与 trigger  

建议回看：[Linux 设备驱动](/ldd/linux-device-driver/)、[GPIO](/ldd/linux-gpio-subsystem/)、[pinctrl](/ldd/linux-pinctrl-subsystem/)，把「节点 → 复用 → GPIO → LED」串成完整路径。
