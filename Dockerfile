FROM dragoncrafted87/ubuntu:edge

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="DragonCrafted87 Pi-Hole with Unbound Recursive DNS" \
      org.label-schema.description=" " \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/DragonCrafted87/docker-pi-hole-unbound" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

COPY root/. /

RUN apt update && \

    # upgrade OS
    apt -y dist-upgrade && \

    # setup unbound
    apt install unbound && \
    curl -O https://www.internic.net/domain/named.root --output root.hints && \
    sudo mv root.hints /var/lib/unbound/ && \
    service unbound start && \

    # install pi-hole
    curl -sSL https://install.pi-hole.net | bash && \

    # clean up after
    apt autoremove -y && \
    apt clean all

EXPOSE 53 53/udp
EXPOSE 67/udp
EXPOSE 80
EXPOSE 443
