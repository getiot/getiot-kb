---
sidebar_position: 5
---

# Yocto 添加 rc.local 文件



```shell
IMAGE_INSTALL_append = "fsl-rc-local"
```



### 设置自动登录



```shell
# Enable local auto-login of the root user (local = serial port and
# virtual console by default, can be configured).
OSTRO_LOCAL_GETTY ?= " \
    ${IMAGE_ROOTFS}${systemd_system_unitdir}/serial-getty@.service \
    ${IMAGE_ROOTFS}${systemd_system_unitdir}/getty@.service \
"
local_autologin () {
    sed -i -e 's/^\(ExecStart *=.*getty \)/\1--autologin root /' ${OSTRO_LOCAL_GETTY}
}
ROOTFS_POSTPROCESS_COMMAND += "${@bb.utils.contains('IMAGE_FEATURES', 'autologin', 'local_autologin;', '', d)}"
```



修改 /etc/systemd/system/getty.target.wants/serial-getty@ttymxc0.service

```shell
ExecStart=-/sbin/agetty -8 -L %I 115200 $TERM
```

改为

```shell
ExecStart=-/sbin/agetty -a root -8 -L %I 115200 $TERM
```





