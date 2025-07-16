FROM caddy:builder AS builder

RUN xcaddy build \
  --with github.com/caddyserver/caddy-k8s/v2

FROM caddy:latest
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
