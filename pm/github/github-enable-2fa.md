---
sidebar_position: 9
---

# GitHub 配置 2FA（双重身份验证）



## 为什么要开启 2FA

自2023年3月13日起，我们登录 GitHub 都会看到一个要求 Enable 2FA 的重要提示，具体如下：

:::warning

GitHub users are [now required](https://github.blog/2023-03-09-raising-the-bar-for-software-security-github-2fa-begins-march-13/) to enable two-factor authentication as an additional security measure. Your activity on GitHub includes you in this requirement. You will need to enable two-factor authentication on your account before May 04, 2023, or be restricted from account actions.

:::

![](https://static.getiot.tech/github-enable-2fa-01.png#center)

大意是，GitHub 用户现在需要启用 2FA 双因素身份验证作为附加的安全措施，您需要在2023年5月4日之前在您的帐户上启用双因素身份验证，否则将被限制进行帐户操作。

GitHub 表示将渐进式推进 2FA 要求，首先从开发人员和管理员开始。这些用户会收到电子邮件提醒，会在网页版 GitHub 上看到横幅提示。开发人员有 45 天的时间来设置 2FA，之后会有一周的缓冲期，如果开发人员还不设置 2FA 将会限制账户访问。

那为什么要启用 2FA 呢？GitHub 官方给出的解释是，GitHub 是软件供应链的核心，确保软件供应链的安全要从保护开发人员开始。因此我们正在推进 2FA 计划，通过提高账户安全性来保护软件开发。开发人员的账户是社会工程和账户接管（ATO）的常见目标。保护开源生态系统的开发人员和消费者免受此类攻击是确保供应链安全的第一步，也是最关键的一步。



## 2FA 是什么

2FA 的英文全名是 Two-factor authentication，即双因子认证，或称为双重身份验证，是一种最常用多因子认证（MFA）方式。顾名思义，2FA 是一种身份验证方法，它要求用户提供密码和另一个认证因子或者至少提供两个认证因子（代替密码），才能访问网站、应用程序或网络。例如，网上银行应用程序要求用户输入密码和通过短信发送到手机上的验证码时，就使用了 2FA。

由于破解第二个认证因子需要付出更多，并且其他类型的因子更难以窃取或伪造，因此 2FA 可提高帐户安全性，并更好地保护组织及其用户免遭未经授权的访问。



## 2FA 配置步骤

首先，登录 GitHub，点击右上方头像，在下拉列表中选择 Settings 进入设置页面。在该页面左侧点击 Password and authentication 选项卡，可以看到一个 Two-factor authentication 设置项，点击“Enable two-factor authentication”按钮进入 2FA 配置页面。

目前 GitHub 支持 Set up using an app 和 Set up using SMS 两种认证方式，由于中国大陆的手机号码无法接收短信，因此我们选择第一种方式，即使用 app 进行认证。此时可以看到如下页面：

![](https://static.getiot.tech/github-enable-2fa-02.png#center)

官方推荐的密码管理 app 包括 [1Password](https://support.1password.com/one-time-passwords/)、[Authy](https://authy.com/guides/github/)、[Microsoft Authenticator](https://www.microsoft.com/en-us/account/authenticator/) 等，国内可以使用“神锁离线版”等 app，当然你也可以使用浏览器插件来完成。

以 app 为例，打开任意一款支持 2FA 的 app，扫描页面上的二维码即可生成一个 2FA 码。如果您使用的 app 或浏览器插件不能使用摄像头扫描，可以点击 enter this secret 获取一串字符，并将这串字符输入到 app 或浏览器插件，这样也能生成 2FA 码。

验证成功后，点击 Continue 按钮进入下一步，在这里你需要保存你的 recovery codes，点击 Download 下载 github-recovery-codes.txt 文件。

最后，点击“I have saved my recovery codes”按钮，一切顺利将出现如下页面，说明 2FA 已经配置成功。下次登录 GitHub 的时候，就会要求您进行 2FA 验证才能登录成功。

![](https://static.getiot.tech/github-enable-2fa-04.png#center)



