FROM golang:latest as builder

# Install dependencies
RUN set -x \
	&& DEBIAN_FRONTEND=noninteractive apt-get update -qq \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -qq -y --no-install-recommends --no-install-suggests \
		git \
		gox \
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
	# Build terraform-docs <= 0.3.0
	&& if [ "${VERSION}" = "0.3.0" ] || [ "${VERSION}" = "0.2.0" ] || [ "${VERSION}" = "0.1.1" ] || [ "${VERSION}" = "0.1.0" ]; then \
		go get github.com/hashicorp/hcl \
		&& go get github.com/tj/docopt \
		&& make \
		&& mkdir -p bin/linux-amd64 \
		&& mv dist/terraform-docs_linux_amd64 bin/linux-amd64/terraform-docs; \
	# Build terraform-docs > 0.3.0
	else \
		make deps \
		&& make test \
		&& make build-linux-amd64 \
		&& if [ ${VERSION} = "0.4.0" ]; then \
			mkdir -p bin/linux-amd64 \
			&& mv bin/terraform-docs-v${VERSION}-linux-amd64 bin/linux-amd64/terraform-docs; \
		fi \
	fi \
	&& chmod +x bin/linux-amd64/terraform-docs

# Use a clean tiny image to store artifacts in
FROM alpine:latest
LABEL \
	maintainer="cytopia <cytopia@everythingcli.org>" \
	repo="https://github.com/cytopia/docker-terraform-docs"
COPY --from=builder /go/src/github.com/segmentio/terraform-docs/bin/linux-amd64/terraform-docs /usr/local/bin/terraform-docs
COPY ./data/docker-entrypoint.sh /docker-entrypoint.sh
COPY ./data/terraform-docs.awk /terraform-docs.awk

ENV WORKDIR /data
WORKDIR /data

CMD ["terraform-docs", "--version"]
ENTRYPOINT ["/docker-entrypoint.sh"]
