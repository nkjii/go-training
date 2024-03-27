FROM golang:1.20.0-alpine AS build-env

# ENV GO111MODULE=on

RUN apk --no-cache add git make build-base

WORKDIR /go/src

RUN mkdir cmd

COPY . .
ARG CGO_ENABLED=0
ARG GOOS=linux
ARG GOARCH=amd64

RUN go build -ldflags "-s -w" -trimpath  -o /go/src/ /go/src/cmd/server.go
RUN chmod 700 ./cmd/
RUN chmod +x ./start.sh

FROM alpine:3.10.2
RUN apk --no-cache add tzdata && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN apk --no-cache add tzdata bash curl jq
ENV TZ=Asia/Tokyo

WORKDIR /go/src
COPY --from=build-env /go/src/server /server
COPY --from=build-env /go/src/start.sh .
ENTRYPOINT ["/server"]