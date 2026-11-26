---
sidebar_position: 7
---

# NuMaker-HMI-N9H30 以太网配置



```bash
msh />ifconfig
network interface device: e0 (Default)
MTU: 1500
MAC: 82 06 21 53 94 53 
FLAGS: UP LINK_UP INTERNET_DOWN DHCP_ENABLE ETHARP BROADCAST IGMP
ip address: 0.0.0.0
gw address: 0.0.0.0
net mask  : 0.0.0.0
dns server #0: 0.0.0.0
dns server #1: 0.0.0.0

network interface device: e1
MTU: 1500
MAC: 82 06 21 53 94 54 
FLAGS: UP LINK_DOWN INTERNET_DOWN DHCP_ENABLE ETHARP BROADCAST IGMP
ip address: 0.0.0.0
gw address: 0.0.0.0
net mask  : 0.0.0.0
dns server #0: 0.0.0.0
dns server #1: 0.0.0.0
```

设置 DNS

```bash
dns e0 0 10.1.32.250
```



```bash
msh />ifconfig
network interface device: e0 (Default)
MTU: 1500
MAC: 82 06 21 53 94 53 
FLAGS: UP LINK_UP INTERNET_DOWN DHCP_ENABLE ETHARP BROADCAST IGMP
ip address: 192.168.137.159
gw address: 192.168.137.1
net mask  : 255.255.255.0
dns server #0: 10.1.32.250
dns server #1: 0.0.0.0

network interface device: e1
MTU: 1500
MAC: 82 06 21 53 94 54 
FLAGS: UP LINK_DOWN INTERNET_DOWN DHCP_ENABLE ETHARP BROADCAST IGMP
ip address: 0.0.0.0
gw address: 0.0.0.0
net mask  : 0.0.0.0
dns server #0: 10.1.32.250
dns server #1: 0.0.0.0
```



```bash
msh />ping getiot.tech
60 bytes from 42.192.64.149 icmp_seq=0 ttl=49 time=37 ms
60 bytes from 42.192.64.149 icmp_seq=1 ttl=49 time=34 ms
60 bytes from 42.192.64.149 icmp_seq=2 ttl=49 time=33 ms
60 bytes from 42.192.64.149 icmp_seq=3 ttl=49 time=35 ms
```





## 参考

- [Win10 将 WLAN 网络共享给以太网](https://cloud.tencent.com/developer/article/1678119)

