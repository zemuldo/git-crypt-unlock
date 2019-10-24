FROM circleci/elixir:1.8.2

LABEL "name"="Docker-Build-Push"
LABEL "maintainer"="Zemuldo <danstan.otieno@gmail.com>"
LABEL "version"="1.0.0"

LABEL "com.github.actions.icon"="package"
LABEL "com.github.actions.color"="blue"
LABEL "com.github.actions.name"="Build and Push Registry"
LABEL "com.github.actions.description"="Login, Build Image, Tag and Push"

RUN sudo apt-get install git-crypt

COPY LICENSE README.md /

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]