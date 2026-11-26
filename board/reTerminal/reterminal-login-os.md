---
sidebar_position: 4
---

# reTerminal 登录系统



## 串口登录

9600 波特率

```bash
$ sudo minicom -D /dev/ttyUSB0 -b 9600
```



## ssh 登录

If you want to log in to the Raspberry Pi OS using **SSH over Wi-Fi/ Ethernet**, you can follow the steps below. First set up Wi-Fi/Ethernet on the reTerminal and then SSH using Windows/Mac/Linux.

**Note:** If you have configured WiFi and enabled SSH using Raspberry Pi Imager, you can skip steps 1 - 4

- **Step 1.** If you have a **Wi-Fi connection**, click the **Wi-Fi icon** on the top right corner of the Raspberry Pi OS Desktop, select your Wi-Fi network and enter the password using the on-screen virtual keyboard

**Note:** The location of the Wi-Fi setting might be different for other OS

- **Step 2.** If you don't have a **Wi-Fi connection**, you can connect an ethernet cable from your router to the ethernet port of the reTerminal

**Note:** Make sure the reTerminal and your computer is connected to the same network

- **Step 3.** Touch on the Raspberry Pi icon at the top left corner and navigate to `Preferences > Raspberry Pi Configuration` and click on **Interfaces** tab
- **Step 4.** Select **Enable** which is next to **SSH** and click **OK**



```bash
$ ssh pi@192.168.1.88
```



输入密码 `raspberry`

