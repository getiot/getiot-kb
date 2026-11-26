---
sidebar_position: 5
---

# 智能家居的安全隐患

One Friday in October 2016, a big chunk of the Internet went missing.

2016年10月的某个周五，一个大型的互联网段消失了。

The internet company Dyn, which routes traffic to Twitter, Netflix, and thousands of other sites, had been paralyzed by bogus requests from hundreds of thousands of computers, all infected with a malicious software called Mirai. But these weren't any old computers. Many were webcams, smart light bulbs, fitness trackers, and other everyday devices that connect to the internet. Collectively, they're known as the Internet of Things, or IoT.

为推特、网飞和数千个其他网站提供路线流量的英特网公司 Dyn 瘫痪，该公司收到来自数十万台电脑的虚假请求，这些电脑都感染上了一款恶意软件 Mirai。但是其中没有一台老式旧电脑。许多都是和互联网相连接的网络摄像头、智能电灯泡以及其他日常设备。总的来说，它们都被称为物联网或者 IoT。

As these gadgets gain new abilities, like how a wi-fi enabled doorbell might be able to unlock your front door, they also offer fresh opportunities to cybercriminals. So just how worried should you be about that smart toaster? And what can we do to make our stuff safer?

随着这些小物件配置了新的功能，比如wi-fi能够赋予门铃开锁的功能，但它们也为网络罪犯提供了新的机遇。所以对于这个智能面包机该多担心呢？还有我们要做些什么才能确保物品更加安全呢？

Internet of Things gadgets are vulnerable to the same takeovers as regular computers. But their access to the physical world can make the consequences much bigger. For instance, if your livestreaming dog monitor is hacked, your private data can be exposed — things like pictures of your family or the layout of your house. Or someone could make your kid's wi-fi enabled talking teddy bear say anything. That's pretty creepy, but it gets even scarier when you replace the teddy bear with a home security system, a car, or a pacemaker.

物联网小物件和普通的计算机一样易受同种接管的伤害。但是它们与实体世界的接触会使得后果更加严重。例如，如果你的实时流媒体电子监控被入侵，你的私人数据就会被暴露——例如家里的状况或房子布局之类的。或者别人能够连接你孩子的无线网控制会说话的泰迪熊。那样相当诡异，但是当你把泰迪熊换成一台家庭安全设备、一辆车或一个起搏器时，就更加可怕了。

The damage isn't limited to the thing that's been hacked, either. A lot of these devices, and sometimes even your laptop, assume that they can trust other machines connected to your home wi-fi network. So if your smart water bottle is compromised, the hacker might be able to send commands to the smart lock on your door, too.

其中危害并不仅限于被入侵的物件。很多这些设备，有时甚至是你的电脑，假设它们可以信任其他连接家庭无线网的机器的话。所以如果你的智能水壶被盗用，黑客还能够向你家门上的智能锁发送指令。

Now, there are also serious risks beyond individual owners. The most common thing that hackers do with their machine victims is weaponize them into botnets—armies of enslaved drones. Then, criminals can hide their nefarious activities behind the normal internet traffic of thousands of machines.

如今，严重风险不止是那些个人业主。黑客们对受害机器所做的最普遍的一件事是，使这些机器武器化并将它们变成僵尸网络—被奴役的蜂群军队。然后，不法分子会将他们的不法行为隐藏于数千个机器的正常网络流量中。

For example, in 2014, a massive botnet that included TVs, routers, and at least one smart refrigerator, was caught sending millions of spam emails. And if a botnet like Mirai suddenly floods a company like Dyn with traffic, it can take down web services in a distributed denial-of-service attack. It's like if your telephone was forced into a pool of a thousand auto-dialers constantly calling a pharmacy: real calls can't get through, and there are so many involuntary fake calls that the company can't block them all.

例如，2014年，发现包括电视、路由器以及至少一台智能冰箱在内的大量僵尸网络发送了百万封垃圾邮件。如果一只类似 Mirai 的僵尸网络突然涌入像 Dyn 这样的流量公司，那么在这种分布式的拒绝服务袭击中，网络服务将崩溃。就像是，如果你的电话被迫进入千个自动拨号连接池中并不断给一家药房拨打电话：真实来电无法进入，由于无意识虚假来电太多，公司无法阻拦所有来电。

Now, these issues aren't unique to the Internet of Things. But IoT devices are extra vulnerable. Manufacturers bring them to market as quickly and cheaply as possible. All too often, the place they cut corners—you guessed it—security.

如今，这些问题并不是物联网中所特有的。但是物联网设备特别易受攻击。制造商们尽可能快的将这些便宜的产品带入市场。有时，他们会尽可能走快捷方式——你猜对了——安全问题。

Many companies grab off-the-shelf software and don't customize it for each device. For instance, smart light bulbs don't need printing software, but manufacturers might not bother to delete it from the stock operating system. So if the chunk of code that accepts files for printing mistakenly allows a hacker to inject their own program, you're in trouble. And these things rarely update automatically; nobody wants to flip the light switch and hear, "Please wait until your lights finish updating." So even if a security bug is fixed, those app-controlled bulbs may never hear about it.

