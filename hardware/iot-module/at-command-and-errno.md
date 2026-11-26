---
sidebar_position: 9
---

# 常用 AT 指令与错误码



## AT 指令

### 一般命令

- AT+CGMI ：给出模块厂商的标识。
- AT+CGMM ：获得模块标识。这个命令用来得到支持的频带（GSM 900，DCS 1800 或 PCS 1900）。当模块有多频带时，回应可能是不同频带的结合。
- AT+CGMR ：获得改订的软件版本。
- AT+CGSN ：获得 GSM 模块的 IMEI（国际移动设备标识）序列号。
- AT+CSCS ：选择 TE 特征设定。这个命令报告 TE 用的是哪个状态设定上的 ME。ME 于是可以转换每一个输入的或显示的字母。这个是用来发送、读取或者撰写短信。
- AT+WPCS ：设定电话簿状态。这个特殊的命令报告通过 TE 电话簿所用的状态的 ME。ME 于是可以转换每一个输入的或者显示的字符串字母。这个用来读或者写电话簿的入口。
- AT+CIMI ：获得 IMSI。这命令用来读取或者识别 SIM 卡的 IMSI（国际移动签署者标识）。在读取 IMSI 之前应该先输入 PIN（如果需要 PIN 的话）。
- AT+CCID ：获得 SIM 卡的标识。这个命令使模块读取 SIM 卡上的 EF-CCID 文件。
- AT+GCAP ：获得能力表。（支持的功能）
- A/ ：重复上次命令。注意，只有 A/ 命令不能重复，必须要有前一个执行的命令。
- AT+CPOF ：关机。这个特殊的命令停止 GSM 软件堆栈和硬件层。与命令 AT+CFUN=0 的功能相同。
- AT+CFUN ：设定电话机能。这个命令选择移动站点的机能水平。
- AT+CPAS ：返回移动设备的活动状态。
- AT+CMEE ：报告移动设备的错误。这个命令决定允许或不允许用结果码“`+CME ERROR:<xxx>`”或者“`+CMS ERROR:<xxx>`”代替简单的“ERROR”。
- AT+CKPD ：小键盘控制。仿真 ME 小键盘执行命令。
- AT+CCLK ：时钟管理。这个命令用来设置或者获得 ME 真实时钟的当前日期和时间。
- AT+CALA ：警报管理。这个命令用来设定在 ME 中的警报日期/时间。（闹铃）
- AT+CRMP ：铃声旋律播放。这个命令在模块的蜂鸣器上播放一段旋律。有两种旋律可用：到来语音、数据或传真呼叫旋律和到来短信声音。
- AT+CRSL ：设定或获得到来的电话铃声的声音级别。

### 呼叫控制命令

- ATD ：拨号命令。这个命令用来设置通话、数据或传真呼叫。
- ATH ：挂机命令。
- ATA ：接电话。
- AT+CEER ：扩展错误报告。这个命令给出当上一次通话设置失败后中断通话的原因。
- AT+VTD ：给用户提供应用 GSM 网络发送 DTMF（双音多频）双音频。这个命令用来定义双音频的长度（默认值是 300 毫秒）。
- AT+VTS ：给用户提供应用 GSM 网络发送 DTMF 双音频。这个命令允许传送双音频。
- ATDL ：重拨上次电话号码。
- AT%Dn ：数据终端就绪（DTR）时自动拨号。
- ATS0 ：自动应答。
- AT+CICB ：来电信差。
- AT+CSNS ：单一编号方案。
- AT+VGR，AT+VGT ：增益控制。这个命令应用于调节喇叭的接收增益和麦克风的传输增益。
- AT+CMUT ：麦克风静音控制。
- AT+SPEAKER ：喇叭/麦克风选择。这个特殊命令用来选择喇叭和麦克风。
- AT+ECHO ：回音取消。
- AT+SIDET ：侧音修正。
- AT+VIP ：初始化声音参数。
- AT+DUI ：用附加的用户信息拨号。
- AT+HUI ：用附加的用户信息挂机。
- AT+RUI ：接收附加用户信息。

### 网络服务命令

- AT+CSQ ：信号质量。
- AT+COPS ：服务商选择。
- AT+CREG ：网络注册。获得手机的注册状态。
- AT+WOPN ：读取操作员名字。
- AT+CPOL ：优先操作员列表。

