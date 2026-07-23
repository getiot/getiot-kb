---
sidebar_position: 4
slug: /rust-gpio-example
---

# GPIO 示例

GPIO 是 General Purpose Input/Output 的缩写，通常翻译为“通用输入输出”。点亮 LED 是嵌入式入门的经典例子。

## 示例思路

不同开发板的 HAL API 不完全一样，但流程通常相似：

1. 获取外设访问权限
2. 配置时钟
3. 把某个引脚配置为输出
4. 设置引脚高低电平

## 伪代码示例

下面是抽象化写法，用来帮助你理解流程：

```rust
fn main() -> ! {
    let peripherals = take_peripherals();
    let mut led = peripherals.pin.into_push_pull_output();

    loop {
        led.set_high();
        delay_ms(500);

        led.set_low();
        delay_ms(500);
    }
}
```

真实项目需要根据开发板选择具体 HAL，例如 STM32、RP2040、nRF、ESP32 等生态各有不同。

## 硬件注意事项

:::warning
连接 LED 时要注意限流电阻和引脚电压。不要把 5V 信号直接接到只支持 3.3V 的 GPIO。
:::

有些开发板的板载 LED 是低电平点亮，也就是 `set_low()` 点亮，`set_high()` 熄灭。遇到现象相反时，先查开发板原理图。

## 小结

GPIO 示例的重点不是背某个 HAL 的函数名，而是理解“配置引脚模式，然后输出高低电平”的基本过程。

