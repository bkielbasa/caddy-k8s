# --- Builder stage with Go and xcaddy ---
FROM golang:1.22 as builder

# Install xcaddy
RUN go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest

# Build Caddy with the k8s plugin
RUN xcaddy build \
  --with github.com/caddyserver/caddy-k8s/v2

# --- Final stage with minimal Caddy image ---
FROM caddy:2

COPY --from=builder /go/bin/caddy /usr/bin/caddy
