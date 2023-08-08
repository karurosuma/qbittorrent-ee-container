FROM alpine:latest AS base

ENV TZ=Etc/UTC
ENV WEBUI_PORT=8080
ENV WEBUI_LANG=en
ENV SESSION_PORT=36847

COPY entrypoint.sh /
RUN apk repo update && \
    apk add --no-cache ca-certificates tzdata curl openssl unzip && \
    mkdir -p /downloads -p /incomplete -p /root/.config/qBittorrent -p /root/.local/share/qBittorrent && \
    ln -s /root/.config/qBittorrent /config && \
    ln -s /root/.local/share/qBittorrent /data && \
    chmod +x /entrypoint.sh &&

VOLUME [ "/config", "/downloads", "/incomplete", "/data" ]

FROM base AS final
RUN if [[ "$(uname -m)" == "x86_64" ]]; then \
    qUrl=https://github.com/c0re100/qBittorrent-Enhanced-Edition/releases/latest/download/qbittorrent-enhanced-nox_x86_64-linux-musl_static.zip; \
    else \
    qUrl=https://github.com/c0re100/qBittorrent-Enhanced-Edition/releases/latest/download/qbittorrent-enhanced-nox_aarch64-linux-musl_static.zip; \
    fi && \
    curl -L -o /tmp/qb-ee.zip ${qUrl} && \
    unzip /tmp/qb-ee.zip -d /bin/ && \
    chmod +x /bin/qbittorrent-nox && \
    rm -rf /tmp/qb-ee.zip

ENTRYPOINT ["/entrypoint.sh"]