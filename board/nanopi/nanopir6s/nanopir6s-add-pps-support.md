---
sidebar_position: 9
draft: true
---

# NanoPi R6S 添加 PPS 驱动



```bash
--- PPS support                                                                               [*]   PPS debugging messages
      *** PPS clients support ***
<*>   Kernel timer client (Testing client, use for debug)
< >   PPS line discipline
<*>   PPS client using GPIO
      *** PPS generators support ***
```



```bash
ppstest /dev/pps0
```





```bash
cat /sys/class/pps/pps2/assert
```







## 参考

- [Linux/Documentation/devicetree/bindings/pps/pps-gpio.txt - Linux Cross Reference - Free Electrons](http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/pps/pps-gpio.txt)
- [[LinuxPPS\] linuxpps and devicetree support](http://www.linuxpps.org/pipermail/discussions/2013-April/004423.html)
