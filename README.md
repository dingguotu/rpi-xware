# Raspberry PI适用的迅雷远程下载 xware-docker 镜像

标签（空格分隔）： RaspberryPI xware docker 迅雷 远程下载

---

目前，已经有很多xware的docker镜像了，但是我发现对于树莓派支持并不是那么友好，由于CPU编码的问题，基本上都不能使用，于是自己做了一个。专为树莓派定制的迅雷xware镜像，基于alpine系统，整个镜像只有19M不到

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

```bash
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

的内容，把 active code 复制一下，打开 [迅雷远程下载](http://yuancheng.xunlei.com/) 点击 `我的下载器` 旁边的 `添加` 把 active code 输入进去。

然后，就可以使用了。

最后，最好在你的 `/etc/rc.local` 中添加上开机启动：

```bash
docker start xware
```

这样，down机重启后也会自动打开xware。

---

## have fun
