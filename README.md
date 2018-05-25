# Raspberry PI适用的迅雷远程下载 xware-docker 镜像

标签（空格分隔）： RaspberryPI xware docker 迅雷 远程下载

---

迅雷为广大路由器爱好者，nas爱好者，服务器爱好者提供了一个很好的平台－－xware 远程下载。只需要很简单的就能部署到你的路由器、NUC之类的闲置机器上，然后只需要通过网站 http://yuancheng.xunlei.com/ 就能远程提交下载任务。无论你是在公司还是外出，当你回到家里时，疲惫的打开电视，发现你想看的影片已经下载到服务器中了，简直是高清爱好者的福音。其实已经有很多xware的docker镜像了，但是我发现对于**树莓派**支持并不是那么友好，基本上都不能正常使用，于是自己做了一个。

---

## 使用方法

首先，拉取我的xware for docker

```bash
docker pull tinko/rpi-xware
```

之后，启动它，需要指定一个 volume 挂在到 `/data` ，xware 所有下载的东西会保存到这个 volume 中。否则下载的东西会保存到容器中。**注意，`/mnt/Download/`请改成你期望的地址**

```bash
docker run --name xware -v /mnt/Download/:/data -d tinko/rpi-xware
```

之后执行

```bash
docker logs xware
```

会看到类似

```
initing...
try stopping xunlei service first...
killall: ETMDaemon: no process killed
killall: EmbedThunderManager: no process killed
killall: vod_httpserver: no process killed
setting xunlei runtime env...
port: 9000 is usable.

YOUR CONTROL PORT IS: 9000

starting xunlei service...
Connecting to 127.0.0.1:9000 (127.0.0.1:9000)
setting xunlei runtime env...
port: 9000 is usable.

YOUR CONTROL PORT IS: 9000

starting xunlei service...

getting xunlei service info...

THE ACTIVE CODE IS: vghqnv

go to http://yuancheng.xunlei.com, bind your device with the active code.
finished.
```
的内容，把 active code 复制一下，打开 http://yuancheng.xunlei.com 点击 `我的下载器` 旁边的 `添加` 把 active code 输入进去。

然后，就可以使用了。

最后，最好在你的 `/etc/rc.local` 中添加上开机启动：

```bash
docker start xware
```

这样，down机重启后也会自动打开xware。

---

## have fun
