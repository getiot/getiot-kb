---
sidebar_position: 15
slug: /how-to-use-kconfig-for-own-projects
draft: true
---

# 如何在自己的项目中使用 Kconfig



## 介绍

Every Linux professional write scripts. Someеimes light, linear. Sometimes complex script with functions and libs(yes, you can write your bash-library for use in other scripts).

每个 Linux 专业人员都会编写脚本。 有时是轻的、线性的。 有时带有函数和库的复杂脚本（是的，您可以编写 bash 库以在其他脚本中使用）。

But some of the scripts need a configuration file to work. For instance, I wrote a script that builds the ubuntu image for pxe, and I need to change the build process without build-script changes. The best way to resolve this task is to add configuration files.

但有些脚本需要配置文件才能工作。 例如，我编写了一个为 pxe 构建 ubuntu 映像的脚本，并且我需要在不更改构建脚本的情况下更改构建过程。 解决此任务的最佳方法是添加配置文件。

Writing this config by hands is not a great idea:

- every user should know all available options
- hight risk of incorrect data entry
- uncomfortable
- maybe something else

手动编写此配置并不是一个好主意：

- 每个用户都应该知道所有可用的选项
- 错误数据输入的高风险
- 不舒服
- 也许还有别的东西

Linux kernel gave us a great solution — KConfig. This system resolves all these troubles:

- New config generated automatically
- You can set the default value
- The previous version of config saved automatically
- text/graphical interface available

Linux 内核给了我们一个很好的解决方案——KConfig。 该系统解决了所有这些问题：

- 自动生成新配置
- 您可以设置默认值
- 自动保存以前版本的配置
- 提供文本/图形界面

