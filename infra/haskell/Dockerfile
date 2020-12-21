FROM alpine:3.12.2

RUN apk update
RUN apk add curl
RUN apk add ghc

RUN ghc --version

RUN curl -sSL https://get.haskellstack.org/ | sh

RUN stack --version

RUN stack update && stack upgrade

WORKDIR /work 
COPY . /work 