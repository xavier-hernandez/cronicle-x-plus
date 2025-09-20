FROM node:lts-alpine3.22 AS builder
RUN apk upgrade --update --no-cache
RUN apk add procps curl bash patch

ENV CRONICLE_VERSION=0.9.80
WORKDIR /opt/cronicle
RUN curl -L -o /tmp/Cronicle-${CRONICLE_VERSION}.tar.gz https://github.com/jhuckaby/Cronicle/archive/refs/tags/v${CRONICLE_VERSION}.tar.gz
RUN tar zxvf /tmp/Cronicle-${CRONICLE_VERSION}.tar.gz -C /tmp/ && \
    mv /tmp/Cronicle-${CRONICLE_VERSION}/* . && \
    rm -rf /tmp/* && \
    yarn
COPY ./patches /tmp/patches
RUN patch -p3 < /tmp/patches/engine.patch lib/engine.js
COPY docker-entrypoint.js ./bin/


FROM node:lts-alpine3.22
RUN apk upgrade --update --no-cache
RUN apk add procps curl bash
COPY --from=builder /opt/cronicle/ /opt/cronicle/
WORKDIR /opt/cronicle
ENV CRONICLE_foreground=1
ENV CRONICLE_echo=1
ENV CRONICLE_color=1
ENV debug_level=1
ENV HOSTNAME=main
RUN node bin/build.js dist && bin/control.sh setup

RUN apk add --no-cache wget openssh rsync bash mc ripgrep nano borgbackup borgmatic p7zip

CMD ["node", "bin/docker-entrypoint.js"]