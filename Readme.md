# forticlient

Connect to a FortiNet VPNs through docker

I don't want to keep the fortiClient running, so the docker container can help the OS light.

Add an proxy is for I can control the traffic more flexiable.


## Usage

The container uses the forticlientsslvpn_cli linux binary to manage ppp interface

All of the container traffic is routed through the VPN, so you can in turn route host traffic through the container to access remote.

### envs

forticlientsslvpn config:

  - VPNADDR
  - VPNUSER
  - VPNPASS

http proxy config:

- PROXY_USER
- PROXY_PASS


If don't need auth for proxy, just run

```
docker run -it --rm \
  --privileged \
  -p 18388:18388 \
  -e VPNADDR=host:port \
  -e VPNUSER=me@domain \
  -e VPNPASS=secret \
  vaayne/docker-forticlient-proxy
```

If need auth for proxy, set `PROXY_USER` and `PROXY_PASS` env.

```
docker run -it --rm \
  --privileged \
  -p 18388:18388 \
  -e VPNADDR=host:port \
  -e VPNUSER=me@domain \
  -e VPNPASS=secret \
  -e PROXY_USER=user \
  -e PROXY_PASS=passwd \
  vaayne/docker-forticlient-proxy
```

## Thanks

### [https://hadler.me](https://hadler.me/linux/forticlient-sslvpn-deb-packages/)
for hosting up to date precompiled binaries which are used in this Dockerfile.

### [docker-forticlient](https://github.com/HybirdCorp/docker-forticlient)
Origin fork repo.

### [gost](https://github.com/ginuerzh/gost)
gost use as proxy server.