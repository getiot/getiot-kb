---
sidebar_position: 1
sidebar_label: 目录结构
slug: /linux-file-system-directory-architecture
authors: [luhuadong]
---

# Linux 目录结构



## 概述

与 Windows 不同。在 Linux 系统中，所有内容都是以文件的形式保存和管理的，即「一切皆文件」。普通文件是文件，目录（Windows 下称为文件夹）是文件，硬件设备（键盘、监视器、硬盘、打印机）是文件，就连套接字（socket）、网络通信等资源也都是文件。

对于 Windows 来说，每一个分区都对应一个盘符。但在 Linux 系统中并没有“盘符”的概念，只有一个根目录（/），所有的文件（资源）都存储在以根目录（/）为树根的树形目录结构中，硬盘分区也是挂载在根目录下的某一目录的。



## 目录结构

Linux 文件系统的最顶层是由根目录开始的，系统使用“/”来表示根目录，在根目录之下的既可以是目录，也可以是文件，而每一个目录中又可以包含（子）目录或文件。如此反复就可以构成一个庞大的文件系统。

实际上，Linux 发行版中的目录结构和目录内容是由 FHS（FileSystem Hierarchy Standard）文件系统层次结构标准定义的。它还定义了几种文件类型和目录的名称、权限和位置。 即使所有文件和目录物理上存储在不同的设备上，它们也都显示在一个公共根目录下。根目录是所有其他目录的父目录，Linux 文件系统包含的目录如下所示。

