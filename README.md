# How to Use it

Caddy with git, ipfilter, filemanager, hugo, ratelimit

## Caddyfile

ipfilter should be set accord to the ip addresses that used for administration

## How to run the container

### volumes

/srv: should bind to the host directory where hugo project located

/var/log/caddy: log directory

/etc/Caddyfile: Caddyfile

/root/.caddy: where cert files saved

