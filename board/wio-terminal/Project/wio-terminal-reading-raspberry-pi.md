---
sidebar_position: 8
slug: /wio-terminal-reading-raspberry-pi
---

# Wio Terminal 读取树莓派状态



![img](https://files.seeedstudio.com/wiki/Wio-Terminal/img/WT-rasp.gif#center)



## Demo 概述

这个 Demo 展示了如何通过 USB 接口读取树莓派的系统状态信息，并显示在 Wio Terminal 的 LCD 屏幕上。具体来说，Wio Terminal 的 USB 为 Client 模式，树莓派的 USB 为 Host 模式，并将 Wio Terminal 识别为一个 USB serial 设备，对应 `/dev/tty*` 设备节点。

**硬件材料**

- 1 x Raspberry Pi
- 1 x Wio Terminal
- 1 x USB Type-C 连接线



## 安装依赖库

本示例 Demo 依赖 **LCD** 库和 **Free_Fonts.h** 字体库：

- `LCD` 库在安装 *Seeed SAMD Boards* 库时已经包含了，大家可以参考 [Wio Terminal 开发环境](/wiot/wio-terminal-development-environment/)。
- `Free_Fonts.h` 库提供了一些免费字体，可以点击[这里](https://files.seeedstudio.com/wiki/Wio-Terminal/res/Free_Fonts.h)下载，并将它放在 Arduino 工程中。



## 树莓派程序

树莓派需要运行下面这个 Python 程序，它的功能是定时收集系统的一些状态信息，并打包发送给 Wio Terminal。默认的 USB 串口节点应该是 `/dev/ttyACM0`，如果不对请自行修改。

```python
import os
import time 
import serial

# Settings for reading from Arduino Serial
serialPort= "/dev/ttyACM0" #Change it to your Serial Port, Check in Arudino IDE
baudRate = 115200
ser = serial.Serial(serialPort, baudRate, timeout=0.5)
time.sleep(2)

# Return CPU temperature as a character string
def getCPUtemperature():
    res = os.popen('vcgencmd measure_temp').readline()
    return(res.replace("temp=","").replace("'C\n",""))
 
# Return RAM information (unit=kb) in a list
# Index 0: total RAM
# Index 1: used RAM
# Index 2: free RAM
def getRAMinfo():
    p = os.popen('free')
    i = 0
    while 1:
        i = i + 1
        line = p.readline()
        if i==2:
            return(line.split()[1:4])
 
# Return % of CPU used by user as a character string
def getCPUuse():
    return(str(os.popen("top -n1 | awk '/Cpu\(s\):/ {print $2}'").readline().strip()))
 
# Return information about disk space as a list (unit included)
# Index 0: total disk space
# Index 1: used disk space
# Index 2: remaining disk space
# Index 3: percentage of disk used
def getDiskSpace():
    p = os.popen("df -h /")
    i = 0
    while 1:
        i = i +1
        line = p.readline()
        if i==2:
            return(line.split()[1:5])
 
def main():
    while True:
        # CPU informatiom
        CPU_temp = getCPUtemperature()
        CPU_usage = getCPUuse()
 
        # RAM information
        # Output is in kb, here I convert it in Mb for readability
        RAM_stats = getRAMinfo()
        RAM_total = str(round(int(RAM_stats[0]) / 1000,1))
        RAM_used = str(round(int(RAM_stats[1]) / 1000,1))
        RAM_free = str(round(int(RAM_stats[2]) / 1000,1))
 
        # Disk information
        DISK_stats = getDiskSpace()
        DISK_total = DISK_stats[0]
        DISK_used = DISK_stats[1]
        DISK_perc = DISK_stats[3]
 
        temp=ser.write(str.encode(CPU_temp+' '+CPU_usage))
    data=ser.write(str.encode(CPU_temp+':'+CPU_usage+':'+RAM_total+':'+RAM_used+':'+RAM_free+':'+DISK_total+':'+DISK_used+':'+DISK_perc))
        ser.flush()
        time.sleep(2)
 
        print('')
        print('CPU Temperature = '+CPU_temp)
        print('CPU Use = '+CPU_usage)
        print('')
        print('RAM Total = '+str(RAM_total)+' MB')
        print('RAM Used = '+str(RAM_used)+' MB')
        print('RAM Free = '+str(RAM_free)+' MB')
        print('')  
        print('DISK Total Space = '+str(DISK_total)+'B')
        print('DISK Used Space = '+str(DISK_used)+'B')
        print('DISK Used Percentage = '+str(DISK_perc)) 


if __name__ == '__main__':
    try:    
        main()
    except KeyboardInterrupt:    
        if ser != None:    
            ser.close()
```



## Arduino 程序

```cpp showLineNumbers
#include"TFT_eSPI.h"
#include"Free_Fonts.h" //include the header file
TFT_eSPI tft;

char buffer[100];
String CPU_temp, CPU_usage, Ram_total, Ram_used, Ram_free, Disk_total, Disk_used, Disk_Per;

const unsigned char ram[] = {
  0x00, 0xC3, 0x18, 0xC3, 0x00, 0x00, 0xE7, 0x18, 0xE7, 0x00, 0x00, 0xC3, 
  0x18, 0xC3, 0x00, 0x00, 0xC3, 0x18, 0xC3, 0x00, 0x00, 0xE7, 0x18, 0xE7, 
  0x00, 0x80, 0xFF, 0xFF, 0xFF, 0x01, 0xC0, 0xFF, 0xFF, 0xFF, 0x03, 0xE0, 
  0x01, 0x00, 0x80, 0x07, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x7F, 0x00, 0x00, 
  0x00, 0xFE, 0x72, 0xF0, 0xFF, 0x0F, 0x4E, 0x60, 0xF8, 0xFF, 0x1F, 0x06, 
  0x60, 0x3C, 0x00, 0x3C, 0x06, 0x72, 0x1C, 0x00, 0x38, 0x4E, 0x7F, 0x0C, 
  0x00, 0x30, 0xFE, 0x7F, 0x0C, 0x00, 0x30, 0xFE, 0x60, 0x0C, 0x00, 0x30, 
  0x06, 0x60, 0x0C, 0x00, 0x30, 0x06, 0x60, 0x0C, 0x00, 0x30, 0x06, 0x7F, 
  0x0C, 0x00, 0x30, 0xFE, 0x7F, 0x0C, 0x00, 0x30, 0xFE, 0x60, 0x0C, 0x00, 
  0x30, 0x06, 0x60, 0x0C, 0x00, 0x30, 0x06, 0x60, 0x0C, 0x00, 0x30, 0x06, 
  0x7F, 0x0C, 0x00, 0x30, 0xFE, 0x7F, 0x0C, 0x00, 0x30, 0xFE, 0x72, 0x1C, 
  0x00, 0x38, 0x4E, 0x60, 0x3C, 0x00, 0x3C, 0x06, 0x60, 0xF8, 0xFF, 0x1F, 
  0x06, 0x72, 0xF0, 0xFF, 0x0F, 0x4E, 0x7F, 0x00, 0x00, 0x00, 0xFE, 0xFF, 
  0x00, 0x00, 0x00, 0xFF, 0xE0, 0x01, 0x00, 0x80, 0x07, 0xC0, 0xFF, 0xFF, 
  0xFF, 0x03, 0x80, 0xFF, 0xFF, 0xFF, 0x01, 0x00, 0xE7, 0x18, 0xE7, 0x00, 
  0x00, 0xC3, 0x18, 0xC3, 0x00, 0x00, 0xC3, 0x18, 0xC3, 0x00, 0x00, 0xE7, 
  0x18, 0xE7, 0x00, 0x00, 0xC3, 0x18, 0xC3, 0x00, };

const unsigned char cpu[] = {
  0x00, 0x42, 0x18, 0x42, 0x00, 0x00, 0x42, 0x18, 0x42, 0x00, 0x00, 0x42, 
  0x18, 0x42, 0x00, 0x00, 0x42, 0x18, 0x42, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0xFF, 0xFF, 0xFF, 0x01, 0xC0, 
  0x00, 0x00, 0x00, 0x03, 0x40, 0x00, 0x00, 0x00, 0x02, 0x4F, 0x00, 0x00, 
  0x00, 0xF2, 0x40, 0x00, 0x00, 0x00, 0x02, 0x40, 0x00, 0x00, 0x00, 0x02, 
  0x40, 0x00, 0x00, 0x00, 0x02, 0x40, 0xF0, 0xFF, 0x0F, 0x02, 0x4F, 0xF8, 
  0xFF, 0x1F, 0xF2, 0x40, 0x18, 0x00, 0x18, 0x02, 0x40, 0xD8, 0xBD, 0x1E, 
  0x02, 0x40, 0x78, 0xBC, 0x1E, 0x02, 0x40, 0x78, 0xA4, 0x1E, 0x02, 0x4F, 
  0x78, 0xBC, 0x1E, 0xF2, 0x4F, 0x78, 0xBC, 0x1E, 0xF2, 0x40, 0x78, 0x84, 
  0x1E, 0x02, 0x40, 0x78, 0x84, 0x1E, 0x02, 0x40, 0xD8, 0x85, 0x1B, 0x02, 
  0x40, 0x18, 0x00, 0x18, 0x02, 0x4F, 0xF8, 0xFF, 0x1F, 0xF2, 0x40, 0xF0, 
  0xFF, 0x0F, 0x02, 0x40, 0x00, 0x00, 0x00, 0x02, 0x40, 0x00, 0x00, 0x00, 
  0x02, 0x40, 0x00, 0x00, 0x00, 0x02, 0x4F, 0x00, 0x00, 0x00, 0xF2, 0x40, 
  0x00, 0x00, 0x00, 0x02, 0xC0, 0x00, 0x00, 0x00, 0x03, 0x80, 0xFF, 0xFF, 
  0xFF, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x00, 0x42, 0x18, 0x42, 0x00, 0x00, 0x42, 0x18, 0x42, 0x00, 0x00, 0x42, 
  0x18, 0x42, 0x00, 0x00, 0x42, 0x18, 0x42, 0x00, };

const unsigned char disk[] = {
  0x00, 0x00, 0x00, 0x00, 0x00, 0xF8, 0xFF, 0xFF, 0xFF, 0x03, 0xFC, 0xFB, 
  0xFF, 0xDF, 0x06, 0x06, 0x02, 0x00, 0x40, 0x0C, 0x06, 0x02, 0x00, 0x5F, 
  0x18, 0x06, 0x02, 0x00, 0x51, 0x30, 0x06, 0x02, 0x00, 0x59, 0x60, 0x06, 
  0x02, 0x00, 0x59, 0x40, 0x06, 0x02, 0x00, 0x59, 0x60, 0x06, 0x02, 0x00, 
  0x59, 0x60, 0x06, 0x02, 0x00, 0x59, 0x60, 0x06, 0x02, 0x00, 0x5F, 0x60, 
  0x06, 0x02, 0x00, 0x40, 0x60, 0x06, 0xFE, 0xFF, 0x7F, 0x60, 0x06, 0x00, 
  0x00, 0x00, 0x60, 0x06, 0x00, 0x00, 0x00, 0x60, 0x06, 0x00, 0x00, 0x00, 
  0x60, 0x06, 0x00, 0x00, 0x00, 0x60, 0x06, 0x00, 0x00, 0x00, 0x60, 0xC6, 
  0xFF, 0xFF, 0xFF, 0x63, 0x66, 0x00, 0x00, 0x00, 0x66, 0x26, 0x00, 0x00, 
  0x00, 0x64, 0x26, 0x00, 0x00, 0x00, 0x64, 0x26, 0x00, 0x00, 0x00, 0x64, 
  0x26, 0xFC, 0xFF, 0x3F, 0x64, 0x26, 0xFC, 0xFF, 0x3F, 0x64, 0x26, 0x00, 
  0x00, 0x00, 0x64, 0x26, 0x00, 0x00, 0x00, 0x64, 0x26, 0xFC, 0xFF, 0x3F, 
  0x64, 0x26, 0x00, 0x00, 0x00, 0x64, 0x26, 0x00, 0x00, 0x00, 0x64, 0x26, 
  0x00, 0x00, 0x00, 0x64, 0x26, 0xFC, 0xFF, 0x3F, 0x64, 0x26, 0x00, 0x00, 
  0x00, 0x64, 0x26, 0x00, 0x00, 0x00, 0x64, 0x26, 0x00, 0x00, 0x00, 0x64, 
  0x26, 0x00, 0x00, 0x00, 0x64, 0xEC, 0xFF, 0xFF, 0xFF, 0x37, 0xF8, 0xFF, 
  0xFF, 0xFF, 0x1F, 0x00, 0x00, 0x00, 0x00, 0x00, };


String getStringPartByNr(String data, char separator, int index)
{
    // spliting a string and return the part nr index
    // split by separator
    
    int stringData = 0;        //variable to count data part nr 
    String dataPart = "";      //variable to hole the return text
    
    for(int i = 0; i<data.length()-1; i++) {    //Walk through the text one letter at a time
      
      if(data[i]==separator) {
        //Count the number of times separator character appears in the text
        stringData++;
        
      }else if(stringData==index) {
        //get the text when separator is the rignt one
        dataPart.concat(data[i]);
        
      }else if(stringData>index) {
        //return text and stop if the next separator appears - to save CPU-time
        return dataPart;
        break;    
      }
    }
    //return text if this is the last part
    return dataPart;
}

void setup() {
  // initialize  serial ports:
  Serial.begin(115200);
  Serial.flush();

  tft.begin();
  tft.setRotation(3);

  //Homescreen when there is no data
  tft.fillScreen(TFT_WHITE);
  while(1) {
    HomeScreen();
    if (Serial.available())
      break;
   }
}
 
void loop() {
  // Try to get the data from serial port
  if (Serial.available() > 0) {    
    int index = 0;
    int numChar = Serial.available();
    if (numChar>50) {
      numChar=50;
    }
    memset(buffer, 0, sizeof(buffer));
    while (numChar--) {
      buffer[index++] = Serial.read();
    }
    
    CPU_temp = getStringPartByNr(buffer, '.', 0);
    CPU_usage = getStringPartByNr(buffer, ':', 1);
    Ram_total = getStringPartByNr(buffer, ':', 2);
    Ram_used = getStringPartByNr(buffer, ':', 3);
    Ram_free = getStringPartByNr(buffer, ':', 4);
    Disk_total = getStringPartByNr(buffer, ':', 5);
    Disk_used = getStringPartByNr(buffer, ':', 6);
    Disk_Per = getStringPartByNr(buffer, ':', 7);
    
  }

    //checking the last piece of data is not empty
    if (Disk_Per != "") { 
      TempScreen();
      delay(2000);
      RamScreen();
      delay(2000);
      DiskScreen();
      delay(2000);
    }
}

void TempScreen() {
  tft.fillScreen(TFT_BLACK);
  tft.setTextColor(TFT_WHITE);
  tft.setTextSize(1);
  tft.setFreeFont(FSSB12); //select Free, Sans, Bold, Oblique, 12pt.
  tft.drawString("Raspberry CPU Data",40,17);
  tft.drawFastHLine(0,45,320,TFT_RED);
  tft.drawFastHLine(0,46,320,TFT_RED);
  tft.drawFastHLine(0,47,320,TFT_RED);
  tft.drawRoundRect(34,66,82,32,5,TFT_WHITE);
  tft.fillRoundRect(35,67,80,30,5,TFT_DARKGREY);
  tft.setFreeFont(FMB12);
  tft.setTextColor(TFT_WHITE);
  tft.drawString("TEMP:",40,70);

  tft.drawRoundRect(34,116,92,32,5,TFT_WHITE);
  tft.fillRoundRect(35,117,90,30,5,TFT_DARKGREY);
  tft.drawString("USAGE:",40,120);

  tft.drawFastHLine(0,220,320,TFT_RED);
  tft.drawFastHLine(0,221,320,TFT_RED);
  tft.drawFastHLine(0,222,320,TFT_RED);

  tft.fillCircle(15,80, 5, TFT_DARKGREY);
  tft.fillCircle(15,130, 5, TFT_DARKGREY);
  tft.drawCircle(15,80,6,TFT_WHITE);
  tft.drawCircle(15,130,6,TFT_WHITE);
  
  tft.setTextColor(TFT_WHITE);
  tft.drawString(CPU_temp+'C',130,70);
  tft.drawString(CPU_usage+'%',130,120);

  tft.drawXBitmap(245,110,cpu, 40, 40, TFT_DARKGREY);
}

void RamScreen() {
  tft.fillScreen(TFT_BLACK);
  tft.setTextColor(TFT_WHITE);
  tft.setTextSize(1);
  tft.setFreeFont(FSSB12); //select Free, Sans, Bold, Oblique, 12pt.
  tft.drawString("Raspberry RAM Data",40,17);
  tft.drawFastHLine(0,45,320,TFT_BLUE);
  tft.drawFastHLine(0,46,320,TFT_BLUE);
  tft.drawFastHLine(0,47,320,TFT_BLUE);
  tft.drawRoundRect(34,66,92,32,5,TFT_WHITE);
  tft.fillRoundRect(35,67,90,30,5,TFT_PINK);
  tft.setFreeFont(FMB12);
  tft.setTextColor(TFT_WHITE);
  tft.drawString("TOTAL:",40,70);

  tft.drawRoundRect(34,116,92,32,5,TFT_WHITE);
  tft.fillRoundRect(35,117,90,30,5,TFT_PINK);
  tft.drawString("USED:",40,120);

  tft.drawRoundRect(34,166,92,32,5,TFT_WHITE);
  tft.fillRoundRect(35,167,90,30,5,TFT_PINK);
  tft.drawString("FREE:",40,170);

  tft.drawFastHLine(0,220,320,TFT_BLUE);
  tft.drawFastHLine(0,221,320,TFT_BLUE);
  tft.drawFastHLine(0,222,320,TFT_BLUE);

  tft.fillCircle(15,80, 5, TFT_PINK);
  tft.fillCircle(15,130, 5, TFT_PINK);
  tft.fillCircle(15,180, 5, TFT_PINK);
  tft.drawCircle(15,80,6,TFT_WHITE);
  tft.drawCircle(15,130,6,TFT_WHITE);
  tft.drawCircle(15,180,6,TFT_WHITE);

  tft.setTextColor(TFT_WHITE);
  tft.drawString(Ram_total+"MB",130,70);
  tft.drawString(Ram_used+"MB", 130,120);
  tft.drawString(Ram_free+"MB", 130,170);

  tft.drawXBitmap(245,110,ram, 40, 40, TFT_PINK);
}

void DiskScreen() {
  tft.fillScreen(TFT_BLACK);
  tft.setTextColor(TFT_WHITE);
  tft.setTextSize(1);
  tft.setFreeFont(FSSB12);
  tft.drawString("Raspberry Disk Data",35,17);
  tft.drawFastHLine(0,45,320,TFT_ORANGE);
  tft.drawFastHLine(0,46,320,TFT_ORANGE);
  tft.drawFastHLine(0,47,320,TFT_ORANGE);
  tft.drawRoundRect(34,66,92,32,5,TFT_WHITE);
  tft.fillRoundRect(35,67,90,30,5,TFT_DARKCYAN);
  tft.setFreeFont(FMB12);
  tft.drawString("TOTAL:",40,70);

  tft.drawRoundRect(34,116,92,32,5,TFT_WHITE);
  tft.fillRoundRect(35,117,90,30,5,TFT_DARKCYAN);
  tft.drawString("USED:",40,120);

  tft.drawRoundRect(34,166,92,32,5,TFT_WHITE);
  tft.fillRoundRect(35,167,90,30,5,TFT_DARKCYAN);
  tft.drawString("PERC.:",40,170);

  tft.drawFastHLine(0,220,320,TFT_ORANGE);
  tft.drawFastHLine(0,221,320,TFT_ORANGE);
  tft.drawFastHLine(0,222,320,TFT_ORANGE);

  tft.fillCircle(15,80, 5, TFT_DARKCYAN);
  tft.fillCircle(15,130, 5, TFT_DARKCYAN);
  tft.fillCircle(15,180, 5, TFT_DARKCYAN);
  tft.drawCircle(15,80,6,TFT_WHITE);
  tft.drawCircle(15,130,6,TFT_WHITE);
  tft.drawCircle(15,180,6,TFT_WHITE);

  if (Disk_Per != 0) {
    int perc = atoi(Disk_Per.c_str());
    float ratio = perc*(0.01) * 30;
    tft.drawRect(180,168,10,30,TFT_WHITE);
    tft.fillRect(180,(168+(30-(int)ratio)),10,(int)ratio,TFT_WHITE);
  }
  
  tft.drawString(Disk_total+'B',130,70);
  tft.drawString(Disk_used+'B', 130,120);
  tft.drawString(Disk_Per+'%', 130,170);

  tft.drawXBitmap(245,110,disk, 40, 40, TFT_DARKCYAN);
  
}

void HomeScreen() {
  tft.setFreeFont(FSSB9);
  tft.setTextColor(TFT_BLACK);
  tft.drawString("Starting...", 120,120);
}
```

[代码下载](https://files.seeedstudio.com/wiki/Wio-Terminal/res/readRasp.ino)