### 安全命令

- AT+CPIN ：输入 PIN。
- AT+CPIN2 ：输入 PIN2。
- AT+CPINC ：PIN 的剩余的尝试号码。
- AT+CLCK ：设备锁。
- AT+CPWD ：改变密码。

### 电话簿命令

- AT+CPBS ：选择电话簿记忆存储。
- AT+CPBR ：读取电话簿表目。
- AT+CPBF ：查找电话簿表目。
- AT+CPBW ：写电话簿表目。
- AT+CPBP ：电话簿电话查询。
- AT+CPBN ：电话簿移动动作。这个特殊命令使电话簿中的条目前移或后移（按字母顺序）
- AT+CNUM ：签署者号码。
- AT+WAIP ：防止在下一次重起时初始化所有的电话簿。
- AT+WDCP ：删除呼叫电话号码。
- AT+CSVM ：设置语音邮件号码。

### 短消息命令

- AT+CSMS ：选择消息服务。支持的服务有 GSM-MO、SMS-MT、SMS-CB。
- AT+CNMA ：新信息确认应答。
- AT+CPMS ：优先信息存储。这个命令定义用来读写信息的存储区域。
- AT+CMGF ：优先信息格式。执行格式有 TEXT 方式和 PDU 方式。
- AT+CSAS ：保存设置。保存 +CSAS 和 +CSMP 的参数。
- AT+CRES ：恢复设置。
- AT+CSDH ：显示文本方式的参数。
- AT+CNMI ：新信息指示。这个命令选择如何从网络上接收短信息。
- AT+CMGR ：读短信。信息从 +CPMS 命令设定的存储器读取。
- AT+CMGL ：列出存储的信息。
- AT+CMGS ：发送信息。
- AT+CMGW ：写短信息并存储。
- AT+CMSS ：从存储器中发送信息。
- AT+CSMP ：设置文本模式的参数。
- AT+CMGD ：删除短信息。删除一个或多个短信息。
- AT+CSCA ：短信服务中心地址。
- AT+CSCB ：选择单元广播信息类型。
- AT+WCBM ：单元广播信息标识。
- AT+WMSC ：信息状态（是否读过、是否发送等等）修正。
- AT+WMGO ：信息覆盖写入。
- AT+WUSS ：不改变 SMS 状态。在执行 +CMGR 或 +CMGL 后仍保持 UNREAD。

### 追加服务命令

- AT+CCFC ：呼叫继续。
- AT+CLCK ：呼叫禁止。
- AT+CPWD ：改变追加服务密码。
- AT+CCWA ：呼叫等待。
- AT+CLIR ：呼叫线确认限制。
- AT+CLIP ：呼叫线确认陈述。
- AT+COLP ：联络线确认陈述。
- AT+CAOC ：费用报告。
- AT+CACM ：累计呼叫计量。
- AT+CAMM ：累计呼叫计量最大值。
- AT+CPUC ：单价和货币表。
- AT+CHLD ：呼叫相关的追加服务。
- AT+CLCC ：列出当前的呼叫。
- AT+CSSN ：追加服务通知。
- AT+CUSD ：无组织的追加服务数据。
- AT+CCUG ：关闭的用户组。

### 数据命令

- AT+CBST ：信差类型选择。
- AT+FCLASS ：选择模式。这个命令把模块设置成数据或传真操作的特殊模式。
- AT+CR ：服务报告控制。这个命令允许更为详细的服务报告。
- AT+CRC ：划分的结果代码。这个命令在呼叫到来时允许更为详细的铃声指示。
- AT+ILRR ：本地 DTE-DCE 速率报告。
- AT+CRLP ：无线电通信线路协议参数。
- AT+DOPT ：其他无线电通信线路参数。
- AT%C ：数据压缩选择。
- AT+DS ：是否允许 V42 二度数据压缩。
- AT+DR ：是否报告 V42 二度数据压缩。
- AT\N ：数据纠错选择。

### 传真命令

- AT+FTM ：传送速率。
- AT+FRM ：接收速率
- AT+FTH ：用 HDLC 协议设置传真传送速率。
- AT+FRH ：用 HDLC 协议设置传真接收速率。
- AT+FTS ：停止特定时期的传送并等待。
- AT+FRS ：接收沉默。