许多公司都是利用现成的软件，他们并没有为每个设备量身定制。例如，智能电灯泡并不需要安装打印功能，但是制造商们或许不会将它们从存储操作系统中删除。所以如果接受打印文件的代码段错误地允许一名黑客导入自己的程序的话，可就麻烦了。这些物件很少自动更新；没人想要开关灯时候听到，“请稍等，灯具正在更新”。所以即使修复了安全漏洞，也轮不到那些应用软件控制的灯具。

Plus, any operating system is only as secure as the password you need to log in and make changes. And manufacturers of IoT devices often set passwords to dumb, predictable defaults like "admin1234" and who wants to change the password on their smart egg tray, anyways? To make matters worse, the hardware might have too little memory and processing power to run standard defenses like firewalls, which try to block unwelcome intrusions from the internet. And how would you even know that your smart weight-loss fork is infected with a virus when its only way of communicating is buzzing?

再加上，任何操作系统，只要你更换登录密码就是安全的。物联网设备的制造商常常将密码设置成很简单默认密码，比如“admin234”，谁又会想到要去更改智能蛋盒的密码呢？更糟糕的是，硬盘储存容量太少，运行像防火墙这类的标准防护的处理能力又很弱，难以阻挡网络不良侵入。如果嗡嗡声是机器交流的唯一方式，我们又怎么知道自己的智能减肥餐具是否感染了病毒呢？

Finally, the sheer scale of the Internet of Things intensifies the problem. Mirai grew way bigger than most botnets simply because there were so many vulnerable IoT devices. So…this can all sound pretty terrifying.

最终，物联网的庞大的规模使这个问题更加严重。Mirai 的扩张比多数僵尸网络更大，因为易受感染的物联网设备太多了。因此...这一切听起来相当可怕。

But the truth is that for now, the main threat to an average user is garden-variety data theft. Most of the fancier attacks are too difficult and their payoffs are too low for crooks to bother. After all, if your enemies are so committed that they'll track down your glucose monitor and hack it. You probably have other things to worry about beyond IoT security. But it may not be long before a hacker can lock your smart thermostat at its max while you're on vacation, running up your energy bill until you pay a ransom.

但是事实是，现在普通用户的主要威胁是普通的数据盗窃。多数空想家想要攻击都太难了，他们支付给那些骗子去骚扰别人的报酬太少了。毕竟，如果你的敌人决心要去追踪并入侵你的血糖仪，那么除了物联网安全外，你或许还有一些其他需要担心的。但是当你度假时，要不了多久，黑客就能够将你的智能恒温器锁定在最大值，不断累积你的能源账单，直到你向他们支付赎金。

If manufacturers don't start baking security into the design of their products, experts worry that we're heading for a trainwreck. They suggest a couple of solutions, including being selective with what data to record, and encrypting whatever data is sent around. They also recommend that manufacturers set a unique default password for each device and only accept commands from someone who's logged in. Automatically monitoring for suspicious activity would help, too. 

如果制造商还不开始考虑产品设计的安全问题，专家们担心事情可能会无法收场。他们给出了一些解决方法，包括有选择地记录数据并给发送数据进行加密。他们还建议制造商为每台设备设定特殊预设密码，并且只接受登录用户的指令。自动监控可疑活动也能帮得上忙。

There are also a few steps you can take to protect yourself from your devices: You can manually check the manufacturer's website for updates and change any passwords that the software allows you to. Don't put webcams anywhere you wouldn't broadcast. Isolate smart devices on separate wi-fi networks from your computers and phones. You can do that with a second router, or on some routers you can just set up a second untrusted "guest network." And, y'know, consider whether you really need that hairbrush to connect to the internet. Ultimately, though, it's going to take pressure from all of us.

你还可以采取一些措施保护自己不受设备干扰：你可以手动检查制造商网站上的更新并在软件允许时更换任何设备密码。不要将网路摄像机放在进行直播的地方。为智能设备以及电脑手机设立单独的无线网密码。你可以用两个路由器，或者有些路由器可以设置第二个不信任“访客网络”。还有，考虑一下自己是否真的需要让发刷连接互联网。最终，它将给我们所有人带来压力。

Manufacturers need to hear that we don't just want cool features, but guarantees that they'll keep us safe.

制造商们需要知道，我们并不仅仅需要炫酷的功能特征，还需要保证我们的安全。



---

Thanks for watching this episode of SciShow, which is produced by Complexly, a group of people who believe the more we understand about the world we live in, the better we get at being humans.

感谢收看本期科学秀，本期科学秀由 Complexly 制作，Complexly 认为我们对居住的世界了解的越多，我们就越能更好的了解人类。

If you want to learn more about this stuff, check out the Crash Course computer science series at youtube.com/crashcourse.

如果你想了解更多，请登录 youtube.com/crashcourse 观看电脑科学系列。