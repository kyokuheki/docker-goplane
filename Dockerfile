FROM golang:alpine as builder
LABEL maintainer Kenzo Okuda <okuda.kenzo@nttv6.net>

RUN apk add --no-cache \
    git \
    curl \
    gcc \
    linux-headers \
    libc-dev

RUN set -eux \
 && go get -v github.com/osrg/gobgp/cmd/gobgpd \
 && go get -v github.com/osrg/gobgp/cmd/gobgp

RUN set -eux \
 && curl https://glide.sh/get | sh \
 && go get -v github.com/osrg/goplane || true \
 && go get -v github.com/socketplane/libovsdb

RUN set -eux \
 && cd /go/src/github.com/osrg/goplane \
 && glide install \
 && go install github.com/osrg/goplane

FROM golang:alpine
LABEL maintainer Kenzo Okuda <kyokuheki@gmail.com>

COPY --from=builder /go/bin/goplane /go/bin/gobgp /go/bin/gobgpd /go/bin/

RUN apk add --no-cache \
    git \
    wget \
    curl \
    mtr \
    tcpdump

ENTRYPOINT ["/go/bin/goplane"]
CMD ["-h"]