### 第二类传真命令

- AT+FDT ：传送数据。
- AT+FDR ：接收数据。
- AT+FET ：传送页标点。
- AT+FPTS ：页转换状态参数。
- AT+FK ：终止会议。
- AT+FBOR ：页转换字节顺序。
- AT+FBUF ：缓冲大小报告。
- AT+FCQ ：控制拷贝质量检验。
- AT+FCR ：控制接收传真的能力。
- AT+FDIS ：当前会议参数。
- AT+FDCC ：设置 DCE 功能参数。
- AT+FLID ：定义本地 ID 串。
- AT+FPHCTO ：页转换超时参数。

### V24-V25命令

- AT+IPR ：确定 DTE 速率。
- AT+ICF ：确定 DTE-DCE 特征结构。
- AT+IFC ：控制 DTE-DCE 本地流量。
- AT&C ：设置 DCD（数据携带检测）信号。
- AT&D ：设置 DTR（数据终端就绪）信号。



## 错误码

### CME 错误码

CME ERROR's (GSM Equipment related codes) Description

- CME ERROR: 0 Phone failure
- CME ERROR: 1 No connection to phone
- CME ERROR: 2 Phone adapter link reserved
- CME ERROR: 3 Operation not allowed
- CME ERROR: 4 Operation not supported
- CME ERROR: 5 PH_SIM PIN required
- CME ERROR: 6 PH_FSIM PIN required
- CME ERROR: 7 PH_FSIM PUK required
- CME ERROR: 10 SIM not inserted
- CME ERROR: 11 SIM PIN required
- CME ERROR: 12 SIM PUK required
- CME ERROR: 13 SIM failure
- CME ERROR: 14 SIM busy
- CME ERROR: 15 SIM wrong
- CME ERROR: 16 Incorrect password
- CME ERROR: 17 SIM PIN2 required
- CME ERROR: 18 SIM PUK2 required
- CME ERROR: 20 Memory full
- CME ERROR: 21 Invalid index
- CME ERROR: 22 Not found
- CME ERROR: 23 Memory failure
- CME ERROR: 24 Text string too long
- CME ERROR: 25 Invalid characters in text string
- CME ERROR: 26 Dial string too long
- CME ERROR: 27 Invalid characters in dial string
- CME ERROR: 30 No network service
- CME ERROR: 31 Network timeout
- CME ERROR: 32 Network not allowed, emergency calls only
- CME ERROR: 40 Network personalization PIN required
- CME ERROR: 41 Network personalization PUK required
- CME ERROR: 42 Network subset personalization PIN required
- CME ERROR: 43 Network subset personalization PUK required
- CME ERROR: 44 Service provider personalization PIN required
- CME ERROR: 45 Service provider personalization PUK required
- CME ERROR: 46 Corporate personalization PIN required
- CME ERROR: 47 Corporate personalization PUK required
- CME ERROR: 48 PH-SIM PUK required
- CME ERROR: 100 Unknown error
- CME ERROR: 103 Illegal MS
- CME ERROR: 106 Illegal ME
- CME ERROR: 107 GPRS services not allowed
- CME ERROR: 111 PLMN not allowed
- CME ERROR: 112 Location area not allowed
- CME ERROR: 113 Roaming not allowed in this location area
- CME ERROR: 126 Operation temporary not allowed
- CME ERROR: 132 Service operation not supported
- CME ERROR: 133 Requested service option not subscribed
- CME ERROR: 134 Service option temporary out of order
- CME ERROR: 148 Unspecified GPRS error
- CME ERROR: 149 PDP authentication failure
- CME ERROR: 150 Invalid mobile class
- CME ERROR: 256 Operation temporarily not allowed
- CME ERROR: 257 Call barred
- CME ERROR: 258 Phone is busy
- CME ERROR: 259 User abort
- CME ERROR: 260 Invalid dial string
- CME ERROR: 261 SS not executed
- CME ERROR: 262 SIM Blocked
- CME ERROR: 263 Invalid block
- CME ERROR: 772 SIM powered down

### CMS 错误码

CMS ERROR's (GSM Network related codes) Description