These are not all the benefits. You can see more [here](https://www.kernel.org/doc/Documentation/kbuild/kconfig-language.txt).

这些还不是全部好处，您可以在[此处](https://www.kernel.org/doc/Documentation/kbuild/kconfig-language.txt)查看更多信息。

## How it works

Simplified schema:

- All configuration parameters described in KConfig-format file (including available ones)
- Interpreter (mconf, gconf, qconf, others) reads this file, current config (if it exists), and shows the menu
- The user selects needed options and selects the SAVE option
- KConfig moves old config to .config.old and creates new config (default name .config)

After that, you get a ready-made config that can be used in scripts(or for project build).

简化架构：

- KConfig 格式文件中描述的所有配置参数（包括可用的参数）
- 解释器（mconf、gconf、qconf 等）读取此文件、当前配置（如果存在）并显示菜单
- 用户选择所需的选项并选择“保存”选项
- KConfig 将旧配置移动到 .config.old 并创建新配置（默认名称 .config）

之后，您将获得一个现成的配置，可以在脚本中使用（或用于项目构建）。

## 示例项目

Now, I’ll show you the demo-project. I placed it on [github](https://github.com/skif-web/demo-kbuild).

现在，我将向您展示演示项目，相关代码我已经放在 [GitHub](https://github.com/skif-web/demo-kbuild) 上。

### 概览

It’s a simple script that shows the information about the last logins. Available options:

- Select destination (file or console)
- If the selected destination is a file, the user can set the filename
- Shows information about both all and only current users

Just clone this repo and go to its directory:

这是一个简单的脚本，显示有关上次登录的信息。 可用选项：

- 选择目的地（文件或控制台）
- 如果选择的目标是文件，用户可以设置文件名
- 显示所有用户和仅当前用户的信息

只需克隆此存储库并转到其目录：

```bash
boozlachu@debian:~$ git clone https://github.com/skif-web/demo-kbuild.git
Cloning into 'demo-kbuild'...
remote: Enumerating objects: 8, done.
remote: Counting objects: 100% (8/8), done.
remote: Compressing objects: 100% (6/6), done.
remote: Total 8 (delta 0), reused 5 (delta 0), pack-reused 0
Unpacking objects: 100% (8/8), done.
boozlachu@debian:~$ cd demo-kbuild/
boozlachu@debian:~/demo-kbuild
$ ls
getLast.sh  KConfig  README.md
```

### KConfig interpreter notes

KConfig is just a language. You have to use the interpreter to show the menu. In the Linux kernel, the interpreter is built when you run the “make menuconfig” command. But I’m a lazy potato and will use the kconfig-frontends package. It is available in Debian/Ubuntu, and you can also build it from the source. Or add an interpreter build from source to your project.

KConfig 只是一种语言。 您必须使用解释器来显示菜单。 在 Linux 内核中，解释器是在运行“make menuconfig”命令时构建的。 但我是个懒人，会使用 kconfig-frontends 包。 它在 Debian/Ubuntu 中可用，您也可以从源代码构建它。 或者从源代码添加一个解释器构建到您的项目中。

### KConfig 文件

The main file here is KConfig. KConfig supports a lot of operators, but I’ll use only some of them.

Various types of variables are available there. The most useful are:

- string to save string data
- bool to save the bool value (y or commented string in config)
- tristate (*/m/commented)

这里的主要文件是 KConfig，KConfig 支持很多运算符，但我将只使用其中的一些。

那里有各种类型的变量可用。最有用的是：

- string 保存字符串数据
- bool 保存 bool 值（y 或配置中的注释字符串）
- 三态（*/m/评论）

执行 `cat KConfig`，查看 KConfig 的内容：

```bash
choice SELECT_DESTINATION
    prompt "Select data destination"
    default DESTINATION_TTY

config SELECT_DESTINATION_TTY
    bool "show data in console"
config SELECT_DESTINATION_FILE
    bool "save data to file"
endchoice


config SELECT_DESTINATION_FILE_FILENAME
    string "destination file"
    depends on SELECT_DESTINATION_FILE
    default "last.log"
    help
      Write destination file with relative or full path

config SHOW_ONLY_CURRENT_USER
    bool "show data only for current user"
    default y
    help
      script will get data only for currewnt user
```

Let’s see it. Choice-endchoice pair allows creating SELECT of variants. Inside these keywords, I set definition (prompt), default value (default), and added available variants (SELECT_DESTINATION_TTY, SELECT_DESTINATION_FILE).

让我们来看看它。 选择-结束选择对允许创建变体的 SELECT。 在这些关键字中，我设置了定义（提示）、默认值（默认），并添加了可用变体（SELECT_DESTINATION_TTY、SELECT_DESTINATION_FILE）。

The next option (SELECT_DESTINATION_FILE_FILENAME) will only be shown if the destination is the file. The keyword “depends on” allows us to do this. Also, the available keyword “selects” that works in the opposite direction.

仅当目标是文件时才会显示下一个选项 (SELECT_DESTINATION_FILE_FILENAME)。 关键字“depends on”使我们能够做到这一点。 此外，可用的关键字“selects”的作用相反。

Option SHOW_ONLY_CURRENT_USER will always be shown.

选项 SHOW_ONLY_CURRENT_USER 将始终显示。

Run kconfig in text mode:

以文本模式运行 kconfig：

```bash
boozlachu@debian:~/demo-kbuild
$ kconfig-mconf KConfig
```

![img](https://miro.medium.com/v2/resize:fit:654/0*02Z4Zu9e9wRftbaB.png#center)

And with qt:

以 Qt 图形界面模式运行：

```
boozlachu@debian:~/demo-kbuild$ kconfig-qconf KConfig
```

![img](https://miro.medium.com/v2/resize:fit:700/0*plwyR_Vl0Xtuxa0-.png#center)

## Test run

After configuring it, we get .config file with options:

配置完成后，我们得到带有选项的 .config 文件：

```bash
boozlachu@debian:~/demo-kbuild$ cat .config
## Automatically generated file; DO NOT EDIT.
# Configuration
#
CONFIG_SELECT_DESTINATION_TTY=y
# CONFIG_SELECT_DESTINATION_FILE is not set
CONFIG_SHOW_ONLY_CURRENT_USER=y
```

As you can see, non-selected options are commented on. It’s useful for my script.

I run it with this config:

正如您所看到的，未选择的选项都带有注释。 这对我的脚本很有用。

我用这个配置运行它：

```bash
boozlachu@debian:~/demo-kbuild$ ./getLast.sh
boozlach pts/0        192.168.2.4      Sun Jul 19 06:00   still logged in
boozlach pts/0        192.168.2.4      Sun Jul 19 05:58 - 05:58  (00:00)
wtmp begins Thu Apr 16 05:48:31 2020
```

I changed the parameters via KConfig and got another result. Now the date was saved to a file, instead of being shown in the console:

我通过 KConfig 更改了参数并得到了另一个结果。 现在日期已保存到文件中，而不是显示在控制台中：

```bash
boozlachu@debian:~/demo-kbuild$ cat .config
## Automatically generated file; DO NOT EDIT.
# Configuration
#
# CONFIG_SELECT_DESTINATION_TTY is not set
CONFIG_SELECT_DESTINATION_FILE=y
CONFIG_SELECT_DESTINATION_FILE_FILENAME="last.log"
CONFIG_SHOW_ONLY_CURRENT_USER=y
boozlachu@debian:~/demo-kbuild
$ ./getLast.sh
boozlachu@debian:~/demo-kbuild
$ cat last.log
boozlach pts/0        192.168.2.4      Sun Jul 19 06:00   still logged in
boozlach pts/0        192.168.2.4      Sun Jul 19 05:58 - 05:58  (00:00)
```

## 小结

As you can see, KConfig is very powerful and friendly util for configuring. It can be used for scripts, package building, and other variants.

If you want to see an improved variant of KConfig using a makefile in the real project — write in comments.

正如您所看到的，KConfig 是一个非常强大且友好的配置工具。 它可用于脚本、包构建和其他变体。

如果您想在实际项目中使用 makefile 查看 KConfig 的改进变体 - 请写在注释中。



## 参考

- [Using kconfig for own projects](https://boozlachu.medium.com/using-kconfig-for-own-projects-deb21e0d1804)

