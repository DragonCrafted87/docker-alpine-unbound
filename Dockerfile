FROM dragoncrafted87/alpine:latest

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="DragonCrafted87 Base Multi Arch Alpine Docker" \
      org.label-schema.description="Alpine Image with python preinstalled to use as a base image." \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/DragonCrafted87/docker-alpine-base" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

COPY root/. /

RUN apk add --update unbound tini && \
    rm  -rf /tmp/* /var/cache/apk/* && \
    chmod +x -R /scripts/*

EXPOSE 53 53/udp
