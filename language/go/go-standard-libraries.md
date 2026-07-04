---
sidebar_position: 35
slug: /go-standard-libraries
---

# Go 语言标准库

Go 语言标准库（Standard library）是 Go 语言提供的一组功能强大且丰富的包（Packages），它实现并为用户提供了各种常见的功能，例如输入输出、网络通信、数据处理、加密解密、并发编程等。标准库包是 Go 语言开发者的重要工具，可以大大提高开发效率，本节将对 Go 语言标准库包及其功能进行介绍。



## 标准库包分类

如果按功能进行划分，Go 语言标准库可以大致分为以下几类。

| 分类           | 相关包                                                       | 描述                                                         |
| :------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| 输入输出       | bufio，fmt，io，log，flag                                    | 这个分类包括二进制以及文本格式在屏幕、键盘、文件以及其他设备上的输入输出等，比如二进制文件的读写。 |
| 文本处理       | encoding，bytes，strings，strconv，text，mime，unicode，regexp，index，path | 这个分类包括字符串和文本内容的处理，比如字符编码转换等。     |
| 网络           | net，http，expvar                                            | 这个分类包括开发网络程序所需要的包，比如Socket编程和网站开发等。 |
| 系统           | os，syscall，sync，time，unsafe                              | 这个分类包含对系统功能的封装，比如对操作系统的交互以及原子性操作等。 |
| 数据结构与算法 | math，sort，container，crypto，hash，archive，compress，image | 整个分类对应各种数据结构和算法的实现封装。                   |
| 运行时         | runtime，reflect，go                                         | 这个分类对应获取运行时信息。                                 |



## 常用包介绍

下面列出一些常用的 Go 语言标准库包：

- **fmt**：提供格式化输入输出功能，用于打印和扫描数据。我们最常用的 `fmt.Printf()` 和 `fmt.Println()` 函数就在这里。
- **net**：提供网络编程相关的功能，包括实现 TCP/IP、HTTP、FTP 等网络协议的功能。
- **http**：提供 HTTP 客户端和服务器的功能，用于构建 Web 应用程序。
- **io**：提供非平台相关的 IO 操作功能，包括文件操作、读写操作、管道操作等。
- **os**：提供操作系统相关的功能，包括文件操作、环境变量、进程管理、用户管理等。
- **sync**：提供同步原语的功能，包括互斥锁、读写锁、条件变量等，用于实现并发编程。
- **encoding/json**：提供 JSON 编码和解码的功能，用于处理 JSON 格式的数据。
- **encoding/xml**：提供 XML 编码和解码的功能，用于处理 XML 格式的数据。
- **crypto**：提供加密和解密相关的功能，包括哈希算法、加密算法、数字签名等。
- **database/sql**：提供 SQL 数据库访问的功能，包括连接数据库、执行 SQL 语句、处理查询结果等。
- **testing**：提供单元测试和性能测试的功能，用于编写和运行测试代码。
- **time**：提供时间相关的功能，包括获取当前时间、计算时间差、格式化时间等。
- **strconv**：提供字符串和基本数据类型之间转换的功能，包括整数、浮点数、布尔值等。
- **regexp**：提供正则表达式的功能，用于处理文本匹配和替换。
- **bufio**：提供缓冲 IO 的功能，用于提高 IO 操作的效率。
- **container**：提供容器数据结构的功能，包括数组、链表、堆、队列等。



## 完整包列表

