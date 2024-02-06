# goバージョン
FROM golang:1.21-alpine
# アップデートとgitのインストール
RUN apk update && apk add git
# boiler-plateディレクトリの作成
RUN mkdir /go/src/go-sample
# ワーキングディレクトリの設定
WORKDIR /go/src/go-sample
# ホストのファイルをコンテナの作業ディレクトリに移行
ADD . /go/src/go-sample
# パッケージのインポート
RUN go install golang.org/x/tools/cmd/goimports@latest

