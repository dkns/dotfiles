FROM alpine:stable
RUN sed -i 's/http\:\/\/dl-cdn.alpinelinux.org/https\:\/\/alpine.global.ssl.fastly.net/g' /etc/apk/repositories
ENV CMAKE_BUILD_TYPE=RelWithDebInfo
WORKDIR /tmp

RUN apk add --update-cache --virtual build-deps --no-cache \
    git \
    alpine-sdk build-base\
    libtool \
    automake \
    m4 \
    autoconf \
    linux-headers \
    unzip \
    ncurses ncurses-dev ncurses-libs ncurses-terminfo \
    python \
    python-dev \
    py-pip \
    clang \
    go \
    nodejs \
    xz \
    curl \
    make \
    cmake \
    && rm -rf /var/cache/apk/*

WORKDIR /tmp

RUN git clone https://github.com/neovim/neovim.git nvim && \
    cd nvim && \
    make && \
    make install && \
    cd ../ && rm -rf nvim
