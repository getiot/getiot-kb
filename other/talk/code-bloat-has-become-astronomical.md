---
sidebar_position: 5
---

# 代码膨胀已成为天文数字



版权声明：本文翻译自 [Code bloat has become astronomical](https://www.positech.co.uk/cliffsblog/2022/06/05/code-bloat-has-become-astronomical/)，作者 [Cliff Harris](https://www.positech.co.uk/cliffsblog/about/)，发布日期：2022-06-05

---



There is a service I use that occasionally means I have to upload some files somewhere (who it is does not matter, as frankly they are all the same). This is basically a simple case of pointing at a folder on my hard drive and copying the contents onto a remote server, where they probably do some database related stuff to assign that bunch of files a name, and verify who downloads it.

Its a big company, so they have big processes, and probably get hacked lot, so there is some security that is required, and also some verification that the files are not tampered with between me uploading and them receiving them. I get that.

…but basically we are talking about enumerating some files, reading them, uploading them, and then closing the connection with a log file saying if it worked, and if not what went wrong. This is not rocket science, and in fact I’ve written code like this from absolute scratch myself, using the wininet API and php on a server talking to a MySQL database. My stuff was probably not quite that robust compared to enterprise level stuff, but it did support hundreds of thousands of uploaded files (GSB challenge data), and verification and download and logging of them. It was one coder working maybe for 2 or 3 weeks?

The special upload tool I had to use today was a total of 230MB of client files, and involved 2,700 different files to manage this process.

You might think thats an embarrassing typo, so I’ll be clear. TWO THOUSAND SEVEN HUNDRED FILEs and 237MB of executables and supporting crap, to copy some files from a client to a server. This is beyond bloatware, this is beyond over-engineering, this is absolutely totally and utterly, provably, obviously, demonstrably ridiculous and insane.

The thing is… I suspect this uploader is no different to any other such software these days from any other large company. Oh and BTW it gives error messages and right now, it doesn’t work. sigh.

偶然的一次，我需要使用网盘服务，就是把文件上传到某个地方（具体是哪家服务就不说了，反正都一样）。这只一个非常简单的操作，首先将硬盘上某个文件夹里的文件复制到远程服务器，然后再执行一些数据库操作，给文件起个名字，然后提供给下载，仅此而已。

提供网盘服务的是一家大公司，规模很大，估计每天有不少黑客访问，所以他们需要一些安全措施，上传和下载的时候还得验证文件是否被篡改等等，这都没问题。

但是，最基本的功能只不过是列出文件、读取文件、上传文件，然后关闭连接，在日志里写上成功，或者出错的话在日志里写出错误原因。这又不是火箭科技，实际上我自己用wininet API写这段代码，服务器用PHP和MySQL，尽管达不到企业级，但也能支持几十万文件的上传、下载和日志记录——一个人写代码大概也就是两三周的工作量？

然而，我用的那个专用上传工具的客户端总共有230MB，包含2700多个文件。

是的，你没看错，2700多个文件，237MB的可执行文件和各种垃圾，仅仅是为了把文件拷贝到服务器而已。这已经不能叫膨胀了，更不是过度设计，这完完全全到了不可理喻的地步。

实际上，不光是这个上传工具，如今任何大型软件公司的任何软件都一样。



I’ve seen coders do this. I know how this happens. It happens because not only are the coders not doing low-level,. efficient code to achieve their goal, they have never even SEEN low level, efficient, well written code. How can we expect them to do anything better when they do not even understand that it is possible?

You can write a program that uploads files securely, rapidly, and safely to a server in less than a twentieth of that amount of code. It can be a SINGLE file, just a single little exe. It does not need hundred and hundreds of DLLS. Its not only possible, its easy, and its more reliable, and more efficient, and easier to debug, and…let me labor this point a bit… it will actually work.

Code bloat sounds like something that grumpy old programmers in their fifties (like me) make a big deal out of, because we are grumpy and old and also grumpy. I get that. But us being old and grumpy means complaining when code runs 50% slower than it should, or is 50% too big. This is way, way, way beyond that. We are at the point where I honestly do believe that 99.9% of the code in files on your PC is absolutely useless and is never even fucking executed. Its just there, in a suite of 65 DLLS, all because some coder wanted to do something trivial, like save out a bitmap and had *no idea how easy that is*, so they just imported an entire bucketful of bloatware crap to achieve it.

Like I say, I really should not be annoyed at young programmers doing this. Its what they learned. They have no idea what high performance or constraint-based development is. When you tell them the original game Elite had a sprawling galaxy, space combat in 3D, a career progression system, trading and thousands of planets to explore, and it was 64k, I guess they HEAR you, but they don’t REALLY understand the gap between that, and what we have now.

我知道怎么回事，我也见过其他程序员的实现方式。根本原因在于，程序员根本不懂怎样通过高效率的底层代码来实现目标，他们甚至从来没见过底层的高效代码。没见过的东西怎么可能做得出来，还要做得更好呢？

编写一个安全、快速上传文件到服务器的软件，最多需要二十分之一的代码量。只需要一个文件，一个exe文件就够了，根本不需要好几百个DLL。这是完全可能的，而且会更容易、更可靠、效率更高，还很容易调试，甚至能更稳定地工作。

代码膨胀似乎是像我这种老家伙的碎碎念，毕竟我已经上年纪了。但我们这帮老家伙们碎碎念的可不是代码运行减慢了50%、规模增大了50%。实际情况远不止于此。

我相信你电脑里99.9%以上的代码都是毫无用处的垃圾，永远不会被运行。但这些代码都堆在那儿，堆在65个DLL文件里，这都是因为程序员想做一些不太重要的事情，比如保存一张图片，但他们完全不懂得该怎么做，就干脆导入一大堆垃圾来实现。

我说过，看着年轻程序员这样做我真不应该生气，毕竟他们学到的实现方式就是这样的。他们根本不知道高性能开发是什么样子，也没见过条件有限的软件是什么样子。你要是告诉他们，最初的Elite游戏能生成整个银河系，有3D狗斗，有职业系统，交易系统，还能探索上千个星球，而这一切只有64KB，他们也能接受，但完全没办法理解这与现在的软件之间有什么差距。



## Why do I care?

I care for a ton of reasons, not least being the fact that if you need two thousand times as much code as usual to achieve a thing, it should work. But more importantly, I am aware of the fact that 99.9% of my processor time on this huge stonking PC is utterly useless. Its carrying out billions of operations per second just to sit still. My PC should be in super-ultra low power mode right now, with all the fans off, in utter silence because all thats happening is some spellchecking as I type in wordpress.

为什么我关心这件事？原因有很多，最简单的就是当你花费两千倍的时间来做一个东西，它就应该能用。但更重要的是，我知道99.9%的CPU时间都浪费在这些垃圾上。每秒执行几十万指令，结果毫无用处。本来我的电脑应该处于极低功耗，风扇都不应该转，因为我现在干的只不过是在wordpress里写字而已。



## Ha. WordPress.

Computers are so fast these days that you should be able to consider them absolute magic. Everything that you could possibly imagine should happen between the 60ths of a second of the refresh rate. And yet, when I click the volume icon on my microsoft surface laptop (pretty new), there is a VISIBLE DELAY as the machine gradually builds up a new user interface element, and eventually works out what icons to draw and has them pop-in and they go live. It takes ACTUAL TIME. I suspect a half second, which in CPU time, is like a billion fucking years.

If I’m right and (conservatively), we have 99% wastage on our PCS, we are wasting 99% of the computer energy consumption too. This is beyond criminal. And to do what? I have no idea, but a quick look at task manager on my PC shows a metric fuckton of bloated crap doing god knows what. All I’m doing is typing this blog post. Windows has 102 background processes running. My nvidia graphics card currently has 6 of them, and some of those have sub tasks. To do what? I’m not running a game right now, I’m using about the same feature set from a video card driver as I would have done TWENTY years ago, but 6 processes are required.

Microsoft edge web view has 6 processes too, as does Microsoft edge too. I don’t even use Microsoft edge. I think I opened an SVG file in it yesterday, and here we are, another 12 useless pieces of code wasting memory, and probably polling the cpu as well.

This is utter, utter madness. Its why nothing seems to work, why everything is slow, why you need a new phone every year, and a new TV to load those bloated streaming apps, that also must be running code this bad.

I honestly think its only going to get worse, because the big dumb, useless tech companies like facebook, twitter, reddit, etc are the worst possible examples of this trend. Soon every one of the inexplicable thousands of ‘programmers’ employed at these places will just be using machine-learning to copy-paste bloated, buggy, sprawling crap from github into their code as they type. A simple attempt to add two numbers together will eventually involve 32 DLLS, 16 windows services and a billion lines of code.

Twitter has two thousand developers. Tweetdeck randomly just fails to load a user column. Its done it for four years now. I bet none of the coders have any idea why it happens, and the code behind it is just a pile of bloated, copy-pasted bullshit.

Reddit, when suggesting a topic title from a link, cannot cope with an ampersand or a semi colon or a pound symbol. Its 2022. They probably have 2,000 developers too. None of them can make a text parser work, clearly. Why are all these people getting paid?

There was a golden age of programming, back when you had actual limitations on memory and CPU. Now we just live in an ultra-wasteful pit of inefficiency. Its just sad.

现在的电脑速度飞快，确实是魔法。你能想到的一切，都能在屏幕刷新一次的1/60秒内完成。但是！当我在Surface笔记本（几乎是新的！）上点击硬盘图标时，我能看到明显的延迟，电脑在一点点画出用户界面。这需要很久，我估计至少有半秒钟，对于CPU来说这就像几十亿年那么长。

如果我没猜错，因为电脑里有99%的垃圾，99%的电力都被浪费了，这已经不能用犯罪来形容了。这些浪费的电力都干什么了？我不知道，但看看任务管理器就知道了：一大堆不知道是什么也不知道在干什么的东西。

我现在只不过写篇文章，Windows就要运行102个后台进程。NVidia显卡有6个进程，一些甚至还有子进程。干啥呢？我又没玩游戏，对于显卡来说我现在干的事儿跟20年前没什么区别，但就是要6个进程。

微软的Edge浏览器也有6个进程，它的Web View还有6个。我甚至都没打开Edge。可能是我昨天开了一张SVG图，这就出现了12个毫无用处的进程在那儿浪费内存和CPU？这简直不可理喻。

这就是为什么一切都不能正常工作，为什么一切都很慢，为什么你每年都要买新手机和新电视，买新的只不过是为了运行更多垃圾程序而已。

我悲观地认为，事情只会越来越糟，因为像Facebook、Twitter、Reddit这些笨头笨脑的巨无霸公司正是现在的趋势。每个公司都有好几千位“程序员”，使用机器学习从GitHub复制粘贴这些毫无用处的垃圾代码。两个数相加就要使用32个DLL和16个Windows服务还有几亿行代码。

Twitter有两千个程序员。但Tweetdeck偶尔还是无法加载某个用户的时间线。这个bug已经有四年多了，我估计没人知道为什么，背后的代码只不过是一堆复制粘贴的垃圾。

再说Reddit，从链接读取标题的功能无法正确处理&和分号，这都2022年了。估计他们也有2000多个程序员，但甚至没人会写文本分析器，所以他们拿钱是干什么的？

曾经CPU和内存都有限的那个时代，才是编程的黄金时代；而现在，我们生活在一堆毫无效率的垃圾里。呜呼哀哉！



## 参考

- [如今，99.9% 以上的代码都是垃圾！](https://blog.csdn.net/csdnnews/article/details/125884038)
