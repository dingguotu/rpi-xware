FROM debian:wheezy-slim
MAINTAINER tinko <dingguotu@gmail.com>

RUN apt-get update
RUN cd /lib && ln -s ld-linux-armhf.so.3 ld-linux.so.3

WORKDIR /xware
ADD Xware1.0.31_armel_v5te_glibc.tar.gz /xware
ADD monitor.sh /xware

VOLUME /data

CMD ["./monitor.sh"]
