FROM alpine:latest
LABEL name="caddy with hugo" author="qiushi"

ARG plugins=http.git,http.ipfilter,http.filemanager,http.ratelimit,http.hugo

ENV HUGO_VERSION=0.20.2

RUN apk add --update wget ca-certificates && \
  cd /tmp && \
  wget https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
  tar xzf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
  mv hugo_${HUGO_VERSION}_linux_amd64/hugo_${HUGO_VERSION}_linux_amd64 /usr/bin/hugo && \
  rm -rf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz  hugo_${HUGO_VERSION}_linux_amd64 && \
  apk del wget ca-certificates && \
  rm /var/cache/apk/*

RUN apk add --no-cache openssh-client git tar curl

RUN curl --silent --show-error --fail --location \
      --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
      "https://caddyserver.com/download/linux/amd64?plugins=${plugins}" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy \
 && chmod 0755 /usr/bin/caddy \
 && /usr/bin/caddy -version

EXPOSE 80 443 2015
VOLUME /root/.caddy
WORKDIR /srv

COPY Caddyfile /etc/Caddyfile

ENTRYPOINT ["/usr/bin/caddy"]
CMD ["--conf", "/etc/Caddyfile", "--log", "stdout"]