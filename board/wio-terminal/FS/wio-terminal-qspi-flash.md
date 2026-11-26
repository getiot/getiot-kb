---
sidebar_position: 2
slug: /wio-terminal-qspi-flash
---

# Wio Terminal 内置 Flash 闪存



Wio Terminal 上内置了一个容量为 4MB 的 Flash 闪存，我们可以用它来存储一些较小的数据、文件、图片之类的，就不用插入 SD 卡了。本文通过几个示例来演示如何操作 Wio Terminal 上的 Flash 闪存，为其安装文件系统，并模拟成 U 盘。



## W25Q32 闪存

Wio Terminal 内置的 Flash 型号是 W25Q32，采用 QSPI 接口与主控制器 ATSAMD51 连接。

![](https://static.getiot.tech/wio-terminal-W25Q32.png#center)

W25Q32 是华邦公司推出的大容量 SPI  Flash 产品，容量是 32M-Bit（即 4M-Byte），划分为 64 个块、1024 个扇区、16384 个页。因此，块大小为 64KB、扇区大小为 4KB、页大小为 256 字节。最高时钟速率为 80MHz，擦除、写次数高达 10 万次，数据保存时间 20 年。



## 安装依赖库

首先需要为 Wio Terminal 安装 `Seeed_Arduino_FS` 文件系统库和 `Seeed_Arduino_SFUD` 库。

1、在 `Seeed_Arduino_FS` 的 [GitHub 仓库](https://github.com/Seeed-Studio/Seeed_Arduino_FS) 下载 zip 包。

2、在 `Seeed_Arduino_SFUD` 的 [GitHub 仓库](https://github.com/Seeed-Studio/Seeed_Arduino_SFUD) 下载 zip 包。

3、然后打开 Arduino IDE，点击 *项目 > 加载库 > 添加 .ZIP 库…*，添加这两个库。



## Flash 读写擦示例

下面示例演示如何利用 SFUD 库，通过 QSPI 接口访问 Wio Terminal 上一块 4MB 大小 Flash 闪存，进行擦除、写入、读取操作。

```cpp showLineNumbers
#include <sfud.h>

#define BUFFER_SIZE   1024

static uint8_t data_buf[BUFFER_SIZE];
static void sfud_demo(uint32_t addr, size_t size, uint8_t *data);

void setup()
{
    Serial.begin(115200);
    while(!Serial) {};
    
    while(!(sfud_init() == SFUD_SUCCESS));
    
#ifdef SFUD_USING_QSPI
    sfud_qspi_fast_read_enable(sfud_get_device(SFUD_W25Q32_DEVICE_INDEX), 2);
#endif

    /* prepare write data */
    for (int i = 0; i < sizeof(data_buf); i++) {
        data_buf[i] = i;
    }

    sfud_demo(0, sizeof(data_buf), data_buf);
}

void loop()
{
 
}

/**
 * SFUD demo for the first flash device test.
 *
 * @param addr flash start address
 * @param size test flash size
 * @param size test flash data buffer
 */
static void sfud_demo(uint32_t addr, size_t size, uint8_t *data)
{
    sfud_err result = SFUD_SUCCESS;
    const sfud_flash *flash = sfud_get_device_table() + 0;
    size_t i;
    
    /* erase test */
    result = sfud_erase(flash, addr, size);
    if (result == SFUD_SUCCESS) {
        Serial.println("Erase the flash data finish");
    } else {
        Serial.println("Erase flash data failed");
        return;
    }
    
    /* write test */
    result = sfud_write(flash, addr, size, data);
    if (result == SFUD_SUCCESS) {
        Serial.println("Write the flash data finish");
    } else {
        Serial.println("Write the flash data failed");
        return;
    }
    
    /* read test */
    size_t BaseTime = micros();
    result = sfud_read(flash, addr, size, data);
    size_t CostTime = micros() - BaseTime;
    
    if (result == SFUD_SUCCESS) {
        Serial.println("Read the flash data success.");
        Serial.println("Offset (h) 00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F\r\n");
        for (i = 0; i < size; i++) {
            if (i % 16 == 0) {
                Serial.print("0x");
                Serial.print(addr + i,HEX);
                Serial.print("\t");
            }
            Serial.print(data[i],HEX);
            Serial.print("\t");
            if (((i + 1) % 16 == 0) || i == size - 1) {
                Serial.println("");
            }
        }
        Serial.println(" ");
    } else {
        Serial.println("Read the flash data failed.");
    }
    /* data check */
    for (i = 0; i < size; i++) {
        if (data[i] != i % 256) {
            Serial.println("Read and check write data has an error.");
            break;
        }
    }
    if (i == size) {
        Serial.println("The flash test is success.\r\n");
        Serial.print("read costTime: ");
        Serial.print(CostTime);
        Serial.println(" us");
    }
}
```

编译并上传程序到 Wio Terminal，打开串口监视器可以看到如下打印：

![img](https://static.getiot.tech/wio-terminal-sfud-flash.png#center)



## 将 Flash 模拟成 U 盘

重点：SFUD -> File System -> USB flash drive

待补充...