![](https://static.getiot.tech/linux-file-system-directory.png#center)



## 目录说明

- **/ (root)**
  - 主层次结构根目录，是整个文件系统层次结构的第一个目录和根目录；
  - 包含所有其他目录，例如子目录；
  - 只有 root 用户具有该目录的写权限；
  - 但这并不是 root 用户的主目录（家目录）。 

- **/bin (user binaries)**
  - 存放二进制可执行文件；
  - 所有用户以单用户模式（single-user mode）使用的常用 Linux 命令的二进制可执行文件都存放于此目录中；
  - 此处存放的一些文件如：*ls*, *cp*, *grep*, *ping*, *cat* 等。

- **/boot (boot loader files)**
  - 存放引导加载程序文件；
  - *kernel*, *initrd*, *grub* 等文件和目录都位于此目录；
  - 例如 vmlinux-2.7.31.25-generic, initrd.img-2.3.32.24-generic 等。

- **/dev (device files)**
  - 包含与系统连接的设备的基本文件（设备节点）；
  - 包括终端设备、USB、网络设备以及连接到系统的任何其他设备；
  - 例如 /dev/usbmon0 , /dev/tty1 , /dev/null 等。

- **/etc (configuration files)**
  - etc 是 ‘edit to config’ 的缩写；
  - 该目录包含已安装程序所需的配置文件；
  - 此处包含的主机和系统配置文件是保证系统正常运行所必需的；
  - 该目录还包含用于控制系统某个程序启动或停止的 shell 程序脚本；
  - 在不了解系统配置知识的情况下，不应编辑此目录中的文件，因为不正确的配置可能会导致系统工作不正常；
  - 例如 /etc/passwd , /etc/shadow , /etc/group , /etc/resolv.conf 等。

- **/home (home directories)**
  - 此目录包含用户的主目录（家目录），其中包含用户保存的文件和该用户的配置文件；
  - 除了 root 用户外，每个用户都会在此目录下有一个单独的目录（以该用户名称命名）；
  - 例如 /home/rudy , /home/tina , /home/guest 等。

- **/lib (system libraries)**
  - 此目录包含系统库文件，/bin 和 /sbin 目录中的二进制文件依赖这些库；
  - 库文件名形如 `ld*`、`lib*` 或 `.so.*`
  - 例如 ld-2.11.1.so 等。

- **/media (removable media devices)**
  - 可移动媒体（如 CD-ROM）的临时挂载目录；
  - 例如 /media/cdrom（CD-ROM 设备），/media/floppy（floppy drives 设备）、/media/cdrecorder（CD writer 设备）等。

- **/mnt (mount directory)**
  - 临时挂载目录，系统管理员可以在其中挂载文件系统。 

- **/opt (optional application software packages)**
  - 该目录包含来自各个供应商的附加应用程序（add-on applications）。

- **/proc (process information)**
  - 这是一个由内核创建的虚拟文件系统，用来向用户提供进程和内核信息，对应于 procfs 挂载；
  - 这个虚拟文件系统在内核空间和用户空间之间打开了一个通信窗口；
  - 该目录中的文件由系统自动生成、填充和删除； 
  - 该目录包含有关系统中正在运行的进程的信息，以及有关正在运行的进程的文本信息，例如 /proc/uptime；
  - 例如 `/proc/{pid}` 目录包含对应 PID 进程的信息。

- **/root (root directory)**
  - 这才是 root 用户的主目录（家目录）。

- **/sbin (system binaries)**
  - 该目录包含基本的系统二进制文件；
  - 系统管理员使用此目录中的 Linux 命令来进行系统维护和配置；
  - 例如 *fsck* , *reboot* , *fdisk* , *ifconfig* , *init* 等。

- **/srv (service data)**
  - 该目录包含系统提供的特定站点服务的数据，例如 Web 服务器的数据和脚本，FTP 服务器提供的数据以及版本控制系统的存储库，即与服务器特定的服务相关的数据；
  - 例如 /srv/nfs 包含 NFS 网络文件系统相关的数据。

- **/sys (system)**
  - 该目录包含有关设备、驱动程序和某些内核功能的信息；
  - 它也是由内核创建的虚拟文件系统， 对应于 sysfs 挂载；
  - 这个文件系统不仅可以把设备（devices）和 驱动程序（drivers）的信息从内核输出到用户空间，也可以用来对设备和驱动程序做设置。

- **/tmp (temporary files)**
  - 该目录包含系统创建的临时文件。 

- **/usr (user programs)**
  - 该目录包含只读的用户数据（例如二进制文件、库、文档）和第二级程序（例如用户实用程序和应用程序）的源代码。子目录说明如下：
  - ***/usr/bin*** → 包含用户程序的二进制文件，在 /bin 目录找不到的二进制文件，可以试试在 /usr/bin 下找找看；
  - ***/usr/include*** → 包含标准的头文件；
  - ***/usr/lib*** → 包含 /usr/bin 和 /usr/sbin 中的二进制文件所依赖的库文件；
  - ***/usr/local*** → 本地数据的三级层次结构，包含你从源代码安装的用户程序（例如，当你编译安装 apache 时，将安装到 /usr/local/apache2 下）；
  - ***/usr/sbin*** → /usr/sbin 包含系统管理员使用的二进制文件，在 /sbin 目录找不到的二进制文件，可以试试在 /usr/sbin 下找找看，这里还包含一些非必需的系统二进制文件（例如用于网络服务的守护程序）；
  - ***/usr/share*** → 包含与体系结构无关（共享）的数据，例如图标和字体库；
  - ***/usr/src*** → 包含 kernel 源代码、头文件和文档；
  - ***/usr/X11*** → 包含 X 视窗系统相关的文件。

- **/var (variable files)**
  - 此目录存放在系统正常运行期间会不断更改的文件，例如日志（logs），假脱机文件（spool files）和临时电子邮件文件。子目录说明如下：
  - ***/var/cache →*** 包含应用程序的缓存数据；
  - ***/var/lib →*** 包含程序的状态信息，即在该程序运行期间修改的数据； 
  - ***/var/lock →*** 包含锁定文件（lock files），即跟踪当前使用资源的文件；
  - ***/var/log →*** 包含系统日志文件；
  - ***/var/mail →*** 包含邮箱文件；
  - ***/var/opt →*** 包含来自存储在 /opt 中的附加软件包（add-on packages）的可变数据；
  - ***/var/run →*** 包含系统运行时的可变数据，例如描述系统自启动以来的系统信息数据；
  - ***/var/spool →*** 包含用于等待处理任务的后台程序，例如打印队列和外发邮件队列；
  - ***/var/spool/mail →*** 用户邮箱的另一个位置；
  - ***/var/tmp →*** 包含在重新启动之间保留的临时文件。


