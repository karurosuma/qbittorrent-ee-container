FROM arm64v8/alpine:latest

ENV TZ=Etc/UTC

RUN apk repo update && \
    apk add --no-cache ca-certificates tzdata curl unzip && \
    curl -L -o /tmp/qb-ee.zip https://github.com/c0re100/qBittorrent-Enhanced-Edition/releases/latest/download/qbittorrent-enhanced-nox_aarch64-linux-musl_static.zip && \
    chmod +x qbittorrent-nox && \
    mv qbittorrent-nox /bin/qbittorrent-nox && \
    rm -rf /tmp/qb-ee.zip && \
    mkdir -p /opt/qbittorrent/downloads -p /opt/qbittorrent/config -p /opt/qbittorrent/incomplete && \
    chmod -R 777 /opt/qbittorrent && \
    ln -s ~/.config/qBittorrent /opt/qbittorrent/config

ENTRYPOINT ["/opt/qbittorrent/run.sh"]