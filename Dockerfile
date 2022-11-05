FROM alpine:latest

ENV TZ=Etc/UTC
ENV WEBUI_PORT=8080
ENV WEBUI_LANG=en
ENV SESSION_PORT=36847
ARG OS_USER_ID=1000


RUN apk repo update && \
    apk add --no-cache ca-certificates tzdata curl openssl unzip && \
    curl -L -o /tmp/qb-ee.zip https://github.com/c0re100/qBittorrent-Enhanced-Edition/releases/latest/download/qbittorrent-enhanced-nox_aarch64-linux-musl_static.zip && \
    unzip /tmp/qb-ee.zip -d /bin/ && \
    chmod +x /bin/qbittorrent-nox && \
    adduser -D -s /bin/sh -u ${OS_USER_ID} qbittorrent && \
    mkdir -p /downloads -p /config -p /home/qbittorrent/.config && \
    ln -s -p /home/qbittorrent/.config /config && \
    chown -R qbittorrent:qbittorrent /home/qbittorrent && \
    rm -rf /tmp/qb-ee.zip

USER qbittorrent
COPY entrypoint.sh /
ENTRYPOINT ["sh /entrypoint.sh"]
