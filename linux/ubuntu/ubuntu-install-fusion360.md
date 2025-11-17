---
sidebar_position: 25
---

# Ubuntu 安装 Fusion360

[Autodesk Fusion 360](/fusion360/fusion360-intro/) 是一个基于云的 3D 建模、CAD、CAM、CAE 和 PCB 软件平台，用于产品设计和制造，为市场上其他知名解决方案提供经济实惠、功能强大的替代方案。但问题是 Autodesk 只提供了 Windows 或 macOS 平台的安装包。



## 通过 snap 安装

Snaps are applications packaged with all their dependencies to run on all popular Linux distributions from a single build. They update automatically and roll back gracefully.

Snaps are discoverable and installable from the [Snap Store](https://snapcraft.io/store), an app store with an audience of millions.

![img](https://res.cloudinary.com/canonical/image/fetch/f_auto,q_auto,fl_sanitize,w_169,h_159/https://assets.ubuntu.com/v1/100386fb-Distro_Logo_Ubuntu.svg)

### Enable snapd

If you’re running [Ubuntu 16.04 LTS (Xenial Xerus)](https://www.ubuntu.com/) or later, including [Ubuntu 18.04 LTS (Bionic Beaver)](https://www.ubuntu.com/desktop/features) and [Ubuntu 20.04 LTS (Focal Fossa)](https://wiki.ubuntu.com/FocalFossa/ReleaseNotes), you don’t need to do anything. Snap is already installed and ready to go.

For versions of Ubuntu between [14.04 LTS (Trusty Tahr)](https://wiki.ubuntu.com/TrustyTahr/ReleaseNotes) and [15.10 (Wily Werewolf)](https://wiki.ubuntu.com/WilyWerewolf/ReleaseNotes), as well as Ubuntu flavours that don’t include *snap* by default, *snap* can be installed from the Ubuntu Software Centre by searching for *snapd*.

Alternatively, snapd can be installed from the command line:

```bash
sudo apt update
sudo apt install snapd
```

Either log out and back in again, or restart your system, to ensure snap’s paths are updated correctly.

### Install Fusion 360

To install Fusion 360, simply use the following command:

```bash
sudo snap install fusion360 --beta
```



## 通过 Wine 安装

[Autodesk-Fusion-360-for-Linux](https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux)

```bash
wget -N https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/builds/stable-branch/bin/install.sh
chmod +x install.sh
bash install.sh && exit
```





