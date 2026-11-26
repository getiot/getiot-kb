---
sidebar_position: 8
slug: /abbreviation-of-embedded-development
---

# 嵌入式开发常见英文单词及缩写

嵌入式开发，避免不了要看芯片手册（包括参考手册、用户手册等），通常在开头的章节会有“Documentation conventions”，意思就是编写文档时的一些约定规则，其中就包括很多半导体行业的专业术语及其英文缩写。因此，为了看明白相关文档，我们最好还是记一下这些常用的专业词汇以及它们的缩写吧。

## 英文缩写

- **ARM**：Advanced RISC Machine
- **AAPCS**：ARM Architecture Process Call Standard，ARM 体系结构过程调用标准
- **RISC**： Reduced Instruction Set Computer，精简指令集计算机
- **RTOS**：Real Time Operating System，实时操作系统
- **DMA**：Direct Memory Access，存储器直接访问
- **EXTI**：External Interrupts，外部中断
- **FSMC**：Flexible Static Memory Controller，可变静态存储控制器
- **FPB**：Flash Patch and Breakpoint，Flash 转换及断电单元
- **HSE**：High Speed External
- **HSI**：High Speed Internal
- **LSE**：Low Speed External
- **LSI**：Low Speed Internal
- **LSU**：Load Store Unit，存取单元
- **PFU**：Prefetch Unit，预取单元
- **DPU**：Dataflow Processing Unit，数据流处理单元
- **FPU**：Floating Processing Unit，浮点计算单元
- **ISR**：Interrupt Service Routines，中断服务程序
- **NMI**：Nonmaskable Interrupt，不可屏蔽中断
- **NVIC**：Nested Vectored Interrupt Controller，嵌套向量中断控制器
- **MPU**：Memory Protection Unit，内存保护单元
- **MMU**：Memory Management Unit，内存管理单元
- **MIPS**：Million Instructions Per Second，每秒能执行的百万条指令的条数
- **RCC**：Reset and Clock Control，复位和时钟控制
- **RTC**：Real-Time Clock，实时时钟
- **IWDG**：Independent Watchdog，独立看门狗
- **WWDG**：Window Watchdog，窗口看门狗
- **TIM**：Timer，定时器
- **GAL**：Generic Array Logic，通用阵列逻辑
- **PAL**：Programmable Array Logic，可编程阵列逻辑
- **ASIC**：Application Specific Integrated Circuit，专用集成电路
- **FPGA**：Field-Programmable Gate Array，现场可编程门阵列
- **CPLD**：Complex Programmable Logic Device，可编程逻辑器件
- **IAP**：即 In-Application Programming，IAP is the ability to re-program the Flash memory of a microcontroller while the user program is running.
- **ICP**：即 In-Circuit Programming，ICP is the ability to program the Flash memory of a microcontroller using the JTAG protocol, the SWD protocol or the bootloader while the device is mounted on the user application board.
  Option bytes：product configuration bits stored in the Flash memory.
- **ITCM**：Instruction Tighly Coupled Memory.
- **DTCM**：Data Tighly Coupled Memory.

## 端口

- **AFIO**：Alternate Function IO，复用IO端口
- **GPIO**：General Purpose Input/Output，通用IO端口
- **IOP(A-G)**：IO port A - IO port G（例如：IOPA:IO port A）
- **CAN**：Controller Area Network，控制器局域网
- **FLITF**：The Flash memory Interface，闪存存储器接口
- **I2C**： Inter-Integrated Circuit，微集成电路
- **IIS**： Integrate Interface of Sound，集成音频接口
- **JTAG**：Joint Test Action Group，联合测试行动小组
- **SPI**：Serial Peripheral Interface，串行外围设备接口
- **SDIO**：SD I/O
- **UART**：Universal Synchr./Asynch. Receiver Transmitter，通用异步接收/发送装置
- **USB**：Universal Serial Bus，通用串行总线

## 寄存器相关

- **CPSP**：Current Program Status Register，当前程序状态寄存器
- **SPSP**：Saved Program Status Register，程序状态备份寄存器
- **CSR**：Clock Control/Status Register，时钟控制状态寄存器
- **LR**：Link Register，链接寄存器
- **SP**：Stack Pointer，堆栈指针
- **MSP**：Main Stack Pointer，主堆栈指针
- **PSP**：Process Stack Pointer，进程堆栈指针
- **PC**：Program Counter，程序计数器

