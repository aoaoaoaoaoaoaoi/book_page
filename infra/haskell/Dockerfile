FROM haskell:8.8.3
SHELL ["/bin/bash", "-oeux", "pipefail", "-c"]

WORKDIR /work

RUN stack build --only-dependencies

COPY . /work/
RUN stack build && stack install

CMD web-service-exe -p $PORT