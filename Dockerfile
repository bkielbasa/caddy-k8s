# --- Builder stage with Go and xcaddy ---
FROM golang:1.24 AS builder

RUN go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest
ENV PATH="/go/bin:${PATH}"

RUN xcaddy build \
  --with github.com/caddyserver/caddy-k8s/v2

# --- Final image with minimal Caddy binary ---
FROM caddy:2
COPY --from=builder /go/bin/caddy /usr/bin/caddy