## 调试相关

- **ICE**：In Circuit Emulator，在线仿真（ICE Breaker 嵌入式在线仿真单元）
- **DBG**：Debug，调试
- **IDE**：Integrated Development Environment，集成开发环境
- **DWT**：Data Watchpoint and Trace，数据观测与跟踪单元
- **ITM**：Instrumentation Trace Macrocell，测量跟踪单元
- **ETM**： Embedded Trace Macrocell，嵌入式追踪宏单元
- **TPIU**：Trace Port Interface Unit，跟踪端口接口单元
- **TAP**： Test Access Port，测试访问端口
- **DAP**：Debug Access Port，调试访问端口
- **TP**：Trace Port，跟踪端口
- **DP**：Debug Port，调试端口
- **SWJ-DP**：Serial Wire JTAG Debug Port，串行 JTAG 调试接口
- **SW-DP**：Serial Wire Debug Port，串行调试接口
- **JTAG-DP**：JTAG Debug Port，JTAG 调试接口

## 系统类

- **IRQ**：Interrupt Request，中断请求
- **FIQ**：Fast Interrupt Request，快速中断请求
- **SW**：Software，软件
- **SWI**：Software Interrupt，软中断
- **RO**：Read Only，只读（部分）
- **RW**：Read Write，读写（部分）
- **ZI**：Zero Initial，零初始化（部分）
- **BSS**：Block Started by Symbol，以符号开始的块（未初始化数据段）

## 总线

- **AHB**：Advanced High-performance Bus，先进的高性能总线
- **AHBS**：AHB Slave Bus
- **AHB-AP**：Advanced High-preformance Bus-Access Port
- **APB**：Advanced Peripheral Bus，外围总线
- **APB1**：Low Speed APB
- **APB2**：High Speed APB
- **PPB**：Private Peripheral Bus，专用外设总线
- **AXIM**：AXI master bus
- **Bus Matrix**：总线矩阵
- **Bus Splitter**：总线分割

## 杂类

- **ALU**：Arithmetic Logical Unit，算术逻辑单元
- **CLZ**：Count Leading Zero，前导零计数（指令）
- **SIMD**：Single Instruction Stream Multiple Data Stream，单指令流，多数据流
- **VFP**：Vector Floating Point，矢量浮点运算
- **DFU**：Device Firmware Upgrade，设备固件升级
- **ICU**：Instruction Cache Unit，指令缓冲存储单元
- **DCU**：Data Cache Unit，数据缓冲存储单元

## 词汇/词组

- **Big Endian**：大端存储模式
- **Little Endian**：小端存储模式
- **Context Switch**：任务切换（上下文切换），指 CPU 寄存器内容的切换
- **Task Switch**：任务切换
- **Literal Pool**：文字池，ARM 汇编语言代码节中的一块用来存放常量数据而非可执行代码的内存块
- **Buffer Pool**：数据缓冲池

## 词汇类/单词

- arbitration：仲裁
- access：访问
- assembler：汇编器
- disassembly：反汇编
- binutils：连接器
- bit-banding：位段（技术）
- bit-band alias：位段别名
- bit-band region：位段区域
- banked：分组
- buffer：缓存
- ceramic：陶瓷
- fetch：取指
- decode：译码
- execute：执行
- Harvard：哈佛（架构）
- handler：处理者
- heap：堆
- stack：栈
- latency：延时
- load (LDR)：加载（存储器内容加载到寄存器 Rn）
- store (STR)：存储（寄存器 Rn 内容存储到存储器）
- loader：装载器
- optimization：优化
- process：进程/过程
- thread：线程
- prescaler：预分频器
- prefetch：预读/预取指
- perform：执行
- pre-emption：抢占
- tail-chaining：尾链
- late-arriving：迟到
- resonator：共振器

## 指令相关

- instructions：指令
- pseudo-instruction：伪指令
- directive：伪操作
- comments：注释
- FA：full ascending，满栈递增（方式）
- EA：empty ascending，空栈递增（方式）
- FD：full desending，满栈递减（方式）
- ED：empty desending，空栈递减（方式）

## 工程类

- threshold value：阈值（不是“阀值”哦）

## 计算机

- Capacity：容量
- Unit：单位