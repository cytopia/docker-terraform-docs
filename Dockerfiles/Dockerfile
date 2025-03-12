FROM golang:1.24.1-alpine as builder

# Install dependencies
RUN set -x \
	&& apk add --update --no-cache \
    bash \
    ca-certificates \
    curl \
    dpkg \
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
  && make build

RUN set -x \
  && dpkg --print-architecture \
  \
  # Copy correct architecture
  && if [ "$(dpkg --print-architecture | awk -F'-' '{print $NF}' )" = "i386" ]; then\
    mv /go/src/github.com/terraform-docs/bin/linux-386/terraform-docs /usr/local/bin/terraform-docs; \
  elif [ "$(uname -m)" = "x86_64" ]; then \
    mv /go/src/github.com/terraform-docs/bin/linux-amd64/terraform-docs /usr/local/bin/terraform-docs; \
  elif [ "$(uname -m)" = "aarch64" ]; then \
    mv /go/src/github.com/terraform-docs/bin/linux-arm64/terraform-docs /usr/local/bin/terraform-docs; \
  elif [ "$(uname -m)" = "armv7l" ]; then \
    mv /go/src/github.com/terraform-docs/bin/linux-arm/terraform-docs /usr/local/bin/terraform-docs; \
  else \
    mv /go/src/github.com/terraform-docs/bin/linux-$(uname -m)/terraform-docs /usr/local/bin/terraform-docs; \
  fi

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
