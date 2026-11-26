---
sidebar_position: 16
draft: true
---

# ART-Pi 学习资料



本文汇总了 RT-Thread 官方硬件平台 ART-Pi 的学习资料、项目分享和常见错误解答，帮助开发者快速入门 ART-Pi 开发。



## 技术分享

### 玩转 ART-Pi

作者：[Aladdin Wang](https://blog.csdn.net/sinat_31039061)

- [玩转ART-Pi（一）——使用STM32CUBMX生成TouchGFX工程](https://blog.csdn.net/sinat_31039061/article/details/108599356)
- [玩转ART-Pi（二）——制作MDK的外部QSPI-FLASH烧录算法](https://blog.csdn.net/sinat_31039061/article/details/108614721)
- [玩转ART-Pi（三）——如何在ART-PI上创建TouchGFX工程](https://blog.csdn.net/sinat_31039061/article/details/108638097)
- [玩转ART-Pi（四）——添加文件系统](https://blog.csdn.net/sinat_31039061/article/details/109763830)
- [玩转ART-Pi（五）——添加网络功能](https://blog.csdn.net/sinat_31039061/article/details/109763903)
- [玩转ART-Pi（六）——添加FTP服务器](https://blog.csdn.net/sinat_31039061/article/details/109923612)
- [玩转ART-Pi（七）——TouchGFX从文件系统中读取图片](https://blog.csdn.net/sinat_31039061/article/details/109763842)
- [玩转ART-Pi（八）——添加动态模块](https://blog.csdn.net/sinat_31039061/article/details/109763932)

### ART-Pi 学习笔记

作者：[adaphoto](https://club.rt-thread.org/u/6760)

- [ART-Pi学习笔记1：驱动SDIO和USB设备做TF读卡器](https://club.rt-thread.org/ask/article/2417.html)
- [ART-Pi学习笔记2：驱动片外SPI_FLASH_W25Q128](https://club.rt-thread.org/ask/article/2423.html)
- [ART-Pi学习笔记3：学习驱动wifi模块AP6212](https://club.rt-thread.org/ask/article/2429.html)
- [ART-Pi学习笔记4：驱动多媒体扩展版的LCD和触摸功能](https://club.rt-thread.org/ask/article/2436.html)
- [ART-Pi学习笔记5：移植LittleVGL2RTT软件包驱动多媒体扩展屏](https://club.rt-thread.org/ask/article/2434.html)
- [ART-Pi学习笔记5.1：优化LVGL软件包提高刷屏的速度](https://club.rt-thread.org/ask/article/2464.html)
- [ART-Pi学习笔记5.2：LVGL模拟器安装在VS2019上的避坑指南](https://club.rt-thread.org/ask/article/2470.html)
- [ART-Pi学习笔记5_3：在littlevgl软件包中显示中文字体](https://club.rt-thread.org/ask/article/2695.html)
- [ART-Pi学习笔记5_4：在littlevgl中显示二维码](https://club.rt-thread.org/ask/article/2698.html)
- [ART-Pi学习笔记6：驱动PWM输出](https://club.rt-thread.org/ask/article/2483.html)
- [ART-Pi学习笔记7：自己添加硬件定时器设备HWTIMER](https://club.rt-thread.org/ask/article/2492.html)
- [ART-Pi学习笔记8：使用AHT10温湿度模块](https://club.rt-thread.org/ask/article/2543.html)
- [ART-Pi学习笔记9：如何为Art-pi的内部flash设置读保护](https://club.rt-thread.org/ask/article/2568.html)
- [Art-Pi学习笔记9：如何使用art-pi的多媒体扩展板播放TF卡中的音乐文件](https://club.rt-thread.org/ask/article/2849.html)
- [Art-Pi学习笔记10：优化多媒体扩展板的音频驱动添加录音功能](https://club.rt-thread.org/ask/article/2872.html)
- [将ART-Pi的bootloader移植到通用H750vb开发板上](https://club.rt-thread.org/ask/article/2538.html)
- [关于使用easyflash保存env环境变量出现hardfault的问题解决](https://club.rt-thread.org/ask/article/2518.html)
- [关于bootloader跳转到app，app在QSPI中运行的问题总结](https://club.rt-thread.org/ask/article/2415.html)
- [关于STM32H7开发板上使用SDIO接口驱动SD卡挂载文件系统的问题总结](https://club.rt-thread.org/ask/article/2404.html)
- [关于在H750VBT6开发板上使用FMC接口驱动TFT-LCD屏的过程总结](https://club.rt-thread.org/ask/article/2585.html)
- [关于将art-pi的eth设备移植到H7系列开发板上使用小结](https://club.rt-thread.org/ask/article/2818.html)
- [关于在H750VBT6开发板上使用片外SPI_FLASH的总结](https://club.rt-thread.org/ask/article/2586.html)

### ART-Pi 与 RT-Thread 入门

作者：[SimonLiu009](https://blog.csdn.net/toopoo)

- [ART-Pi 上手初体验](https://blog.csdn.net/toopoo/article/details/113105148)
- [开发环境 RT-Thread Studio 的安装和设置](https://blog.csdn.net/toopoo/article/details/113112458)
- [GPIO 引脚输入输出按键中断控制台打印](https://blog.csdn.net/toopoo/article/details/113487496)
- [线程的创建](https://blog.csdn.net/toopoo/article/details/113604115)
- [ART-Pi 配置 PWM 设备(避坑指南，已验证)](https://blog.csdn.net/toopoo/article/details/113632100)
- [启用 ART-Pi 硬件 RTC 和 Alarm 组件](https://blog.csdn.net/toopoo/article/details/113664677)
- [启用 NTP 同步时钟](https://blog.csdn.net/toopoo/article/details/113665077)
- [软件定时器](https://blog.csdn.net/toopoo/article/details/113745708)

### Embeded 小飞哥

- [ART-PI-重力感应无线智能小车第二弹-----OneNet+板载wifi控制电机转动](https://mp.weixin.qq.com/s?__biz=MzI0OTM2OTU5OA==&mid=2247484021&idx=1&sn=59c605eb7a2c5f2c7343603cdbe8bfcc)
- [ART-PI重力感应无线智能小车第一弹](https://mp.weixin.qq.com/s?__biz=MzI0OTM2OTU5OA==&mid=2247483943&idx=1&sn=b080f3a268c1529ccde5e6a7a878efdb)
- [ART-PI_PWM舵机使用](https://mp.weixin.qq.com/s?__biz=MzI0OTM2OTU5OA==&mid=2247483921&idx=1&sn=3092ff2acbdf9ae023906d6c47565221)
- [ART-PI 连接OneNet服务器+控制板载LED灯](https://mp.weixin.qq.com/s?__biz=MzI0OTM2OTU5OA==&mid=2247483872&idx=1&sn=1c40eceda38929e92d7db12831a735e6)
- [ART-Pi OLED驱动流程(RTT-Studio 平台)](https://mp.weixin.qq.com/s?__biz=MzI0OTM2OTU5OA==&mid=2247483720&idx=1&sn=4862db09c0232722778aa184333d2eda)
- [ART-PI OLED小时钟+ESP8266获取网络时间)](https://mp.weixin.qq.com/s?__biz=MzI0OTM2OTU5OA==&mid=2247483788&idx=1&sn=0abc1594b18f45207d33c8d5e3a52351)

###   RT-Thread 入门

作者：[张世争](https://club.rt-thread.org/u/15331/article)

- [【ART-PI】STM32H750XBH6 - 入手篇](https://club.rt-thread.org/ask/article/2462.html)
- [【ART-PI】STM32H750XBH6 - RT-Thread 最小系统移植](https://club.rt-thread.org/ask/article/2469.html)
- [【ART-PI】RT-Thread Freemodbus RS485从机](https://club.rt-thread.org/ask/article/2477.html)
- [【ART-PI】RT-Thread 开启RTC 与 Alarm组件](https://club.rt-thread.org/ask/article/2501.html)
- [【ART-PI】STM32H750XBH6 RT-Thread 点亮LCD](https://club.rt-thread.org/ask/article/2676.html)

### RT-Thread 学习

作者：[杨澄](https://blog.csdn.net/m0_37697335/category_10484125.html)

- [ART-Pi 实现音乐播放器 --播放《天空之城》](https://blog.csdn.net/m0_37697335/article/details/110140740)
- [ART-Pi 实现PWM底层配置](https://blog.csdn.net/m0_37697335/article/details/109696834)
- [ART-Pi的系统时钟配置](https://blog.csdn.net/m0_37697335/article/details/109704602)
- [ART-Pi_电路原理图浅析](https://blog.csdn.net/m0_37697335/article/details/109253544)

### ART-Pi 项目实战

作者：[LZS](https://blog.csdn.net/lzs940320/category_9906518.html)

- [ART-Pi 项目实战--TouchGFx添加列表滑动效果](https://blog.csdn.net/lzs940320/article/details/112648955)
- [ART-Pi 项目实战--TouchGFx添加温度曲线](https://blog.csdn.net/lzs940320/article/details/112648538)
- [ART-Pi 项目实战--TouchGFx添加时钟控件](https://blog.csdn.net/lzs940320/article/details/112647915)
- [ART-Pi 项目实战--TouchGFx添加小弹窗](https://blog.csdn.net/lzs940320/article/details/112647623)
- [ART-Pi 项目实战--TouchGFx控制LED亮灭及图标切换](https://blog.csdn.net/lzs940320/article/details/112647071)
- [ART-Pi 项目实战--TouchGFx界面效果优化](https://blog.csdn.net/lzs940320/article/details/112437259)
- [ART-Pi 项目实战--TouchGFx页面布局](https://blog.csdn.net/lzs940320/article/details/112427254)
- [ART-Pi 项目实战--TouchGFx快速实践](https://blog.csdn.net/lzs940320/article/details/112368116)
- [ART-Pi 项目实战--USB_Device 模拟读卡器](https://blog.csdn.net/lzs940320/article/details/112261856)
- [ART-Pi 项目实战--添加FTP和NTP网络服务](https://blog.csdn.net/lzs940320/article/details/112261421)
- [ART-Pi 项目实战--添加wifi和net双网卡](https://blog.csdn.net/lzs940320/article/details/111637309)
- [ART-Pi 项目实战--添加各类文件系统](https://blog.csdn.net/lzs940320/article/details/111596717)
- [ART-Pi 项目实战--FreeModbus协议的移植](https://blog.csdn.net/lzs940320/article/details/111563063)
- [ART-Pi 项目实战--使用RT-thread studio建立工程](https://blog.csdn.net/lzs940320/article/details/111562800)
- [ART-Pi 项目实战 -- 项目升级计划](https://blog.csdn.net/lzs940320/article/details/110953711)

### 飘雪冰峰

- [利用ART-PI 向 ONENET 上传甲醛浓度信息](https://blog.csdn.net/weixin_37127273/article/details/111119167)
- [ART-PI 连接 ONENET 物联网平台](https://blog.csdn.net/weixin_37127273/article/details/111083856)
- [基于ART-PI的智能甲醛检测仪](https://blog.csdn.net/weixin_37127273/article/details/111051723)
- [ART-Pi lvgl添加触摸事件部分代码](https://blog.csdn.net/weixin_37127273/article/details/110142852)
- [ART-Pi 添加lvgl支持包](https://blog.csdn.net/weixin_37127273/article/details/110134225)

### Z_Tam

- [RT-Thread系列文章目录](https://blog.csdn.net/weixin_37875741/article/details/111498660)
- [ART-Pi RT-Thread Studio ADC](https://blog.csdn.net/weixin_37875741/article/details/111497767)
- [ART-Pi RT-Thread Studio TouchGFX 硬件交互](https://blog.csdn.net/weixin_37875741/article/details/110942141)
- [ART-Pi RT-Thread Studio TouchGFX驱动显示屏](https://blog.csdn.net/weixin_37875741/article/details/110674003)
- [ART-Pi RT-Thread Studio ulog日志](https://blog.csdn.net/weixin_37875741/article/details/109830100)
- [RT-Thread Studio驱动SD卡](https://blog.csdn.net/weixin_37875741/article/details/109733737)

### ART-Pi 与 LRS007

作者：[ForestRain](https://club.rt-thread.org/u/14994/article)

- [基于APT-Pi与LRS007的LoRa-Radio-Driver软件包应用笔记](https://club.rt-thread.org/ask/article/2540.html)
- [基于ART-Pi与LRS007的LoRaWAN_ED_Stack软件包应用笔记](https://club.rt-thread.org/ask/article/2541.html)

### [ART-Pi入门篇](https://blog.csdn.net/jiangyingh/category_10770427.html)

作者：[MyJYHao](https://blog.csdn.net/JIANGYINGH)

- [ART-PI入门篇之点亮OLED显示屏（0.96寸四脚IIC）](https://blog.csdn.net/JIANGYINGH/article/details/113138796)
- [ART-PI入门篇之点亮4.3寸RGB显示屏(正点原子/野火)](https://blog.csdn.net/JIANGYINGH/article/details/113401615)

### 水寒

- [ART-PI 中使用 Modbus 详解](https://dp2px.com/2020/12/05/mcu-rumen7/)
- [ART-PI 示例代码使用 HAL 库过程](https://dp2px.com/2020/12/04/mcu-rumen8/)
- [刚到的 ART-Pi 开发板点灯总结](https://dp2px.com/2020/11/21/mcu-rumen4/)
- [RT-Thread 串口操作实践（ART-Pi开发板）](https://dp2px.com/2020/11/22/mcu-rumen5/)

### 玩转 ART-Pi 开发板

作者：[Ouxiaolong](https://blog.csdn.net/bruceoxl/category_10642929.html)

- [第1章 ART-Pi开发板开机使用](https://bruceou.blog.csdn.net/article/details/110826282)
- [第2章 ART-Pi开发环境搭建](https://bruceou.blog.csdn.net/article/details/110835778)
- [第3章 ART-Pi固件下载与使用](https://bruceou.blog.csdn.net/article/details/111411585)
- [第4章 API-Pi使用多线程](https://bruceou.blog.csdn.net/article/details/112389223)
- [第5章 API-Pi自动初始化详解](https://bruceou.blog.csdn.net/article/details/113663581)
- [第6章 ART-Pi 添加一个串口设备](https://bruceou.blog.csdn.net/article/details/114219971)
- [《嵌入操作系统 – 玩转ART-Pi开发板》第7章 环境监测系统（一）](https://bruceou.blog.csdn.net/article/details/115803076)
- [《嵌入操作系统 – 玩转ART-Pi开发板》第7章 环境监测系统（二）](https://bruceou.blog.csdn.net/article/details/115825831)
- [《嵌入操作系统 – 玩转ART-Pi开发板》第7章 环境监测系统（三）【完结】](https://bruceou.blog.csdn.net/article/details/115831160)

### Rice 嵌入式开发

- [在RT-Thread的ART-PI平台，进行图片识别](https://blog.csdn.net/baidu_29900103/article/details/114529251)

### [Thread_Liu](https://club.rt-thread.org/u/13731)

- [基于 ART-Pi 实现的百度 AI 图像识别](https://club.rt-thread.org/ask/article/2645.html)
- [使用 Clion 调试 ART-Pi 工程](https://club.rt-thread.org/ask/article/2850.html)

### RT-Thread ART-PI 学习笔记

作者：[张竞豪](https://blog.csdn.net/weixin_42487906)

- [TouchGFX的使用和配置](https://blog.csdn.net/weixin_42487906/article/details/113681946)
- [文件系统的使用和配置](https://blog.csdn.net/weixin_42487906/article/details/113766368)
- [网络功能使用和websocket软件包获取心知天气](https://blog.csdn.net/weixin_42487906/article/details/113767644)

### 爱学习的乐乐

- [基于RT-Thread Stduio使用ART-Pi的ADC外设](https://blog.csdn.net/qq_21479819/article/details/115298966)
- [基于RT-Thread的环境监测装置（含IO口模拟8080时序驱动TFT屏幕）](https://blog.csdn.net/qq_21479819/article/details/115288428)

### 崔可

- [手把手教你使用 ART-Pi(STM32H750)片内2M-FLASH](https://club.rt-thread.org/ask/article/2314.html)
- [使用 ART-Pi(STM32H750) 片外8M 之JLINK](https://club.rt-thread.org/ask/article/2348.html)

### [玩转ART-PI+TouchGFX](https://blog.csdn.net/songjun007/category_10823105.html)

作者：[就是菜啊！](https://blog.csdn.net/songjun007)

- [ART-PI开发板连接玫瑰科技5寸LCD屏幕](https://blog.csdn.net/songjun007/article/details/113922992)

### ART-PI开发记录

作者：[爱FC的捷哥](https://blog.csdn.net/a3748622)

- [1、STM32CUBEMX创建LTDC显示工程](https://blog.csdn.net/a3748622/article/details/111879518)

### 其他

- [ART-PI开发板简单点个灯](https://www.getce.cn/show/140.html)
- [ART-PI开发板蓝牙配网流程分析](https://blog.csdn.net/u014421520/article/details/110938234)
- [ART-Pi在studio中勾选USB host后编译错误的问题](https://club.rt-thread.org/ask/article/2511.html)
- [ART-Pi上手体验](https://blog.csdn.net/qq_42913442/article/details/110912956?ops_request_misc=%257B%2522request%255Fid%2522%253A%2522162626312316780264094559%2522%252C%2522scm%2522%253A%252220140713.130102334..%2522%257D&request_id=162626312316780264094559&biz_id=0&utm_medium=distribute.pc_search_result.none-task-blog-2~all~baidu_landing_v2~default-7-110912956.first_rank_v2_pc_rank_v29&utm_term=ART-Pi&spm=1018.2226.3001.4187)
- [STM32的“GPU”——DMA2D实例详解](https://club.rt-thread.org/ask/article/2858.html)
- [ART-PI CANFD 测试与Debug](https://club.rt-thread.org/ask/article/2587.html)

更多内容请访问 [ART-Pi 官网](https://art-pi.gitee.io/website/docs/#/tutorial/README)。



## 作品秀

1. [基于 RT-Thread + ART-Pi 的 RedClock](https://www.cirmall.com/circuit/22366/)
2. [基于 RT-Thread + ART-Pi 的网络照相机](https://www.cirmall.com/circuit/22342/)
3. [基于 RT-Thread + ART-Pi 的数字图像处理与识别](https://www.cirmall.com/circuit/22393/)
4. [基于 RT-Thread + ART-Pi 的智能甲醛检测仪](https://www.cirmall.com/circuit/22333/)
5. [基于 RT-Thread +ART-Pi 的数采一期下位机](https://www.cirmall.com/circuit/22180/)
6. [基于 RT-Thread + ART-Pi 的重力感应无线智能小车](https://www.cirmall.com/circuit/22311/)
7. [基于 RT-Thread + ART-Pi 的运动手表](https://www.cirmall.com/circuit/22378/)
8. [基于 ART-Pi 和 RTT-Nano 的战争雷霆游戏战机飞行参数外设](https://www.cirmall.com/circuit/22228/)
9. [基于 RT-Thread + ART-Pi 的车内二氧化碳检测仪](https://www.cirmall.com/circuit/22343/)
10. [基于 RT-Thread + ART-Pi 的可拓展遥控小车](https://www.cirmall.com/circuit/22350/)
10. [基于 RT-Thread 的 485 数据采集系统](https://www.cirmall.com/circuit/22215/)
10. [基于 RT-Thread + ART-Pi 的写字机器人](https://www.cirmall.com/circuit/22392/)
10. [基于 lvgl 的漏电保护装置校验仪 UI 设计](https://www.cirmall.com/circuit/22330/)
10. [基于RT-Thread和阿里云的气压温度测量系统](https://www.cirmall.com/circuit/22563/)
10. [基于RT-Thread的CAN数据采集终端](https://www.cirmall.com/circuit/22608/)
10. [ART-Pi基于touchGFX的调试助手](https://www.cirmall.com/circuit/22400/)
10. [桌面式智能家居控制系统](https://www.cirmall.com/circuit/22359/)
10. [PM2.5颗粒物检测仪](https://www.cirmall.com/circuit/22561/)
10. [CAN-Monitor](https://www.cirmall.com/circuit/22274/)
10. [手语识别翻译发生装置](https://www.cirmall.com/circuit/22386/)
10. [基于嵌入式操作系统的机器人欠驱动控制模型算法设计与实现](https://www.cirmall.com/circuit/22600/)
10. [声源自动跟随小车](https://www.cirmall.com/circuit/22048/)
10. [基于深度学习的机器故障智能检测设备](https://www.cirmall.com/circuit/22255/)
10. [基于ST传感器的跌落及倾倒检测](https://www.cirmall.com/circuit/22323/)

更多作品参考设计：[https://www.rt-thread.org/page/projects.html](https://www.rt-thread.org/page/projects.html)



## FAQs

1. [ART-Pi 在 Studio 中使用 TouchGFX Library 编译报错怎么解决？](https://club.rt-thread.org/ask/question/428803.html)

2. [在 ART-Pi 平台有没有人成功使用 openocd 可以直接烧写到外部 Quad spi flash 的？](https://club.rt-thread.org/ask/question/428825.html)

3. [基于 ART-Pi 开发板创建的工程，RT-Thread Settings 打不开？](https://club.rt-thread.org/ask/question/428826.html)

4. [ART-Pi 工程用 mdk5 打开后提示文件找不到了？](https://club.rt-thread.org/ask/question/428844.html)

5. [gitee 上的 ART-Pi 仓库地址在哪找到？](https://club.rt-thread.org/ask/question/428880.html)

6. [仅有 ART-Pi 开发包时，RTT Studio 无法创建 ART-Pi 工程怎么办？](https://club.rt-thread.org/ask/question/428881.html)

7. [ARTPi 的 FDCAN 使用官方工程如何发送数据？](https://club.rt-thread.org/ask/question/428952.html)

8. [ART-PI factory demo 在 gcc 9.3.1 上报错；使用 env 中的 scons 报错](https://club.rt-thread.org/ask/question/429159.html)

9. [ARTPI 更新新的 sdk ，无法建立快捷方式【已解决】](https://club.rt-thread.org/ask/question/429248.html)

10. [ART-Pi PWM 定时器 等外设 怎么凑够四个呢？](https://club.rt-thread.org/ask/question/429269.html)

11. [ART-Pi 的 MDK 开发为什么要在 D 盘 mklink？](https://club.rt-thread.org/ask/question/429289.html)

12. [ART-Pi scons --target=iar 出错啥原因？](https://club.rt-thread.org/ask/question/429332.html)

13. [ART-Pi 工程用 MDK5 AC6 编译器报错什么原因？](https://club.rt-thread.org/ask/question/429343.html)

14. [ART-Pi 的 SDK 中，如何配置 wifi 和 eth 同时打开？](https://club.rt-thread.org/ask/question/429366.html)

15. [ART-Pi wifi 固件被破坏后，重新烧写 hash 值校验不对启动不了啥原因？](https://club.rt-thread.org/ask/question/429391.html)

16. [程序烧到内部 rom 后，如何把 touchgfx 图片数据烧到片外 8M 闪存里？](https://club.rt-thread.org/ask/question/429399.html)

17. [使用 ART-Pi上面的 wifi 模块连接 onenet 失败](https://club.rt-thread.org/ask/question/429418.html)

18. [AT Device 使用正点原子 ESP8266 模块获取天气，无法进入透传模式？](https://club.rt-thread.org/ask/question/429460.html)

19. [关于 GT1151 触摸芯片的驱动包问题](https://club.rt-thread.org/ask/question/429644.html)

20. [ART-Pi 默认为 -Oz 优化，为啥优化成 -O0 之后，hardfault？](https://club.rt-thread.org/ask/question/429710.html)

21. [使用 ART-Pi 开发板作为主要的开发对象，关于 rtc_alarm 的使用问题](https://club.rt-thread.org/ask/question/429871.html)

22. [ART-Pi 中 ART-Pi_W25Q64.stldr 是怎么制作和应用的](https://club.rt-thread.org/ask/question/429931.html)

23. [ART-Pi 使用 AT 包驱动 EC20 报错](https://club.rt-thread.org/ask/question/429985.html)

24. [研究 ART-Pi 中，线程创建后，没看到删除操作，但是看不到了](https://club.rt-thread.org/ask/question/429996.html)

25. [ART-Pi 在运行 Touchgfx 时，如果打开 wifi 就在初始化时有一段时间乱码什么情况？](https://club.rt-thread.org/ask/question/430021.html)

26. [使用 ART-Pi 学习时关于 RTT 中文件系统以及 flash 的疑问](https://club.rt-thread.org/ask/question/430283.html)

27. [ART-Pi 使用的 webnet 软件包替换成 Webclient 包需要哪些步骤？](https://club.rt-thread.org/ask/question/430356.html)

28. [SFUD 无法正常写入数据到 ART-Pi 外部 SPI FLASH 的部分区域](https://club.rt-thread.org/ask/question/430401.html)

29. [ART-Pi 在 studio 中勾选 USB host 后编译错误的问题](https://club.rt-thread.org/ask/article/2511.html)

30. **设备管理显示 ST-LINK 带感叹号，且 ST-LINK 红灯常亮。**

    答：需要更新 ST-LINK 驱动，[下载地址](https://www.st.com/zh/development-tools/stsw-link009.html)。

31. **设备管理器能看到 ST-LINK 虚拟串口，但是通用串行设备看不到 ST-LINK。**

    答：查看我的电脑是否有一个 ART-Pi 的 U 盘图标，如果有请参考上一条重新安装驱动，如果还不行，请卸载掉原来的 ST-LINK 驱动后再重新安装一次。

32. **RTT Studio 提示找不到 ST-LINK.exe 的路径。**

    答: 先确保已经通过 RTT Studio 资源管理器下载了1.4版本的 ST-LINK，然后修改工程配置中 ST-LINK 版本为 V1.4。

33. **为什么无法 debug 程序/为什么程序下载进去了不会运行？**

    答：STM32H750 执行片外 QSPI FLASH 上的程序需要有一个 bootloader 来跳转过去，出厂前已经默认烧录了bootloader，所以可以运行，如果不小心擦除了，请重新烧录 bootloader。bootloader 烧录成功之后会打印 Logo，如下所示。

    ```bash
       ___  ______  _____         ______  _   ______  _____  _____  _____ 
      / _ \ | ___ \|_   _|        | ___ \(_)  | ___ \/  _  \/  _  \|_   _|
     / /_\ \| |_/ /  | |   ______ | |_/ / _   | |_/ /| | | || | | |  | |  
     |  _  ||    /   | |  |______||  __/ | |  | ___ \| | | || | | |  | |  
     | | | || |\ \   | |          | |    | |  | |_/ /\ \_/ /\ \_/ /  | |  
     \_| |_/\_| \_|  \_/          \_|    |_|  \____/  \___/  \___/   \_/  
    ```

34. **IDE 报错**

    答：请使用 RTT Studio V1.1.5 以上版本，ART-Pi-SDK 请使用 V1.0.1 以上版本。

    另外，STM32H7 目录下有2个版本的资源包，请打开下拉框取消其中一个勾，请不要同时勾选多个下载。

更多问题解答：[点击这里](https://art-pi.gitee.io/website/docs/#/development/ART-Pi_%E5%B8%B8%E8%A7%81%E9%97%AE%E9%A2%98%E8%A7%A3%E7%AD%94)



