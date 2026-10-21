# Builds the MinIO client (mc) binary from source.
#
# The MC_RELEASE build arg pins the exact upstream release tag
# (https://github.com/minio/mc/releases) that will be checked out and
# compiled. Override it via `--build-arg MC_RELEASE=...` or the
# MC_RELEASE variable in .env to change versions.

# This code is from the alfalfa repository at https://github.com/NatLabRockies/alfalfa.
# distributed under the 3-clause BSD License in service/LICENSE.md.

FROM docker.io/library/golang:1.24-alpine AS build

ARG MC_RELEASE=RELEASE.2025-04-16T18-13-26Z

ENV CGO_ENABLED=0
ENV GOPATH=/go
ENV GOSUMDB=off

RUN apk add --no-cache git bash ca-certificates

WORKDIR /build

RUN git clone --depth 1 --branch ${MC_RELEASE} https://github.com/minio/mc.git .

RUN go build -trimpath -ldflags "$(go run buildscripts/gen-ldflags.go)" -o /go/bin/mc .

# **** Minimal runtime image ****
FROM docker.io/library/alpine:3.19

RUN apk add --no-cache ca-certificates

COPY --from=build /go/bin/mc /usr/bin/mc

ENTRYPOINT ["mc"]
