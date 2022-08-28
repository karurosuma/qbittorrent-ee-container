# qBittorrent Enhanced Edition Dockerfile

## Docker Hub
https://hub.docker.com/repository/docker/karurosuma/qbittorrent-ee

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
  -v /path/to/appdata/config:/home/qbittorrent/.config\
  -v /path/to/downloads:/home/qbittorrent/downloads\
  --restart unless-stopped \
  karurosuma/qbittorrent-ee:<arch>-latest
```

### Docker Compose

## Web UI Login Credentials
Scheme: `https`<br>
Username: `admin`<br>
Password: `adminadmin`

## Replace default SSL certificate
Replace the `server.crt` and `server.key` that located at `/home/qbittorrent/.config/qBittorrent/` with your SSL certificate and key.<br>
By default, it will generate a private key with no passphrase and a certificate that contains subject `localhost` and `3650` days lifetime.