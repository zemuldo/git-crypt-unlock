FROM alpine:latest

LABEL "name"="Git-Crypt Unlock"
LABEL "maintainer"="Zemuldo <danstan.otieno@gmail.com>"
LABEL "version"="1.0"

LABEL "com.github.actions.icon"="unlock"
LABEL "com.github.actions.color"="red"
LABEL "com.github.actions.name"="Git-Crypt Unlock"
LABEL "com.github.actions.description"="Unlock files encrypted using Git-Crypt"

RUN apk --update add ca-certificates bash curl git g++ gnupg make openssh openssl openssl-dev && rm -rf /var/cache/apk/*

RUN curl -L https://github.com/AGWA/git-crypt/archive/debian/$VERSION.tar.gz | tar zxv -C /var/tmp

RUN cd /var/tmp/git-crypt-debian && make && make install PREFIX=/usr/local && rm -rf /var/tmp/git-crypt

COPY LICENSE README.md /

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]