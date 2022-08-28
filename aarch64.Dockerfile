FROM arm64v8/alpine:latest

ENV TZ=Etc/UTC

COPY run.sh /home/qbittorrent/

RUN apk repo update && \
    apk add --no-cache ca-certificates tzdata curl unzip && \
    curl -L -o /tmp/qb-ee.zip https://github.com/c0re100/qBittorrent-Enhanced-Edition/releases/latest/download/qbittorrent-enhanced-nox_aarch64-linux-musl_static.zip && \
    unzip /tmp/qb-ee.zip -d /bin/ && \
    chmod +x /bin/qbittorrent-nox && \
    rm -rf /tmp/qb-ee.zip && \
    adduser -s -D /bin/sh qbittorrent && \
    mkdir -p /home/qbittorrent/downloads && \
    chmod +x /home/qbittorrent/run.sh && \
    chown -R qbittorrent:qbittorrent /home/qbittorrent

USER qbittorrent
ENTRYPOINT ["/home/qbittorrent/run.sh"]