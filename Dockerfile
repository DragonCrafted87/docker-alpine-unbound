# syntax=docker/dockerfile:1
FROM ghcr.io/dragoncrafted87/alpine:3.19

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="DragonCrafted87 Unbound Recursive DNS" \
      org.label-schema.description="Alpine Image with Unbound." \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/DragonCrafted87/docker-alpine-unbound" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

COPY root/. /

RUN <<eot ash
    set -e

    apk add --update \
        drill \
        tini \
        unbound \

    rm -rf /tmp/*
    rm -rf /var/cache/apk/*
    chmod +x -R /scripts/*
eot

EXPOSE 53 53/udp
