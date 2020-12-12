FROM fpco/stack-build-small:lts-16 as haskellBuilder
SHELL ["/bin/bash", "-oeux", "pipefail", "-c"]
RUN stack setup
RUN stack update && stack upgrade
WORKDIR /work
COPY . /work

FROM codesimple/elm:0.19 as elmBuilder
SHELL ["/bin/bash", "-oeux", "pipefail", "-c"]
WORKDIR /work
COPY . /work
RUN elm make elm-src/Main.elm --output=static/main.js

FROM alpine:3.12.2
SHELL ["/bin/bash", "-oeux", "pipefail", "-c"]