FROM golang:1.9.3 as builder


RUN curl -fsSL -o /usr/local/bin/dep https://github.com/golang/dep/releases/download/v0.4.1/dep-linux-amd64 \
  && chmod +x /usr/local/bin/dep

RUN mkdir -p /go/src/illaoi
WORKDIR /go/src/illaoi

COPY Gopkg.toml Gopkg.lock ./
RUN /usr/local/bin/dep ensure -vendor-only

COPY ./*.go /go/src/illaoi

RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -i -o /go/bin/illaoi

FROM alpine:3.7 as runner

COPY --from=builder /go/bin/illaoi /usr/local/bin/illaoi

ENV ILLAOI_PORT ":8080"

CMD /usr/local/bin/illaoi
