---
sidebar_position: 9
authors: [luhuadong]
---

# Arduino 串口通信



Arduino 与计算机通信最常用的方式就是串口通信。在 Arduino 控制器上，串口都是位于 0（RX）和 1（TX）的两个引脚，Arduino 的 USB 口通过一个转换芯片（通常是 ATmega16u2）与这两个串口引脚连接。该转换芯片会通过 USB 接口在计算机上虚拟出一个用于与 Arduino 通信的串口。

因此，当使用 USB 线将 Arduino 与计算机连接时，两者之间便建立了串口连接。通过此连接，Arduino 便可与计算机互传数据了。

![](https://static.getiot.tech/arduino-serial-connection.png#center)



## 串口初始化

在使用串口与计算机通信之前，需要先使用 `Serial.begin()` 函数初始化 Arduino 的串口通信功能。函数原型如下：

```cpp showLineNumbers
Serial.begin(speed);
Serial.begin(speed, config);
```

其中，Serial 是 Arduino 预先定义好的串口对象；参数 speed 为串口通信的波特率，数据类型为 long；参数 config 是可选的，用于设置串口通信的数据位、校验位、停止位，默认为 SERIAL_8N1。

波特率是一个衡量通信速度的参数，它表示每秒传送的比特（bit）的个数。例如 9600 bps 表示每秒发送 9600 bit 的数据。使用串口通信的双方必须使用一致的波特率才能正常通信。串口通信中常用的波特率有 300、600、1200、2400、4800、9600、14400、19200、28800、38400、57600、115200。波特率越高，表明串口通信的速率越高。

串口初始化示例：

```cpp showLineNumbers
void setup() 
{
    Serial.begin(9600); // 打开串口，并设置波特率为 9600 bps
}
```



## 串口输出

串口初始化完成后，就可以使用 `Serial.print()` 和 `Serial.println()` 函数向计算机发送信息了。函数原型如下：

```cpp showLineNumbers
Serial.print(val)
Serial.print(val, format)
```

参数 val 是要输出的数据，各种类型的数据均可；参数 format 是可选的，用于指定输出格式，其值可以是 BIN（二进制）、DEC（十进制）、OCT（八进制）、HEX（十六进制），或者是指定浮点数输出的小数位数（默认输出两位）。

例如：

```cpp showLineNumbers
Serial.print(78);              // 输出 "78"
Serial.print(1.23456);         // 输出 "1.23"
Serial.print('N');             // 输出 "N"
Serial.print("Hello world.");  // 输出 "Hello world."
```

添加第2个参数，会影响输出格式

```cpp showLineNumbers
Serial.print(78, BIN);         // 输出 "1001110"
Serial.print(78, OCT);         // 输出 "116"
Serial.print(78, DEC);         // 输出 "78"
Serial.print(78, HEX);         // 输出 "4E"
Serial.print(1.23456, 0);      // 输出 "1"
Serial.print(1.23456, 2);      // 输出 "1.23"
Serial.print(1.23456, 4);      // 输出 "1.2345"
```

`Serial.println()` 的用法与 `Serial.print()` 一样，唯一的不同是， `Serial.println()` 会在输出完指定数据后，附加一组回车换行符。



## 串口输入

除了输出，串口还可以用于接收由计算机发出的数据。接收串口数据需要使用 `Serial.read()` 函数，其函数原型如下：

```cpp showLineNumbers
Serial.read();
```

`Serial.read()` 函数没有参数。调用该函数，如果串口接收缓冲区有数据，则每次返回1字节的数据，数据类型为 int 型；如果没有数据，则返回 -1。

所以，在使用串口读取数据时，通常会搭配使用 `Serial.available()` 函数。它的作用是返回当前缓冲区中接收到的数据字节数。

示例：

```cpp showLineNumbers
int incomingByte = 0; // 定义变量用于接收串口数据

void setup() 
{
    Serial.begin(9600); // 打开串口，并设置波特率为 9600 bps
}

void loop() 
{
    // 检测缓冲区中是否有可读数据
    if (Serial.available() > 0) 
    {
        // 有可读数据，读取1字节
        incomingByte = Serial.read();

        // 看看你收到的数据是什么
        Serial.print("I received: ");
        Serial.println(incomingByte, DEC);
    }
}
```

前面多次提到的「**串口缓冲区**」实际上是 Arduino 启动后在 SRAM 中开辟的一段大小为 64 Bytes 的空间，串口接收到的数据都会被暂时存放在该空间中，因此将这个存储空间称为串口缓冲区（serial buffer）。当调用 `Serial.read()` 函数时，Arduino 便会从缓冲区中取出 1 Byte 的数据。



## 串口监视器

将上述串口通信的示例代码，编译下载到 Arduino 控制板，打开串口监视器即可进行测试。找到 Arduino IDE 工具栏最右侧的「**串口监视器**」，点击打开。它是 Arduino IDE 自带的一个小工具，可以向 Arduino 设备发送数据，也可以用来查看串口传来的数据。

![](https://static.getiot.tech/arduino-ide-menu-bar.png#center)

需要注意的是，在串口监视器的右下角有一个波特率设置下拉菜单，如果无法收发数据，请检查此处设置的波特率与程序中的设置是否一致。

![](https://static.getiot.tech/arduino-ide-monitor.png#center)



## 更多函数

除了上面提到的几个函数，实际上 Arduino 还为我们提供了其他接口函数，它们在 Arduino 核心库的 HardwareSerial 类中定义。Arduino 已经默认包含了这个类，因此不需要使用 include 语句引入即可使用这些函数。



### available()

获取串口接收到的数据个数，即获取串口接收缓冲区中的字节数。接受缓冲区最多可保存 64 bytes 的数据。

语法：

```cpp showLineNumbers
Serial.available();
```

参数：无

返回值：可读取的字节数

### begin()

初始化串口。可配置串口的各项参数。

语法：

```cpp showLineNumbers
Serial.begin(speed);
Serial.begin(speed, config);
```

参数：

- speed：波特率
- config：数据位、校验位、停止位配置

返回值：无

### end()

结束串口通信。该操作可以释放该串口所在的数字引脚，使得其可以作为普通数字引脚使用。

语法：

```cpp showLineNumbers
Serial.end();
```

参数：无

返回值：无

### find()

从串口缓冲区读取数据，直到读取到指定的字符串。

语法：

```cpp showLineNumbers
Serial.find(target);
```

参数：

- target : 需要搜索的字符串或字符

返回值：

- Boolean型：
- True：找到
- False：没有找到

### findUntil()

从串口缓冲区读取数据，直到读取到指定的字符串或指定的停止符。

语法：

```cpp showLineNumbers
Serial.findUntil(target, terminal);
```

参数：

- target : 需要搜索的字符串或字符
- terminal : 停止符

返回值：bool 型数据

### flush()

等待正在发送的数据发送完成。

语法：

```cpp showLineNumbers
Serial.flush();
```

参数：无

返回值：无

### parseFloat()

从串口缓冲区返回第一个有效的 float 型数据。

语法：

```cpp showLineNumbers
Serial.parseFloat();
```

参数：无

返回值：float 型数据

### parseInt()

从串口流中查找第一个有效的整型数据。

语法：

```cpp showLineNumbers
Serial.parseInt();
```

参数：无

返回值：int 型数据

### peek()

返回1字节的数据，但不会从接受缓冲区删除该数据。与 `read()` 不同，`read()` 读取数据后，会从接受缓冲区删除该数据。

语法：

```cpp showLineNumbers
Serial.peek();
```

参数：无

返回值：进入接受缓冲区的第一个字节的数据；如果没有可读数据，则返回 -1。

### print()

将数据输出到串口。数据会以 ASCII 形式输出。如果要以字节形式输出数据，你需要使用 `write()` 函数。

语法：

```cpp showLineNumbers
Serial.print(val);
Serial.print(val, format);
```

参数：

- val: 需要输出的数据
- format: 输出的进制形式
  - BIN（二进制）
  - DEC（十进制）
  - OCT（八进制）
  - HEX（十六进制）

返回值：输出的字节数

### println()

将数据输出到串口，并回车换行。数据会以 ASCII 码形式输出。

语法：

```cpp showLineNumbers
Serial.println(val);
Serial.println(val, format);
```

参数：

- val：需要输出的数据
- format：输出的进制形式（同上）

返回值：输出的字节数

### read()

从串口读取数据。与 `peek()` 不同，`read()` 每读取一个字节，就会从接受缓冲区移除一个字节的数据。

语法：

```cpp showLineNumbers
Serial.read();
```

参数：无

返回值：进入串口缓冲区的第一个字节；如果没有可读数据，则会返回 -1。

### readBytes()

从接受缓冲区读取指定长度的字符，并将其存入一个数组中。等待数据时间超过设定的超时时间，将退出这个函数。

语法：

```cpp showLineNumbers
Serial.readBytes(buffer, length);
```

参数：

- buffer：用于存储数据的数组（`char[]` 或者 `byte[]`）
- length：需要读取的字符长度

返回值：读到的字节数；如果没有接收到有效的数据，则返回 0。

### readBytesUntil()

从接受缓冲区读取指定长度的字符，并将其存入一个数组中。如果读取到停止符或者等待数据时间超过设定的超时时间，将退出这个函数。

语法：

```cpp showLineNumbers
Serial.readBytesUntil(character, buffer, length);
```

参数：

- character：停止符
- buffer：用于存储数据的数组（ char[] 或者byte[] ）
- length：需要读取的字符长度

返回值：读到的字节数；如果没有接收到有效的数据，则返回 0。

### setTimeout()

设置超时时间。用于设置 `Serial.readBytesUntil()` 和 `Serial.readBytes()` 的等待串口数据时间。

语法：

```cpp showLineNumbers
Serial.setTimeout(time);
```

参数：

- time：超时时间，单位毫秒

返回值：无

### write()

输出数据到串口（以字节形式输出到串口）。

语法：

```cpp showLineNumbers
Serial.write(val);
Serial.write(str);
Serial.write(buf, len);
```

参数：

- val：发送的数据
- str：string型的数据
- buf：数组型的数据
- len：缓冲区的长度

返回值：输出的字节数



