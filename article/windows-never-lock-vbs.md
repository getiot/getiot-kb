---
sidebar_position: 25
slug: /windows-never-lock-vbs
---

# Windows 防止锁屏脚本



## 背景介绍

有些公司出于安全和保密工作考虑，会通过 Windows 组策略强制所有办公电脑在无操作的情况下 5 分钟或者 10 分钟自动锁屏，避免无关人士看到不该看的内容。作为程序员，十分反感这种一刀切的方案，一来很容易打断思路，比如正在写代码或者向别人展示时，突然锁屏了就挺恶心的；二来每次锁屏后都要输入密码，这简直就是浪费生命，不能忍！

为了解决这个问题，我们可以编写一个简单的 vbs 脚本，在锁屏周期内模拟按键操作，从而避免 Windows 桌面被锁屏。之所以使用 vbs 脚本，而不是 Python、JavaScript 等更流行的高级语言，主要是因为这个程序的需求特别简单，而且 vbs 脚本可以在 Windows 系统中直接运行，不需要安装任何依赖。

## 脚本程序

下面给出两个脚本，你可以将它们命名为 never_lock.vbs 文件（先在 Windows 系统新建一个 txt 文本文件，粘贴代码，然后修改文件名）。

【复杂版本】

```vb showLineNumbers
Set ws=Wscript.CreateObject("Wscript.Shell")
If ws.expandenvironmentstrings("%strikkeyflag%")=("on")Then
    wscript.echo("Screen Never Lockout")
    ws.Environment("user").Item("strikkeyflag")="off"
    set mi=getobject("winmgmts:win32_process").instances_
    for each p in mi
        if ucase(p.name)=ucase("wscript.exe")then
            p.terminate
        End If
    Next
    wscript.quit
Else
    wscript.echo("Screen Never Lockout")
    ws.Environment("user").Item("strikkeyflag")="on"
    do
        set WshShell = CreateObject("WScript.Shell")
        WshShell.SendKeys"{ScrollLock}"
        wscript.sleep(280000) 'ms
    Loop
end if
```

【简单版本】

```vb showLineNumbers
'先定义一个Shell对象
Set WshShell = WScript.CreateObject("WScript.Shell")

'设置成正需要接续的时间
do
'设置成比屏保时间短点就可以
    WScript.Sleep 60000 '1min 60000ms
    WshShell.SendKeys "{ScrollLock}"
loop
```

在 Windows 系统中双击 never_lock.vbs 脚本，即可运行。

如需停止脚本，可以按 Ctrl + Shift + Esc 键打开任务管理器，找到 Microsoft ® Windows Based Script Host，结束任务即可。

## 工作原理

你应该已经猜到，never_lock.vbs 脚本的工作原理就是通过定时按一次 Scroll Lock 键，让系统认为一直有人为操作，只要定时时间在锁屏周期以内，就可以达到避免锁屏的效果。

Scroll Lock 即“滚动锁定键”，是一个现存于大部分键盘上的按键，通常附有一个指示按键开关情况的灯号。这个按键曾经用来锁定所有软件的滚动功能，但已不为现今大部分软件所使用。因为这个按键已经不常用，所以部分键盘（例如笔记本）已经移除了这个键。不过系统还是保留了 Scroll Lock 按键的定义，因此我们可以借助这个没什么用的按键完成防止锁屏的功能，不会对系统造成任何影响。

