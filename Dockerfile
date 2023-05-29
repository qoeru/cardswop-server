#server starts here
FROM dart:stable AS server

WORKDIR /app/server/

COPY . .

RUN dart pub global activate dart_frog_cli
RUN dart pub global run dart_frog_cli:dart_frog build

RUN dart pub get
RUN dart compile exe build/bin/server.dart -o build/bin/server

CMD ["/app/server/build/bin/server"]
