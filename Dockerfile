FROM alpine:3.18.0
LABEL authors "netdoge <root@netdoge.com>"

ENV VERSION="20230206.0"

RUN set -xe && \
    apk add --no-cache iptables ip6tables curl && \
    curl -fsSLO --compressed "https://github.com/wangyu-/udp2raw/releases/download/20230206.0/udp2raw_binaries.tar.gz" && \
    tar -zxvf udp2raw_binaries.tar.gz && \
    mv udp2raw_amd64_hw_aes usr/udp2raw && \
    rm udp2raw_* && \
    mv /usr/udp2raw / &&\
    apk del curl 

COPY config.conf /config.conf 
EXPOSE 3000

CMD ./udp2raw --conf-file config.conf
