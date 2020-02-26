## 前言
其实一直很喜欢用 Clash For Windows(CFW)，界面简洁现代，修改配置文件也很方便。但是 CFW 内存占用实在太高了，clash 内核占用为 9.7 M左右，而 CFW 则要到 150 M 以上。而我基本上开着电脑就会挂着 clash，所以着实受不了长时间的这样高内存的损耗。

于是，我就写了一个批处理脚本，可以方便的控制 clash 的启动和关闭，下载配置文件，添加到开机启动等。

外行所写，大佬轻拍
![](https://raw.githubusercontent.com/pcysanji/Clash-Web-Bat/master/screenshot/screenshot1.png)

## 软件介绍
此版使用的内核是 clashr - 解锁网易云音乐版。还用到了 Razord 面板和 [subconverter](https://github.com/tindy2013/subconverter/)。
感谢大佬们的贡献。

## 使用说明
### 启动 clash
启动clash时，会同时打开 Razord 面板的本地版：http://127.0.0.1:9090/ui/#/
![](https://raw.githubusercontent.com/pcysanji/Clash-Web-Bat/master/screenshot/screenshot2.gif)

个人认为，在线版的稳定性未知，所以本地面板是必备的。我配置是默认 config.yaml 是添加了启动面板的参数的。参数如下：


```
external-controller: '127.0.0.1:9090'

external-ui: dashboard_Razord
```


如果你想使用本地面板的话，可以在配置文件中添加上面这两行。使用本地subconvert下载配置文件时，会自动添加上述参数。下载配置文件如下。

### 下载配置文件
如果机场有提供clash订阅可以直接输入订阅地址。如果只提供了ssr或v2ray的订阅，可以使用本地转换工具subconverter，使用方法如下：

1. 对 SSR/V2RAY 订阅地址进行 URL 编码[在线URL编码](https://tool.chinaz.com/tools/urlencode.aspx)
2. 修改订阅地址为 http://127.0.0.1:25500/sub?target=clashr&url=%URL编码后的订阅地址%

实例：假设订阅地址为 https://google.com/
URL 编码后为 https%3a%2f%2fgoogle.com%2f
配置文件地址为 http://127.0.0.1:25500/sub?target=clashr&url=https%3a%2f%2fgoogle.com%2f

旧的配置文件会保存为 config.yaml-bak

### 添加到开机启动
添加到开机启动是通过添加开机注册表的形式进行处理的。期间需要获取管理员权限，如果电脑装了除火绒外的其他国产杀软可能就会被误杀。

### 更新 GeoIP 数据库
自动下载更新 MaxMind 的 GeoIP lite 数据库
![](https://raw.githubusercontent.com/pcysanji/Clash-Web-Bat/master/screenshot/screenshot3.gif)

## 常见问题
Q：面板设置中的“开机时启动”和“设置为系统代理”无法使用。
A：这两项是因为网页没有动系统设置的权限，我已在批处理中添加设想功能。

## TO DO
- [x] 添加更新 GeoIP 的功能
- [x] 设置系统代理
- [ ] 支持更新和下载subconvert组件
- [ ] 支持ssr或v2的订阅地址直接转换，无需手动url编码再添加参数
- [ ] 支持自动更新订阅
- [x] 支持多订阅，多配置文件的切换


## 更新记录
2020-02-26
V1.3.1
BUG 修复
 - 启动 clash 找不到文件
 
功能增加
 - 下载配置时可自定义名称，不带后缀名。
 - selectprofile 是可以选配置文件名的。
 - 默认记录上次启动的配置文件。如果删了可以重新用 selectprofile 设置一下配置文件名
 
 本工具的cmd都不要改文件名，会出现调用出错，找不到文件。

V1.3
BUG 修复
1. 添加到开机自启的出错问题，以及添加自启失败；
2. 下载配置时无法成功备份旧配置，即config.yaml-bak无法被覆盖
3. 添加启动本地面板后的提示，加了弹窗提示。

功能添加
- 暂时添加一个新的批处理为“指定配置文件启动clash.cmd”，可指定配置文件启动，把配置文件放到Profile文件夹即可，启动时输入想要启动配置文件名称 如 1.yaml

2020-02-24
V1.2
1. 去掉了打开在线面板：http://clash.razord.top/#/ 。想用在线面板的时候自己用就是了。通过本地subconvert转换机场的订阅会自动添加面板的启动参数。
2. 添加了自动更新GeoIP数据库的功能。
3. 添加了启动clash后提示是否设置系统代理的功能。
4. 如果设置里系统代理，为保证退出clash后也能正常上网，请使用 [2]   关闭 clash 的选项关闭clash。

V1.1
本地subconvert订阅添加外部参数：external-ui: dashboard_Razord，这样使用本地转换工具的时候，就会自动启动面板了。

V1.0
就是想写了。完成了自己基本用得上的功能。

