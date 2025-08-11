FROM golang:alpine3.22 AS builder

WORKDIR /app
RUN apk add --no-cache git && \
    git clone https://github.com/hipages/php-fpm_exporter . && \
    git fetch origin pull/240/head:pr-240 && \
    git switch pr-240 && \
    CGO_ENABLED=0 go build -o php-fpm_exporter -ldflags="-s -w"

FROM alpine:3.22.1

COPY --from=builder /app/php-fpm_exporter /bin/php-fpm_exporter
RUN adduser -D exporter

USER       exporter
EXPOSE     9253
CMD        ["/bin/php-fpm_exporter", "server"]