- CMS ERROR: 1 Unassigned number
- CMS ERROR: 8 Operator determined barring
- CMS ERROR: 10 Call bared
- CMS ERROR: 21 Short message transfer rejected
- CMS ERROR: 27 Destination out of service
- CMS ERROR: 28 Unindentified subscriber
- CMS ERROR: 29 Facility rejected
- CMS ERROR: 30 Unknown subscriber
- CMS ERROR: 38 Network out of order
- CMS ERROR: 41 Temporary failure
- CMS ERROR: 42 Congestion
- CMS ERROR: 47 Recources unavailable
- CMS ERROR: 50 Requested facility not subscribed
- CMS ERROR: 69 Requested facility not implemented
- CMS ERROR: 81 Invalid short message transfer reference value
- CMS ERROR: 95 Invalid message unspecified
- CMS ERROR: 96 Invalid mandatory information
- CMS ERROR: 97 Message type non existent or not implemented
- CMS ERROR: 98 Message not compatible with short message protocol
- CMS ERROR: 99 Information element non-existent or not implemente
- CMS ERROR: 111 Protocol error, unspecified
- CMS ERROR: 127 Internetworking , unspecified
- CMS ERROR: 128 Telematic internetworking not supported
- CMS ERROR: 129 Short message type 0 not supported
- CMS ERROR: 130 Cannot replace short message
- CMS ERROR: 143 Unspecified TP-PID error
- CMS ERROR: 144 Data code scheme not supported
- CMS ERROR: 145 Message class not supported
- CMS ERROR: 159 Unspecified TP-DCS error
- CMS ERROR: 160 Command cannot be actioned
- CMS ERROR: 161 Command unsupported
- CMS ERROR: 175 Unspecified TP-Command error
- CMS ERROR: 176 TPDU not supported
- CMS ERROR: 192 SC busy
- CMS ERROR: 193 No SC subscription
- CMS ERROR: 194 SC System failure
- CMS ERROR: 195 Invalid SME address
- CMS ERROR: 196 Destination SME barred
- CMS ERROR: 197 SM Rejected-Duplicate SM
- CMS ERROR: 198 TP-VPF not supported
- CMS ERROR: 199 TP-VP not supported
- CMS ERROR: 208 D0 SIM SMS Storage full
- CMS ERROR: 209 No SMS Storage capability in SIM
- CMS ERROR: 210 Error in MS
- CMS ERROR: 211 Memory capacity exceeded
- CMS ERROR: 212 Sim application toolkit busy
- CMS ERROR: 213 SIM data download error
- CMS ERROR: 255 Unspecified error cause
- CMS ERROR: 300 ME Failure
- CMS ERROR: 301 SMS service of ME reserved
- CMS ERROR: 302 Operation not allowed
- CMS ERROR: 303 Operation not supported
- CMS ERROR: 304 Invalid PDU mode parameter
- CMS ERROR: 305 Invalid Text mode parameter
- CMS ERROR: 310 SIM not inserted
- CMS ERROR: 311 SIM PIN required
- CMS ERROR: 312 PH-SIM PIN required
- CMS ERROR: 313 SIM failure
- CMS ERROR: 314 SIM busy
- CMS ERROR: 315 SIM wrong
- CMS ERROR: 316 SIM PUK required
- CMS ERROR: 317 SIM PIN2 required
- CMS ERROR: 318 SIM PUK2 required
- CMS ERROR: 320 Memory failure
- CMS ERROR: 321 Invalid memory index
- CMS ERROR: 322 Memory full
- CMS ERROR: 330 SMSC address unknown
- CMS ERROR: 331 No network service
- CMS ERROR: 332 Network timeout
- CMS ERROR: 340 No +CNMA expected
- CMS ERROR: 500 Unknown error
- CMS ERROR: 512 User abort
- CMS ERROR: 513 Unable to store
- CMS ERROR: 514 Invalid Status
- CMS ERROR: 515 Device busy or Invalid Character in string
- CMS ERROR: 516 Invalid length
- CMS ERROR: 517 Invalid character in PDU
- CMS ERROR: 518 Invalid parameter
- CMS ERROR: 519 Invalid length or character
- CMS ERROR: 520 Invalid character in text
- CMS ERROR: 521 Timer expired
- CMS ERROR: 522 Operation temporary not allowed
- CMS ERROR: 532 SIM not ready
- CMS ERROR: 534 Cell Broadcast error unknown
- CMS ERROR: 535 Protocol stack busy

