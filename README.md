# qBittorrent Enhanced Edition Dockerfile

## Docker Compose
### AMD64
```
version: "2.1"
services:
  qbittorrent-ee:
    dns:
      - 8.8.8.8
      - 1.1.1.1
    image: karurosuma/qbittorrent-ee:amd64-latest
    container_name: qbittorrent-ee
    environment:
      - TZ=Asia/Hong_Kong
      - WEBUI_PORT=8080
    volumes:
      - /share/CE_CACHEDEV1_DATA/Containers/qbittorrent-ee/config:/home/qbittorrent/.config
      - /share/CE_CACHEDEV1_DATA/Downloads:/home/qbittorrent/downloads
    ports:
      - 8080:8080
    restart: always
```
### AARCH64
```
version: "2.1"
services:
  qbittorrent-ee:
    dns:
      - 8.8.8.8
      - 1.1.1.1
    image: karurosuma/qbittorrent-ee:aarch64-latest
    container_name: qbittorrent-ee
    environment:
      - TZ=Asia/Hong_Kong
      - WEBUI_PORT=8080
    volumes:
      - /share/CE_CACHEDEV1_DATA/Containers/qbittorrent-ee/config:/home/qbittorrent/.config
      - /share/CE_CACHEDEV1_DATA/Downloads:/home/qbittorrent/downloads
    ports:
      - 8080:8080
    restart: always
```