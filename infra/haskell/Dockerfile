FROM fpco/stack-build-small:lts-16 as haskellBuilder
SHELL ["/bin/bash", "-oeux", "pipefail", "-c"]
RUN stack setup
RUN stack update && stack upgrade
WORKDIR /work
COPY . /work