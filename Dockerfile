#server starts here
FROM dart:stable AS server

RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - &&\
apt-get install -y nodejs

WORKDIR /app/server/

COPY . .

WORKDIR /app/server/shared/

RUN dart pub get

RUN npm install prisma

RUN npx prisma generate &&\
    dart run build_runner build

# RUN npx prisma db push

WORKDIR /app/server/

RUN dart pub global activate dart_frog_cli
RUN dart pub global run dart_frog_cli:dart_frog build

RUN dart pub get
RUN dart compile exe build/bin/server.dart -o build/bin/server

CMD ["/app/server/build/bin/server"]
