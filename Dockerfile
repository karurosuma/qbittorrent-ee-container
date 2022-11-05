FROM alpine:latest

ENV TZ=Etc/UTC
ENV WEBUI_PORT=8080
ENV WEBUI_LANG=en
ENV SESSION_PORT=36847
ARG OS_USER_ID=1000

COPY entrypoint.sh /
RUN apk repo update && \
    apk add --no-cache ca-certificates tzdata curl openssl unzip && \
    curl -L -o /tmp/qb-ee.zip https://github.com/c0re100/qBittorrent-Enhanced-Edition/releases/latest/download/qbittorrent-enhanced-nox_aarch64-linux-musl_static.zip && \
    unzip /tmp/qb-ee.zip -d /bin/ && \
    chmod +x /bin/qbittorrent-nox && \
    adduser -D -s /bin/sh -u ${OS_USER_ID} qbittorrent && \
    mkdir -p /downloads -p /incomplete -p /home/qbittorrent/.config/qBittorrent -p /home/qbittorrent/.local/share/qBittorrent && \
    ln -s /home/qbittorrent/.config/qBittorrent /config && \
    ln -s /home/qbittorrent/.local/share/qBittorrent /data && \
    chmod +x /entrypoint.sh && \
    chown -R qbittorrent:qbittorrent /home/qbittorrent /config /downloads /incomplete /data && \
    rm -rf /tmp/qb-ee.zip

VOLUME [ "/config", "/downloads", "/incomplete", "/data" ]

USER qbittorrent
ENTRYPOINT ["/entrypoint.sh"]
