FROM alpine:3.7
MAINTAINER tinko <dingguotu@gmail.com>

RUN cd /lib && ln -s ld-linux-armhf.so.3 ld-linux.so.3

RUN apk add --no-cache --purge -uU curl bash && \
    mkdir -p /glibc && \
    GLIBC_URL='http://github.com/chrisanthropic/docker-alpine-rpi-glibc-builder/releases/download/0.0.1' && \
    GLIBC_VERSION='2.23-r3' && \
	curl \
		-jkSLN ${GLIBC_URL}/glibc-${GLIBC_VERSION}.apk \
		-o /glibc/glibc-${GLIBC_VERSION}.apk && \
	curl \
		-jsSLN ${GLIBC_URL}/glibc-bin-${GLIBC_VERSION}.apk \
		-o /glibc/glibc-bin-${GLIBC_VERSION}.apk && \
	curl \
		-jkSLN ${GLIBC_URL}/glibc-i18n-${GLIBC_VERSION}.apk \
		-o /glibc/glibc-i18n-${GLIBC_VERSION}.apk && \
	apk add --allow-untrusted --no-cache /glibc/*.apk; \
	/usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 C.UTF-8 || true && \
	echo "export LANG=C.UTF-8" > /etc/profile.d/locale.sh && \
	/usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib && \
	echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf && \
	apk del --purge curl glibc-i18n && \
	rm -rf /var/cache/apk/* /tmp/* /glibc


WORKDIR /xware
ADD Xware1.0.31_armel_v5te_glibc.tar.gz /xware
ADD monitor.sh /xware

VOLUME /data

CMD ["./monitor.sh"]