| 父目录    | 包名             | 描述                                                         |
| :-------- | :--------------- | :----------------------------------------------------------- |
| archive   | tar              | 实现对 tar 压缩文档的访问。                                  |
| archive   | zip              | 提供对 ZIP 压缩文档的读和写支持。                            |
| 无        | bufio            | 实现缓冲的 I/O 功能。                                        |
| 无        | builtin          | 提供 Go 的预声明标识符的文档。                               |
| 无        | bytes            | 提供了对字节切片操作的函数                                   |
| 无        | cmp              | 提供了与比较有序值相关的类型和函数。                         |
| compress  | bzip2            | 实现了 bzip2 解压缩。                                        |
| compress  | flate            | 实现了 RFC 1951 中所定义的 DEFLATE 压缩数据格式。            |
| compress  | gzip             | 实现了 RFC 1951 中所定义的 gzip 格式压缩文件的读和写。       |
| compress  | lzw              | 实现了 Lempel-Ziv-Welch 编码格式的压缩的数据格式。           |
| compress  | zlib             | 实现了 RFC 1950 中所定义的 zlib 格式压缩数据的读和写。       |
| container | heap             | 提供了实现 heap.Interface 接口的任何类型的堆操作。           |
| container | list             | 实现了一个双链表。                                           |
| container | ring             | 实现了对循环链表的操作。                                     |
| 无        | context          | 定义了 Context 类型，用于在不同 goroutine 之间传递上下文信息，并管理这些 goroutine 的生命周期。 |
| crypto    | aes              | 实现了AES 加密（以前的 Rijndael），详见美国联邦信息处理标准（197号文）。 |
| crypto    | cipher           | 实现了标准的密码块模式，该模式可包装进低级的块加密实现中。   |
| crypto    | des              | 实现了数据加密标准（Data Encryption Standard，DES）和三重数据加密算法法（Triple Data Encryption Algorithm，TDEA）。 |
| crypto    | dsa              | 实现了 FIPS 186-3 所定义的数据签名算法（Digital Signature Algorithm）。 |
| crypto    | ecdh             | 实现了 NIST 曲线和 Curve25519 上的 Diffie-Hellman 椭圆曲线算法。 |
| crypto    | ecdsa            | 实现了 FIPS 186-3 所定义的椭圆曲线数据签名算法（Elliptic Curve Digital Signature Algorithm）。 |
| crypto    | ed25519          | 实现了 Ed25519 签名算法。                                    |
| crypto    | elliptic         | 实现了素数域上几个标准的椭圆曲线。                           |
| crypto    | hmac             | 实现了键控哈希消息身份验证码（Keyed-Hash Message Authentication Code，HMAC）。 |
| crypto    | md5              | 实现了 RFC 1321 中所定义的 MD5 哈希算法。                    |
| crypto    | rand             | 实现了一个加密安全的伪随机数生成器。                         |
| crypto    | rc4              | 实现了 RC4 加密，其定义见 Bruce Schneier 的应用密码学（Applied Cryptography）。 |
| crypto    | rsa              | 实现了 PKCS#1 中所定义的 RSA 加密。                          |
| crypto    | sha1             | 实现了 RFC 3174 中所定义的 SHA1 哈希算法。                   |
| crypto    | sha256           | 实现了 FIPS 180-2 中所定义的 SHA224 和 SHA256 哈希算法。     |
| crypto    | sha512           | 实现了 FIPS 180-2 中所定义的 SHA384 和 SHA512 哈希算法。     |
| crypto    | subtle           | 实现了一些有用的加密函数，但需要仔细考虑以便正确应用它们。   |
| crypto    | tls              | 部分实现了 RFC 4346 所定义的 TLS 1.1 协议。                  |
| crypto    | x509             | 可解析 X.509 编码的键值和证书。                              |
| crypto    | x509/pkix        | 包含用于对 X.509 证书、CRL 和 OCSP 的 ASN.1 解析和序列化的共享的、低级的结构。 |
| database  | sql              | 围绕 SQL 提供了一个通用的接口。                              |
| database  | sql/driver       | 定义了数据库驱动所需实现的接口，同 sql 包的使用方式。        |
| debug     | buildinfo        | 提供对 Go 二进制文件中嵌入的关于其构建方式的信息的访问。     |
| debug     | dwarf            | 提供了对从可执行文件加载的 DWARF 调试信息的访问，这个包对于实现 Go 语言的调试器非常有价值。 |
| debug     | elf              | 实现了对 ELF 对象文件的访问。ELF 是一种常见的二进制可执行文件和共享库的文件格式。Linux 采用了 ELF 格式。 |
| debug     | gosym            | 访问 Go 语言二进制程序中的调试信息。对于可视化调试很有价值。 |
| debug     | macho            | 实现了 Mach-O 对文件的访问。                                 |
| debug     | pe               | 实现了对 PE（Microsoft Windows Portable Executable）文件的访问。 |
| debug     | plan9obj         | 实现了对 Plan 9 a.out 目标文件的访问。                       |
| 无        | embed            | 提供对正在运行的 Go 程序中嵌入的文件的访问。                 |
| encoding  | ascii85          | 实现了 ascii85 数据编码，用于 btoa 工具和 Adobe’s PostScript 以及 PDF 文档格式。 |
| encoding  | asn1             | 实现了解析 DER 编码的 ASN.1 数据结构，其定义见 ITU-T Rec X.690。 |
| encoding  | base32           | 实现了 RFC 4648 中所定义的 base32 编码。                     |
| encoding  | base64           | 实现了 RFC 4648 中所定义的 base64 编码。                     |
| encoding  | binary           | 实现了在无符号整数值和字节串之间的转化，以及对固定尺寸值的读和写。 |
| encoding  | csv              | 可读和写由逗号分割的数值（csv）文件。                        |
| encoding  | gob              | 管理 gob 流——在编码器（发送者）和解码器（接收者）之间进行二进制值交换。 |
| encoding  | hex              | 实现了十六进制的编码和解码。                                 |
| encoding  | json             | 实现了定义于 RFC 4627 中的 JSON 对象的编码和解码。           |
| encoding  | pem              | 实现了 PEM（Privacy Enhanced Mail）数据编码。                |
| encoding  | xml              | 实现了一个简单的可理解 XML 名字空间的 XML 1.0 解析器。       |
| 无        | errors           | 实现了操作错误的函数。                                       |
| 无        | expvar           | 为公共变量提供了一个标准的接口，如服务器中的运算计数器。     |
| 无        | flag             | 实现了命令行标记解析。                                       |
| 无        | fmt              | 实现了格式化输入输出。                                       |
| go        | ast              | 声明了用于展示 Go 包中的语法树类型。                         |
| go        | build            | 提供了构建 Go 包的工具。                                     |
| go        | build/constraint | 实现构建约束线（constraint lines）的解析和计算。             |
| go        | constant         | 实现表示非类型化 Go 常量的 Value 及其相应操作。              |
| go        | doc              | 从一个 Go AST（抽象语法树）中提取源代码文档。                |
| go        | doc/comment      | 实现 Go doc 注释（文档注释）的解析和重新格式化，这些注释紧跟在包、const、func、type 或 var 的顶级声明之前。 |
| go        | format           | 实现了 Go 源代码的标准格式化。                               |
| go        | importer         | 提供对导出数据导入程序的访问。                               |
| go        | parser           | 实现了一个 Go 源文件解析器。                                 |
| go        | printer          | 实现了对 AST（抽象语法树）的打印。                           |
| go        | scanner          | 实现了一个 Go 源代码文本的扫描器。                           |
| go        | token            | 定义了代表 Go 编程语言中词法标记以及基本操作标记（printing、predicates）的常量。 |
| go        | types            | 声明数据类型并实现 Go 包的类型检查算法。                     |
| go        | version          | 在 `[Go toolchain name syntax]` 中提供对 `[Go versions]` 的操作，如：go1.20、go1.21.0、go1.22 rc2 和 go1.23.4-bigcorp 等字符串。 |
| hash      | adler32          | 实现了 Adler-32 校验和。                                     |
| hash      | crc32            | 实现了 32 位的循环冗余校验或 CRC-32 校验和。                 |
| hash      | crc64            | 实现了 64 位的循环冗余校验或 CRC-64 校验和。                 |
| hash      | fnv              | 实现了 Glenn Fowler、Landon Curt Noll 和 Phong Vo 所创建的 FNV-1 和 FNV-1a 非加密哈希函数。 |
| hash      | maphash          | 提供字节序列上的哈希函数。                                   |
| html      | template         | 实现了一个 HTML5 兼容的分词器和解析器。它自动构建 HTML 输出，并可防止代码注入。 |
| image     | color            | 实现了一个基本的颜色库。                                     |
| image     | color/palette    | 提供标准调色板。                                             |
| image     | draw             | 提供一些画图函数。                                           |
| image     | gif              | 实现了一个 GIF 图像解码器。                                  |
| image     | jpeg             | 实现了一个 JPEG 图像解码器和编码器。                         |
| image     | png              | 实现了一个 PNG 图像解码器和编码器。                          |
| index     | suffixarray      | 通过构建内存索引实现的高速字符串匹配查找算法。               |
| io        | fs               | 提供了对 I/O 原语的基本接口。。                              |
| io        | ioutil           | 实现了一些实用的 I/O 函数。                                  |
| log       | slog             | 它是一个简单的记录包，提供最基本的日志功能。                 |
| log       | syslog           | 提供了对系统日志服务的简单接口。                             |
| 无        | maps             | 定义对任何类型的映射都有用的各种函数。                       |
| math      | big              | 实现了多精度的算术运算（大数）。                             |
| math      | bits             | 为预先声明的无符号整数类型实现位计数和操作函数。             |
| math      | cmplx            | 为复数提供了基本的常量和数学函数。                           |
| math      | rand             | 实现了伪随机数生成器。                                       |
| math      | rand/v2          | 实现了伪随机数生成器（v2）。                                 |
| 无        | mine             | 实现了部分的 MIME 规范。                                     |
| mime      | multipart        | 实现了在 RFC 2046 中定义的 MIME 多个部分的解析。             |
| mime      | quotedprintable  | 实现 RFC 2045 指定的 Quoted-printable 编码。                 |
| net       | http             | 提供了 HTTP 客户端和服务器的实现。                           |
| net       | http/cgi         | 实现了定义于 RFC 3875 中的 CGI（通用网关接口）。             |
| net       | http/cookiejar   | 实现内存中兼容 RFC 6265 的 http.CookieJar。                  |
| net       | http/fcgi        | 实现了 FastCGI 协议。                                        |
| net       | http/httptest    | 提供了一些 HTTP 测试应用。                                   |
| net       | http/httptrace   | 提供跟踪 HTTP 客户端请求中的事件的机制。                     |
| net       | http/httputil    | 提供了一些 HTTP 应用函数，这些是对 net/http 包中的东西的补充，只不过相对不太常用。 |
| net       | http/pprof       | 通过其 HTTP 服务器运行时提供性能测试数据，该数据的格式正是 pprof 可视化工具需要的。 |
| net       | mail             | 实现了对邮件消息的解析。                                     |
| net       | rpc              | 提供了对一个来自网络或其他 I/O 连接的对象可导出的方法的访问。 |
| net       | rpc/jsonrpc      | 为 rpc 包实现了一个 JSON-RPC ClientCodec 和 ServerCodec。    |
| net       | smtp             | 实现了定义于 RFC 5321 中的简单邮件传输协议（Simple Mail Transfer Protocol）。 |
| net       | textproto        | 实现了在 HTTP、NNTP 和 SMTP 中基于文本的通用的请求/响应协议。 |
| net       | url              | 解析 URL 并实现查询转义。                                    |
| os        | exec             | 可运行外部命令。                                             |
| os        | signal           | 实现对传入信号的访问。                                       |
| os        | user             | 通过名称和 id 进行用户账户检查。                             |
| path      | filepath         | 实现了以与目标操作系统定义文件路径相兼容的方式处理文件名路径。 |
| 无        | plugin           | 实现 Go 插件的加载和符号解析。                               |
| 无        | reflect          | 实现了运行时反射，允许一个程序以任意类型操作对象。           |
| regexp    | syntax           | 实现了一个简单的正则表达式库，将正则表达式解析为语法树。     |
| runtime   | cgo              | 包含对 cgo 工具生成的代码的运行时支持。                      |
| runtime   | coverage         | 提供用于测试代码覆盖率的统计和分析的功能，可用于收集、分析和报告测试代码的覆盖率。 |
| runtime   | debug            | 包含当程序在运行时调试其自身的功能。                         |
| runtime   | metrics          | 提供一个稳定的接口来访问 Go 运行时导出的实现定义的指标。     |
| runtime   | pprof            | 以 pprof 可视化工具需要的格式写运行时性能测试数据。          |
| runtime   | race             | 实现数据竞争检测逻辑。                                       |
| runtime   | trace            | 提供了一种轻量级的跟踪器，可以捕获程序的执行轨迹和性能数据，并生成可视化的跟踪文件，以便开发者分析程序的行为和性能瓶颈。 |
| 无        | slices           | 提供了对任何类型的切片都有用的各种函数。                     |
| 无        | sort             | 提供对集合排序的基础函数集。                                 |
| 无        | strconv          | 实现了在基本数据类型和字符串之间的转换。                     |
| 无        | strings          | 实现了操作字符串的简单函数。                                 |
| sync      | atomic           | 提供了低级的用于实现同步算法的原子级的内存机制，如互斥锁。   |
| syscall   | js               | 当使用 js/wasm 体系结构时，提供了对 WebAssembly 主机环境的访问。 |
| testing   | fstest           | 实现了对测试实现和文件系统用户的支持。                       |
| testing   | iotest           | 提供一系列测试目的的类型，实现了 Reader 和 Writer 标准接口。 |
| testing   | quick            | 实现了用于黑箱测试的实用函数。                               |
| testing   | slogtest         | 实现了对 log/slog.Handler 测试实现的支持。                   |
| text      | scanner          | 为 UTF-8 文本提供了一个扫描器和分词器。                      |
| text      | tabwriter        | 实现了一个写筛选器（tabwriter.Writer），它可将一个输入的 tab 分割的列翻译为适当对齐的文本。 |
| text      | template         | 数据驱动的模板引擎，用于生成类似 HTML 的文本输出格式。       |
| text      | template/parse   | 为由 text/template 和 html/template 定义的模板构建解析树。   |
| time      | tzdata           | 提供测量和显示时间的功能。                                   |
| unicode   | utf16            | 实现了 UTF-16 序列的的编码和解码。                           |
| unicode   | utf8             | 实现了支持以 UTF-8 编码的文本的函数和常数。                  |
| 无        | unsafe           | 包含绕过 Go 程序的类型安全的操作。                           |



## 参考

- [Standard library - Go Packages](https://pkg.go.dev/std)
