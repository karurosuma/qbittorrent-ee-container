FROM arm64v8/alpine:latest

ENV TZ=Etc/UTC
ENV WEBUI_PORT=8080
ENV INCOMING_PORT=36847

COPY run.sh /home/qbittorrent/

RUN apk repo update && \
    apk add --no-cache ca-certificates tzdata curl openssl unzip && \
    curl -L -o /tmp/qb-ee.zip https://github.com/c0re100/qBittorrent-Enhanced-Edition/releases/latest/download/qbittorrent-enhanced-nox_aarch64-linux-musl_static.zip && \
    unzip /tmp/qb-ee.zip -d /bin/ && \
    chmod +x /bin/qbittorrent-nox && \
    adduser -D -s /bin/sh qbittorrent && \
    mkdir -p /home/qbittorrent/downloads -p /home/qbittorrent/.config && \
    chmod +x /home/qbittorrent/run.sh && \
    chown -R qbittorrent:qbittorrent /home/qbittorrent && \
    rm -rf /tmp/qb-ee.zip

USER qbittorrent
ENTRYPOINT ["/home/qbittorrent/run.sh"]