#!/bin/sh

CONFIG_DIR=/home/qbittorrent/.config/qBittorrent

if [ ! -f "${CONFIG_DIR}" ]; then
    mkdir -p ${CONFIG_DIR}
fi

if [ ! -f "${CONFIG_DIR}/server.crt" ]; then
    openssl req -new -newkey rsa:4096 -days 3650 -subj '/CN=localhost' -nodes -x509 -keyout ${CONFIG_DIR}/server.key -out ${CONFIG_DIR}/server.crt
fi

if [ ! -f "${CONFIG_DIR}/qBittorrent.conf" ]; then
cat <<EOF > ${CONFIG_DIR}/qBittorrent.conf
[BitTorrent]
Session\Port=${SESSION_PORT}
Session\AutoBanBTPlayerPeer=true
Session\AutoBanUnknownPeer=true
Session\AddExtensionToIncompleteFiles=true
Session\DefaultSavePath=/home/qbittorrent/downloads
Session\TempPathEnabled=true
Session\TempPath=/home/qbittorrent/downloads/incomplete

[Preferences]
General\Locale=${WEBUI_LANG}
WebUI\HTTPS\Enabled=true
WebUI\HTTPS\CertificatePath=/home/qbittorrent/.config/qBittorrent/server.crt
WebUI\HTTPS\KeyPath=/home/qbittorrent/.config/qBittorrent/server.key
EOF
fi

/bin/qbittorrent-nox --webui-port=${WEBUI_PORT}