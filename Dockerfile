FROM alpine:latest

RUN apk update --no-cache && apk upgrade --no-cache \
    && apk add --no-cache git bash make g++ openssl-dev

RUN wget https://www.libssh2.org/download/libssh2-1.9.0.tar.gz -P /tmp \
    && cd /tmp \
    && tar -zxvf libssh2-1.9.0.tar.gz \
    && cd libssh2-1.9.0 \
    && ./configure --with-crypto=auto \
    && make \
    && make install \
    && rm -f /tmp/libssh2-1.9.0.tar.gz \
    && rm -R /tmp/libssh2-1.9.0

RUN wget https://curl.haxx.se/download/curl-7.65.1.tar.gz -P /tmp \
    && cd /tmp \
    && tar -zxvf curl-7.65.1.tar.gz \
    && cd curl-7.65.1 \
    && ./configure --with-libssh2=/usr/local \
    && make \
    && make install \
    && rm -f /tmp/curl-7.65.1.tar.gz \
    && rm -R /tmp/curl-7.65.1

RUN git clone https://github.com/git-ftp/git-ftp.git /tmp/git-ftp \
    && cd /tmp/git-ftp \
    && git checkout "$(git tag | grep '^[0-9]*\.[0-9]*\.[0-9]*$' | tail -1)" \
    && make install \
    && rm -R /tmp/git-ftp
