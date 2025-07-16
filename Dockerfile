FROM golang:1.24 AS builder

# Avoid Git prompt failure
ENV GIT_TERMINAL_PROMPT=0
ENV PATH="/go/bin:$PATH"

# Install xcaddy
RUN go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest

# Build caddy with k8s plugin
RUN xcaddy build \
  --with github.com/caddyserver/caddy-k8s/v2

# Final slim image
FROM caddy:2
COPY --from=builder /go/bin/caddy /usr/bin/caddy
