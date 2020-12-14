FROM codesimple/elm:0.19 as elmBuilder
WORKDIR /work
COPY . /work
RUN elm make src/Main.elm --output=static/main.js