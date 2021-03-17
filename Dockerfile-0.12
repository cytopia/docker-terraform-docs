FROM golang:1.16.0-alpine as builder

# Install dependencies
RUN set -x \
	&& apk add --update --no-cache \
    bash \
    ca-certificates \
    curl \
    gcc \
    git \
    make \
    musl-dev \
    openssh \
    wget

# Get and build terraform-docs
ARG VERSION=latest
RUN set -x \
	&& mkdir -p /go/src/github.com \
	&& git clone https://github.com/terraform-docs/terraform-docs /go/src/github.com/terraform-docs \
	&& cd /go/src/github.com/terraform-docs \
  \
  # Check out specific tag
	&& if [ "${VERSION}" != "latest" ]; then \
		git checkout v${VERSION}; \
	fi \
  \
  # Build
  && go mod download \
  && make build \
  && mv /go/src/github.com/terraform-docs/bin//linux-amd64/terraform-docs /usr/local/bin/terraform-docs

# Version pre-check
RUN set -x \
	&& if [ "${VERSION}" != "latest" ]; then \
		terraform-docs --version | grep "${VERSION}"; \
	else \
		terraform-docs --version | grep -E "(terraform-docs[[:space:]])?(version[[:space:]])?(v?[.0-9]+)?-?(dev|latest|beta)?"; \
	fi


# Use a clean tiny image to store artifacts in
FROM alpine:3.11
LABEL \
	maintainer="cytopia <cytopia@everythingcli.org>" \
	repo="https://github.com/cytopia/docker-terraform-docs"
COPY --from=builder /usr/local/bin/terraform-docs /usr/local/bin/terraform-docs
COPY ./data/docker-entrypoint-0.12.sh /docker-entrypoint.sh

WORKDIR /data

CMD ["terraform-docs", "--version"]
ENTRYPOINT ["/docker-entrypoint.sh"]
