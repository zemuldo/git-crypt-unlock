FROM alpine:latest

LABEL "name"="Docker-Build-Push"
LABEL "maintainer"="Zemuldo <danstan.otieno@gmail.com>"
LABEL "version"="1.0.0"

LABEL "com.github.actions.icon"="package"
LABEL "com.github.actions.color"="blue"
LABEL "com.github.actions.name"="Build and Push Registry"
LABEL "com.github.actions.description"="Login, Build Image, Tag and Push"

RUN apk --update add ca-certificates bash curl git g++ gnupg make openssh openssl openssl-dev && rm -rf /var/cache/apk/*

RUN curl -L https://github.com/AGWA/git-crypt/archive/debian/$VERSION.tar.gz | tar zxv -C /var/tmp

RUN cd /var/tmp/git-crypt-debian && make && make install PREFIX=/usr/local && rm -rf /var/tmp/git-crypt

COPY LICENSE README.md /

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]