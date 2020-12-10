FROM haskell:8.8.4
SHELL ["/bin/bash", "-oeux", "pipefail", "-c"]

WORKDIR /work

COPY ./stack.yaml ./bookPageApp.cabal /work/
RUN stack build --only-dependencies

COPY . /work/
RUN stack build && stack install

CMD stack exec bookPageApp