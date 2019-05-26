FROM golang:latest as builder

# Install dependencies
RUN set -x \
	&& DEBIAN_FRONTEND=noninteractive apt-get update -qq \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -qq -y --no-install-recommends --no-install-suggests \
		git \
	&& curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

# Get and build terraform-docs
ARG VERSION
RUN set -x \
	&& export GOPATH=/go \
	&& mkdir -p /go/src/github.com/segmentio \
	&& git clone https://github.com/segmentio/terraform-docs /go/src/github.com/segmentio/terraform-docs \
	&& cd /go/src/github.com/segmentio/terraform-docs \
	&& if [ ${VERSION} != "latest" ]; then \
		git checkout v${VERSION}; \
	fi \
	&& make deps \
	&& make test \
	&& make build-linux-amd64 \
	&& if [ ${VERSION} = "0.4.0" ]; then \
		mkdir -p bin/linux-amd64; \
		mv bin terraform-docs-v${VERSION}-linux-amd64 bin/linux-amd64/terraform-docs; \
	fi \
	&& chmod +x bin/linux-amd64/terraform-docs

# Use a clean image
FROM alpine:latest
COPY --from=builder /go/src/github.com/segmentio/terraform-docs/bin/linux-amd64/terraform-docs /usr/local/bin/terraform-docs
WORKDIR /docs
ENTRYPOINT ["/usr/local/bin/terraform-docs"]
CMD ["--version"]
