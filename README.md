# qBittorrent Enhanced Edition Dockerfile

## Usage
### Docker CLI
```
docker run -d \
  --name=qbittorrent-ee \
  -e TZ=Etc/UTC \
  -e WEBUI_PORT=8080 \
  -e WEBUI_LANG=en
  -e SESSION_PORT=36847 \
  -p 8080:8080 \
  -p 36847:36847 \
  -p 36847:36847/udp \
  -v /path/to/config:/config \
  -v /path/to/data:/data \
  -v /path/to/incomplete:/incomplete \
  -v /path/to/downloads:/downloads \
  --restart unless-stopped \
  karurosuma/qbittorrent-ee:latest
```

### Docker Compose
[docker-compose.yaml](./docker-compose.yaml)

## Web UI Login Credentials
Scheme: `https`<br>
Username: `admin`<br>
Password: `adminadmin`

## Replace default SSL certificate
Replace the `server.crt` and `server.key` that located at `/config/` with your SSL certificate and key.<br>
By default, it will generate a private key with no passphrase and a certificate that contains subject `localhost` and `3650` days lifetime.

## Docker Hub
https://hub.docker.com/repository/docker/karurosuma/qbittorrent-ee