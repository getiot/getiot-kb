---
sidebar_position: 5
---

# NanoPi R6S 硬盘分区





```bash
/dev/mmcblk2       /dev/mmcblk2p1     /dev/mmcblk2p4     /dev/mmcblk2p7
/dev/mmcblk2boot0  /dev/mmcblk2p2     /dev/mmcblk2p5     /dev/mmcblk2p8
/dev/mmcblk2boot1  /dev/mmcblk2p3     /dev/mmcblk2p6     /dev/mmcblk2p9
```



```bash
$ sudo mount /dev/mmcblk2p6 /mnt/
mount: /mnt: wrong fs type, bad option, bad superblock on /dev/mmcblk2p6, missing codepage or helper program, or other error.
```





```bash
$ sudo fdisk -l
```



```bash
Disk /dev/mmcblk2: 28.91 GiB, 31037849600 bytes, 60620800 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 73987B6B-4974-4C94-A3E8-58AB2EB7A946

Device           Start      End  Sectors  Size Type
/dev/mmcblk2p1   16384    24575     8192    4M unknown
/dev/mmcblk2p2   24576    32767     8192    4M unknown
/dev/mmcblk2p3   32768    40959     8192    4M unknown
/dev/mmcblk2p4   40960    73727    32768   16M unknown
/dev/mmcblk2p5   73728   155647    81920   40M unknown
/dev/mmcblk2p6  155648   221183    65536   32M unknown
/dev/mmcblk2p7  221184   286719    65536   32M unknown
/dev/mmcblk2p8  286720  8019967  7733248  3.7G unknown
/dev/mmcblk2p9 8019968 60620766 52600799 25.1G unknown
```

