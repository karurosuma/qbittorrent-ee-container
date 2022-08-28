#!/bin/sh

CONFIG_DIR=/home/qbittorrent/.config/qBittorrent
if [ ! -f "${CONFIG_DIR}/server.crt" ]; then
    openssl req -new -newkey rsa:4096 -days 3650 -subj '/CN=localhost' -nodes -x509 -keyout ${CONFIG_DIR}/server.key -out ${CONFIG_DIR}/server.crt
fi

/bin/qbittorrent-nox --webui-port=${WEBUI_PORT}