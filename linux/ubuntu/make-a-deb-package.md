---
sidebar_position: 8
---

# Ubuntu 制作 deb 包



I developed [mitpick](https://github.com/Mithil467/mitpick), a tool to capture the terminal output screenshot, right from the terminal, and copy it to the clipboard. All you need to run is `mitpick`. I am just using mitpick as an example, and the reason that I explored deb packaging in the first place.

Let's get straight into how I packaged it into a `.deb` file.

You'll need a folder to store all contents of the package. Let's call this folder `mitpick_1.0-1` (package-name). This folder is like the `root` of the target system.

Binary files or executables go into the `bin` folder.

```shell
mkdir mitpick_1.0-1/usr/local/bin -p
cp <executable_path> mitpick_1.0-1/usr/local/bin
```

The `-p` flag takes care that the directory is made with all parent directories as well. Otherwise, the command gives error no such file or directory exists.

Other resource files go into the `share` folder. Like in my case, I needed an external bash file as well.

```shell
mkdir mitpick_1.0-1/usr/local/share/mitpick -p
cp <resource_file> mitpick_1.0-1/usr/local/share/mitpick
```

Lastly, you need to make a text file called `control` which includes all metadata information about the package.

```shell
mkdir mitpick_1.0-1/DEBIAN
nano mitpick_1.0-1/DEBIAN/control
```

```ini
Package: mitpick
Version: 1.0-1
Architecture: amd64
Depends: xdotool, xclip
Maintainer: Mithil Poojary mithil467@gmail.com
Description: mitpick
 When you need to screenshot your terminal, just run this
 small program!
```

Each line in the description should start with a single space.

Read about metadata options [here](https://www.debian.org/doc/debian-policy/ch-controlfields.html).

Lastly, you need to package it.

```shell
dpkg-deb --build mitpick_1.0-1

dpkg-deb: building package 'mitpick' in 'mitpick_1.0-1.deb'.
```

Now you can install it:

```shell
sudo apt install ./mitpick_1.0-1.deb
```

That is all for this guide 💖.

**Motivation to make mitpick**

I have QWassignments which involve taking screenshots (a lot of them) of the terminal output for certain commands. The screenshot tools work just fine, but it is really tedious to perform those 4-5 clicks. Mitpick captures the screenshot of the terminal and copies it to the clipboard. All I need to do is execute `mitpick`, and boom, the screenshot is taken and copied to the clipboard to be pasted onto your google doc. It is not that good with the boundaries of the terminal and is in no means a perfect tool.

| Cover pic - screenshot of [cool-retro-term](https://github.com/Swordfish90/cool-retro-term) on my PC





