FROM alpine:latest AS base

ENV TZ=Etc/UTC
ENV WEBUI_PORT=8080
ENV WEBUI_LANG=en
ENV SESSION_PORT=36847
ARG OS_USER_ID=1000

COPY entrypoint.sh /
RUN apk repo update && \
    apk add --no-cache ca-certificates tzdata curl openssl unzip && \
    adduser -D -s /bin/sh -u ${OS_USER_ID} qbittorrent && \
    mkdir -p /downloads -p /incomplete -p /home/qbittorrent/.config/qBittorrent -p /home/qbittorrent/.local/share/qBittorrent && \
    ln -s /home/qbittorrent/.config/qBittorrent /config && \
    ln -s /home/qbittorrent/.local/share/qBittorrent /data && \
    chmod +x /entrypoint.sh && \
    chown -R qbittorrent:qbittorrent /home/qbittorrent /config /downloads /incomplete /data

VOLUME [ "/config", "/downloads", "/incomplete", "/data" ]

FROM base AS final
RUN if [[ "${PLATFORM}" == "x86_64" ]]; then \
    qUrl=https://github.com/c0re100/qBittorrent-Enhanced-Edition/releases/latest/download/qbittorrent-enhanced-nox_x86_64-linux-musl_static.zip; \
    else \
    qUrl=https://github.com/c0re100/qBittorrent-Enhanced-Edition/releases/latest/download/qbittorrent-enhanced-nox_arm-linux-musl_static.zip; \
    fi && \
    curl -L -o /tmp/qb-ee.zip ${qUrl} && \
    unzip /tmp/qb-ee.zip -d /bin/ && \
    chmod +x /bin/qbittorrent-nox && \
    rm -rf /tmp/qb-ee.zip

USER qbittorrent
ENTRYPOINT ["/entrypoint.sh"]