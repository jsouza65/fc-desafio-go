FROM golang:alpine as builder

RUN apk update && apk add --no-cache git

WORKDIR /go/src

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" .

FROM scratch

WORKDIR /go/src

COPY --from=builder /go/src /usr/bin/

ENTRYPOINT ["hello"]